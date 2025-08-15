package com.dayuan.controller.system;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSRole;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.system.RoleFunctionModel;
import com.dayuan.model.system.UserRoleModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSRoleService;
import com.dayuan.service.system.TSUserService;
import com.dayuan.util.*;
import com.dayuan3.common.util.SystemConfigUtil;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class TSUserController extends BaseController {
    @Value("${systemUrl}")
    String systemUrl;
    //用户签名文件存放地址
    @Value("${userSignaturePath}")
    String userSignaturePath;
    private final Logger log = Logger.getLogger(TSUserController.class);
    @Autowired
    private TSUserService tsUserService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private TSRoleService tsRoleService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private TSOperationService tSOperationService;
    @Autowired
    private TSFunctionService tSFunctionService;
    /**
    * @Description
    * @Date 2022/07/14 11:09
    * @Author xiaoyl
    * @Param type 类型：0 正常跳转，1 异地登录被迫下线
    * @return
    */
    @RequestMapping({"/toLogin"})
    public ModelAndView toLogin(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        int type=0;
        //获取Session
        HttpSession session = request.getSession();
        TSUser loginUser = (TSUser) session.getAttribute("session_user");
        //判断当前请求sessionID是否是最后一次登录的用户sessionID，后登录的用户会把之前的用户sessionID覆盖掉
        ServletContext application = session.getServletContext();
        String sessionId = session.getId();
        if (loginUser != null && sessionId.equals(application.getAttribute(loginUser.getId()))) {
//      return new ModelAndView(new RedirectView(request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/system/goHome"));
            if ((systemUrl.lastIndexOf("/") + 1) == systemUrl.length()) {
                return new ModelAndView(new RedirectView(systemUrl + "system/goHome"));
            } else {
                return new ModelAndView(new RedirectView(systemUrl + "/system/goHome"));
            }
        }else if(loginUser != null && !sessionId.equals(application.getAttribute(loginUser.getId()))){
            type=1;//被迫退出
        }
        map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
        map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright1"));
        map.put("type", type);
        session.setAttribute("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
        return new ModelAndView("/login", map);
    }

    /**
     * 用户登录
     * @param userName  用户名
     * @param password  MD5加密一次的新密码
     * @param vcode 验证码
     * @param spw 0_合规密码,1_弱密码,2_初始密码
     * @param request
     * @return
     */
    @RequestMapping({"/loginAjax"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "登录",type = 0,serviceClass = "TSUserService")
    public Map<String, Object> login(String userName, String password, String vcode, @RequestParam(value = "spw", required = false, defaultValue = "0") Integer spw, HttpServletRequest request) {
        Map<String, Object> map = new HashMap();
        try {
            Object sessionCode = request.getSession().getAttribute("session_validatecode");
            if ((sessionCode != null) && (!vcode.equals(sessionCode.toString()))) {
                map.put("tip", "验证码错误！");
                map.put("status", 4);
                return map;
            }

            //每次登录，原验证码失效
            request.getSession().setAttribute("session_validatecode",  (int)(Math.random()*10000));

            //账号已锁定
            if (LockAccount.waIsLocked(userName)) {
                map.put("tip", "账号已锁定！");
                map.put("status", 5);
                return map;
            }

            TSUser loginUser = tsUserService.getUserByUserName(userName);
            if (loginUser != null) {
                String pwd = CipherUtil.encodeByMD5(password);
                if (!pwd.equals(loginUser.getPassword())) {
                    //记录账号输入错误次数
                    LockAccount.waInputError(userName);

                    map.put("tip", "账号或密码错误！");//update by xiaoyl 2021-12-16 武陵相关负责人提出提示账号不存在容易穷举账号信息，统一提示账号或密码错误！
                    map.put("status", 3);
                    return map;
                }

                if (loginUser.getStatus() == 1) {
                    map.put("tip", "账号已被禁用！");
                    map.put("status", 6);
                    return map;
                }

                List<RoleFunctionModel> menus = this.tSFunctionService.getRoleMenus(loginUser.getRoleId());
                if ((menus == null) || (menus.size() == 0)) {
                    map.put("tip", "此用户无平台权限！");
                    map.put("status", 2);
                    return map;

                } else {
                    //密码正确，账号正常

                    //是否初始密码
                    com.alibaba.fastjson.JSONArray defaultPasswordArr = null;
                    if (SystemConfigUtil.OTHER_CONFIG != null && SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config") != null) {
                        defaultPasswordArr = SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config").getJSONArray("default_password");
                    }
                    if (defaultPasswordArr != null) {
                        Iterator<Object> it = defaultPasswordArr.iterator();
                        while (it.hasNext()) {
                            String defaultPassword = (String) it.next();

                            //强制修改初始密码
                            if (password.equals(CipherUtil.encodeByMD5(defaultPassword))) {
                                spw = 2;
                                break;
                            }
                        }
                    }

                    if (0==spw) {
                        //正常密码

                        //密码过期天数
                        int pwExpire = SystemConfigUtil.getInteger(SystemConfigUtil.SYSTEM_NAME_CONFIG, 0, "pwExpire");
                        //用户密码过期
                        if (pwExpire > 0) {
                            Date editPwTime = loginUser.getEditPwTime();
                            //未修改过密码
                            if (editPwTime == null) {
                                //记录临时登录信息
                                request.getSession().setAttribute("temp_session_user", loginUser);
                                map.put("tip", "密码已过期，请修改密码！");
                                map.put("status", 9);

                                //重置锁定账号输入次数
                                LockAccount.waUnlock(userName);
                                return map;
                            }

                            Calendar c0 = Calendar.getInstance();
                            c0.setTime(editPwTime);
                            c0.add(Calendar.DAY_OF_YEAR, pwExpire);
                            //密码过期
                            if (System.currentTimeMillis() >= c0.getTimeInMillis()) {
                                //记录临时登录信息
                                request.getSession().setAttribute("temp_session_user", loginUser);
                                map.put("tip", "密码已过期，请修改密码！");
                                map.put("status", 9);

                                //重置锁定账号输入次数
                                LockAccount.waUnlock(userName);
                                return map;
                            }
                        }

                        //正常登录成功
                        Integer count = (loginUser.getLoginCount().shortValue() + 1);
                        loginUser.setLoginCount(count);
                        loginUser.setLoginTime(new Date());

                        tsUserService.updateById(loginUser);
                        request.getSession().setAttribute("session_user", loginUser);

                        if (loginUser.getDepartId() != null) {
                            TSDepart depart = departService.getById(loginUser.getDepartId());
                            request.getSession().setAttribute("org", depart);
                        }

                        if (loginUser.getPointId() != null) {
                            BasePoint point = this.basePointService.queryById(loginUser.getPointId());
                            request.getSession().setAttribute("point", point);
                        }

                        List<TSOperation> btnList = this.tSOperationService.queryAllPrivilegs(loginUser.getRoleId());
                        JSONArray json = JSONArray.fromObject(btnList);
                        request.getSession().setAttribute("btnList", json.toString());

                        map.put("tip", "登录成功");
                        map.put("status", 0);
                        //add by xiaoyl 2022/07/14获取ServletContext对象，将用户登录后的sessionID存放在ServletContext对象中，通过sessionID判断用户是否多处登录，多处登录的话将前一个登录的用户踢下线
                        ServletContext application = request.getSession().getServletContext();
                        String sessionId = request.getSession().getId();
                        if(application.getAttribute(loginUser.getId()) == null){
                            application.setAttribute(loginUser.getId(),sessionId);
                        }else if (application.getAttribute(loginUser.getId())!= null && !StringUtils.equals(sessionId,application.getAttribute(loginUser.getId()).toString())){
                            application.removeAttribute(loginUser.getId());
                            application.setAttribute(loginUser.getId(),sessionId);
                        }

                        //重置锁定账号输入次数
                        LockAccount.waUnlock(userName);
                        return map;

                    //弱密码或初始密码，要求修改密码
                    } else {
                        //记录临时登录信息
                        request.getSession().setAttribute("temp_session_user", loginUser);

                        map.put("tip", "密码过于简单，请修改密码！");
                        map.put("status", 8);

                        //重置锁定账号输入次数
                        LockAccount.waUnlock(userName);
                        return map;
                    }
                }
            } else {
                //密码错误和用户不存在都用3 Dz 20230811 甘肃等保提出提示账号不存在容易穷举账号信息，统一提示账号或密码错误！
                map.put("tip", "账号或密码错误！");
                map.put("status", 3);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            map.put("tip", "登录失败，请联系管理员！");
            map.put("status", 1);
        }
        return map;
    }


    /**
     * 密码过于简单，强制修改密码页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping({"system/user/simplePassword"})
    public ModelAndView simplePassword(HttpServletRequest request, HttpServletResponse response) {
        TSUser loginUser = (TSUser) request.getSession().getAttribute("temp_session_user");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", loginUser.getId());
        map.put("userName", loginUser.getUserName());
        map.put("realName", loginUser.getRealname());
        map.put("departName", loginUser.getDepartName());
        map.put("pointName", loginUser.getPointName());
        map.put("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
        map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright1"));
        return new ModelAndView("/common/simplePassword", map);
    }
    /**
     * 密码过于简单，强制修改密码
     * @return
     */
    @RequestMapping({"system/user/updatePassword2"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "密码修改",type = 2, serviceClass = "TSUserService")
    public AjaxJson updatePassword2(HttpServletRequest request, String password) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser sessionUser = (TSUser) request.getSession().getAttribute("temp_session_user");

//            //密码正则表达式
//            Pattern pattern = Pattern.compile(WebConstant.pwRegEx);
//            Matcher matcher = pattern.matcher(password);

            if (sessionUser == null) {
                aj.setSuccess(false);
                aj.setMsg("用户信息失效，请重新登录！");

//            } else if (!matcher.matches()) {
//                aj.setSuccess(false);
//                aj.setMsg("修改密码失败，新密码不符合要求！");

            } else if (sessionUser.getPassword().equals(CipherUtil.encodeByMD5(password))) {
                //新密码不能与原密码相同
                aj.setSuccess(false);
                aj.setMsg("新密码不能与原密码相同！");

            } else {
                TSUser user = tsUserService.getById(sessionUser.getId());
                user.setPassword(CipherUtil.encodeByMD5(password));
                user.setEditPwTime(new Date());
                user.setUpdateBy(sessionUser.getId());
                user.setUpdateDate(new Date());
                tsUserService.updateById(user);
                aj.setMsg("修改密码成功！");
                request.getSession().removeAttribute("temp_session_user");
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("修改密码失败！");
        }
        return aj;
    }

    /**
     * 修改密码
     * @param id 用户ID
     * @param password  MD5加密一次的新密码
     * @param oldPassword MD5加密一次的原密码
     * @param request
     * @return
     */
    @RequestMapping({"system/user/updatePassword"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "密码修改",type = 2, serviceClass = "TSUserService")
    public AjaxJson updatePassword(String id, String password, String oldPassword, HttpServletRequest request) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser user = this.tsUserService.getById(id);
            if (user == null) {
                aj.setSuccess(false);
                aj.setMsg("用户不存在");
            } else if (StringUtil.isEmpty(password) || StringUtil.isEmpty(oldPassword)) {
                aj.setSuccess(false);
                aj.setMsg("密码不能为空");
            } else {
//                CipherUtil cipher = new CipherUtil();
//                String pwd = CipherUtil.generatePassword(oldPassword);
                if (CipherUtil.encodeByMD5(oldPassword).equals(user.getPassword())) {
                    user.setPassword(CipherUtil.encodeByMD5(password));
                    user.setEditPwTime(new Date());
                    PublicUtil.setCommonForTable(user, false);
                    tsUserService.updateById(user);
                    aj.setMsg("修改密码成功");
                } else {
                    aj.setSuccess(false);
                    aj.setMsg("原密码错误");
                }
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("修改密码失败");
        }
        return aj;
    }

    @RequestMapping({"system/user/updateRealname"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "修改用户名",type = 2, serviceClass = "TSUserService")
    public AjaxJson updateRealname(TSUser user) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser oldUser = tsUserService.getById(user.getId());
            if (oldUser == null) {
                aj.setSuccess(false);
                aj.setMsg("用户不存在");
            } else {
                oldUser.setRealname(user.getRealname());
                PublicUtil.setCommonForTable(oldUser, false);
                tsUserService.updateById(oldUser);
                aj.setMsg("修改个人信息成功");
                ContextHolderUtils.getSession().setAttribute("session_user", oldUser);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
        }
        return aj;
    }

    @RequestMapping({"system/user/list"})
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        Map<String, Object> map = new HashMap();
        TSUser tsUser = (TSUser) session.getAttribute("session_user");
        DepartTreeModel departTree = null;
        List<TSRole> roleList = new ArrayList();
        try {
            TSRole role = this.tsRoleService.queryById(tsUser.getRoleId());
            String childrenId = role.getChildrenId();
            if (StringUtil.isNotEmpty(childrenId)) {
                String[] split = childrenId.split(",");
                for (int i = 0; i < split.length; i++) {
                    TSRole roles = this.tsRoleService.queryById(split[i]);
                    if (roles != null) {
                        roleList.add(roles);
                    }
                }
            } else {
                roleList.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (tsUser.getDepartId() != null) {
            departTree = this.departService.getDepartPoint(tsUser.getDepartId());
        }
        map.put("roleList", roleList);
        map.put("roleListJson", JSON.toJSONString(roleList));
        map.put("departTree", departTree);
        return new ModelAndView("/system/user/list", map);
    }

    @RequestMapping({"system/user/getPoint"})
    @ResponseBody
    public AjaxJson getPoint(HttpServletResponse response, Integer id) {
        AjaxJson jsonObj = new AjaxJson();

        List<BasePoint> points = this.basePointService.selectByDepartid(id, null);

        jsonObj.setObj(points);

        return jsonObj;
    }

    @RequestMapping({"system/user/datagrid"})
    @ResponseBody
    public AjaxJson datagrid(UserRoleModel model, Page page, HttpServletResponse response, Integer departId, Integer usetType) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSDepart dp = null;
            if (departId != null) {
                dp = departService.getById(departId);
            }

            if (dp != null) {
                model.setDepartCode(dp.getDepartCode());
                model.setPointId(null);
            } else {
                TSUser user = PublicUtil.getSessionUser();
                if (user.getPointId() != null) {
                    model.setDepartId(null);
                    model.setPointId(user.getPointId());
                } else {
                    model.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
                    model.setPointId(null);
                }
            }
            model.setUserType(usetType);
            page = tsUserService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObj;
    }

    @RequestMapping({"system/user/save"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "新增与编辑",type = 1,serviceClass = "TSUserService")
    public AjaxJson save(TSUser bean, @RequestParam(value = "signatureFilePath", required = false) MultipartFile file, @RequestParam(required = false, defaultValue = "0") Short haveSignature, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSUser oldUser = tsUserService.getUserByUserName(bean.getUserName());
            //上传用户签名图片
            if (haveSignature == 1) {//是否拥有签名设置权限： 0 没有， 1 有
                if (null != file && file.getSize() > 0) {
                    String reName = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());
                    String fileName = uploadFile(request, "/" + userSignaturePath, file, reName);
                    bean.setSignatureFile(userSignaturePath + fileName);
                } else if (StringUtil.isEmpty(bean.getSignatureFile())) {// 编辑用户时若没有文件且则表示移除签名
                    bean.setSignatureFile("");
                }
            }

            //编辑用户
            if (StringUtil.isNotEmpty(bean.getId())) {
                if (oldUser == null || oldUser.getId().equals(bean.getId())) {

                    if (StringUtil.isNotEmpty(bean.getPassword())) {
                        bean.setPassword(CipherUtil.encodeByMD5(bean.getPassword()));
                        bean.setEditPwTime(new Date());
                    }
                    PublicUtil.setCommonForTable(bean, false);
                    tsUserService.updateById(bean);
                  /*  //编辑用户时若重新选择签名文件则需删除旧的签名文件
                    if (StringUtil.isNotEmpty(oldUser1.getSignatureFile()) && null != file && file.getSize() > 0) {
                        String path = WebConstant.res.getString("resources") + oldUser1.getSignatureFile();
                        DyFileUtil.deleteFolder(path);
                    }*/
                } else {//账户已存在
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("登录账号已存在");
                }

                //新增用户
            } else {
                if (oldUser == null) {
                    bean.setId(UUIDGenerator.generate());
                    bean.setLoginCount(0);
                    bean.setDeleteFlag(0);
                    PublicUtil.setCommonForTable(bean, true);
                    bean.setPassword(CipherUtil.encodeByMD5(bean.getPassword()));
                    if (bean.getSorting() == null) {
                        bean.setSorting(0);
                    }
                    //如果需要为-1，设置序号为该用户所属机构下的用户的最大序号+1
                    if (bean.getSorting() == -1 && bean.getDepartId() != null) {
                        short maxSort = tsUserService.queryMaxSortByDepartId(bean.getDepartId());//所属机构下的用户的最大序号
                        bean.setSorting((maxSort + 1));
                    }
                    tsUserService.save(bean);

                    //账户已存在
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("账户名已存在");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",bean.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }

    /**
     * 修改备注信息
     * @param id
     * @param remark
     * @return
     */
    @RequestMapping({"system/user/editRemark"})
    @ResponseBody
    @SystemLog(module = "用户管理", methods = "新增与编辑", type = 1,serviceClass = "TSUserService")
    public AjaxJson editRemark(String id, String remark) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(id)) {
                TSUser user = new TSUser();
                user.setId(id);
                user.setRemark(org.apache.commons.lang.StringUtils.isBlank(remark) ? "" : remark);
                PublicUtil.setCommonForTable(user, false);
                tsUserService.updateById(user);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    @RequestMapping({"system/user/logout"})
    public ModelAndView logout(HttpServletRequest request, HttpSession session) {
        //add by xiaoyl 2022/07/14 start 用户退出的时候清除application中的会话ID
        ServletContext application = session.getServletContext();
        TSUser loginUser = (TSUser) session.getAttribute("session_user");
        application.removeAttribute(loginUser.getId());
        //add by xiaoyl 2022/07/14 end
        session.removeAttribute("session_user");
        session.removeAttribute("org");
        session.invalidate();
        request.getSession().setAttribute("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
        String url = "redirect:"+request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
        return new ModelAndView(url);
    }

    @RequestMapping({"system/user/queryById"})
    @ResponseBody
    public AjaxJson queryById(String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            UserRoleModel bean = this.tsUserService.getUserAndRole(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObject;
    }

    @RequestMapping({"system/user/delete"})
    @ResponseBody
    @SystemLog(module = "用户管理",methods = "删除",type = 3,serviceClass = "TSUserService")
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
//            tsUserService.delete2(Arrays.asList(ids.split(",")), PublicUtil.getSessionUser().getId());
            tsUserService.removeByIds(Arrays.asList(ids.split(",")));
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping({"system/user/unlock"})
    @ResponseBody
    public AjaxJson unlock(HttpServletRequest request, HttpServletResponse response, String username) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            LockAccount.waUnlock(username);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping({"/queryByDepartId"})
    @ResponseBody
    public AjaxJson queryByDepartId(HttpServletResponse response, Integer departId, String subset, String realname) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            List<TSUser> points = this.tsUserService.queryByDepartId(departId, subset, realname);
            jsonObj.setObj(points);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("查询失败");
        }
        return jsonObj;
    }

    @RequestMapping({"/queryByRoleId"})
    @ResponseBody
    public AjaxJson queryByRoleId(HttpServletResponse response, String roleId, String realname) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            List<TSUser> points = this.tsUserService.queryByRoleId(roleId, realname);
            jsonObj.setObj(points);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("查询失败");
        }
        return jsonObj;
    }

    /**
     * @return
     * @Description 根据检测点ID查询用户列表，用于抽样单复核使用
     * @Date 2020/10/29 11:43
     * @Author xiaoyl
     * @Param
     */
    @RequestMapping({"system/user/queryUserByPointId"})
    @ResponseBody
    public AjaxJson queryUserByPointId(Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        List<TSUser> list = tsUserService.queryByPointId(id);
        jsonObj.setObj(list);
        return jsonObj;
    }


    /**
     * 解除送检账号微信绑定
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "system/user/del_openid")
    @ResponseBody
    public AjaxJson delOpenid(String id) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSUser user = tsUserService.getById(id);
            if (user != null) {
                PublicUtil.setCommonForTable(user, false);
                tsUserService.delOpenid(user);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("解绑成功");
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("获取用户信息失败或该用户未绑定!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObject;
    }
    /**
    * @Description 恢复已删除的用户
    * @Date 2022/06/30 16:21
    * @Author xiaoyl
    * @Param
    * @return
    */
    @RequestMapping({"system/user/recoveryUser"})
    @ResponseBody
    public AjaxJson recoveryUser(String id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser user = tsUserService.getById(id);
            user.setDeleteFlag(0);
            user.setStatus(0);
            PublicUtil.setCommonForTable(user, false);
            tsUserService.updateById(user);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
}
