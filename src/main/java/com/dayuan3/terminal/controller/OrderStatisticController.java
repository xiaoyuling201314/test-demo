package com.dayuan3.terminal.controller;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.terminal.bean.OrderStatisticDaily;
import com.dayuan3.terminal.bean.OrderStatisticMonthly;
import com.dayuan3.terminal.service.OrderStatisticDailyService;
import com.dayuan3.terminal.service.OrderStatisticMonthlyService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 财务统计
 */
@Controller
@RequestMapping("/orderStatistic")
public class OrderStatisticController {

    private Logger log = Logger.getLogger(OrderStatisticController.class);

    @Autowired
    private OrderStatisticDailyService orderStatisticDailyService;
    @Autowired
    private OrderStatisticMonthlyService orderStatisticMonthlyService;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 订单统计
     * @param request
     * @return
     */
    @RequestMapping("/analysis")
    public ModelAndView analysis(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();

        //今天订单
        Calendar calendar1 = Calendar.getInstance();   //今天
        StringBuffer sql1 = new StringBuffer();
        sql1.append("SELECT ts.iu_id reg_id, ts.order_userid user_id, ts.order_type, ts.iu_id company_id  " +
                "FROM tb_sampling ts  " +
                "  LEFT JOIN inspection_unit_user iuu ON ts.sampling_userid = iuu.id " +
                "  LEFT JOIN inspection_unit iu ON iuu.inspection_id = iu.id " +
                "WHERE ts.delete_flag=0 AND ts.order_status=2 " +
                " AND ts.order_time BETWEEN ? AND  ? ");
        List<Map<String,Object>> result1 = jdbcTemplate.queryForList(sql1.toString(),
                new Object[]{DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 00:00:00",
                        DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 23:59:59"});


        Set req_units1 = new HashSet();  //委托单位
        Set ins_units1 = new HashSet();  //送检单位
        Set ins_users1 = new HashSet();  //送检用户
        int order1 = 0;   //订单数
        int order_zd1 = 0;   //自助下单
        int order_wx1 = 0;   //电子抽样

        order1 = result1.size();
        for (Map<String,Object> map1 : result1){
            if (null != map1.get("reg_id")){
                req_units1.add(map1.get("reg_id").toString());
            }
            if (null != map1.get("company_id")){
                ins_units1.add(map1.get("company_id").toString());
            }
            if (null != map1.get("user_id")){
                ins_users1.add(map1.get("user_id").toString());
            }
            if (null != map1.get("order_type")){
                if ("1".equals(map1.get("order_type").toString())) {
                    order_zd1++;
                } else if ("2".equals(map1.get("order_type").toString())) {
                    order_wx1++;
                }
            }
        }

        //今日交易流水
        StringBuffer sql11 = new StringBuffer("SELECT SUM(ic.money) money " +
                "FROM income ic  " +
                "WHERE ic.delete_flag = 0 AND ic.status = 1 AND ic.transaction_type IN (0,1) " +
                " AND ic.pay_date BETWEEN ? AND ? ");
        Map map11 = jdbcTemplate.queryForMap(sql11.toString(),
                new Object[]{DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 00:00:00",
                        DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 23:59:59"});
        //订单收入
        double income1 = map11 == null || map11.get("money") == null
                || "".equals(map11.get("money")) ? 0.0 : Double.parseDouble(map11.get("money").toString());

        //今日收入
        Map<String,Object> dayIncome = new HashMap<String,Object>();
        dayIncome.put("income", income1);
        dayIncome.put("order_number", order1);
        dayIncome.put("ins_unit_number", ins_units1.size());
        dayIncome.put("ins_user_number", ins_users1.size());



        //本月收入
        Calendar calendar2 = Calendar.getInstance();   //本月1号
        calendar2.set(Calendar.DAY_OF_MONTH, 1);
        Calendar calendar3 = Calendar.getInstance();   //下月1号
        calendar3.set(Calendar.DAY_OF_MONTH, 1);
        calendar3.add(Calendar.MONTH, 1);

        double income2 = income1;   //订单收入
        Set req_units2 = new HashSet();  //委托单位
        Iterator req_units_it2 = req_units1.iterator();
        while (req_units_it2.hasNext()){
            req_units2.add(req_units_it2.next());
        }
        Set ins_units2 = new HashSet();  //送检单位
        Iterator ins_units_it2 = ins_units1.iterator();
        while (ins_units_it2.hasNext()){
            ins_units2.add(ins_units_it2.next());
        }
        Set ins_users2 = new HashSet();  //送检用户
        Iterator ins_users_it2 = ins_users1.iterator();
        while (ins_users_it2.hasNext()){
            ins_users2.add(ins_users_it2.next());
        }

        int order2 = order1;   //订单数
        int order_zd2 = order_zd1;   //终端下单
        int order_wx2 = order_wx1;   //微信下单
        StringBuffer sql2 = new StringBuffer();
        sql2.append("SELECT income_order, qty_order, qty_wx_order, qty_zd_order, qty_wx_pay, qty_zfb_pay, qty_ye_pay, " +
                " req_unit_statistic, ins_unit_statistic, ins_user_statistic " +
                " FROM order_statistic_daily " +
                "WHERE delete_flag = 0 AND date >= ? AND date < ? ");
        List<Map<String,Object>> result2 = jdbcTemplate.queryForList(sql2.toString(),
                new Object[]{DateUtil.formatDate(calendar2.getTime(),"yyyy-MM-dd")+" 00:00:00",
                        DateUtil.formatDate(calendar3.getTime(),"yyyy-MM-dd")+" 23:59:59"});
        for (Map<String,Object> map2 : result2){
            if (null != map2.get("income_order")){
                income2 += Double.parseDouble(map2.get("income_order").toString());
            }
            if (null != map2.get("qty_order")){
                order2 += Integer.parseInt(map2.get("qty_order").toString());
            }
            if (null != map2.get("qty_wx_order")){
                order_wx2 += Integer.parseInt(map2.get("qty_wx_order").toString());
            }
            if (null != map2.get("qty_zd_order")){
                order_zd2 += Integer.parseInt(map2.get("qty_zd_order").toString());
            }
            if (null != map2.get("req_unit_statistic")){
                String[] req_unit1 = map2.get("req_unit_statistic").toString().split(",");
                for (String req_unit2 : req_unit1){
                    String[] req_unit3 = req_unit2.split("-");
                    if (req_unit3[0]!=null&&!req_unit3[0].equals("")){
                        req_units2.add(req_unit3[0]);
                    }
                }
            }
            if (null != map2.get("ins_unit_statistic")){
                String[] ins_unit1 = map2.get("ins_unit_statistic").toString().split(",");
                for (String ins_unit2 : ins_unit1){
                    String[] ins_unit3 = ins_unit2.split("-");
                    if (ins_unit3[0]!=null&&!ins_unit3[0].equals("")){
                        ins_units2.add(ins_unit3[0]);
                    }
                }
            }
            if (null != map2.get("ins_user_statistic")){
                String[] ins_user1 = map2.get("ins_user_statistic").toString().split(",");
                for (String ins_user2 : ins_user1){
                    String[] ins_user3 = ins_user2.split("-");
                    if (ins_user3[0]!=null&&!ins_user3[0].equals("")){
                        ins_users2.add(ins_user3[0]);
                    }
                }
            }
        }

        //本月收入
        Map monthIncome = new HashMap();
        monthIncome.put("income", income2);
        monthIncome.put("order_number", order2);
        monthIncome.put("ins_unit_number", ins_units2.size());
        monthIncome.put("ins_user_number", ins_users2.size());

        //总收入
        double income3 = income2;   //订单收入
        Set req_units3 = new HashSet();  //委托单位
        Iterator req_units_it3 = req_units2.iterator();
        while (req_units_it3.hasNext()){
            req_units3.add(req_units_it3.next());
        }
        Set ins_units3 = new HashSet();  //送检单位
        Iterator ins_units_it3 = ins_units2.iterator();
        while (ins_units_it3.hasNext()){
            ins_units3.add(ins_units_it3.next());
        }
        Set ins_users3 = new HashSet();  //送检用户
        Iterator ins_users_it3 = ins_users2.iterator();
        while (ins_users_it3.hasNext()){
            ins_users3.add(ins_users_it3.next());
        }
        int order3 = order2;   //订单数
        int order_zd3 = order_zd2;   //终端下单
        int order_wx3 = order_wx2;   //微信下单
        StringBuffer sql3 = new StringBuffer();
        sql3.append("SELECT income_order, qty_order, qty_wx_order, qty_zd_order, qty_wx_pay, qty_zfb_pay, qty_ye_pay, " +
                " req_unit_statistic, ins_unit_statistic, ins_user_statistic " +
                " FROM order_statistic_monthly " +
                "WHERE delete_flag = 0 ");
        List<Map<String,Object>> result3 = jdbcTemplate.queryForList(sql3.toString());
        for (Map<String,Object> map3 : result3){
            if (null != map3.get("income_order")){
                income3 += Double.parseDouble(map3.get("income_order").toString());
            }
            if (null != map3.get("qty_order")){
                order3 += Integer.parseInt(map3.get("qty_order").toString());
            }
            if (null != map3.get("qty_wx_order")){
                order_wx3 += Integer.parseInt(map3.get("qty_wx_order").toString());
            }
            if (null != map3.get("qty_zd_order")){
                order_zd3 += Integer.parseInt(map3.get("qty_zd_order").toString());
            }
            if (null != map3.get("req_unit_statistic")){
                String[] req_unit1 = map3.get("req_unit_statistic").toString().split(",");
                for (String req_unit2 : req_unit1){
                    String[] req_unit3 = req_unit2.split("-");
                    if (req_unit3[0]!=null&&!req_unit3[0].equals("")){
                        req_units3.add(req_unit3[0]);
                    }
                }
            }
            if (null != map3.get("ins_unit_statistic")){
                String[] ins_unit1 = map3.get("ins_unit_statistic").toString().split(",");
                for (String ins_unit2 : ins_unit1){
                    String[] ins_unit3 = ins_unit2.split("-");
                    if (ins_unit3[0]!=null&&!ins_unit3[0].equals("")){
                        ins_units3.add(ins_unit3[0]);
                    }
                }
            }
            if (null != map3.get("ins_user_statistic")){
                String[] ins_user1 = map3.get("ins_user_statistic").toString().split(",");
                for (String ins_user2 : ins_user1){
                    String[] ins_user3 = ins_user2.split("-");
                    if (ins_user3[0]!=null&&!ins_user3[0].equals("")){
                        ins_users3.add(ins_user3[0]);
                    }
                }
            }
        }

        //收入总数
        Map<String ,Object> totalIncome = new HashMap<String ,Object>();
        totalIncome.put("income", income3);
        totalIncome.put("order_number", order3);
        totalIncome.put("ins_unit_number", ins_units3.size());
        totalIncome.put("ins_user_number", ins_users3.size());

        //下单方式、支付方式
        Map<String ,Object> way = new HashMap<String ,Object>();
        way.put("order_zd", order_zd3);
        way.put("order_wx", order_wx3);


        //订单趋势、收入趋势
        StringBuffer sql4 = new StringBuffer();
        sql4.append("SELECT COUNT(1) order_number, SUM(IF(tb1.order_fees IS NOT NULL, tb1.order_fees, 0)) order_fees, tb1.pay_hour " +
                "FROM( " +
                "SELECT ts.order_fees, DATE_FORMAT(ts.order_time, '%H') pay_hour " +
                " FROM tb_sampling ts " +
                "WHERE ts.delete_flag=0 AND ts.order_status=2 " +
                " AND ts.order_time >= ? AND ts.order_time <= ? " +
                ") tb1 GROUP BY tb1.pay_hour ORDER BY tb1.pay_hour ASC ");

        List<Map<String,Object>> result4 = jdbcTemplate.queryForList(sql4.toString(),
                new Object[]{DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 00:00:00",
                        DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd")+" 23:59:59"});

        map.put("trend", JSONObject.toJSONString(result4)); //趋势数据


        map.put("dayIncome", dayIncome);    //今日收入
        map.put("monthIncome", monthIncome);    //本月收入
        map.put("totalIncome", totalIncome);    //总收入
        map.put("way", way);    //全部订单-下单方式、支付方式

        return new ModelAndView("/terminal/income/analysis", map);
    }

    /**
     * 订单统计-获取图表数据
     * @param yyyy  年
     * @param mm    月
     * @param season 季度
     * @param start 开始时间
     * @param end   结束时间
     * @return
     */
    @RequestMapping(value = "/getChartData")
    @ResponseBody
    public AjaxJson getChartData(String yyyy, String mm, String season, String start, String end) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            //样品种类
            Map<String, Map> foodMap = new HashMap<String, Map>();
            //检测项目
            Map<String, Map> itemMap = new HashMap<String, Map>();
            //送检单位
            Map<String, Map> insUnitMap = new HashMap<String, Map>();
            //委托单位
            Map<String, Map> reqUnitMap = new HashMap<String, Map>();

            //终端下单数量
            int order_zd = 0;
            //微信下单数量
            int order_wx = 0;

            Map<String, Map> map = new HashMap<String, Map>();
            map.put("foodMap",foodMap);
            map.put("itemMap",itemMap);
            map.put("insUnitMap",insUnitMap);
            map.put("reqUnitMap",reqUnitMap);

            //收入趋势-历史
            List<OrderStatisticDaily> incomeList = null;
            //收入趋势-今天
            OrderStatisticDaily income = null;

            //自定义时间范围
            if (StringUtil.isNotEmpty(start) && StringUtil.isNotEmpty(end)) {
                //今天
                Calendar c1 = Calendar.getInstance();
                //开始时间
                Calendar c2 = Calendar.getInstance();
                c2.setTime(DateUtil.parseDate(start,"yyyy-MM-dd"));
                //结束时间
                Calendar c3 = Calendar.getInstance();
                c3.setTime(DateUtil.parseDate(end,"yyyy-MM-dd"));

                //结束日期或结束前一天，用于获取统计表数据
                Calendar c4 = Calendar.getInstance();

                OrderStatisticDaily s1 = null;
                List<OrderStatisticDaily> s2 = null;
                List<OrderStatisticMonthly> s3 = null;
                List<OrderStatisticDaily> s4 = null;

                //结束时间是今天或未来
                if ((c1.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c1.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c1.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH))
                    || c3.getTime().getTime() >= c1.getTime().getTime()) {
                    s1 = orderStatisticDailyService.dailyStatistic(c1);

                    //如果结束时间是当天，获取到结束前一天的统计数据
                    c4.add(Calendar.DAY_OF_MONTH, -1);

                //开始时间等于结束时间
                } else if (c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c2.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH)) {
                    s1 = orderStatisticDailyService.selectByDate(DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd"));

                    c4.setTime(c3.getTime());

                } else {
                    c4.setTime(c3.getTime());
                }

                //收入趋势-今天
                income = s1;

                //历史财务统计
                //开始时间不等于结束时间
                if (!(c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c2.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH))) {

                    //开始时间与结束时间在同一个月内
                    if (c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                            && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)) {

                        //开始日期小于等于结束前一天
                        if (c2.getTime().getTime()<= c4.getTime().getTime()){
                            s2 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));

                            //收入趋势-历史
                            incomeList = s2;
                        }


                        //开始时间与结束时间不在同一个月内
                    } else {

                        s2 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c3.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));

                        //结束时间前一月
                        Calendar c5 = Calendar.getInstance();
                        c5.setTime(c3.getTime());
                        c5.add(Calendar.MONTH, -1);

                        s3 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd"),
                                DateUtil.formatDate(c5.getTime(),"yyyy-MM-dd"));

                        if (c2.get(Calendar.DAY_OF_MONTH) != 1) {
                            Calendar c6 = Calendar.getInstance();
                            c6.clear();
                            c6.setTime(c2.getTime());
                            c6.set(Calendar.DAY_OF_MONTH, c6.getActualMaximum(Calendar.DAY_OF_MONTH));

                            s4 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c6.getTime(), "yyyy-MM-dd"));
                        }

                        //开始日期小于等于结束前一天
                        if (c2.getTime().getTime()<= c4.getTime().getTime()){
                            //收入趋势-历史
                            incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));
                        }

                    }

                }

                if (s1 != null) {
                    map = dailyStatisticalSummary(map, s1);

                    //终端下单数量
                    order_zd += s1.getQtyZdOrder();
                    //微信下单数量
                    order_wx += s1.getQtyWxOrder();
                }
                if (s2 != null) {
                    for (OrderStatisticDaily osd : s2) {
                        map = dailyStatisticalSummary(map, osd);

                        //终端下单数量
                        order_zd += osd.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osd.getQtyWxOrder();
                    }
                }
                if (s3 != null) {
                    for (OrderStatisticMonthly osm : s3) {
                        map = monthlyStatisticalSummary(map, osm);

                        //终端下单数量
                        order_zd += osm.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osm.getQtyWxOrder();
                    }
                }
                if (s4 != null) {
                    for (OrderStatisticDaily osd : s4) {
                        map = dailyStatisticalSummary(map, osd);

                        //终端下单数量
                        order_zd += osd.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osd.getQtyWxOrder();
                    }
                }

            //按年月统计
            } else if (StringUtil.isNotEmpty(mm) && StringUtil.isNotEmpty(yyyy)) {
                OrderStatisticDaily s5 = null;
                List<OrderStatisticDaily> s6 = null;
                List<OrderStatisticMonthly> s7 = null;

                Calendar c7 = Calendar.getInstance();
                //本月财务统计
                if ((c7.get(Calendar.MONTH)+1) == Integer.parseInt(mm)
                        && c7.get(Calendar.YEAR) == Integer.parseInt(yyyy)){

                    //今天财务统计
                    s5 = orderStatisticDailyService.dailyStatistic(c7);

                    if (c7.get(Calendar.DAY_OF_MONTH) != 1) {
                        c7.add(Calendar.DAY_OF_MONTH, -1);
                        s6 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c7.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c7.getTime(), "yyyy-MM-dd"));
                    }

                    //收入趋势-历史
                    incomeList = s6;
                    //收入趋势-今天
                    income = s5;


                //历史财务统计
                } else {
                    c7.clear();
                    c7.set(Calendar.YEAR, Integer.parseInt(yyyy));
                    c7.set(Calendar.MONTH, (Integer.parseInt(mm)-1));
                    c7.set(Calendar.DAY_OF_MONTH, c7.getActualMaximum(Calendar.DAY_OF_MONTH));

                    s7 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c7.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c7.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c7.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c7.getTime(), "yyyy-MM-dd"));
                }

                if (s5 != null) {
                    map = dailyStatisticalSummary(map, s5);

                    //终端下单数量
                    order_zd += s5.getQtyZdOrder();
                    //微信下单数量
                    order_wx += s5.getQtyWxOrder();
                }
                if (s6 != null) {
                    for (OrderStatisticDaily osd : s6) {
                        map = dailyStatisticalSummary(map, osd);

                        //终端下单数量
                        order_zd += osd.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osd.getQtyWxOrder();
                    }
                }
                if (s7 != null) {
                    for (OrderStatisticMonthly osm : s7) {
                        map = monthlyStatisticalSummary(map, osm);

                        //终端下单数量
                        order_zd += osm.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osm.getQtyWxOrder();
                    }
                }

            //按季度统计
            } else if (StringUtil.isNotEmpty(season) && StringUtil.isNotEmpty(yyyy)) {

                OrderStatisticDaily s8 = null;
                List<OrderStatisticDaily> s9 = null;
                List<OrderStatisticMonthly> s10 = null;

                //季度开始日期
                Calendar c8 = Calendar.getInstance();
                c8.clear();
                c8.set(Calendar.YEAR, Integer.parseInt(yyyy));
                c8.set(Calendar.DAY_OF_MONTH, 1);
                //季度结束日期
                Calendar c9 = Calendar.getInstance();
                c9.clear();
                c9.set(Calendar.YEAR, Integer.parseInt(yyyy));
                switch (season){
                    case "1":
                        c8.set(Calendar.MONTH, 0);
                        c9.set(Calendar.MONTH, 2);
                        break;
                    case "2":
                        c8.set(Calendar.MONTH, 3);
                        c9.set(Calendar.MONTH, 5);
                        break;
                    case "3":
                        c8.set(Calendar.MONTH, 6);
                        c9.set(Calendar.MONTH, 8);
                        break;
                    case "4":
                        c8.set(Calendar.MONTH, 9);
                        c9.set(Calendar.MONTH, 11);
                        break;
                }
                c9.set(Calendar.DAY_OF_MONTH, c9.getActualMaximum(Calendar.DAY_OF_MONTH));

                //本季度
                Calendar c10 = Calendar.getInstance();

                //本季度 - 本月财务统计
                if (c10.get(Calendar.YEAR) == Integer.parseInt(yyyy)
                    && c10.get(Calendar.MONTH) >= c8.get(Calendar.MONTH)
                    && c10.get(Calendar.MONTH) <= c9.get(Calendar.MONTH)){

                    //今天财务统计
                    s8 = orderStatisticDailyService.dailyStatistic(c10);

                    if (c10.get(Calendar.DAY_OF_MONTH) != 1) {
                        c10.add(Calendar.DAY_OF_MONTH, -1);
                        s9 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c10.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c10.getTime(), "yyyy-MM-dd"));
                    }

                    s10 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c8.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c8.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c10.getTime(), "yyyy-MM-dd"));
                    //收入趋势-今天
                    income = s8;

                } else {
                    //历史财务统计
                    s10 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c8.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c8.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(), "yyyy-MM-dd"));

                }


                if (s8 != null) {
                    map = dailyStatisticalSummary(map, s8);

                    //终端下单数量
                    order_zd += s8.getQtyZdOrder();
                    //微信下单数量
                    order_wx += s8.getQtyWxOrder();
                }
                if (s9 != null) {
                    for (OrderStatisticDaily osd : s9) {
                        map = dailyStatisticalSummary(map, osd);

                        //终端下单数量
                        order_zd += osd.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osd.getQtyWxOrder();
                    }
                }
                if (s10 != null) {
                    for (OrderStatisticMonthly osm : s10) {
                        map = monthlyStatisticalSummary(map, osm);

                        //终端下单数量
                        order_zd += osm.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osm.getQtyWxOrder();
                    }
                }

            //按年统计
            } else if (StringUtil.isNotEmpty(yyyy)) {
                OrderStatisticDaily s11 = null;
                List<OrderStatisticDaily> s12 = null;
                List<OrderStatisticMonthly> s13 = null;

                //本年
                Calendar c11 = Calendar.getInstance();

                //本年财务统计
                if (c11.get(Calendar.YEAR) == Integer.parseInt(yyyy)) {
                    //今天财务统计
                    s11 = orderStatisticDailyService.dailyStatistic(c11);

                    if (c11.get(Calendar.DAY_OF_MONTH) != 1) {
                        c11.add(Calendar.DAY_OF_MONTH, -1);
                        s12 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                    }

                    s13 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c11.getTime(),"yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                    //收入趋势-今天
                    income = s11;

                //往年财务统计
                } else {
                    //当年最后一天日期
                    c11.set(Calendar.YEAR, Integer.parseInt(yyyy));
                    c11.set(Calendar.MONTH, 11);
                    c11.set(Calendar.DAY_OF_MONTH, c11.getActualMaximum(Calendar.DAY_OF_MONTH));

                    s13 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c11.getTime(),"yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(),"yyyy-12-01"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                }

                if (s11 != null) {
                    map = dailyStatisticalSummary(map, s11);

                    //终端下单数量
                    order_zd += s11.getQtyZdOrder();
                    //微信下单数量
                    order_wx += s11.getQtyWxOrder();
                }
                if (s12 != null) {
                    for (OrderStatisticDaily osd : s12) {
                        map = dailyStatisticalSummary(map, osd);

                        //终端下单数量
                        order_zd += osd.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osd.getQtyWxOrder();
                    }
                }
                if (s13 != null) {
                    for (OrderStatisticMonthly osm : s13) {
                        map = monthlyStatisticalSummary(map, osm);

                        //终端下单数量
                        order_zd += osm.getQtyZdOrder();
                        //微信下单数量
                        order_wx += osm.getQtyWxOrder();
                    }
                }

            }


            //收入趋势数据汇总
            if (incomeList == null){
                incomeList = new ArrayList<OrderStatisticDaily>();
            }
            if (income != null){
                incomeList.add(income);
            }


            Map<String,Object> result = new HashMap<String,Object>();
            result.put("incomes", incomeList);
            result.put("foodMap", map.get("foodMap"));
            result.put("itemMap", map.get("itemMap"));
            result.put("insUnitMap", map.get("insUnitMap"));
            result.put("reqUnitMap", map.get("reqUnitMap"));
            result.put("orderZd", order_zd);
            result.put("orderWx", order_wx);

            jsonObj.setObj(result);

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    private Map dailyStatisticalSummary(Map<String, Map> map, OrderStatisticDaily s1){
        //样品种类
        Map<String, Map> foodMap = map.get("foodMap");
        //检测项目
        Map<String, Map> itemMap = map.get("itemMap");
        //送检单位
        Map<String, Map> insUnitMap = map.get("insUnitMap");
        //委托单位
        Map<String, Map> reqUnitMap = map.get("reqUnitMap");
        if (s1 != null) {
            String foodStatistic = s1.getFoodStatistic();
            if (StringUtil.isNotEmpty(foodStatistic)) {
                String[] foodStr1 = foodStatistic.split(",");
                for (String foodStr2 : foodStr1){
                    String[] foodStr3 = foodStr2.split("-");
                    if(StringUtil.isNotEmpty(foodStr3[0])){
                        Map foodMap0 = foodMap.get(foodStr3[0]);
                        if (null == foodMap0) {
                            foodMap0 = new HashMap();
                            foodMap0.put("name", foodStr3[1]);
                            foodMap0.put("number", Integer.parseInt(foodStr3[2]));
                        } else {
                            foodMap0.put("number", Integer.parseInt(foodMap0.get("number").toString()) + Integer.parseInt(foodStr3[2]));
                        }
                        foodMap.put(foodStr3[0], foodMap0);
                    }
                }
            }

            String itemStatistic = s1.getItemStatistic();
            if (StringUtil.isNotEmpty(itemStatistic)) {
                String[] itemStr1 = itemStatistic.split(",");
                for (String itemStr2 : itemStr1){
                    String[] itemStr3 = itemStr2.split("-");
                    if(StringUtil.isNotEmpty(itemStr3[0])){
                        Map itemMap0 = itemMap.get(itemStr3[0]);
                        if (null == itemMap0) {
                            itemMap0 = new HashMap();
                            itemMap0.put("name", itemStr3[1]);
                            itemMap0.put("number", Integer.parseInt(itemStr3[2]));
                        } else {
                            itemMap0.put("number", Integer.parseInt(itemMap0.get("number").toString()) + Integer.parseInt(itemStr3[2]));
                        }
                        itemMap.put(itemStr3[0], itemMap0);
                    }
                }
            }

            String insUnitStatistic = s1.getInsUnitStatistic();
            if (StringUtil.isNotEmpty(insUnitStatistic)) {
                String[] insUnitStr1 = insUnitStatistic.split(",");
                for (String insUnitStr2 : insUnitStr1){
                    String[] insUnitStr3 = insUnitStr2.split("-");
                    if(StringUtil.isNotEmpty(insUnitStr3[0])){
                        Map insUnitMap0 = insUnitMap.get(insUnitStr3[0]);
                        if (null == insUnitMap0) {
                            insUnitMap0 = new HashMap();
                            insUnitMap0.put("name", insUnitStr3[1]);
                            insUnitMap0.put("number", Integer.parseInt(insUnitStr3[2]));
                        } else {
                            insUnitMap0.put("number", Integer.parseInt(insUnitMap0.get("number").toString()) + Integer.parseInt(insUnitStr3[2]));
                        }
                        insUnitMap.put(insUnitStr3[0], insUnitMap0);
                    }
                }
            }

            String reqUnitStatistic = s1.getReqUnitStatistic();
            if (StringUtil.isNotEmpty(reqUnitStatistic)) {
                String[] reqUnitStr1 = reqUnitStatistic.split(",");
                for (String reqUnitStr2 : reqUnitStr1){
                    String[] reqUnitStr3 = reqUnitStr2.split("-");
                    if(StringUtil.isNotEmpty(reqUnitStr3[0])){
                        Map reqUnitMap0 = reqUnitMap.get(reqUnitStr3[0]);
                        if (null == reqUnitMap0) {
                            reqUnitMap0 = new HashMap();
                            reqUnitMap0.put("name", reqUnitStr3[1]);
                            reqUnitMap0.put("number", Integer.parseInt(reqUnitStr3[2]));
                        } else {
                            reqUnitMap0.put("number", Integer.parseInt(reqUnitMap0.get("number").toString()) + Integer.parseInt(reqUnitStr3[2]));
                        }
                        reqUnitMap.put(reqUnitStr3[0], reqUnitMap0);
                    }
                }
            }
        }
        return map;
    }
    private Map monthlyStatisticalSummary(Map<String, Map> map, OrderStatisticMonthly s1){
        //样品种类
        Map<String, Map> foodMap = map.get("foodMap");
        //检测项目
        Map<String, Map> itemMap = map.get("itemMap");
        //送检单位
        Map<String, Map> insUnitMap = map.get("insUnitMap");
        //委托单位
        Map<String, Map> reqUnitMap = map.get("reqUnitMap");
        if (s1 != null) {
            String foodStatistic = s1.getFoodStatistic();
            if (StringUtil.isNotEmpty(foodStatistic)) {
                String[] foodStr1 = foodStatistic.split(",");
                for (String foodStr2 : foodStr1){
                    String[] foodStr3 = foodStr2.split("-");
                    if(StringUtil.isNotEmpty(foodStr3[0])){
                        Map foodMap0 = foodMap.get(foodStr3[0]);
                        if (null == foodMap0) {
                            foodMap0 = new HashMap();
                            foodMap0.put("name", foodStr3[1]);
                            foodMap0.put("number", Integer.parseInt(foodStr3[2]));
                        } else {
                            foodMap0.put("number", Integer.parseInt(foodMap0.get("number").toString()) + Integer.parseInt(foodStr3[2]));
                        }
                        foodMap.put(foodStr3[0], foodMap0);
                    }
                }
            }

            String itemStatistic = s1.getItemStatistic();
            if (StringUtil.isNotEmpty(itemStatistic)) {
                String[] itemStr1 = itemStatistic.split(",");
                for (String itemStr2 : itemStr1){
                    String[] itemStr3 = itemStr2.split("-");
                    if(StringUtil.isNotEmpty(itemStr3[0])){
                        Map itemMap0 = itemMap.get(itemStr3[0]);
                        if (null == itemMap0) {
                            itemMap0 = new HashMap();
                            itemMap0.put("name", itemStr3[1]);
                            itemMap0.put("number", Integer.parseInt(itemStr3[2]));
                        } else {
                            itemMap0.put("number", Integer.parseInt(itemMap0.get("number").toString()) + Integer.parseInt(itemStr3[2]));
                        }
                        itemMap.put(itemStr3[0], itemMap0);
                    }
                }
            }

            String insUnitStatistic = s1.getInsUnitStatistic();
            if (StringUtil.isNotEmpty(insUnitStatistic)) {
                String[] insUnitStr1 = insUnitStatistic.split(",");
                for (String insUnitStr2 : insUnitStr1){
                    String[] insUnitStr3 = insUnitStr2.split("-");
                    if(StringUtil.isNotEmpty(insUnitStr3[0])){
                        Map insUnitMap0 = insUnitMap.get(insUnitStr3[0]);
                        if (null == insUnitMap0) {
                            insUnitMap0 = new HashMap();
                            insUnitMap0.put("name", insUnitStr3[1]);
                            insUnitMap0.put("number", Integer.parseInt(insUnitStr3[2]));
                        } else {
                            insUnitMap0.put("number", Integer.parseInt(insUnitMap0.get("number").toString()) + Integer.parseInt(insUnitStr3[2]));
                        }
                        insUnitMap.put(insUnitStr3[0], insUnitMap0);
                    }
                }
            }

            String reqUnitStatistic = s1.getReqUnitStatistic();
            if (StringUtil.isNotEmpty(reqUnitStatistic)) {
                String[] reqUnitStr1 = reqUnitStatistic.split(",");
                for (String reqUnitStr2 : reqUnitStr1){
                    String[] reqUnitStr3 = reqUnitStr2.split("-");
                    if(StringUtil.isNotEmpty(reqUnitStr3[0])){
                        Map reqUnitMap0 = reqUnitMap.get(reqUnitStr3[0]);
                        if (null == reqUnitMap0) {
                            reqUnitMap0 = new HashMap();
                            reqUnitMap0.put("name", reqUnitStr3[1]);
                            reqUnitMap0.put("number", Integer.parseInt(reqUnitStr3[2]));
                        } else {
                            reqUnitMap0.put("number", Integer.parseInt(reqUnitMap0.get("number").toString()) + Integer.parseInt(reqUnitStr3[2]));
                        }
                        reqUnitMap.put(reqUnitStr3[0], reqUnitMap0);
                    }
                }
            }
        }
        return map;
    }


    /**
     * 实收统计
     * @param request
     * @return
     */
    @RequestMapping("/realIncome")
    public ModelAndView realIncome(HttpServletRequest request) {
        return new ModelAndView("/terminal/income/realIncome");
    }

    /**
     * 实收统计-获取数据
     * @param yyyy  年
     * @param mm    月
     * @param season 季度
     * @param start 开始时间
     * @param end   结束时间
     * @return
     */
    @RequestMapping(value = "/getRealIncomeData")
    @ResponseBody
    public AjaxJson getRealIncomeData(String yyyy, String mm, String season, String start, String end) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            //收入趋势-历史
            List<OrderStatisticDaily> incomeList = null;
            //收入趋势-今天
            OrderStatisticDaily income = null;

            if (StringUtil.isNotEmpty(start) && StringUtil.isNotEmpty(end)) {
                //今天
                Calendar c1 = Calendar.getInstance();
                //开始时间
                Calendar c2 = Calendar.getInstance();
                c2.setTime(DateUtil.parseDate(start,"yyyy-MM-dd"));
                //结束时间
                Calendar c3 = Calendar.getInstance();
                c3.setTime(DateUtil.parseDate(end,"yyyy-MM-dd"));

                //结束日期或结束前一天，用于获取统计表数据
                Calendar c4 = Calendar.getInstance();

                OrderStatisticDaily s1 = null;
                List<OrderStatisticDaily> s2 = null;
                List<OrderStatisticMonthly> s3 = null;
                List<OrderStatisticDaily> s4 = null;


                //结束时间是今天或未来
                if ((c1.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c1.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c1.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH))
                        || c3.getTime().getTime() >= c1.getTime().getTime()) {
                    s1 = orderStatisticDailyService.dailyStatistic(c1);

                    //如果结束时间是当天，获取到结束前一天的统计数据
                    c4.add(Calendar.DAY_OF_MONTH, -1);

                    //开始时间等于结束时间
                } else if (c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c2.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH)) {
                    s1 = orderStatisticDailyService.selectByDate(DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd"));

                    c4.setTime(c3.getTime());

                } else {
                    c4.setTime(c3.getTime());
                }

                //收入趋势-今天
                income = s1;

                //历史财务统计
                //开始时间不等于结束时间
                if (!(c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                        && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)
                        && c2.get(Calendar.DAY_OF_MONTH) == c3.get(Calendar.DAY_OF_MONTH))) {

                    //开始时间与结束时间在同一个月内
                    if (c2.get(Calendar.YEAR) == c3.get(Calendar.YEAR)
                            && c2.get(Calendar.MONTH) == c3.get(Calendar.MONTH)) {

                        //开始日期小于等于结束前一天
                        if (c2.getTime().getTime()<= c4.getTime().getTime()){
                            s2 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));

                            //收入趋势-历史
                            incomeList = s2;
                        }


                        //开始时间与结束时间不在同一个月内
                    } else {

                        s2 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c3.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));

                        //结束时间前一月
                        Calendar c5 = Calendar.getInstance();
                        c5.setTime(c3.getTime());
                        c5.add(Calendar.MONTH, -1);

                        s3 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c2.getTime(),"yyyy-MM-dd"),
                                DateUtil.formatDate(c5.getTime(),"yyyy-MM-dd"));

                        if (c2.get(Calendar.DAY_OF_MONTH) != 1) {
                            Calendar c6 = Calendar.getInstance();
                            c6.clear();
                            c6.setTime(c2.getTime());
                            c6.set(Calendar.DAY_OF_MONTH, c6.getActualMaximum(Calendar.DAY_OF_MONTH));

                            s4 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c6.getTime(), "yyyy-MM-dd"));
                        }

                        //开始日期小于等于结束前一天
                        if (c2.getTime().getTime()<= c4.getTime().getTime()){
                            //收入趋势-历史
                            incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c2.getTime(), "yyyy-MM-dd"),
                                    DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"));
                        }

                    }

                }


            } else if (StringUtil.isNotEmpty(mm) && StringUtil.isNotEmpty(yyyy)) {
                OrderStatisticDaily s5 = null;
                List<OrderStatisticDaily> s6 = null;
                List<OrderStatisticMonthly> s7 = null;

                Calendar c7 = Calendar.getInstance();
                //本月财务统计
                if ((c7.get(Calendar.MONTH)+1) == Integer.parseInt(mm)
                        && c7.get(Calendar.YEAR) == Integer.parseInt(yyyy)){

                    //今天财务统计
                    s5 = orderStatisticDailyService.dailyStatistic(c7);

                    if (c7.get(Calendar.DAY_OF_MONTH) != 1) {
                        c7.add(Calendar.DAY_OF_MONTH, -1);
                        s6 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c7.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c7.getTime(), "yyyy-MM-dd"));
                    }

                    //收入趋势-历史
                    incomeList = s6;
                    //收入趋势-今天
                    income = s5;


                    //历史财务统计
                } else {
                    c7.clear();
                    c7.set(Calendar.YEAR, Integer.parseInt(yyyy));
                    c7.set(Calendar.MONTH, (Integer.parseInt(mm)-1));
                    c7.set(Calendar.DAY_OF_MONTH, c7.getActualMaximum(Calendar.DAY_OF_MONTH));

                    s7 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c7.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c7.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c7.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c7.getTime(), "yyyy-MM-dd"));
                }


            } else if (StringUtil.isNotEmpty(season) && StringUtil.isNotEmpty(yyyy)) {

                OrderStatisticDaily s8 = null;
                List<OrderStatisticDaily> s9 = null;
                List<OrderStatisticMonthly> s10 = null;

                //季度开始日期
                Calendar c8 = Calendar.getInstance();
                c8.clear();
                c8.set(Calendar.YEAR, Integer.parseInt(yyyy));
                c8.set(Calendar.DAY_OF_MONTH, 1);
                //季度结束日期
                Calendar c9 = Calendar.getInstance();
                c9.clear();
                c9.set(Calendar.YEAR, Integer.parseInt(yyyy));
                switch (season){
                    case "1":
                        c8.set(Calendar.MONTH, 0);
                        c9.set(Calendar.MONTH, 2);
                        break;
                    case "2":
                        c8.set(Calendar.MONTH, 3);
                        c9.set(Calendar.MONTH, 5);
                        break;
                    case "3":
                        c8.set(Calendar.MONTH, 6);
                        c9.set(Calendar.MONTH, 8);
                        break;
                    case "4":
                        c8.set(Calendar.MONTH, 9);
                        c9.set(Calendar.MONTH, 11);
                        break;
                }
                c9.set(Calendar.DAY_OF_MONTH, c9.getActualMaximum(Calendar.DAY_OF_MONTH));

                //本季度
                Calendar c10 = Calendar.getInstance();

                //本季度 - 本月财务统计
                if (c10.get(Calendar.YEAR) == Integer.parseInt(yyyy)
                        && c10.get(Calendar.MONTH) >= c8.get(Calendar.MONTH)
                        && c10.get(Calendar.MONTH) <= c9.get(Calendar.MONTH)){

                    //今天财务统计
                    s8 = orderStatisticDailyService.dailyStatistic(c10);

                    if (c10.get(Calendar.DAY_OF_MONTH) != 1) {
                        c10.add(Calendar.DAY_OF_MONTH, -1);
                        s9 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c10.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c10.getTime(), "yyyy-MM-dd"));
                    }

                    s10 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c8.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c8.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c10.getTime(), "yyyy-MM-dd"));
                    //收入趋势-今天
                    income = s8;

                } else {
                    //历史财务统计
                    s10 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c8.getTime(),"yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c8.getTime(), "yyyy-MM-01"),
                            DateUtil.formatDate(c9.getTime(), "yyyy-MM-dd"));

                }


            } else if (StringUtil.isNotEmpty(yyyy)) {
                OrderStatisticDaily s11 = null;
                List<OrderStatisticDaily> s12 = null;
                List<OrderStatisticMonthly> s13 = null;

                //本年
                Calendar c11 = Calendar.getInstance();

                //本年财务统计
                if (c11.get(Calendar.YEAR) == Integer.parseInt(yyyy)) {
                    //今天财务统计
                    s11 = orderStatisticDailyService.dailyStatistic(c11);

                    if (c11.get(Calendar.DAY_OF_MONTH) != 1) {
                        c11.add(Calendar.DAY_OF_MONTH, -1);
                        s12 = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-MM-01"),
                                DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                    }

                    s13 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c11.getTime(),"yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(),"yyyy-MM-dd"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                    //收入趋势-今天
                    income = s11;

                    //往年财务统计
                } else {
                    //当年最后一天日期
                    c11.clear();
                    c11.set(Calendar.YEAR, Integer.parseInt(yyyy));
                    c11.set(Calendar.MONTH, 11);
                    c11.set(Calendar.DAY_OF_MONTH, c11.getActualMaximum(Calendar.DAY_OF_MONTH));

                    s13 = orderStatisticMonthlyService.selectByDate2(DateUtil.formatDate(c11.getTime(),"yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(),"yyyy-12-01"));

                    //收入趋势-历史
                    incomeList = orderStatisticDailyService.selectByDate2(DateUtil.formatDate(c11.getTime(), "yyyy-01-01"),
                            DateUtil.formatDate(c11.getTime(), "yyyy-MM-dd"));
                }

            }

            Double real_income = 0.0;   //实收
            Double real_income_wx = 0.0;   //实收-微信
            Double real_income_zfb = 0.0;   //实收-支付宝
            Double real_income_cz = 0.0;   //实收-充值

            Double order_income = 0.0;   //订单收入
            Double order_income_ye = 0.0;   //订单收入-余额支付

            Double real_refund = 0.0;   //实际退款
            Double order_refund = 0.0;   //订单退款

            Integer pay_wx = 0;   //微信支付次数(不含充值)
            Integer pay_zfb = 0;   //支付宝支付次数(不含充值)
            Integer pay_ye = 0;   //余额支付次数

            Double fee_check = 0.0;   //检测费用
            Double fee_print = 0.0;   //打印费用
            Double fee_report = 0.0;   //报告费用
            Double fee_take_sampling = 0.0;   //上门取样费用

            List<String> dates = new ArrayList<String>();   //趋势图-日期数据
            List<Double> real_incomes = new ArrayList<Double>();   //趋势图-实收
            List<Double> real_incomes_wx = new ArrayList<Double>();   //趋势图-微信收入
            List<Double> real_incomes_zfb = new ArrayList<Double>();   //趋势图-支付宝收入
            List<Double> real_incomes_cz = new ArrayList<Double>();   //趋势图-充值收入
            List<Integer> cz_users_num = new ArrayList<Integer>();   //趋势图-充值用户数量



            //收入趋势数据汇总
            if (incomeList == null){
                incomeList = new ArrayList<OrderStatisticDaily>();
            }
            if (income != null){
                incomeList.add(income);
            }
            Iterator<OrderStatisticDaily> incomeIt = incomeList.iterator();
            while (incomeIt.hasNext()) {
                OrderStatisticDaily osd = incomeIt.next();
                real_income += osd.getIncome();
                real_income_wx += osd.getIncomeWx();
                real_income_zfb += osd.getIncomeZfb();
                real_income_cz += osd.getIncomeCz();

                order_income += osd.getIncomeOrder();
                order_income_ye += osd.getIncomeYe();

                real_refund += osd.getRefundWxZfb() + osd.getRefundCz();
                order_refund += osd.getRefundWxZfb() + osd.getRefundYe();

                pay_wx += osd.getQtyWxPay();
                pay_zfb += osd.getQtyZfbPay();
                pay_ye += osd.getQtyYePay();

                fee_check += osd.getFeeCheck();
                fee_print += osd.getFeePrint();
                fee_report += osd.getFeeReport();
                fee_take_sampling += osd.getFeeTakeSampling();

                dates.add(DateUtil.formatDate(osd.getDate(), "yyyy-MM-dd"));
                real_incomes.add( new BigDecimal(osd.getIncome()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                real_incomes_wx.add( new BigDecimal(osd.getIncomeWx()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                real_incomes_zfb.add( new BigDecimal(osd.getIncomeZfb()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                real_incomes_cz.add( new BigDecimal(osd.getIncomeCz()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                cz_users_num.add(osd.getQtyCzUser());
            }

            Map<String,Object> result = new HashMap<String,Object>();
            result.put("real_income", real_income);
            result.put("real_income_wx", real_income_wx);
            result.put("real_income_zfb", real_income_zfb);
            result.put("real_income_cz", real_income_cz);

            result.put("order_income", order_income);
            result.put("order_income_ye", order_income_ye);

            result.put("real_refund", real_refund);
            result.put("order_refund", order_refund);

            result.put("pay_wx", pay_wx);
            result.put("pay_zfb", pay_zfb);
            result.put("pay_ye", pay_ye);

            result.put("fee_check", fee_check);
            result.put("fee_print", fee_print);
            result.put("fee_report", fee_report);
            result.put("fee_take_sampling", fee_take_sampling);

            result.put("dates", dates);
            result.put("real_incomes", real_incomes);
            result.put("real_incomes_wx", real_incomes_wx);
            result.put("real_incomes_zfb", real_incomes_zfb);
            result.put("real_incomes_cz", real_incomes_cz);
            result.put("cz_users_num", cz_users_num);
            jsonObj.setObj(result);

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 手动执行财务统计
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
            c1.clear();
            c1.setTime(sd);

            while (c1.getTime().getTime() <= ed.getTime()) {
                //财务统计日统计
                orderStatisticDailyService.saveOrUpdateDailyStatistic(c1);

                //财务统计月统计
                if (c1.get(Calendar.DAY_OF_MONTH) == c1.getActualMaximum(Calendar.DAY_OF_MONTH)){
                    orderStatisticMonthlyService.monthlyStatistic(c1);
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
     * 测试专用
     * 刷新从2019/07/01到昨天的财务统计
     */
    @RequestMapping("/test")
    @ResponseBody
    public String test(){
        try {
            //测试，刷新从2019/07/01到昨天的财务统计
            Calendar c1 = Calendar.getInstance();
            c1.clear();
            c1.setTime(DateUtil.parseDate("2019-07-01","yyyy-MM-dd"));

            Calendar c2 = Calendar.getInstance();
            c2.set(Calendar.HOUR_OF_DAY, 0);
            c2.set(Calendar.MINUTE, 0);
            c2.set(Calendar.SECOND, 0);

            while ( c1.getTime().getTime() < c2.getTime().getTime()){
                //统计当天订单
                orderStatisticDailyService.saveOrUpdateDailyStatistic(c1);

                //当月最后一天，统计当月订单
                if (c1.get(Calendar.DAY_OF_MONTH) == c1.getActualMaximum(Calendar.DAY_OF_MONTH)){
                    orderStatisticMonthlyService.monthlyStatistic(c1);
                }

                c1.add(Calendar.DAY_OF_MONTH, 1);
            }

        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + e.getStackTrace());
        }
        return "success";
    }

}