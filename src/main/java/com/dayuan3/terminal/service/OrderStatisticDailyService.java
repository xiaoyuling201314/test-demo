package com.dayuan3.terminal.service;

import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan3.terminal.bean.OrderStatisticDaily;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.mapper.OrderStatisticDailyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class OrderStatisticDailyService extends BaseService<OrderStatisticDaily, Integer> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private OrderStatisticDailyMapper mapper;

    @Override
    public OrderStatisticDailyMapper getMapper() {
        return mapper;
    }

    /**
     * 新增或更新某天统计订单和检测情况
     *
     * @param calendar0 统计日期
     */
    public void saveOrUpdateDailyStatistic(Calendar calendar0) throws Exception {
        //新增或更新统计记录
        OrderStatisticDaily statisticDaily = this.dailyStatistic(calendar0);
        OrderStatisticDaily oldStatisticDaily = this.selectByDate(DateUtil.formatDate(statisticDaily.getDate(), "yyyy-MM-dd"));
        if (oldStatisticDaily == null) {
            //查询委托单位总数
            StringBuffer sql1 = new StringBuffer();
            sql1.append("SELECT COUNT(1) FROM requester_unit WHERE delete_flag = 0 ");
            int reqUnitNum = jdbcTemplate.queryForObject(sql1.toString(), Integer.class);
            statisticDaily.setQtyAllReqUnit(reqUnitNum);

            //查询送检单位总数
            sql1.setLength(0);
            sql1.append("SELECT COUNT(1) FROM inspection_unit WHERE delete_flag = 0 ");
            int insUnitNum = jdbcTemplate.queryForObject(sql1.toString(), Integer.class);
            statisticDaily.setQtyAllInsUnit(insUnitNum);

            Date now=new Date();
            statisticDaily.setCreateDate(now);
            statisticDaily.setUpdateDate(now);
            mapper.insertSelective(statisticDaily);

        } else {
            statisticDaily.setId(oldStatisticDaily.getId());
            Date now=new Date();
            statisticDaily.setUpdateDate(now);
            mapper.updateByPrimaryKeySelective(statisticDaily);
        }
    }

    /**
     * 统计某天订单和检测情况
     *
     * @param calendar0 统计日期
     * @throws Exception
     */
    public OrderStatisticDaily dailyStatistic(Calendar calendar0) throws Exception {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(calendar0.getTime());

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

        //订单退款(退款到支付宝、微信)
        Double refund_wx_zfb = 0.0;
        //余额退款(退款到账户余额)
        Double refund_ye = 0.0;
        //充值退款(退款到用户支付宝、微信)
        Double refund_cz = 0.0;

        //充值收款
        Double income_cz = 0.0;
        //充值次数
        Integer qty_cz = 0;
        //充值用户数量
        Integer qty_cz_user = 0;

        //当天微信下单次数
        Integer order_wx = 0;
        //当天终端下单次数
        Integer order_zd = 0;

        //当天微信付款次数(不含充值)
        Integer pay_wx = 0;
        //当天支付宝付款次数(不含充值)
        Integer pay_zfb = 0;
        //当天余额付款次数
        Integer pay_ye = 0;

        //检测费用(元)
        Double fee_check = 0.0;
        //打印费用(元)
        Double fee_print = 0.0;
        //报告费用(元)
        Double fee_report = 0.0;
        //上门取样费用(元)
        Double fee_take_sampling = 0.0;

        //当天下单送检单位
        Map<String, Map> ins_units_map = new HashMap<String, Map>();
        //当天下单送检用户
        Map<String, Map> ins_users_map = new HashMap<String, Map>();

        //获取当天订单
        StringBuffer sql1 = new StringBuffer();
        sql1.append("SELECT ts.id, ts.iu_id, ts.iu_name, ts.order_userid, ts.order_username, " +
                " ts.order_fees, ts.order_type," +
                " iu.id company_id, iu.company_name, iuu.id user_id, iuu.real_name user_name " +
                "FROM tb_sampling ts  " +
                "  LEFT JOIN inspection_unit_user iuu ON ts.order_userid = iuu.id " +
                "  LEFT JOIN inspection_unit iu ON iuu.inspection_id = iu.id " +
                "WHERE ts.delete_flag=0 AND ts.order_status=2" +
                " AND ts.order_time >= ? AND ts.order_time <= ? ");
        List<Map<String, Object>> result1 = jdbcTemplate.queryForList(sql1.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});

        for (Map map1 : result1) {
            //下单方式
            if (null != map1.get("order_type")) {
                int orderPlatform = Integer.parseInt(map1.get("order_type").toString());
                //自助下单
                if (orderPlatform == 1) {
                    order_zd += 1;
                    //电子抽样
                } else if (orderPlatform == 2) {
                    order_wx += 1;
                }
            }

            //送检单位
            if (null != map1.get("company_id")) {
                Map iuMap = ins_units_map.get(map1.get("company_id").toString());
                if (null == iuMap) {
                    iuMap = new HashMap();
                    //送检单位名称
                    iuMap.put("name", map1.get("company_name") == null ? "" : map1.get("company_name").toString());
                    //送检订单数量
                    iuMap.put("number", 1);
                } else {
                    //送检订单数量
                    iuMap.put("number", (int) iuMap.get("number") + 1);
                }
                ins_units_map.put(map1.get("company_id").toString(), iuMap);
            }

            //送检用户
            if (null != map1.get("user_id")) {
                Map iuserMap = ins_users_map.get(map1.get("user_id").toString());
                if (null == iuserMap) {
                    iuserMap = new HashMap();
                    //送检用户名称
                    iuserMap.put("name", map1.get("user_name") == null ? "" : map1.get("user_name").toString());
                    //送检订单数量
                    iuserMap.put("number", 1);
                } else {
                    //送检订单数量
                    iuserMap.put("number", (int) iuserMap.get("number") + 1);
                }
                ins_users_map.put(map1.get("user_id").toString(), iuserMap);
            }
        }

        //当天送检单位订单统计(格式:ID-送检单位-订单数量)
        StringBuffer ins_units_str = new StringBuffer();
        if (ins_units_map.size() > 0) {
            Iterator<Map.Entry<String, Map>> ins_units_it = ins_units_map.entrySet().iterator();
            while (ins_units_it.hasNext()) {
                Map.Entry<String, Map> m1 = ins_units_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                ins_units_str.append(id + "-" + name + "-" + number + ",");
            }
            ins_units_str.deleteCharAt(ins_units_str.length() - 1);
        }

        //当天送检用户订单统计(格式:ID-送检用户-订单数量)
        StringBuffer ins_users_str = new StringBuffer();
        if (ins_users_map.size() > 0) {
            Iterator<Map.Entry<String, Map>> ins_users_it = ins_users_map.entrySet().iterator();
            while (ins_users_it.hasNext()) {
                Map.Entry<String, Map> m1 = ins_users_it.next();
                String id = m1.getKey();
                String name = m1.getValue().get("name") == null ? "" : m1.getValue().get("name").toString();
                String number = m1.getValue().get("number") == null ? "0" : m1.getValue().get("number").toString();
                ins_users_str.append(id + "-" + name + "-" + number + ",");
            }
            ins_users_str.deleteCharAt(ins_users_str.length() - 1);
        }

        //获取当天送检样品种类
        StringBuffer sql2 = new StringBuffer();
        sql2.append("SELECT tsd.food_id, tsd.food_name, count(1) number " +
                "FROM tb_sampling_detail tsd  " +
                "WHERE tsd.print_code_time >= ? AND tsd.print_code_time <= ? " +
                "GROUP BY tsd.food_id ");
        List<Map<String, Object>> result2 = jdbcTemplate.queryForList(sql2.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});

        //当天送检样品种类统计(格式:ID-样品种类-检测次数)
        StringBuffer foods_str = new StringBuffer();
        if (result2.size() > 0) {
            Iterator<Map<String, Object>> result2_it = result2.iterator();
            while (result2_it.hasNext()) {
                Map<String, Object> m1 = result2_it.next();
                String id = m1.get("food_id") == null ? "" : m1.get("food_id").toString();
                String name = m1.get("food_name") == null ? "" : m1.get("food_name").toString();
                String number = m1.get("number") == null ? "" : m1.get("number").toString();
                foods_str.append(id + "-" + name + "-" + number + ",");
            }
            foods_str.deleteCharAt(foods_str.length() - 1);
        }


        //获取当天送检检测项目
        StringBuffer sql3 = new StringBuffer();
        sql3.append("SELECT tsd.item_id, tsd.item_name, count(1) number " +
                "FROM tb_sampling_detail tsd  " +
                "WHERE tsd.print_code_time >= ? AND tsd.print_code_time <= ? " +
                "GROUP BY tsd.item_id ");
        List<Map<String, Object>> result3 = jdbcTemplate.queryForList(sql3.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});

        //当天送检检测项目统计(格式:ID-检测项目-检测次数)
        StringBuffer items_str = new StringBuffer();
        if (result3.size() > 0) {
            Iterator<Map<String, Object>> result3_it = result3.iterator();
            while (result3_it.hasNext()) {
                Map<String, Object> m1 = result3_it.next();
                String id = m1.get("item_id") == null ? "" : m1.get("item_id").toString();
                String name = m1.get("item_name") == null ? "" : m1.get("item_name").toString();
                String number = m1.get("number") == null ? "" : m1.get("number").toString();
                items_str.append(id + "-" + name + "-" + number + ",");
            }
            items_str.deleteCharAt(items_str.length() - 1);
        }


        //获取当天(检测费用、打印费用、报告费用)收款次数、金额
        StringBuffer sql4 = new StringBuffer();
        sql4.append("SELECT ic.pay_type, COUNT(1) pay_number, " +
                " SUM(ic.money) money  " +  //总费用（含检测费用、复检费用）
//                " SUM(ic.check_money) check_money, " +  //检测费用
//                " SUM(ic.report_money) report_money, " +    //一单多用，报告费用
//                " SUM(ic.take_sampling_money) take_sampling_money, " +  //上门取样费用
//                " SUM(IF(ic.transaction_type = 1, ic.money, 0)) print_money " + //重打报告费用
                "FROM income ic " +
                "WHERE ic.delete_flag = 0  " +
                " AND ic.status = 1 AND ic.transaction_type IN (0,1) " +    //0_检测费用, 1_打印费用
                " AND ic.pay_date >= ?  " +
                " AND ic.pay_date <= ?  " +
                "GROUP BY ic.pay_type");
        List<Map<String, Object>> result4 = jdbcTemplate.queryForList(sql4.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});
        Iterator<Map<String, Object>> it4 = result4.iterator();
        while (it4.hasNext()) {
            Map<String, Object> map4 = it4.next();
            Integer pay_type = map4.get("pay_type") == null ? null : Integer.parseInt(map4.get("pay_type").toString());
            Integer pay_number = map4.get("pay_number") == null ? 0 : Integer.parseInt(map4.get("pay_number").toString());
            Double money = map4.get("money") == null ? 0.0 : Double.parseDouble(map4.get("money").toString());
            Double report_money = map4.get("report_money") == null ? 0.0 : Double.parseDouble(map4.get("report_money").toString());
            Double check_money = map4.get("check_money") == null ? 0.0 : Double.parseDouble(map4.get("check_money").toString());
            Double print_money = map4.get("print_money") == null ? 0.0 : Double.parseDouble(map4.get("print_money").toString());
            Double take_sampling_money = map4.get("take_sampling_money") == null ? 0.0 : Double.parseDouble(map4.get("take_sampling_money").toString());

            //微信、支付宝和余额收入：检测费用（含报告费用、上门取样费用） + 打印费用
            if (pay_type == 0) {
                pay_wx = pay_number;
                income_wx = money;
            } else if (pay_type == 1) {
                pay_zfb = pay_number;
                income_zfb = money;
            } else if (pay_type == 2) {
                pay_ye = pay_number;
                income_ye = money;
            }

            //检测费用(元)
            fee_check += check_money;
            //打印费用(元)
            fee_print += print_money;
            //报告费用(元)
            fee_report += report_money;
            //上门取样费用(元)
            fee_take_sampling += take_sampling_money;
        }


        //获取当天充值次数、金额、用户数量
        StringBuffer sql5 = new StringBuffer();
        sql5.append("SELECT COUNT(1) cz_number, SUM(money) money " +
                "FROM income ic " +
                "WHERE ic.delete_flag = 0  " +
                " AND ic.status = 1  " +
                " AND ic.transaction_type = 2  " +
                " AND ic.pay_date >= ? " +
                " AND ic.pay_date <= ? " +
                "GROUP BY ic.create_by");
        List<Map<String, Object>> result5 = jdbcTemplate.queryForList(sql5.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});

        qty_cz_user = result5.size();
        Iterator<Map<String, Object>> it5 = result5.iterator();
        while (it5.hasNext()) {
            Map<String, Object> map5 = it5.next();
            qty_cz += map5.get("cz_number") == null ? 0 : Integer.parseInt(map5.get("cz_number").toString());
            income_cz += map5.get("money") == null ? 0.0 : Double.parseDouble(map5.get("money").toString());
        }


        //获取退款金额
        StringBuffer sql6 = new StringBuffer();
        sql6.append("SELECT ic.transaction_type, ic.pay_type, SUM(money) money " +
                "FROM income ic " +
                "WHERE ic.delete_flag = 0  " +
                " AND ic.status = 1  " +
                " AND ic.transaction_type IN(3,4)  " +
                " AND ic.pay_date >= ? " +
                " AND ic.pay_date <= ? " +
                "GROUP BY ic.transaction_type");
        List<Map<String, Object>> result6 = jdbcTemplate.queryForList(sql6.toString(),
                new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 00:00:00",
                        DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd") + " 23:59:59"});

        Iterator<Map<String, Object>> it6 = result6.iterator();
        while (it6.hasNext()) {
            Map<String, Object> map6 = it6.next();
            Integer transaction_type = map6.get("transaction_type") == null ? null : Integer.parseInt(map6.get("transaction_type").toString());
            Integer pay_type = map6.get("pay_type") == null ? null : Integer.parseInt(map6.get("pay_type").toString());
            Double money = map6.get("money") == null ? 0.0 : Double.parseDouble(map6.get("money").toString());
            if (transaction_type == 3) {
                //订单退款
                if (pay_type == 0 || pay_type == 1) {
                    refund_wx_zfb += money;
                } else if (pay_type == 2) {
                    refund_ye += money;
                }
            } else if (transaction_type == 4) {
                //充值退款
                refund_cz += money;
            }
        }


        income = income_wx + income_zfb + income_cz - refund_wx_zfb - refund_cz;
        income_order = income_wx + income_zfb + income_ye - refund_wx_zfb - refund_ye;

        OrderStatisticDaily statisticDaily = new OrderStatisticDaily(calendar.getTime(), income,
                order_wx + order_zd, order_wx, order_zd, pay_wx, pay_zfb, result2.size(), foods_str.toString(), result3.size(), items_str.toString(),
                null, null, ins_units_map.size(), ins_units_str.toString(), null, null, null, null, null,
                pay_ye, income_ye, income_wx, income_zfb, income_cz, refund_wx_zfb, refund_ye, refund_cz, qty_cz, qty_cz_user, income_order,
                fee_check, fee_print, fee_report, fee_take_sampling, null, null, null, ins_users_map.size(), ins_users_str.toString());
        return statisticDaily;
    }


    /**
     * 根据日期查询财务统计
     *
     * @param date 格式:yyyy-MM-dd
     * @return
     */
    public OrderStatisticDaily selectByDate(String date) {
        return mapper.selectByDate(date);
    }

    /**
     * 根据日期段查询财务统计
     *
     * @param start 开始时间
     * @param end   结束时间
     * @return
     */
    public List<OrderStatisticDaily> selectByDate2(String start, String end) {
        return mapper.selectByDate2(start, end);
    }

    /**
     * 获取订单对应的委托单位列表
     */
    public List<RequesterUnit> getRequesterList(String orderNo, Integer[] requestIds) {
        return mapper.getRequesterList(orderNo, requestIds);
    }

    public Page loadDatagrid(Page page, RequesterUnit t) throws Exception {


        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);

        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());

        }
        List<RequesterUnit> list = mapper.getRequesterLists(page);
        page.setResults(list);
        return page;
    }
}
