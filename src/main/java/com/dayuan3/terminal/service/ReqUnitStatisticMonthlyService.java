package com.dayuan3.terminal.service;

import com.dayuan.common.PublicUtil;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.bean.ReqUnitStatisticDaily;
import com.dayuan3.terminal.bean.ReqUnitStatisticMonthly;
import com.dayuan3.terminal.mapper.ReqUnitStatisticDailyMapper;
import com.dayuan3.terminal.mapper.ReqUnitStatisticMonthlyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class ReqUnitStatisticMonthlyService extends BaseService<ReqUnitStatisticMonthly, Integer> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private ReqUnitStatisticMonthlyMapper mapper;

    public ReqUnitStatisticMonthlyMapper getMapper() {
        return mapper;
    }

    /**
     * 新增或更新某天委托单位统计记录
     * @param calendar0 统计日期
     */
    public void saveOrUpdateMonthlyStatistic(Calendar calendar0) throws Exception {
//        //新增或更新统计记录
//        InsUnitStatisticDaily statisticDaily = this.dailyStatistic(calendar0, null);
//        InsUnitStatisticDaily oldStatisticDaily = this.selectByDate(DateUtil.formatDate(statisticDaily.getDate(),"yyyy-MM-dd"));
//        PublicUtil.setCommonForTable(statisticDaily,true, null);
//        if (oldStatisticDaily == null){
//            mapper.insertSelective(statisticDaily);
//
//        } else {
//            statisticDaily.setId(oldStatisticDaily.getId());
//            mapper.updateByPrimaryKeySelective(statisticDaily);
//        }
    }

    /**
     * 委托单位月统计
     * @param calendar0  统计年月
     * @param insUnitId  委托单位ID NULL：统计全部单位
     * @throws Exception
     */
    public void monthlyStatistic(Calendar calendar0, Integer insUnitId) throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.setTime(calendar0.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));

        String yyyyMMddStr0 = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-01");    //统计年月-第一天
        String yyyyMMddStr1 = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd");    //统计年月-最后一天
        Date yyyyMMdd0 = DateUtil.parseDate(yyyyMMddStr0, "yyyy-MM-dd");    //统计年月-第一天

        //当月送检数据
        StringBuffer sql1 = new StringBuffer();
        sql1.append("SELECT rusd.date, rusd.ins_uint_id, rusd.ins_uint_name,  " +
                " SUM(rusd.check_number) check_number, SUM(rusd.unqualified_number) unqualified_number,  " +
                " SUM(rusd.check_number_daily) check_number_monthly,  " +
                " GROUP_CONCAT(unqualified_statistic) unqualified_statistic " +
                "FROM req_unit_statistic_daily rusd " +
                "WHERE rusd.delete_flag = 0 " +
                " AND rusd.date >= ? " +
                " AND rusd.date <= ? ");
        if (insUnitId != null){
            sql1.append(" AND ts.reg_id = " + insUnitId + " ");
        }
        sql1.append(" GROUP BY rusd.ins_uint_id ");

        List list1 = jdbcTemplate.queryForList(sql1.toString(), new Object[]{yyyyMMddStr0 + " 00:00:00", yyyyMMddStr1 + " 23:59:59"});
        Iterator it1 = list1.iterator();
        while (it1.hasNext()){
            Map<String, Object> map1 = (Map<String, Object>) it1.next();

            Integer check_number = StringUtil.isNotEmpty(map1.get("check_number")) ? Integer.parseInt(map1.get("check_number").toString()) : 0;
            Integer unqualified_number = StringUtil.isNotEmpty(map1.get("unqualified_number")) ? Integer.parseInt(map1.get("unqualified_number").toString()) : 0;
            Integer check_number_monthly = StringUtil.isNotEmpty(map1.get("check_number_monthly")) ? Integer.parseInt(map1.get("check_number_monthly").toString()) : 0;

            ReqUnitStatisticMonthly reqUnitStatisticMonthly = new ReqUnitStatisticMonthly();
            reqUnitStatisticMonthly.setDate(yyyyMMdd0);
            reqUnitStatisticMonthly.setInsUintId(map1.get("ins_uint_id") == null ? null : Integer.parseInt(map1.get("ins_uint_id").toString()));
            reqUnitStatisticMonthly.setInsUintName(map1.get("ins_uint_name") == null ? "" : map1.get("ins_uint_name").toString());
            reqUnitStatisticMonthly.setCheckNumber(check_number);
            reqUnitStatisticMonthly.setUnqualifiedNumber(unqualified_number);
            reqUnitStatisticMonthly.setCheckNumberMonthly(check_number_monthly);

            String unqualified_statistic = map1.get("unqualified_statistic")!=null?map1.get("unqualified_statistic").toString():"";
            if (StringUtil.isNotEmpty(unqualified_statistic)) {
                Map<String, Integer> food_item_unqualified_map = new HashMap<String, Integer>();

                String[] food_item_unqualifieds = unqualified_statistic.split(",");
                for (String food_item_unqualified : food_item_unqualifieds) {
                    if (StringUtil.isNotEmpty(food_item_unqualified)) {
                        String[] food_item_unqualified0 = food_item_unqualified.split("-");
                        if (food_item_unqualified_map.get(food_item_unqualified0[0]+"-"+food_item_unqualified0[1]) == null) {
                            food_item_unqualified_map.put(food_item_unqualified0[0]+"-"+food_item_unqualified0[1], Integer.parseInt(food_item_unqualified0[2]));
                        } else {
                            food_item_unqualified_map.put(food_item_unqualified0[0]+"-"+food_item_unqualified0[1],
                                    food_item_unqualified_map.get(food_item_unqualified0[0]+"-"+food_item_unqualified0[1]) + Integer.parseInt(food_item_unqualified0[2]));
                        }
                    }
                }

                StringBuffer food_item_unqualified_str = new StringBuffer();
                Iterator<Map.Entry<String, Integer>> it2 = food_item_unqualified_map.entrySet().iterator();
                while (it2.hasNext()) {
                    Map.Entry<String, Integer> map2 = it2.next();
                    food_item_unqualified_str.append(map2.getKey()+"-"+map2.getValue().toString()+",");
                }
                if (food_item_unqualified_str.length()>0){
                    food_item_unqualified_str.deleteCharAt(food_item_unqualified_str.length()-1);
                }
                reqUnitStatisticMonthly.setUnqualifiedStatistic(food_item_unqualified_str.toString());
            }

            //新增或更新委托单位统计
            ReqUnitStatisticMonthly reqUnitStatisticMonthly0 = this.selectByDate(yyyyMMddStr0, reqUnitStatisticMonthly.getInsUintId());
            if (reqUnitStatisticMonthly0 != null) {
                reqUnitStatisticMonthly.setId(reqUnitStatisticMonthly0.getId());
                PublicUtil.setCommonForTable(reqUnitStatisticMonthly, false, null);
                this.updateBySelective(reqUnitStatisticMonthly);
            } else {
                PublicUtil.setCommonForTable(reqUnitStatisticMonthly, true, null);
                this.insert(reqUnitStatisticMonthly);
            }
        }
    }


    /**
     * 根据日期查询委托单位统计
     * @param date 格式:yyyy-MM-dd
     * @param unitId 委托单位ID
     * @return
     */
    public ReqUnitStatisticMonthly selectByDate(String date, Integer unitId){
        return mapper.selectByDate(date, unitId);
    }

    /**
     * 根据日期段查询委托单位统计
     * @param start 格式:yyyy-MM-dd
     * @param end   格式:yyyy-MM-dd
     * @param unitId    委托单位ID
     * @return
     */
    public List<ReqUnitStatisticMonthly> selectByDate2(String start, String end, Integer unitId){
        return mapper.selectByDate2(start, end, unitId);
    }



}
