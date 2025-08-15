package com.dayuan3.terminal.controller;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.DateUtil;
import com.dayuan3.common.model.TimeModel;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.model.RequesterUnitModel;
import com.dayuan3.terminal.service.ReqUnitStatisticDailyService;
import com.dayuan3.terminal.service.ReqUnitStatisticMonthlyService;
import com.dayuan3.terminal.service.RequesterUnitTypeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 委托单位统计
 */
@Controller
@RequestMapping("/reqUnitStatistic")
public class ReqUnitStatisticController {

    private Logger log = Logger.getLogger(ReqUnitStatisticController.class);

    @Autowired
    private ReqUnitStatisticDailyService reqUnitStatisticDailyService;
    @Autowired
    private ReqUnitStatisticMonthlyService reqUnitStatisticMonthlyService;
    @Autowired
    RequesterUnitTypeService requesterUnitTypeService;
    @Autowired
    private TSDepartService departService;

    /**
     * 委托单位统计
     *
     * @return
     */
    @RequestMapping("/statistic")
    public ModelAndView statistic() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<RequesterUnitType> rutList = requesterUnitTypeService.queryAllType();
            map.put("rutList", JSON.toJSONString(rutList));
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
        }
        return new ModelAndView("/terminal/requester/statistic/statistic", map);
    }

    /**
     * 委托单位统计-获取数据
     *
     * @param type        类型 month、season、year、diy（月、季、年、自定义）
     * @param month       月
     * @param season      年
     * @param year        季度
     * @param start       开始时间
     * @param end         结束时间
     * @param did         机构ID
     * @param unitTypeArr 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他
     * @return
     */
    @RequestMapping(value = "/getData")
    @ResponseBody
    public AjaxJson getData(RequesterUnitModel model,String type, String month, String season, String year, String start, String end, Integer did, String[] unitTypeArr) {
        AjaxJson aj = new AjaxJson();
        try {
            TSUser tsUser = PublicUtil.getSessionUser();
            did = (did == null || did == 0) ? tsUser.getDepartId() : did;
            String today = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
            TimeModel time = DateUtil.formatTime(type, month, season, year, start, end);
            //数据统计-委托单位：获委托单位送检和应送检数据
            Map<String, Object> dataMap = reqUnitStatisticDailyService.selectData(did, time.getStart(), time.getEnd(), today, unitTypeArr,model);
            aj.setObj(dataMap);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            aj.setSuccess(false);
            aj.setMsg("操作失败");
        }

        return aj;
    }


    /**
     * 委托单位统计-获取数据
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
    @RequestMapping(value = "/datagrid2")
    @ResponseBody
    public AjaxJson datagrid2(RequesterUnitModel model, Page page, String type, String month, String season, String year, String start, String end, Integer did, Integer unitType) {
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
     * 手动执行委托单位统计
     *
     * @param startDate 统计日期-开始日期
     * @param endDate   统计日期-结束日期
     */
    @RequestMapping("/manualRunning")
    @ResponseBody
    public String manualRunning(String startDate, String endDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date sd = sdf.parse(startDate);
            Date ed = sdf.parse(endDate);

            Calendar c1 = Calendar.getInstance();
            c1.clear();
            c1.setTime(sd);

            while (c1.getTime().getTime() <= ed.getTime()) {
                //委托单位日统计
                reqUnitStatisticDailyService.dailyStatistic(c1, null);

                //委托单位月统计
                if (c1.get(Calendar.DAY_OF_MONTH) == c1.getActualMaximum(Calendar.DAY_OF_MONTH)) {
                    reqUnitStatisticMonthlyService.monthlyStatistic(c1, null);
                }
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
     * 获取机构数据
     *
     * @param session
     * @return
     */
    @RequestMapping(value = "querydepart")
    @ResponseBody
    public AjaxJson querydepart(HttpSession session) {
        AjaxJson jsonObj = new AjaxJson();
        TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        try {
            TSDepart depart = departService.getById(tsUser.getDepartId());
            jsonObj.setObj(depart);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObj;
    }

    /**
     * 委托单位统计数据(目前没有地方使用)
     *
     * @param model
     * @param page
     * @return
     */
/*    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(RequesterUnitModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (null != model.getKeyWords()) {
                if (DateUtil.formatDate(new Date(), "yyyy-MM-dd").equals(model.getKeyWords())) {
                    //实时统计
                    page = reqUnitStatisticDailyService.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid1", "getRowTotal1");

                } else {
                    //历史统计
                    page = reqUnitStatisticDailyService.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid2", "getRowTotal2");
                }
                List<ReqUnitStatisticDaily> list = (List<ReqUnitStatisticDaily>) page.getResults();
                if (list != null) {
                    for (ReqUnitStatisticDaily rusd : list) {
                        if (rusd.getCheckNumberDaily() == null) {
                            rusd.setCheckNumberDaily(0);
                        }
                        if (rusd.getCheckNumber() == null) {
                            rusd.setCheckNumber(0);
                        }
                        if (rusd.getUnqualifiedNumber() == null) {
                            rusd.setUnqualifiedNumber(0);
                        }
                        if (rusd.getCheckNumberDaily() == 0 || rusd.getCheckNumber() == 0) {
                            rusd.setCheckRate(0.00);
                        } else {
                            Integer checkNumberDaily = rusd.getCheckNumberDaily() == 0 ? 1 : rusd.getCheckNumberDaily();
                            rusd.setCheckRate(new BigDecimal("" + ((rusd.getCheckNumber() * 1.00) / (checkNumberDaily * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                        }
                    }
                }
            }
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }*/

    /**
     * 委托单位统计数据(目前没有地方使用)
     *
     * @param model
     * @param page
     * @return
     */
/*    @RequestMapping(value = "/datagridAll")
    @ResponseBody
    public AjaxJson datagridAll(RequesterUnitModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (null != model.getKeyWords()) {
                if (DateUtil.formatDate(new Date(), "yyyy-MM-dd").equals(model.getKeyWords())) {
                    //实时统计
                    page = reqUnitStatisticDailyService.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid1", "getRowTotal1");
                } else {
                    //历史统计
                    page = reqUnitStatisticDailyService.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid2", "getRowTotal2");
                }
                List<ReqUnitStatisticDaily> list = (List<ReqUnitStatisticDaily>) page.getResults();
                if (list != null) {
                    for (ReqUnitStatisticDaily rusd : list) {
                        if (rusd.getCheckNumberDaily() == null) {
                            rusd.setCheckNumberDaily(0);
                        }
                        if (rusd.getCheckNumber() == null) {
                            rusd.setCheckNumber(0);
                        }
                        if (rusd.getUnqualifiedNumber() == null) {
                            rusd.setUnqualifiedNumber(0);
                        }
                        if (rusd.getCheckNumberDaily() == 0 || rusd.getCheckNumber() == 0) {
                            rusd.setCheckRate(0.00);
                        } else {
                            Integer checkNumberDaily = rusd.getCheckNumberDaily() == 0 ? 1 : rusd.getCheckNumberDaily();
                            rusd.setCheckRate(new BigDecimal("" + ((rusd.getCheckNumber() * 1.00) / (checkNumberDaily * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                        }
                    }
                }
            }
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }*/

}