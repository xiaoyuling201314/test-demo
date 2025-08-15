package com.dayuan3.common.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan.model.BaseModel;
import com.dayuan.util.DateUtil;
import com.dayuan.util.ReflectHelper;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.model.SysOperationLogModel;
import com.dayuan3.common.model.SysPayLogModel;
import com.dayuan3.common.model.SysPrintLogModel;
import com.dayuan3.common.service.SysManageLogService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.Map;

/**
 * Author: shit
 * Date: 2019-09-17 09:53
 * Content:系统日志管理
 */
@Controller
@RequestMapping("/sysManageLog")
public class SysManageLogController extends BaseController {

    private Logger log = Logger.getLogger(SysManageLogController.class);

    @Autowired
    private SysManageLogService sysManageLogService;

    @RequestMapping("/list")
    public String list(Model model) {
        String start = DateUtil.xDayAgo(-30);
        String end = DateUtil.date_sdf.format(new Date());
        model.addAttribute("start", start);
        model.addAttribute("end", end);
        return "/syslog/list";
    }

    /**
     * 用户操作日志
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/operation/datagrid")
    @ResponseBody
    public AjaxJson operationDatagrid(SysOperationLogModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            model = (SysOperationLogModel) setStartAndEndDate(model, page);
            page = sysManageLogService.loadOperationLogDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 报告打印日志
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/print/datagrid")
    @ResponseBody
    public AjaxJson printDatagrid(SysPrintLogModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            model = (SysPrintLogModel) setStartAndEndDate(model, page);
            page = sysManageLogService.loadPrintLogDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     *
     *
     */
    private BaseModel setStartAndEndDate(BaseModel model, Page page) throws Exception {
        ReflectHelper reflectHelper = new ReflectHelper(model);
        //高级搜索时间范围，当高级搜索时，时间范围清空，然后高级搜索的结束时间没填就默认为今天
        Map<String, String> dateMap = page.getDateMap();
        if (null != dateMap) {
            String operateTimeStartDate = dateMap.get("operateTimeStartDate");
            String operateTimeEndDate = dateMap.get("operateTimeEndDate");
            if (StringUtil.isNotEmpty(operateTimeStartDate)) {
                reflectHelper.setMethodValue("operateTimeStart", operateTimeStartDate);
            }
            if (StringUtil.isNotEmpty(operateTimeEndDate)) {
                reflectHelper.setMethodValue("operateTimeEnd", operateTimeEndDate);
            } else {
                reflectHelper.setMethodValue("operateTimeEnd", DateUtil.date_sdf.format(new Date()) + " 23:59:59");
            }
        }
        return model;
    }

    /**
     * 付款日志
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pay/datagrid")
    @ResponseBody
    public AjaxJson payDatagrid(SysPayLogModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            model = (SysPayLogModel) setStartAndEndDate(model, page);
            page = sysManageLogService.loadPayLogDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
}
