package com.dayuan3.statistics.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.controller.BaseController;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.statistics.model.ConsumptionModel;
import com.dayuan3.statistics.service.ConsumptionStatisticDailyService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 财务统计
 */
@Controller
@RequestMapping("/consumptionStatistic")
public class ConsumptionStatisticController extends BaseController {

    private Logger log = Logger.getLogger(ConsumptionStatisticController.class);

    @Autowired
    private ConsumptionStatisticDailyService consumptionStatisticDailyService;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 消费统计
     * @param request
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/statistics/consumption/list", map);
    }

    /**
     * 消费统计数据
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "/loadDatagrid")
    @ResponseBody
    public AjaxJson loadDatagrid(ConsumptionModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(model.getYear())) {
                if (StringUtil.isNotEmpty(model.getMonth())) {
                    Calendar c0 = Calendar.getInstance();
                    c0.clear();
                    c0.set(Calendar.YEAR, Integer.parseInt(model.getYear()));
                    c0.set(Calendar.MONTH, Integer.parseInt(model.getMonth())-1);
                    c0.set(Calendar.DAY_OF_MONTH, c0.getActualMaximum(Calendar.DAY_OF_MONTH));
                    model.setStartDateStr(DateUtil.formatDate(c0.getTime(), "yyyy-MM-01 00:00:00"));
                    model.setEndDateStr(DateUtil.formatDate(c0.getTime(), "yyyy-MM-dd 23:59:59"));

                } else if (StringUtil.isNotEmpty(model.getSeason())) {
                    switch (model.getSeason()) {
                        case "1":
                            model.setStartDateStr(model.getYear()+"-01-01 00:00:00");
                            model.setEndDateStr(model.getYear()+"-03-31 23:59:59");
                            break;
                        case "2":
                            model.setStartDateStr(model.getYear()+"-04-01 00:00:00");
                            model.setEndDateStr(model.getYear()+"-06-30 23:59:59");
                            break;
                        case "3":
                            model.setStartDateStr(model.getYear()+"-07-01 00:00:00");
                            model.setEndDateStr(model.getYear()+"-09-30 23:59:59");
                            break;
                        case "4":
                            model.setStartDateStr(model.getYear()+"-10-01 00:00:00");
                            model.setEndDateStr(model.getYear()+"-12-31 23:59:59");
                            break;
                    }

                } else {
                    model.setStartDateStr(model.getYear()+"-01-01 00:00:00");
                    model.setEndDateStr(model.getYear()+"-12-31 23:59:59");
                }

            } else {
                if (StringUtil.isNotEmpty(model.getStart())) {
                    model.setStartDateStr(model.getStart()+" 00:00:00");
                }
                if (StringUtil.isNotEmpty(model.getEnd())) {
                    model.setEndDateStr(model.getYear()+" 23:59:59");
                }
            }

            page = consumptionStatisticDailyService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 手动执行消费统计
     * @param startDate 统计日期-开始日期
     * @param endDate 统计日期-结束日期
     */
    @RequestMapping("/manualRunning")
    @ResponseBody
    public String manualRunning(String startDate, String endDate){
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date sd = sdf.parse(startDate);
            Date ed = sdf.parse(endDate);

            Calendar c1 = Calendar.getInstance();
            c1.setTime(sd);

            while (c1.getTime().getTime() <= ed.getTime()) {
                //消费统计-日统计
                consumptionStatisticDailyService.saveOrUpdateDailyStatistic(c1);

                c1.add(Calendar.DAY_OF_YEAR, 1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            return "fail";
        }
        return "success";
    }

    /**
     * 测试专用
     * 刷新从2019/07/01到昨天的消费统计
     */
    @RequestMapping("/test")
    @ResponseBody
    public String test(){
        try {
            //测试，刷新从2019/07/01到昨天的消费统计
            Calendar c1 = Calendar.getInstance();
            c1.setTime(DateUtil.parseDate("2019-07-01","yyyy-MM-dd"));

            Calendar c2 = Calendar.getInstance();
            c2.set(Calendar.HOUR_OF_DAY, 0);
            c2.set(Calendar.MINUTE, 0);
            c2.set(Calendar.SECOND, 0);

            while ( c1.getTime().getTime() < c2.getTime().getTime()){
                //统计当天消费情况
                consumptionStatisticDailyService.saveOrUpdateDailyStatistic(c1);

                c1.add(Calendar.DAY_OF_MONTH, 1);
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
        }
        return "success";
    }

}