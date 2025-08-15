package com.dayuan.controller.wx;

import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSRole;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.wx.WxAccesstoken;
import com.dayuan.bean.wx.WxUser;
import com.dayuan.bean.wx.WxsignIn;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.system.UserRoleModel;
import com.dayuan.model.wx.WxsignInModel;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSRoleService;
import com.dayuan.service.wx.WxAccesstokenService;
import com.dayuan.service.wx.WxUserService;
import com.dayuan.service.wx.WxsignInService;
import com.dayuan.util.*;
import com.dayuan.util.wx.SignUtil;
import com.dayuan.util.wx.WeixinUtil;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/wx")
public class WxController extends BaseController {
    private final Logger log = Logger.getLogger(WxController.class);
    private static final String appId = WebConstant.res.getString("appId");
    private static final String secret = WebConstant.res.getString("secret");
    private static final String redirectUri = WebConstant.res.getString("redirectUri");
    public final static String code_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code ";
    //使用微信openid的时候打开注释（入口为 /wx/p_attendance_main）
    public final static String mainUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=" + redirectUri + "wx%2fp_attendance_main.do&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
    //不使用微信openid的时候打开注释（入口为 /wx/p_attendance_main2）
    //public final static String mainUrl = "/wx/login2.do";

    /**
     * 2019-10-09 端州微信公众号修改内容如下：
     * 1.由于端州微信不再提供公众号开发信息 所以暂时取消获取openid 改为用户登录进入
     * 2.各个模块内容异常跳转地址 由微信地址 改为自定义本地服务器地址 mainUrl 微信考勤同理
     * 3.新增 main2 和 login2 方法
     * 4.异常跳转页面把 return new ModelAndView(new RedirectView(mainUrl)); 替换为 return new ModelAndView("/ledger/wx/login2", mapData);
     */

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private WxUserService wxUserService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private TSRoleService tsRoleService;
    @Autowired
    private WxsignInService wxInService;
    @Autowired
    private WxAccesstokenService accesstokenService;

    /**
     * 微信用户进入考勤主页面
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/p_attendance_main")
    public ModelAndView sign(HttpServletRequest request) throws Exception {
        // start 获取网页授权
        Map<String, Object> mapData = new HashMap<>();
        HttpSession session = request.getSession();
        String openid = (String) session.getAttribute("openid");
        WxUser user = wxUserService.selectByOpenid(openid);
        if (user != null && user.getStatus() == 0) {//如果当前用户已经登录,且用户已经绑定
            request.getSession().setAttribute("wxuser", user);
            mapData.put("openid", user.getOpenid());
            mapData.put("type", user.getType());
            mapData.put("userId", user.getUserId());
            mapData.put("departId", 1);
            return new ModelAndView("/wx/personnel/p_main_interface", mapData);
        } else {
            JSONObject jsonObject = null;
            if (StringUtils.isEmpty(openid)) {
                String code = request.getParameter("code");// 用来获取网页授权
                if (code != null) {
                    String requestUrl = code_url.replace("CODE", code).replace("APPID", appId).replace("APPSECRET", secret);
                    jsonObject = WeixinUtil.httpRequest(requestUrl, "GET", null);
                }
                if (null != jsonObject) {
                    try {
                        if (jsonObject.getString("access_token") == null) {// 获取用户信息失败
                            return new ModelAndView("/wx/login", mapData);
                        } else {
                            openid = jsonObject.getString("openid");
                            if (!StringUtils.isEmpty(openid)) {
                                mapData.put("openid", openid);
                                request.getSession().setAttribute("openid", openid);
                                WxUser wxuser = wxUserService.selectByOpenid(openid);
                                if (wxuser != null && wxuser.getStatus() == 0) {// 用户已绑定
                                    request.getSession().setAttribute("wxuser", wxuser);
                                    mapData.put("type", wxuser.getType());
                                    mapData.put("userId", wxuser.getUserId());
                                    mapData.put("departId", 1);
                                    if (null != wxuser.getDepartId()) {
                                        TSDepart depart = departService.getById(wxuser.getDepartId());
                                        request.getSession().setAttribute("depart", depart);
                                    }
                                    return new ModelAndView("/wx/personnel/p_main_interface", mapData);
                                } else {// 用户未绑定
                                    return new ModelAndView("/wx/login", mapData);
                                }
                            }
                        }
                    } catch (Exception e) {
                        return new ModelAndView("/wx/login", mapData);
                    }
                }
            }
            return new ModelAndView("/wx/login", mapData);
        }
    }

    /**
     * 微信用户绑定平台账号
     *
     * @param bean
     * @param request
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(WxUser bean, HttpServletRequest request) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            String openid = bean.getOpenid();
            String userName = bean.getUserName();
            String password = bean.getPwd();
            if (StringUtils.isEmpty(openid)) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("获取信息失败，请进入公众号重试!");
                return jsonObject;
            }
            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("账号或密码不能为空，请重试!");
                return jsonObject;
            }
            CipherUtil cipher = new CipherUtil();
            String pwd = CipherUtil.generatePassword(password); // 加密算法
            WxUser wxUser = wxUserService.selectByUserAndPwd(userName, pwd);
            if (wxUser == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("账号或密码不正确!");
                return jsonObject;
            } else if (wxUser.getStatus() == 1) {// 已停用
                jsonObject.setSuccess(false);
                jsonObject.setMsg("该账号已停用!");
                return jsonObject;
            } else if (wxUser.getOpenid() != null) {
                if (!wxUser.getOpenid().equals(openid)) {// 被绑定的不是该openid
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该账号已被其他用户绑定!");
                    return jsonObject;
                } else {
                    jsonObject.setSuccess(true);
                    jsonObject.setMsg("登录成功");
                    request.getSession().setAttribute("wxuser", wxUser);
                    TSDepart depart = departService.getById(wxUser.getDepartId());
                    request.getSession().setAttribute("depart", depart);
                    return jsonObject;
                }
            } else if (wxUser != null && wxUser.getOpenid() == null) {// 用户没有被绑定
                WxUser wxopenid = wxUserService.selectByOpenid(openid);
                if (wxopenid != null) {// 微信已绑定账号
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("您已绑定平台账号,请退出重试!");
                    return jsonObject;
                }
            }
            Date now = new Date();
            wxUser.setOpenid(bean.getOpenid());
            wxUser.setCreate_date(now);
            wxUser.setUpdate_date(now);
            wxUserService.updateBySelective(wxUser);
            jsonObject.setSuccess(true);
            jsonObject.setMsg("绑定成功");
            request.getSession().setAttribute("wxuser", wxUser);
            TSDepart depart = departService.getById(wxUser.getDepartId());
            request.getSession().setAttribute("depart", depart);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    @RequestMapping("test")
    public ModelAndView test() throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        return new ModelAndView("/wx/list", mapData);

    }

    /**
     * 个人中心页面
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("userCenter")
    public ModelAndView userCenter(HttpServletRequest request, String openid) throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        if (StringUtils.isEmpty(openid)) {
            openid = (String) request.getSession().getAttribute("openid");
        }
        WxUser wxuser = wxUserService.selectByOpenid(openid);// 查询绑定用户
        if (wxuser == null) {//获取不到用户
            return new ModelAndView(new RedirectView(WxController.mainUrl));
        }
        TSDepart depart = (TSDepart) request.getSession().getAttribute("depart");
        if (wxuser != null) {
            mapData.put("user", wxuser);
            mapData.put("depart", depart);

        }
        return new ModelAndView("/wx/userCenter", mapData);

    }

    /**
     * 个人中心页面
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("signList")
    public ModelAndView signList(String userId, HttpServletRequest request, String openid)
            throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        if (StringUtils.isEmpty(userId)) {
            WxUser user = (WxUser) request.getSession().getAttribute("wxuser");
            if (user != null) {
                userId = user.getId().toString();
            } else {
                return new ModelAndView(new RedirectView(mainUrl));
            }
        }
        List<WxsignInModel> signs = wxInService.queryByUserId(userId, new Date());
        mapData.put("signs", signs);
        mapData.put("userId", userId);
        mapData.put("openid", openid);
        return new ModelAndView("/wx/signList", mapData);
    }

    /**
     * 打开实时监控界面
     *
     * @return
     * @author Dz
     */
    @RequestMapping("/sign_manager")
    public ModelAndView sign_manager(HttpServletRequest request, String date) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            WxUser user = (WxUser) request.getSession().getAttribute("wxuser");
            if (user != null) {
                TSDepart depart = departService.getById(user.getDepartId());
                String[] departIds = null;
                if (depart != null) {
                    String sql = "SELECT GROUP_CONCAT(id) FROM t_s_depart WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag = 0 AND id = ?), '%')";
                    departIds = jdbcTemplate.queryForObject(sql, new Object[]{depart.getId()}, String.class).split(",");
                }


                // 获取有签到记录日期
                List<String> signDates = wxInService.querySignDate(departIds);
                StringBuffer signDatesStr = new StringBuffer();
                for (String signDate : signDates) {
                    signDatesStr.append("\"" + signDate + "\",");
                }

                if (signDatesStr.length() > 0) {
                    map.put("signDates", signDatesStr.substring(0, signDatesStr.length() - 1));
                } else {
                    map.put("signDates", null);
                }
                String openid = (String) request.getSession().getAttribute("openid");
                map.put("openid", openid);
                map.put("date", date);
            } else {
                return new ModelAndView(new RedirectView(mainUrl));
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }

        return new ModelAndView("/wx/sign_manager", map);
    }

    /**
     * 根据用户查询定位信息
     *
     * @param signUserId
     * @param signDate
     * @return
     */
    @RequestMapping(value = "/getSignByUserId")
    @ResponseBody
    public AjaxJson getSignByUserId(String signUserId, Date signDate) {
        AjaxJson jsonObj = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<WxsignInModel> signs = wxInService.queryByUserId(signUserId, signDate);

            map.put("signs", signs);
            jsonObj.setObj(map);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 微信用户绑定平台账号
     *
     * @param bean
     * @return
     */
    @RequestMapping(value = "/saveSign")
    @ResponseBody
    public AjaxJson saveSign(WxsignIn bean, String openid) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (openid == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("获取用户信息失败，请登录公众号重试!");
            }
            WxUser wxuser = wxUserService.selectByOpenid(openid);// 查询绑定用户
            if (wxuser != null) {
                Date now = new Date();
                bean.setSignType((short) 0);
                bean.setCreateBy(wxuser.getId().toString());
                bean.setCreateDate(now);
                bean.setUpdateBy(wxuser.getId().toString());
                bean.setUpdateDate(now);
                wxInService.insertSelective(bean);
                //根据外勤签到去创建或更新每日统计数据信息
                //dailyStatisticsService.saveOrUpdateBySign(wxuser, bean, now);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("签到成功!.");
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("绑定用户已失效请重新绑定");
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 微信账号管理页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("wxManage")
    public ModelAndView wxManage(HttpSession session)
            throws Exception {
        Map<String, Object> mapData = new HashMap<>();
        TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        DepartTreeModel departTree = null;
        List<TSRole> roleList = tsRoleService.getRoleList();

        if (null != tsUser.getDepartId()) {
            departTree = departService.getDepartPoint(tsUser.getDepartId());
        }
        mapData.put("roleList", roleList);
        mapData.put("departTree", departTree);
        return new ModelAndView("/wx/wxManage", mapData);
    }

    /**
     * 微信账号管理删除
     *
     * @param ids
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            Integer[] idas = new Integer[ida.length];
            for (int i = 0; i < ida.length; i++) {
                idas[i] = Integer.parseInt(ida[i]);
            }
            wxUserService.delete(idas);
            //dailyStatisticsService.delete(idas);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 获取实时监控数据
     *
     * @param signDate 签到时间
     * @return
     * @author
     */
    @RequestMapping(value = "/getLocations")
    @ResponseBody
    public AjaxJson getLocations(HttpServletRequest request, Date signDate, String realname) {
        AjaxJson jsonObj = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSDepart depart = (TSDepart) request.getSession().getAttribute("depart");
            if (depart == null) {
                depart = PublicUtil.getSessionUserDepart();
            }
            Integer departId = depart.getId();
            if (signDate == null) {
                signDate = new Date();
            }
            String sd = DateUtil.date_sdf.format(signDate);

//			List<TbSignInModel> signs = tbSignInService.queryByDepartIds(departIds, sd+" 00:00:00", sd+" 23:59:59");
            List<WxsignInModel> signs = wxInService.queryByDepartIds(departId, sd, realname);

		/*	map.put("points", points);
            map.put("cars", cars);
			map.put("jydws", jydws);
			map.put("scdws", scdws);
			map.put("cydws", cydws);
			*/
            map.put("signs", signs);
            jsonObj.setObj(map);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 数据列表
     *
     * @return
     * @throws MissSessionExceprtion
     * @throws Exception
     */
    @RequestMapping(value = "datagrid")
    @ResponseBody
    public AjaxJson datagrid(UserRoleModel model, Page page) throws MissSessionExceprtion {
        AjaxJson jsonObj = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        try {
            page.setOrder("ASC");
            if (null != user.getPointId()) {
                model.setDepartId(null);
                model.setPointId(user.getPointId());
            } else {
                model.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
                // model.setDepartId(user.getDepartId());
                model.setPointId(null);
            }
            page = wxUserService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return jsonObj;
    }

    /**
     * 微信用户绑定平台账号
     *
     * @return
     * @throws MissSessionExceprtion
     */
    @RequestMapping(value = "/deleteOpenid")
    @ResponseBody
    public AjaxJson deleteOpenid(Integer id) throws MissSessionExceprtion {
        AjaxJson jsonObject = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        try {
            WxUser wxuser = wxUserService.selectByPrimaryKey(id);
            if (wxuser != null) {
                Date now = new Date();
                wxuser.setOpenid(null);
                wxuser.setDelete_date(now);
                wxuser.setUpdate_by(user.getId());
                wxUserService.updateById(wxuser);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("解绑成功");
            } else {
                jsonObject.setSuccess(true);
                jsonObject.setMsg("获取用户信息失败或该用户未绑定!");
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 通过userId查询是否有权限绑定微信
     *
     * @return
     */
    @RequestMapping(value = "queryByUserId")
    @ResponseBody
    public AjaxJson queryByUserId(Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        WxUser user = new WxUser();
        user.setStatus((short) 0);
        try {
            if (id != null) {
                user = wxUserService.selectByPrimaryKey(id);
            }
            jsonObj.setObj(user);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作异常.");
        }
        return jsonObj;
    }

    /**
     * 平台给用添加绑定微信权限
     *
     * @return
     */
    @RequestMapping(value = "addUser")
    @ResponseBody
    public AjaxJson addUser(WxUser bean) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String userId = bean.getUserId();
            if (StringUtils.isEmpty(userId)) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("获取用户信息失败，请重试");
                return jsonObj;
            }
            WxUser wxuser = wxUserService.selectByUserId(userId);
            if (wxuser == null) {
                wxUserService.insertSelective(bean);
            } else {
                bean.setId(wxuser.getId());
                bean.setDelete_flag((short) 0);
                // if(bean.getStatus().equals(0))
                if (bean.getStatus() == 0) {// 没有权限
                    bean.setType((short) 2);//说明没有类型
                    wxUserService.updateById(bean);
                } else if (bean.getStatus() == 1) {// 有权限
                    wxUserService.updateBySelective(bean);
                }
            }
            jsonObj.setSuccess(true);
            jsonObj.setMsg("操作成功.");
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作异常.");
        }
        return jsonObj;
    }

    /**
     * 打开实时监控界面
     *
     * @param functionId 菜单ID
     * @return
     * @author Dz
     */
    @RequestMapping("/monitorMap")
    public ModelAndView monitorMap(String functionId) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            TSDepart depart = PublicUtil.getSessionUserDepart();
            String[] departIds = null;
            if (depart != null) {
                String sql = "SELECT GROUP_CONCAT(id) FROM t_s_depart WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag = 0 AND id = ?), '%')";
                departIds = jdbcTemplate.queryForObject(sql, new Object[]{depart.getId()}, String.class).split(",");
            }

            // 获取有签到记录日期
            List<String> signDates = wxInService.querySignDate(departIds);
            StringBuffer signDatesStr = new StringBuffer();
            for (String signDate : signDates) {
                signDatesStr.append("\"" + signDate + "\",");
            }

            if (signDatesStr.length() > 0) {
                map.put("signDates", signDatesStr.substring(0, signDatesStr.length() - 1));
            } else {
                map.put("signDates", null);
            }
            map.put("functionId", functionId);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/wx/monitorMap", map);
    }

    /**
     * 打开实时监控界面
     *
     * @return
     * @author Dz
     */
    @RequestMapping("/map")
    public ModelAndView map(String lat, String lng) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map.put("lat", lat);
            map.put("lng", lng);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/wx/map", map);
    }

    /**
     * 打开签到页面
     *
     * @return
     * @author Dz
     */
    @RequestMapping("/signmap")
    public ModelAndView signmap(String openid, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (StringUtils.isEmpty(openid)) {
                openid = (String) request.getSession().getAttribute("openid");
            }
            map.put("openid", openid);
            WxUser user = wxUserService.selectByOpenid(openid);
            if (user != null) {
                String userId = user.getUserId();
                map.put("userId", userId);
            } else {
                return new ModelAndView(new RedirectView(mainUrl));
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/wx/sign", map);
    }

    /**
     * 新增编辑微信用户
     *
     * @param bean
     * @return
     */
    @RequestMapping(value = "saveUser")
    @ResponseBody
    public AjaxJson saveUser(WxUser bean) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (bean.getDepartId() == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("添加失败，请选择所属机构!");
                return jsonObject;
            }
            WxUser model = wxUserService.getUserByUserName(bean.getUserName());
            Date now = new Date();
            TSUser user = PublicUtil.getSessionUser();
            bean.setUpdate_by(user.getId());
            bean.setUpdate_date(now);
            if (bean.getId() == null) {// 新增数据
                if (model == null) {
                    bean.setCreate_by(user.getId());
                    bean.setCreate_date(now);
                    CipherUtil cipher = new CipherUtil();
                    bean.setPassword(CipherUtil.generatePassword(bean.getPassword())); //加密
                    wxUserService.insertSelective(bean);
                    //shit:新增人员时，同时去新增该人员的每日统计数据
                    /*if (bean.getStatus() == 0) {
                        dailyStatisticsService.createDSMInCreateUser(bean, now);
                    }*/
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该登录账户已存在，请重新输入.");
                }
            } else {// 修改数据
                if (model == null || bean.getId().equals(model.getId())) {
                    PublicUtil.setCommonForTable(bean, false);
                    if (StringUtil.isNotEmpty(bean.getPassword())) {
                        CipherUtil cipher = new CipherUtil();
                        bean.setPassword(CipherUtil.generatePassword(bean.getPassword())); //加密
                    }
                    wxUserService.updateBySelective(bean);
                    //编辑用户的时候根据用户的id和当前时间去更新每日统计数据
                    //dailyStatisticsService.updateByUser(bean.getStatus(),bean.getId(),now);
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该登录账户已存在，请重新输入.");
                }
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }


    /**
     * 平台获取未绑定账号
     *
     * @return
     */
    @RequestMapping(value = "getUser")
    @ResponseBody
    public AjaxJson getUser() {
        AjaxJson jsonObject = new AjaxJson();
        try {
            List<WxUser> user = wxUserService.selectByDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            jsonObject.setObj(user);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    @RequestMapping(value = "wechatController", params = "wechat", method = RequestMethod.GET)
    public void wechatGet(HttpServletRequest request,
                          HttpServletResponse response,
                          @RequestParam(value = "signature") String signature,
                          @RequestParam(value = "timestamp") String timestamp,
                          @RequestParam(value = "nonce") String nonce,
                          @RequestParam(value = "echostr") String echostr) {
//需要修改的地
        if (SignUtil.checkSignature("dzfda", signature,
                timestamp, nonce)) {
            try {
                response.getWriter().print(echostr);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    /**
     * 获取jssdk权限
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("getsign")
    @ResponseBody
    public AjaxJson getsign(HttpServletRequest request)
            throws Exception {
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        AjaxJson jsonObject = new AjaxJson();
        String jspurl = request.getParameter("jspurl");
        Map<String, Object> ret = new HashMap<String, Object>();
        String access_token = null;
        String jsapi_ticket = null;
        WxAccesstoken accesstoken = accesstokenService.queryById("1");// 先获取数据库中的token
        if (accesstoken != null && accesstoken.getAccesstoken() != null) {
            access_token = accesstoken.getAccesstoken();
            jsapi_ticket = accesstoken.getJsapiticket();

        } else {
            access_token = "huhongtao";
        }
        ret = WeixinUtil.getWxConfig(request, appId, secret, access_token, jsapi_ticket, jspurl);
        jsonObject.setObj(ret);
        String token = (String) ret.get("access_token");
        jsapi_ticket = (String) ret.get("jsapi_ticket");
        WxAccesstoken bean = new WxAccesstoken();
        bean.setAccesstoken(token);
        bean.setAddtime(new Date());
        if (jsapi_ticket != null) {
            bean.setJsapiticket(jsapi_ticket);
        }
        bean.setId("1");
        if (accesstoken == null) {
            accesstokenService.insert(bean);
        } else {
            accesstokenService.updateById(bean);
        }

        return jsonObject;
    }

    /**
     * 考勤人员导出
     *
     * @param request
     * @param response
     * @param types
     * @return
     */
    @RequestMapping(value = "/exportFile")
    @ResponseBody
    private ResponseEntity<byte[]> exportFile(HttpServletRequest request, Page page, HttpServletResponse response, String types, UserRoleModel model) {
        ResponseEntity<byte[]> responseEntity = null;
        String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("storageDirectory") + "business/";
        File logoSaveFile = new File(rootPath);
        if (!logoSaveFile.exists()) {
            logoSaveFile.mkdirs();
        }
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        try {
            SXSSFWorkbook workbook = null;
            TSUser tsUser = PublicUtil.getSessionUser();
            //数据处理
            if (null != tsUser.getPointId()) {
                model.setDepartId(null);
                model.setPointId(tsUser.getPointId());
            } else {
                model.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
                model.setPointId(null);
            }

            page.setOrder("ASC");
            page.setPageSize(10000000);
            page = wxUserService.loadDatagrid(page, model);
            @SuppressWarnings("unchecked")
            List<WxUser> WxUsers = (List<WxUser>) page.getResults();

            for (WxUser wxUser : WxUsers) {
                if (StringUtils.isEmpty(wxUser.getOpenid())) {//绑定微信号为空
                    wxUser.setOpenid("未绑定");
                } else {
                    wxUser.setOpenid("已绑定");
                }

                if (wxUser.getType() == 1) {// 用Remark字段代替人员类型
                    wxUser.setParam1("管理人员");
                } else {
                    wxUser.setParam1("签到人员");
                }

                if (wxUser.getType() == 1) {//用rolename带替状态
                    wxUser.setParam2("停用");
                } else {
                    wxUser.setParam2("启用");
                }
            }
            if ("word".equals(types)) {
                String docName = fileName + ".doc";
                        /*ItextTools.createDepartWordDocument(rootPath, rootPath + docName, Excel.BUSINESS_HEADERS, list, null, request);*/
                responseEntity = DyFileUtil.download(request, response, rootPath, docName);
                return responseEntity;
            }
            String xlsName = fileName + ".xlsx";
            workbook = new SXSSFWorkbook(100);
            Excel.outputExcelFile(workbook, Excel.wx_user_HEADERS, Excel.wx_user_FIELDS, WxUsers, rootPath + xlsName, "2","");
            FileOutputStream fOut = new FileOutputStream(rootPath + xlsName);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            if ("excel".equals(types)) {
                responseEntity = DyFileUtil.download(request, response, rootPath, xlsName);
            } else if ("pdf".equals(types)) {
                if (!getLicense()) {
                    return null;
                }
                Workbook wb = new Workbook(rootPath + xlsName);
                String pdfName = fileName + ".pdf";
                wb.removeExternalLinks();
                wb.save(new FileOutputStream(new File(rootPath + pdfName)), SaveFormat.PDF);
                responseEntity = DyFileUtil.download(request, response, rootPath, pdfName);
            }

        } catch (Exception e) {
            e.printStackTrace();
            log.error("**********************" + e.getMessage() + e.getStackTrace());
        }

        return responseEntity;
    }

    public static boolean getLicense() {
        boolean result = false;
        try {
            InputStream is = BaseController.class.getClassLoader().getResourceAsStream("\\license.xml");
            License aposeLic = new License();
            aposeLic.setLicense(is);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //=================以下为停用openid 相关代码（实际openid为后台自动生成的UUID,而不是微信提供的openid）=====================

    @RequestMapping("login2")
    public ModelAndView login2() throws Exception {
        return new ModelAndView("/wx/login2");
    }

    @RequestMapping("/p_attendance_main2")
    public ModelAndView p_attendance_main2(HttpServletRequest request) throws Exception {
        // start 获取网页授权
        Map<String, Object> mapData = new HashMap<>();
        HttpSession session = request.getSession();
        String openid = (String) session.getAttribute("openid");
        WxUser user = wxUserService.selectByOpenid(openid);
        if (user != null && user.getStatus() == 0) {//如果当前用户已经登录,且用户已经绑定
            request.getSession().setAttribute("wxuser", user);
            mapData.put("openid", user.getOpenid());
            mapData.put("type", user.getType());
            mapData.put("userId", user.getUserId());
            mapData.put("departId", 1);
            return new ModelAndView("/wx/personnel/p_main_interface", mapData);
        } else {
            return new ModelAndView("/wx/login2", mapData);
        }
    }

    @RequestMapping(value = "/save2")
    @ResponseBody
    public AjaxJson save2(WxUser bean, HttpServletRequest request) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            String userName = bean.getUserName();
            String password = bean.getPwd();

            if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("账号或密码不能为空，请重试!");
                return jsonObject;
            }
            CipherUtil cipher = new CipherUtil();
            String pwd = CipherUtil.generatePassword(password); // 加密算法
            WxUser wxUser = wxUserService.selectByUserAndPwd(userName, pwd);
            if (wxUser == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("账号或密码不正确!");
                return jsonObject;
            } else if (wxUser.getStatus() == 1) {// 已停用
                jsonObject.setSuccess(false);
                jsonObject.setMsg("该账号已停用!");
                return jsonObject;
            }
            if (StringUtils.isEmpty(wxUser.getOpenid())) {// 用户没有被openId 生成一个
                Date now = new Date();
                wxUser.setOpenid(UUIDGenerator.generate());
                wxUser.setCreate_date(now);
                wxUser.setUpdate_date(now);
                wxUserService.updateBySelective(wxUser);
            }
            jsonObject.setSuccess(true);
            jsonObject.setMsg("绑定成功");
            request.getSession().setAttribute("wxuser", wxUser);
            TSDepart depart = departService.getById(wxUser.getDepartId());
            request.getSession().setAttribute("depart", depart);
            request.getSession().setAttribute("openid", wxUser.getOpenid());
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }


    /**
     * 微信端修改账号密码
     *
     * @param bean
     * @param newPwd   新密码
     * @return
     */
    @RequestMapping(value = "changePwd")
    @ResponseBody
    public AjaxJson changePwd(HttpServletRequest request, WxUser bean, String newPwd) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            WxUser user = wxUserService.queryById(bean.getId());
            Date now = new Date();
            user.setUpdate_by(bean.getId().toString());//微信考勤用户
            user.setUpdate_date(now);
            CipherUtil cipher = new CipherUtil();
            if (bean.getPassword().equals("") || bean.getPassword() == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("旧密码不能为空");
                return jsonObject;
            }
            String oldPwd = CipherUtil.generatePassword(bean.getPassword());
            if (!user.getPassword().equals(oldPwd)) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("旧密码不正确!");
                return jsonObject;
            }
            user.setPassword(CipherUtil.generatePassword(newPwd));
            wxUserService.updateBySelective(user);
            request.getSession().setAttribute("wxuser", user);
            jsonObject.setMsg("修改密码成功!");
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

}
