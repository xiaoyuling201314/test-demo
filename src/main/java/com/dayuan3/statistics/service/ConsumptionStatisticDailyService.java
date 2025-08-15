package com.dayuan3.statistics.service;

import com.dayuan.common.PublicUtil;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan3.statistics.bean.ConsumptionStatisticDaily;
import com.dayuan3.statistics.mapper.ConsumptionStatisticDailyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class ConsumptionStatisticDailyService extends BaseService<ConsumptionStatisticDaily, Integer> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private ConsumptionStatisticDailyMapper mapper;

    public ConsumptionStatisticDailyMapper getMapper() {
        return mapper;
    }

    /**
     * 新增或更新某天统计订单和检测情况
     * @param calendar0 统计日期
     */
    public void saveOrUpdateDailyStatistic(Calendar calendar0) throws Exception {
        //最新消费情况
        List<ConsumptionStatisticDaily> statisticDailys0 = this.dailyStatistic(calendar0, null);

        if (statisticDailys0 != null && statisticDailys0.size() > 0) {
            //以往统计消费情况
            List<ConsumptionStatisticDaily> statisticDailys1 = this.selectByDate(DateUtil.formatDate(statisticDailys0.get(0).getDate(),"yyyy-MM-dd"), null);

            if (statisticDailys1 == null || statisticDailys1.size() == 0){
                //新增
                Iterator it0 = statisticDailys0.iterator();
                while (it0.hasNext()) {
                    ConsumptionStatisticDaily statisticDaily0 = (ConsumptionStatisticDaily) it0.next();
                    //日期和送检用户ID不允许为空
                    if (statisticDaily0.getDate() != null && statisticDaily0.getUserId() != null) {
                        PublicUtil.setCommonForTable(statisticDaily0,true, null);
                        mapper.insertSelective(statisticDaily0);
                    }
                }

            } else {
                //新增或更新
                Iterator it0 = statisticDailys0.iterator();
                while (it0.hasNext()) {
                    //最新消费记录
                    ConsumptionStatisticDaily statisticDaily0 = (ConsumptionStatisticDaily) it0.next();

                    //日期和送检用户ID不允许为空
                    if (statisticDaily0.getDate() != null && statisticDaily0.getUserId() != null) {

                        if (statisticDailys1.size() == 0) {
                            PublicUtil.setCommonForTable(statisticDaily0,true, null);
                            mapper.insertSelective(statisticDaily0);

                        } else {
                            Iterator it1 = statisticDailys1.iterator();
                            while (it1.hasNext()) {
                                //以往消费记录
                                ConsumptionStatisticDaily statisticDaily1 = (ConsumptionStatisticDaily) it1.next();
                                //对比日期和用户ID，更新
                                if (DateUtil.formatDate(statisticDaily0.getDate(),"yyyy-MM-dd").equals(DateUtil.formatDate(statisticDaily1.getDate(),"yyyy-MM-dd"))
                                        && statisticDaily0.getUserId().equals(statisticDaily1.getUserId())) {

                                    statisticDaily0.setId(statisticDaily1.getId());
                                    PublicUtil.setCommonForTable(statisticDaily0,false, null);
                                    mapper.updateByPrimaryKey(statisticDaily0);
                                    it1.remove();
                                    break;
                                }

                                //无匹配记录，新增
                                if (!it1.hasNext()) {
                                    PublicUtil.setCommonForTable(statisticDaily0,true, null);
                                    mapper.insertSelective(statisticDaily0);
                                }
                            }
                        }
                    }
                }

                //删除脏数据
                if (statisticDailys1 != null && statisticDailys1.size() > 0 ){
                    Iterator it2 = statisticDailys1.iterator();
                    while (it2.hasNext()) {
                        ConsumptionStatisticDaily statisticDaily2 = (ConsumptionStatisticDaily) it2.next();
                        statisticDaily2.setDeleteFlag((short) 1);
                        PublicUtil.setCommonForTable(statisticDaily2, false, null);
                        mapper.updateByPrimaryKey(statisticDaily2);
                    }
                }

            }
        }

    }

    /**
     * 统计某天消费情况
     * @param calendar0  统计日期
     * @param userId   送检用户ID
     * @throws Exception
     */
    public List<ConsumptionStatisticDaily> dailyStatistic(Calendar calendar0, Integer userId) throws Exception {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(calendar0.getTime());

        StringBuffer sql0 = new StringBuffer();
        sql0.append("SELECT iuu.id 'userId', iuu.real_name 'userName', iuu.phone 'userPhone',  " +
                " COUNT(DISTINCT ts.id) 'qtyOrder', SUM(ts.qtyOrderDetails) 'qtyOrderDetails', SUM(ts.inspection_fee) 'feeOrder', " +
                " ? AS 'date' " +
                "FROM (SELECT tb1.id id, tb1.inspection_fee inspection_fee, tb1.sampling_userid sampling_userid, " +
                "  COUNT(1) 'qtyOrderDetails' " +
                "  FROM tb_sampling tb1 INNER JOIN tb_sampling_detail tb2 ON tb2.sampling_id = tb1.id " +
                "  WHERE " +
                "   tb1.delete_flag = 0 AND tb1.order_status = 2  " +
                "   AND tb1.pay_date BETWEEN ? AND ? ");
        if (userId != null) {
            sql0.append(" AND tb1.sampling_userid = '"+userId+"' ");
        }
        sql0.append("  GROUP BY tb1.id " +
                " ) ts " +
                " INNER JOIN inspection_unit_user iuu ON ts.sampling_userid = iuu.id " +
                "GROUP BY ts.sampling_userid ");

        String date0 = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd");
//        List<ConsumptionStatisticDaily> statistics = jdbcTemplate.queryForList(sql0.toString(),
//                new Object[]{date0, date0 + " 00:00:00", date0 + " 23:59:59"}, ConsumptionStatisticDaily.class);
        List<Map<String, Object>> statisticsMaps = jdbcTemplate.queryForList(sql0.toString(),
                new Object[]{date0, date0 + " 00:00:00", date0 + " 23:59:59"});

        List<ConsumptionStatisticDaily> statistics = new ArrayList<ConsumptionStatisticDaily>();
        for (Map statisticsMap : statisticsMaps) {
            ConsumptionStatisticDaily csd = new ConsumptionStatisticDaily();
            csd.setUserId(Integer.parseInt(statisticsMap.get("userId").toString()));
            csd.setUserName(statisticsMap.get("userName") == null ? "" : statisticsMap.get("userName").toString());
            csd.setUserPhone(statisticsMap.get("userPhone") == null ? "" : statisticsMap.get("userPhone").toString());
            csd.setQtyOrder(statisticsMap.get("qtyOrder") == null ? 0 : Integer.parseInt(statisticsMap.get("qtyOrder").toString()));
            csd.setQtyOrderDetails(statisticsMap.get("qtyOrderDetails") == null ? 0 : Integer.parseInt(statisticsMap.get("qtyOrderDetails").toString()));
            csd.setFeeOrder(statisticsMap.get("feeOrder") == null ? 0.0 : Double.parseDouble(statisticsMap.get("feeOrder").toString()));
            csd.setDate(calendar.getTime());
            statistics.add(csd);
        }

        return statistics;

    }


    /**
     * 根据日期查询消费统计
     * @param date 格式:yyyy-MM-dd
     * @param userId   送检用户ID
     * @return
     */
    public List<ConsumptionStatisticDaily> selectByDate(String date, Integer userId){
        return mapper.selectByDate(date, userId);
    }

    /**
     * 根据日期段查询消费统计
     * @param start 开始时间
     * @param end   结束时间
     * @param userId   送检用户ID
     * @return
     */
    public List<ConsumptionStatisticDaily> selectByDate2(String start, String end, Integer userId){
        return mapper.selectByDate2(start, end, userId);
    }


}
