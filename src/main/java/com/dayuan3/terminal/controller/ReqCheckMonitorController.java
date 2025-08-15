package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.util.DateUtil;
import com.dayuan3.common.model.TimeModel;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.model.RequesterUnitModel;
import com.dayuan3.terminal.service.ReqUnitStatisticDailyService;
import com.dayuan3.terminal.service.RequesterUnitService;
import com.dayuan3.terminal.service.RequesterUnitTypeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据统计-检测监控
 */
@Controller
@RequestMapping("/checkMonitor")
public class ReqCheckMonitorController {

    private Logger log = Logger.getLogger(ReqCheckMonitorController.class);
    @Autowired
    RequesterUnitTypeService requesterUnitTypeService;
    @Autowired
    private ReqUnitStatisticDailyService reqUnitStatisticDailyService;
    @Autowired
    private RequesterUnitService requesterUnitService;
    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;

    /**
     * 数据统计-检测监控
     *
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView details() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<RequesterUnitType> rutList = requesterUnitTypeService.queryAllType();
            map.put("rutList", rutList);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/requester/statistic/monitor_list", map);
    }


    /**
     * 数据统计-检测监控：获取数据
     *
     * @param type     类型 month、season、year、diy（月、季、年、自定义）
     * @param month    月
     * @param season   年
     * @param year     季度
     * @param start    开始时间
     * @param end      结束时间
     * @param did      机构ID
     * @param unitType 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他
     * @return
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(RequesterUnitModel model, Page page, String type, String month, String season, String year, String start, String end, Integer did, Integer unitType) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser tsUser = PublicUtil.getSessionUser();
            did = (did == null || did == 0) ? tsUser.getDepartId() : did;
            String today = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
            TimeModel time = DateUtil.formatTime(type, month, season, year, start, end);
            reqUnitStatisticDailyService.loadDatagrid2(page, model, did, time.getStart(), time.getEnd(), today, unitType);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 数据统计-检测监控-送检详情
     *
     * @param id     委托单位ID
     * @param type   类型 month、season、year、diy（月、季、年、自定义）
     * @param month  月
     * @param season 年
     * @param year   季度
     * @param start  开始时间
     * @param end    结束时间
     * @return
     */
    @RequestMapping("/details")
    public ModelAndView details(Integer id, String type, String month, String season, String year, String start, String end) {
        Map<String, Object> map = new HashMap<>();
        try {
            RequesterUnit requesterUnit = requesterUnitService.queryById(id);
            map.put("reqUnit", requesterUnit);
            List<RequesterUnitType> rutList = requesterUnitTypeService.queryAllType();
            map.put("rutList", rutList);
            map.put("type", type);
            map.put("month", month);
            map.put("season", season);
            map.put("year", year);
            map.put("start", start);
            map.put("end", end);
            map.put("id", id);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/requester/statistic/monitor_details", map);
    }

    /**
     * 数据统计-检测监控-送检详情：数据查询
     *
     * @param id     委托单位ID
     * @param type   类型 month、season、year、diy（月、季、年、自定义）
     * @param month  月
     * @param season 年
     * @param year   季度
     * @param start  开始时间
     * @param end    结束时间
     * @return
     */
    @RequestMapping(value = "/datagrid_details")
    @ResponseBody
    public AjaxJson datagridDetails(CheckResultModel model, Page page, Integer id, String type, String month, String season, String year, String start, String end) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TimeModel time = DateUtil.formatTime(type, month, season, year, start, end);
            dataCheckRecordingService.datagridDetails(page, model, id, time.getStart(), time.getEnd());
            //此处解开打开用于测试生成委托单位日统计数据
            //Calendar calendar = Calendar.getInstance();
            //reqUnitStatisticDailyService.dailyStatistic(calendar, id);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

}