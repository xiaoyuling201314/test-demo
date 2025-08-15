package com.dayuan3.terminal.service;

import com.dayuan.common.PublicUtil;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.terminal.bean.OrderStatisticDaily;
import com.dayuan3.terminal.bean.OrderStatisticMonthly;
import com.dayuan3.terminal.mapper.OrderStatisticMonthlyMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class OrderStatisticMonthlyService extends BaseService<OrderStatisticMonthly, Integer> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private OrderStatisticMonthlyMapper mapper;

    public OrderStatisticMonthlyMapper getMapper() {
        return mapper;
    }

    /**
     * 每月统计订单和检测情况
     * @param calendar0  统计年月
     * @throws Exception
     */
    public void monthlyStatistic(Calendar calendar0) throws Exception {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(calendar0.getTime());

        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);

        //下个月1号
        Calendar calendar1 = Calendar.getInstance();
        calendar1.setTime(calendar.getTime());
        calendar1.add(Calendar.MONTH, 1);

        StringBuffer sql1 = new StringBuffer();
        sql1.append("SELECT " +
                " date, income, qty_order, qty_wx_order, qty_zd_order, qty_wx_pay, qty_zfb_pay,  " +
                " food_statistic, item_statistic, req_unit_statistic, ins_unit_statistic, ins_user_statistic, " +
                " qty_all_req_unit, qty_all_ins_unit  " +
                "FROM " +
                " order_statistic_daily osd  " +
                "WHERE osd.delete_flag = 0 " +
                " AND osd.date >= ? AND osd.date < ? ");
        List<Map<String, Object>> result1 = jdbcTemplate.queryForList(sql1.toString(),
                new Object[]{ DateUtil.formatDate(calendar.getTime(),"yyyy-MM-dd HH:mm:ss"),
                    DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd HH:mm:ss")});

        // 当月委托单位总数
        int qty_all_req_unit = 0;
        // 当月送检单位总数
        int qty_all_ins_unit = 0;

//        Double income = 0.0;    // 当月收入
//        int order_wx = 0;   // 当月微信下单次数
//        int order_zd = 0;   // 当月终端下单次数
//        int pay_wx = 0;     // 当月微信付款次数
//        int pay_zfb = 0;    // 当月支付宝付款次数


        // 当月送检样品种类(不管什么时候下单)
        Map<String, Map> foods_map = new HashMap<String, Map>();
        // 当月送检检测项目(不管什么时候下单)
        Map<String, Map> items_map = new HashMap<String, Map>();

//        //停止统计当月下单委托单位，因为收样可更改委托单位，统计无意义 --Dz 2020/01/03
        // 当月下单委托单位
//        Map<String, Map> req_units_map = new HashMap<String, Map>();
        // 当月下单送检单位
        Map<String, Map> ins_units_map = new HashMap<String, Map>();
        // 当月下单送检用户
        Map<String, Map> ins_users_map = new HashMap<String, Map>();

        Iterator result1_it = result1.iterator();
        while (result1_it.hasNext()){
            Map map1 = (Map) result1_it.next();

            qty_all_req_unit = qty_all_req_unit >= Integer.parseInt(map1.get("qty_all_req_unit").toString())
                    ? qty_all_req_unit : Integer.parseInt(map1.get("qty_all_req_unit").toString());

            qty_all_ins_unit = qty_all_ins_unit >= Integer.parseInt(map1.get("qty_all_req_unit").toString())
                    ? qty_all_ins_unit : Integer.parseInt(map1.get("qty_all_req_unit").toString());

            if (null != map1.get("food_statistic") && "" != map1.get("food_statistic").toString()){
                String[] foodStr1 = map1.get("food_statistic").toString().split(",");
                for (String foodStr2 : foodStr1){
                    String[] foodStr3 = foodStr2.split("-");
                    if(StringUtil.isNotEmpty(foodStr3[0])){
                        Map foodMap = foods_map.get(foodStr3[0]);
                        if (null == foodMap) {
                            foodMap = new HashMap();
                            //样品种类名称
                            foodMap.put("name", foodStr3[1]);
                            //样品种类送检次数
                            foodMap.put("number", Integer.parseInt(foodStr3[2]));
                        } else {
                            //样品种类送检次数
                            foodMap.put("number", Integer.parseInt(foodStr3[2]) + Integer.parseInt(foodMap.get("number").toString()));
                        }
                        foods_map.put(foodStr3[0], foodMap);
                    }
                }
            }

            if (null != map1.get("item_statistic") && "" != map1.get("item_statistic").toString()){
                String[] itemStr1 = map1.get("item_statistic").toString().split(",");
                for (String itemStr2 : itemStr1){
                    String[] itemStr3 = itemStr2.split("-");
                    if(StringUtil.isNotEmpty(itemStr3[0])){
                        Map itemMap = items_map.get(itemStr3[0]);
                        if (null == itemMap) {
                            itemMap = new HashMap();
                            //检测项目名称
                            itemMap.put("name", itemStr3[1]);
                            //检测项目检测次数
                            itemMap.put("number", Integer.parseInt(itemStr3[2]));
                        } else {
                            //检测项目检测次数
                            itemMap.put("number", Integer.parseInt(itemStr3[2]) + Integer.parseInt(itemMap.get("number").toString()));
                        }
                        items_map.put(itemStr3[0], itemMap);
                    }
                }
            }

//        //停止统计当月下单委托单位，因为收样可更改委托单位，统计无意义 --Dz 2020/01/03
//            if (null != map1.get("req_unit_statistic") && "" != map1.get("req_unit_statistic").toString()){
//                String[] reqUnitStr1 = map1.get("req_unit_statistic").toString().split(",");
//                for (String reqUnitStr2 : reqUnitStr1){
//                    String[] reqUnitStr3 = reqUnitStr2.split("-");
//                    if(StringUtil.isNotEmpty(reqUnitStr3[0])){
//                        Map reqUnitMap = req_units_map.get(reqUnitStr3[0]);
//                        if (null == reqUnitMap) {
//                            reqUnitMap = new HashMap();
//                            //委托单位名称
//                            reqUnitMap.put("name", reqUnitStr3[1]);
//                            //委托单位委托次数
//                            reqUnitMap.put("number", Integer.parseInt(reqUnitStr3[2]));
//                        } else {
//                            //委托单位委托次数
//                            reqUnitMap.put("number", Integer.parseInt(reqUnitStr3[2]) + Integer.parseInt(reqUnitMap.get("number").toString()));
//                        }
//                        req_units_map.put(reqUnitStr3[0], reqUnitMap);
//                    }
//                }
//            }

            if (null != map1.get("ins_unit_statistic") && "" != map1.get("ins_unit_statistic").toString()){
                String[] insUnitStr1 = map1.get("ins_unit_statistic").toString().split(",");
                for (String insUnitStr2 : insUnitStr1){
                    String[] insUnitStr3 = insUnitStr2.split("-");
                    if(StringUtil.isNotEmpty(insUnitStr3[0])){
                        Map insUnitMap = ins_units_map.get(insUnitStr3[0]);
                        if (null == insUnitMap) {
                            insUnitMap = new HashMap();
                            //送检单位名称
                            insUnitMap.put("name", insUnitStr3[1]);
                            //送检单位送检次数
                            insUnitMap.put("number", Integer.parseInt(insUnitStr3[2]));
                        } else {
                            //送检单位送检次数
                            insUnitMap.put("number", Integer.parseInt(insUnitStr3[2]) + Integer.parseInt(insUnitMap.get("number").toString()));
                        }
                        ins_units_map.put(insUnitStr3[0], insUnitMap);
                    }
                }
            }

            if (null != map1.get("ins_user_statistic") && "" != map1.get("ins_user_statistic").toString()){
                String[] insUserStr1 = map1.get("ins_user_statistic").toString().split(",");
                for (String insUserStr2 : insUserStr1){
                    String[] insUserStr3 = insUserStr2.split("-");
                    if(StringUtil.isNotEmpty(insUserStr3[0])){
                        Map insUserMap = ins_units_map.get(insUserStr3[0]);
                        if (null == insUserMap) {
                            insUserMap = new HashMap();
                            //送检用户名称
                            insUserMap.put("name", insUserStr3[1]);
                            //送检用户送检次数
                            insUserMap.put("number", Integer.parseInt(insUserStr3[2]));
                        } else {
                            //送检用户送检次数
                            insUserMap.put("number", Integer.parseInt(insUserStr3[2]) + Integer.parseInt(insUserMap.get("number").toString()));
                        }
                        ins_users_map.put(insUserStr3[0], insUserMap);
                    }
                }
            }

        }

        //当月送检样品种类统计(格式:ID-样品种类-检测次数)
        StringBuffer foods_str = new StringBuffer();
        if (foods_map.size()>0){
            Iterator<Map.Entry<String, Map>> foods_it = foods_map.entrySet().iterator();
            while (foods_it.hasNext()){
                Map.Entry<String, Map> m1 = foods_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                foods_str.append(id+"-"+name+"-"+number+",");
            }
            foods_str.deleteCharAt(foods_str.length()-1);
        }

        //当月送检检测项目统计(格式:ID-检测项目-检测次数)
        StringBuffer items_str = new StringBuffer();
        if (items_map.size()>0){
            Iterator<Map.Entry<String, Map>> items_it = items_map.entrySet().iterator();
            while (items_it.hasNext()){
                Map.Entry<String, Map> m1 = items_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                items_str.append(id+"-"+name+"-"+number+",");
            }
            items_str.deleteCharAt(items_str.length()-1);
        }

//        //停止统计当月下单委托单位，因为收样可更改委托单位，统计无意义 --Dz 2020/01/03
//        //当月委托单位订单统计(格式:ID-委托单位-订单数量)
//        StringBuffer req_units_str = new StringBuffer();
//        if (req_units_map.size()>0){
//            Iterator<Map.Entry<String, Map>> req_units_it = req_units_map.entrySet().iterator();
//            while (req_units_it.hasNext()){
//                Map.Entry<String, Map> m1 = req_units_it.next();
//                String id = m1.getKey();
//                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
//                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
//                req_units_str.append(id+"-"+name+"-"+number+",");
//            }
//            req_units_str.deleteCharAt(req_units_str.length()-1);
//        }

        //当月送检单位订单统计(格式:ID-送检单位-订单数量)
        StringBuffer ins_units_str = new StringBuffer();
        if (ins_units_map.size()>0){
            Iterator<Map.Entry<String, Map>> ins_units_it = ins_units_map.entrySet().iterator();
            while (ins_units_it.hasNext()){
                Map.Entry<String, Map> m1 = ins_units_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                ins_units_str.append(id+"-"+name+"-"+number+",");
            }
            ins_units_str.deleteCharAt(ins_units_str.length()-1);
        }

        //当月送检用户订单统计(格式:ID-送检用户-订单数量)
        StringBuffer ins_users_str = new StringBuffer();
        if (ins_users_map.size()>0){
            Iterator<Map.Entry<String, Map>> ins_users_it = ins_users_map.entrySet().iterator();
            while (ins_users_it.hasNext()){
                Map.Entry<String, Map> m1 = ins_users_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                ins_users_str.append(id+"-"+name+"-"+number+",");
            }
            ins_users_str.deleteCharAt(ins_users_str.length()-1);
        }


        //实际收款(微信收款+支付宝收款+充值收款-订单退款-充值退款)
        Double income = 0.0;
        //订单收款(微信收款+支付宝收款+余额付款-订单退款-余额退款)
        Double income_order = 0.0;
        //余额付款
        Double income_ye = 0.0;
        //微信收款
        Double income_wx = 0.0;
        //支付宝收款
        Double income_zfb = 0.0;

        //订单退款(支付宝、微信退款)
        Double refund_wx_zfb = 0.0;
        //余额退款
        Double refund_ye = 0.0;
        //充值退款
        Double refund_cz = 0.0;

        //充值收款
        Double income_cz = 0.0;
        //充值次数
        int qty_cz = 0;

        //当月订单数量
        int qty_order = 0;
        //当月微信下单次数
        int order_wx = 0;
        //当月终端下单次数
        int order_zd = 0;

        //当月微信付款次数(不含充值)
        int pay_wx = 0;
        //当月支付宝付款次数(不含充值)
        int pay_zfb = 0;
        //当月余额付款次数
        int pay_ye = 0;

        //检测费用(元)
        Double fee_check = 0.0;
        //打印费用(元)
        Double fee_print = 0.0;
        //报告费用(元)
        Double fee_report = 0.0;
        //上门取样费用(元)
        Double fee_take_sampling = 0.0;

        //月统计
        StringBuffer sql2 = new StringBuffer("SELECT SUM(osd.income) income, SUM(osd.qty_order) qty_order, " +
                " SUM(osd.qty_wx_order) qty_wx_order, SUM(osd.qty_zd_order) qty_zd_order, " +
                " SUM(osd.qty_wx_pay) qty_wx_pay, SUM(osd.qty_zfb_pay) qty_zfb_pay, " +
                " SUM(osd.qty_ye_pay) qty_ye_pay, SUM(osd.income_ye) income_ye, " +
                " SUM(osd.income_wx) income_wx, SUM(osd.income_zfb) income_zfb, " +
                " SUM(osd.income_cz) income_cz, SUM(osd.refund_wx_zfb) refund_wx_zfb, " +
                " SUM(osd.refund_ye) refund_ye, SUM(osd.refund_cz) refund_cz, " +
                " SUM(osd.qty_cz) qty_cz, SUM(osd.income_order) income_order, " +
                " SUM(osd.fee_check) fee_check, SUM(osd.fee_print) fee_print, " +
                " SUM(osd.fee_report) fee_report, SUM(osd.fee_take_sampling) fee_take_sampling " +
                "FROM " +
                " order_statistic_daily osd  " +
                "WHERE osd.delete_flag = 0 " +
                " AND osd.date >= ? AND osd.date < ? ");
        List<Map<String, Object>> result2 = jdbcTemplate.queryForList(sql2.toString(),
                new Object[]{ DateUtil.formatDate(calendar.getTime(),"yyyy-MM-dd HH:mm:ss"),
                        DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd HH:mm:ss")});
        if (result2!=null && result2.size()>0) {
            Map<String, Object> map2 = result2.get(0);
            income = map2.get("income") == null ? 0.0 : Double.parseDouble(map2.get("income").toString());
            income_order = map2.get("income_order") == null ? 0.0 : Double.parseDouble(map2.get("income_order").toString());
            income_ye = map2.get("income_ye") == null ? 0.0 : Double.parseDouble(map2.get("income_ye").toString());
            income_wx = map2.get("income_wx") == null ? 0.0 : Double.parseDouble(map2.get("income_wx").toString());
            income_zfb = map2.get("income_zfb") == null ? 0.0 : Double.parseDouble(map2.get("income_zfb").toString());
            refund_wx_zfb = map2.get("refund_wx_zfb") == null ? 0.0 : Double.parseDouble(map2.get("refund_wx_zfb").toString());
            refund_ye = map2.get("refund_ye") == null ? 0.0 : Double.parseDouble(map2.get("refund_ye").toString());
            refund_cz = map2.get("refund_cz") == null ? 0.0 : Double.parseDouble(map2.get("refund_cz").toString());
            income_cz = map2.get("income_cz") == null ? 0.0 : Double.parseDouble(map2.get("income_cz").toString());

            qty_cz = map2.get("qty_cz") == null ? 0 : Integer.parseInt(map2.get("qty_cz").toString());
            qty_order = map2.get("qty_order") == null ? 0 : Integer.parseInt(map2.get("qty_order").toString());
            order_wx = map2.get("qty_wx_order") == null ? 0 : Integer.parseInt(map2.get("qty_wx_order").toString());
            order_zd = map2.get("qty_zd_order") == null ? 0 : Integer.parseInt(map2.get("qty_zd_order").toString());
            pay_wx = map2.get("qty_wx_pay") == null ? 0 : Integer.parseInt(map2.get("qty_wx_pay").toString());
            pay_zfb = map2.get("qty_zfb_pay") == null ? 0 : Integer.parseInt(map2.get("qty_zfb_pay").toString());
            pay_ye = map2.get("qty_ye_pay") == null ? 0 : Integer.parseInt(map2.get("qty_ye_pay").toString());

            fee_check = map2.get("fee_check") == null ? 0.0 : Double.parseDouble(map2.get("fee_check").toString());
            fee_print = map2.get("fee_print") == null ? 0.0 : Double.parseDouble(map2.get("fee_print").toString());
            fee_report = map2.get("fee_report") == null ? 0.0 : Double.parseDouble(map2.get("fee_report").toString());
            fee_take_sampling = map2.get("fee_take_sampling") == null ? 0.0 : Double.parseDouble(map2.get("fee_take_sampling").toString());

        }

        //月统计充值用户数量
        StringBuffer sql3 = new StringBuffer("SELECT COUNT(1), SUM(money) " +
                "FROM income ic " +
                "WHERE ic.delete_flag = 0  " +
                " AND ic.status = 1  " +
                " AND ic.transaction_type = 2  " +
                " AND ic.pay_date >= ? " +
                " AND ic.pay_date < ? " +
                "GROUP BY ic.create_by ");

        List<Map<String, Object>> result3 = jdbcTemplate.queryForList(sql3.toString(),
                new Object[]{ DateUtil.formatDate(calendar.getTime(),"yyyy-MM-dd HH:mm:ss"),
                        DateUtil.formatDate(calendar1.getTime(),"yyyy-MM-dd HH:mm:ss")});
        //充值用户数量
        int qty_cz_user = result3.size();


        //新增或更新统计记录
        OrderStatisticMonthly oldStatisticMonthly= this.selectByDate(DateUtil.formatDate(calendar.getTime(),"yyyy-MM-dd"));
        OrderStatisticMonthly statisticMonthly = new OrderStatisticMonthly(calendar.getTime(), income,
                qty_order, order_wx, order_zd, pay_wx, pay_zfb, foods_map.size(), foods_str.toString(), items_map.size(), items_str.toString(),
                null, null, ins_units_map.size(), ins_units_str.toString(), null, null, null, qty_all_req_unit, qty_all_ins_unit,
                pay_ye, income_ye, income_wx, income_zfb, income_cz, refund_wx_zfb, refund_ye, refund_cz, qty_cz, qty_cz_user, income_order,
                fee_check, fee_print, fee_report, fee_take_sampling, null, null, null, ins_users_map.size(), ins_users_str.toString());

        if (oldStatisticMonthly == null){
            PublicUtil.setCommonForTable(statisticMonthly,true, null);
            mapper.insertSelective(statisticMonthly);

        } else {
            PublicUtil.setCommonForTable(statisticMonthly,false, null);
            statisticMonthly.setId(oldStatisticMonthly.getId());
            mapper.updateByPrimaryKeySelective(statisticMonthly);
        }
    }

    /**
     * 根据年月查询财务统计
     * @param date 格式:yyyy-MM-dd
     * @return
     */
    public OrderStatisticMonthly selectByDate(String date){
        return mapper.selectByDate(date);
    }

    /**
     * 根据年月查询财务统计
     * @param start
     * @param end
     * @return
     */
    public List<OrderStatisticMonthly> selectByDate2(String start, String end){
        return mapper.selectByDate2(start, end);
    }

}
