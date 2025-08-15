package com.dayuan3.admin.controller;

import cn.dev33.satoken.stp.StpUtil;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.ValidformJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.util.CipherUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.model.InspectionUnitUserModel;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.common.bean.InspectionUnitUserLabel;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.bean.baseInspectionUnit;
import com.dayuan3.common.service.CommonDataService;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUnitUserLabelService;
import com.dayuan3.common.service.InspectionUnitUserRequesterService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.terminal.bean.InsUnitReqUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.service.InsUnitReqUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.terminal.service.RequesterUnitTypeService;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Description 用户管理
 * @Author xiaoyl
 * @Date 2025/6/10 15:47
 */
@RestController
@RequestMapping("/inspUnitUser")
public class InspectionUnitUserController extends BaseController {
    private Logger log = Logger.getLogger(InspectionUnitUserController.class);

    @Autowired
    private InspectionUnitUserService insUnitUserService;
    @Autowired
    private InspectionUnitService inspectionUnitService;
    @Autowired
    private CommonDataService dataService;
    @Autowired
    private CommonLogUtilService logUtil;
    @Autowired
    private InspectionUnitUserService inspectionUnitUserService;

    @Autowired
    private InspectionUnitUserLabelService labelService;

    @Autowired
    private InspectionUnitUserRequesterService inspectionUnitUserRequesterService;

    @Autowired
    private InsUnitReqUnitService insUnitReqUnitService;
    @Autowired
    private RequesterUnitTypeService requesterTypeService;

    /**
     * 送检用户页面
     *
     * @param inspUnitId 送检单位ID
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(int inspUnitId) {
        Map<String, Object> map = new HashMap<String, Object>();

        Integer coldUnitId = null;
        InspectionUnit inspectionUnit=inspectionUnitService.queryUnitById(inspUnitId);
        if (inspectionUnit!=null) {;
            coldUnitId=inspectionUnit.getColdUnitId();
        }
        map.put("coldUnitId", coldUnitId);
        map.put("inspUnitId", inspUnitId);

        return new ModelAndView("/terminal/inspUnitUser/list", map);
    }


    /**
     * 送检用户页面
     *
     * @param id 送检用户id
     * @return
     */
    @RequestMapping("/saveOrUpdate")
    public ModelAndView saveOrUpdate(Model model, Integer id) {
        List<RequesterUnitType> list = requesterTypeService.queryAllType();
        List<baseInspectionUnit> inspectionList = dataService.queryInspection();//查询送检单位
        model.addAttribute("inspectionListObj", JSONArray.fromObject(inspectionList));
        model.addAttribute("id", id);
        model.addAttribute("reqListType", list);//单位类型
        return new ModelAndView("/terminal/inspUnitUser/add");
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    public AjaxJson datagrid(InspectionUnitUserModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = insUnitUserService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping(value = "/save")
    public AjaxJson save(InspectionUnitUser bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (bean.getId() == null) {
                String nextAccount = insUnitUserService.getNextAccount();
                bean.setAccount(nextAccount);
                String pwd = CipherUtil.generatePassword(bean.getPassword());
                bean.setPassword(pwd);
                PublicUtil.setCommonForTable(bean, true);
                /*if (bean.getInspectionId() != null) {
                    int count = insUnitUserService.queryCountByInspectId(bean.getInspectionId());
                    if (count > 0) {
                        bean.setType(0);//注册默认普通用户
                    } else {
                        bean.setType(1);//注册默认管理员
                    }
                } else {
                    bean.setType(0);//注册默认普通用户
                }*/
                insUnitUserService.insertSelective(bean);
                //保存操作日志
                insUnitUserService.insertOperationLog(bean, new Short("0"), new Short("0"), log);
            } else {
                /*if(bean.getUserType() ==0){//如果是个人就把企业关联ID设置为null
                    bean.setInspectionId(null);
                }*/
                InspectionUnitUser user = insUnitUserService.queryById(bean.getId());
                if (!user.getPassword().equals(bean.getPassword())) {
                    String pwd = CipherUtil.generatePassword(bean.getPassword());
                    bean.setPassword(pwd);
                }
                bean.setLoginCount(user.getLoginCount());
                PublicUtil.setCommonForTable(bean, false);
                insUnitUserService.updateBySelective(bean);
                //编辑用户，踢人下线，迫使前端用户token失效，重新登录
                StpUtil.logout("S_" + bean.getId(), "WX");
                //保存操作日志
                insUnitUserService.insertOperationLog(bean, new Short("0"), new Short("1"), log);
            }
        } catch (Exception e) {
            insUnitUserService.insertOperationLog(bean, new Short("1"), null, log);
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    public AjaxJson queryById(Integer id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        InspectionUnitUser bean = null;
        try {
            bean = insUnitUserService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param request
     * @param response
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            insUnitUserService.delete(ids);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 进入送检用户个人信息页面
     *
     * @return
     */
    @RequestMapping("/queryInfo")
    public ModelAndView queryInfo(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("success", "true");
        InspectionUnitUser userInfo;
        try {
            userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            userInfo = insUnitUserService.queryById(userInfo.getId());
            InspectionUnit unitInfo = inspectionUnitService.queryById(userInfo.getInspectionId());
            map.put("userInfo", userInfo);
            map.put("unitInfo", unitInfo);
            map.put("inspectionUnitPath", WebConstant.res.getString("inspectionUnitPath"));
        } catch (Exception e) {
            log.info("个人信息查询失败：" + e.getMessage());
            map.put("success", "false");
        }
        return new ModelAndView("/terminal/userInfo", map);
    }


    /**
     * 送检用户 - 登录账号重复验证
     *
     * @param userId   用户ID
     * @param userName 登录账号
     * @return
     */
    @RequestMapping("/selectByUsername")
    public ValidformJson selectByUsername(Integer userId, String userName) {
        ValidformJson json = new ValidformJson();
        try {
            InspectionUnitUser user = insUnitUserService.selectByUsername(userName);
            if (user != null && !user.getId().equals(userId)) {
                json.setStatus("n");
                json.setInfo("该登录账号已存在！");
            }
        } catch (Exception e) {
            json.setStatus("n");
            json.setInfo("操作失败");
        }
        return json;
    }

    /**
     * 送检用户 - 登录账号重复验证
     *
     * @param userId 用户ID
     * @param phone  登录账号
     * @return
     */
    @RequestMapping("/selectByPhone")
    public ValidformJson selectByPhone(Integer userId, String phone) {
        ValidformJson json = new ValidformJson();
        try {
            InspectionUnitUser user = insUnitUserService.selectByPhone(phone);
            if (user != null && !user.getId().equals(userId)) {
                json.setStatus("n");
                json.setInfo("该手机号码已存在！");
            }
        } catch (Exception e) {
            json.setStatus("n");
            json.setInfo("操作失败");
        }
        return json;
    }

    /**
     * 送检账号界面（查询所有的送检账号，包括企业和个人）
     *
     * @return
     */
    @RequestMapping("/listAll")
    public ModelAndView listAll() {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<baseInspectionUnit> inspectionList = dataService.queryInspection();//查询送检单位
            map.put("inspectionList", inspectionList);
            map.put("inspectionListObj", JSONArray.fromObject(inspectionList));
            List<RequesterUnitType> list = requesterTypeService.queryAllType();
            map.put("reqListType", list);  //单位类型
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/inspUnitUser/listAll", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid_all")
    public AjaxJson datagridAll(InspectionUnitUserModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = insUnitUserService.loadDatagridAll(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 解除送检账号微信绑定
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/del_openid")
    public AjaxJson delOpenid(Integer id, HttpServletRequest request) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            InspectionUnitUser iuu = insUnitUserService.queryById(id);
            if (iuu != null) {
                PublicUtil.setCommonForTable(iuu, false);
                insUnitUserService.delOpenid(iuu);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("解绑成功");
                //前端用户踢出下线
                StpUtil.logout("S_" + iuu.getId(), "WX");
                logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "del_openid", "微信解绑",
                        true, "送检账号微信解绑成功 用户编号[" + id + "]", request);
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("获取用户信息失败或该用户未绑定!");
                logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "del_openid", "微信解绑",
                        false, "获取用户信息失败或该用户未绑定! 用户编号[" + id + "]", request);
            }
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
            logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "del_openid", "微信解绑",
                    false, e.getMessage() + " 用户编号[" + id + "]", request);
        }
        return jsonObject;
    }

    /**
     * 重置送检账号支付密码
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/resetpwd")
    public AjaxJson resetpwd(Integer id, HttpServletRequest request) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            InspectionUnitUser iuu = insUnitUserService.queryById(id);
            if (iuu != null) {
                PublicUtil.setCommonForTable(iuu, false);
                insUnitUserService.resetpwd(iuu);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("清除支付密码成功");
                //保存操作日志
                logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "resetpwd", "清除支付密码",
                        true, "清除支付密码成功 用户编号[" + id + "]", request);
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("获取用户信息失败!");
                //保存操作日志
                logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "resetpwd", "清除支付密码",
                        false, "获取用户信息失败! 用户编号[" + id + "]", request);
            }
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
            //保存操作日志
            logUtil.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_USER, InspectionUnitUserController.class.toString(), "resetpwd", "清除支付密码",
                    false, e.getMessage() + " 用户编号[" + id + "]", request);
        }
        return jsonObject;
    }


    /**
     * 重置送检账号支付密码
     *
     * @param id               送检账号ID
     * @param identifiedNumber 送检账号的身份证号码
     * @return
     */
    @RequestMapping(value = "/checkNumber")
    public ValidformJson checkNumber(Integer id, String identifiedNumber) {
        ValidformJson json = new ValidformJson();
        try {
            int num = insUnitUserService.selcetNumber(id, identifiedNumber);
            if (num > 0) {
                json.setStatus("n");
                json.setInfo("该身份证号码已被使用！");
            } else {
                json.setInfo("");
            }
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            json.setStatus("n");
            json.setInfo("操作失败");
        }
        return json;
    }

    /**
     * 查看用户信息-通过账户余额进入该界面
     *
     * @param userId 数据记录id
     * @throws Exception
     */
    @RequestMapping("/queryByBalanceMgt")
    public ModelAndView queryByBalanceMgt(Model model, String userId) {
        try {
            model.addAttribute("userId", userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/terminal/inspUnitUser/user");
    }

    /**
     * 查看用户信息-通过账户余额进入该界面
     *
     * @param userId 数据记录id
     * @throws Exception
     */
    @RequestMapping("/queryByUserId")
    public AjaxJson queryByUserId(Integer userId) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            InspectionUnitUser inspectionUnitUser = inspectionUnitUserService.queryByUserId(userId);
            ajaxJson.setObj(inspectionUnitUser);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setMsg("查看信息失败!");
            ajaxJson.setSuccess(false);
        }
        return ajaxJson;
    }

    /**
     * 设置默认的委托单位标签
     *
     * @param request
     * @param response
     * @param id        标签ID
     * @param isdefault 是否默认：0否1是
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年1月8日
     */
    @RequestMapping("/setDefaultlabel")
    public AjaxJson setDefaultlabel(HttpServletRequest request, HttpServletResponse response, Integer id, Short isdefault) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            InspectionUnitUser userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            if (isdefault == 0) {//设置为非默认标签
                InspectionUnitUserLabel bean = labelService.queryById(id);
                bean.setIsdefault(isdefault);
                bean.setUpdateBy(userInfo.getId().toString());
                bean.setUpdateDate(new Date());
                labelService.updateBySelective(bean);
            } else {////设置为默认标签,将其他标签设置为非默认标签
                labelService.updateSetDefault(userInfo.getId(), id);
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 编辑送检用户--委托单位标签
     *
     * @param request
     * @param labelId
     * @param operatorType edit:委托单位标签编辑 add:委托单位全表搜索
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年1月9日
     */
    @RequestMapping("/queryLabelById")
    public ModelAndView queryLabelById(HttpServletRequest request, Integer labelId, @RequestParam(required = false) String operatorType) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            InspectionUnitUser userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            if (userInfo == null) {
                map.put("success", "false");
            }
            InspectionUnitUserLabel bean = labelService.queryById(labelId);
            map.put("bean", bean);
            map.put("operatorType", operatorType);
        } catch (Exception e) {
            log.info("个人信息查询失败：" + e.getMessage());
            map.put("success", "false");
        }
        return new ModelAndView("/terminal/labelInfo", map);
    }

    /**
     * 加载待选委托单位列表
     *
     * @param request
     * @param response
     * @param id
     * @param keyWords 搜索委托单位
     * @param isQuery  是否查询已选列表
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年1月9日
     */
    @RequestMapping("/loadInspectionUnit")
    public AjaxJson loadInspectionUnit(HttpServletRequest request, HttpServletResponse response, Integer id, String keyWords, Boolean isQuery) {
        AjaxJson jsonObj = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            InspectionUnitUser userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            if (userInfo == null) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("用户登录失效！");
            }
            List<InsUnitReqUnit> list = insUnitReqUnitService.loadInspectionUnit(userInfo.getInspectionId(), id, keyWords);
            map.put("list", list);
            if (isQuery) {
                List<InspectionUnitUserRequester> labelList = inspectionUnitUserRequesterService.selectByLabelId(id);
                map.put("labelList", labelList);
            }
            jsonObj.setAttributes(map);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 新增编辑标签
     *
     * @param bean
     * @param request
     * @param response
     * @param details
     * @return
     */
    @RequestMapping(value = "/saveLabel")
    public AjaxJson saveLabel(InspectionUnitUserLabel bean, HttpServletRequest request, HttpServletResponse response, String details, Integer[] deleteIds) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            InspectionUnitUser user = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            bean.setUserId(user.getId());
            bean.setCreateBy(user.getId().toString());
            bean.setUpdateBy(user.getId().toString());
            List<InspectionUnitUserRequester> listDetail = com.alibaba.fastjson.JSONArray.parseArray(details, InspectionUnitUserRequester.class);
            labelService.save(bean, listDetail, deleteIds);
            jsonObject.setMsg("保存成功");
        } catch (Exception e) {
            log.error("**************************" + e.getMessage());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败!");
        }
        return jsonObject;
    }

    /**
     * 根据委托单位标签查询委托单位列表
     *
     * @param request
     * @param response
     * @param id       为0时表示查询该委托单位下的所有数据
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年1月9日
     */
    @RequestMapping("/loadRequestByLableId")
    public AjaxJson loadRequestByLableId(HttpServletRequest request, HttpServletResponse response, Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            InspectionUnitUser userInfo = (InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
            if (userInfo == null) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("用户登录失效！");
            }
            List<InspectionUnitUserRequester> list = null;
            if (id != 0) {
                list = inspectionUnitUserRequesterService.selectByLabelId(id);
            } else {
//           		List<InsUnitReqUnit> labelList=insUnitReqUnitService.loadInspectionUnit(userInfo.getInspectionId(),0,null);
                list = labelService.selectAllLabelList(userInfo.getInspectionId(), userInfo.getId());
            }
            jsonObj.setObj(list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 送检用户停用或者启用用户方法
     *
     * @param stopId 用户ID
     * @return
     */
    @RequestMapping("/stop")
    public AjaxJson stop(Integer stopId, Short checked) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser sessionUser = PublicUtil.getSessionUser();
            insUnitUserService.stop(stopId, checked, sessionUser.getId(), new Date());
            StpUtil.logout("S_" + stopId, "WX");
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

}
