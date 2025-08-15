package com.dayuan.logs.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan.logs.bean.SysLog;
import com.dayuan.logs.model.SysLogModel;
import com.dayuan.logs.service.SysIpAdressService;
import com.dayuan.logs.service.SysLogService;
import com.dayuan.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.*;

@RequestMapping("/sysLog")
@Controller
public class SysLogController extends BaseController {
    private Logger log = Logger.getLogger(SysLogController.class);
    @Autowired
    private SysLogService sysLogService;
    @Autowired
    private SysIpAdressService ipAdressService;

    /**
     * 进入用户日志列表页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(@RequestParam(required = false) String userName) {
        Map<String, Object> map = new HashMap<>();
        if (StringUtil.isNotEmpty(userName)) {
            SysLog bean = new SysLog(userName, "用户管理", "登录",(short)0);
            map.put("bean", bean);
        } else {
            map.put("bean", null);
        }
        return new ModelAndView("/syslog/sys_list", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(SysLogModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("asc");
            page = sysLogService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 进入详情页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/detail")
    public ModelAndView detail(@RequestParam(required = false) Integer id) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        return new ModelAndView("/syslog/sys_detail", map);
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        SysLog bean = null;
        try {
            bean = sysLogService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        jsonObject.setObj(bean);
        return jsonObject;
    }

    @RequestMapping("/queryAllModule")
    @ResponseBody
    public AjaxJson queryAllModule() {
        AjaxJson jsonObject = new AjaxJson();
        try {
            List<String> moduleList = sysLogService.queryAllModule();
            jsonObject.setObj(moduleList);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * @return
     * @Description 刷新IP地址对应的物理地址
     * 1.请求ip 138接口更新历史库
     * 2.更新当前数据对应的物理地址
     * @Date 2022/03/10 9:26
     * @Author xiaoyl
     * @Param
     */
    @RequestMapping("/refreshAddress")
    @ResponseBody
    public AjaxJson refreshAddress(Integer id) {
        AjaxJson jsonObject = new AjaxJson();
        SysLog bean = null;
        try {
            bean = sysLogService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            String systemAddress = ipAdressService.syncDealIPAddress(bean.getRemoteIp());
           if(StringUtils.isNotBlank(systemAddress)) {
               bean.setParam1(systemAddress);
               sysLogService.updateBySelective(bean);
           }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常."+e.getMessage());
        }
        jsonObject.setObj(bean);
        return jsonObject;
    }
}
