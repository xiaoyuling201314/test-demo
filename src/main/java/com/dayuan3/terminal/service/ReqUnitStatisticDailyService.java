package com.dayuan3.terminal.service;

import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.data.TSDepartMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.ReqUnitStatisticDaily;
import com.dayuan3.terminal.bean.ReqUnitStatisticMonthly;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.mapper.ReqUnitStatisticDailyMapper;
import com.dayuan3.terminal.mapper.RequesterUnitTypeMapper;
import com.dayuan3.terminal.model.ReqStatisModel;
import com.dayuan3.terminal.model.RequesterUnitModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.*;


@Service
public class ReqUnitStatisticDailyService extends BaseService<ReqUnitStatisticDaily, Integer> {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private RequesterUnitService requesterUnitService;
    @Autowired
    private ReqUnitStatisticMonthlyService reqUnitStatisticMonthlyService;

    @Autowired
    private ReqUnitStatisticDailyMapper mapper;
    
    @Autowired
    private RequesterUnitTypeMapper unitTypeMapper;
    
    @Autowired
    private ReqUnitStatisticDailyMapper statisticDailyMapper;

    
    @Autowired
    private TSDepartMapper departMapper;

    public ReqUnitStatisticDailyMapper getMapper() {
        return mapper;
    }

    /**
     * 委托单位日统计
     *
     * @param calendar0 统计日期
     * @param insUnitId 委托单位ID NULL：统计全部单位
     * @throws Exception
     */
    public void dailyStatistic(Calendar calendar0, Integer insUnitId) throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(calendar0.getTime());

        String yyyyMMdd = DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd");    //统计日期

        Map<String, Map> map = new HashMap<String, Map>();

        /**************************** 统计当天送检数据 ******************************/
        //当天送检数据
        StringBuffer sql1 = new StringBuffer();
        sql1.append("SELECT tsd.food_name, tsd.item_name, dcr.conclusion, dcr.delete_flag dcr_delete_flag, " +
                " tsr.request_id reg_id, tsr.request_name reg_name, COUNT(1) number " +
                " FROM tb_sampling_detail tsd  " +
                " INNER JOIN tb_sampling ts ON tsd.sampling_id = ts.id " +
                " INNER JOIN tb_sampling_requester tsr ON tsr.sampling_id = ts.id " +
                " LEFT JOIN data_check_recording dcr ON dcr.sampling_detail_id = tsd.id " +
                "WHERE 1=1 " +
//                " AND dcr.delete_flag = 0 " +
                " AND tsd.sample_tube_time >= ? AND tsd.sample_tube_time <= ? " +
                " AND ts.delete_flag = 0 AND ts.personal = 2 AND ts.order_status = 2 ");
        if (insUnitId != null) {
            sql1.append(" AND tsr.request_id = " + insUnitId + " ");
        }
        sql1.append(" GROUP BY tsr.request_id, dcr.food_id, dcr.item_id, dcr.conclusion ");

        List list1 = jdbcTemplate.queryForList(sql1.toString(), new Object[]{yyyyMMdd + " 00:00:00", yyyyMMdd + " 23:59:59"});
        Iterator it1 = list1.iterator();
        while (it1.hasNext()) {
            Map<String, Object> map1 = (Map<String, Object>) it1.next();

            int check_number = 0;   //送检数量
            int unqualified_number = 0;   //不合格数量

            Map<String, Object> map1_1 = (Map<String, Object>) map.get(map1.get("reg_id").toString());
            Map<String, Object> map1_2 = null;
            if (map1_1 == null) {
                map1_1 = new HashMap<String, Object>();
                map1_1.put("reg_name", map1.get("reg_name").toString());  //委托单位名称
                map1_2 = new HashMap<String, Object>(); //不合格 样品种类-检测项目
                map1_1.put("unqualified_food_item", map1_2);

            } else {
                check_number = StringUtil.isNotEmpty(map1_1.get("check_number")) ? Integer.parseInt(map1_1.get("check_number").toString()) : 0;
                unqualified_number = StringUtil.isNotEmpty(map1_1.get("unqualified_number")) ? Integer.parseInt(map1_1.get("unqualified_number").toString()) : 0;
                map1_2 = (Map<String, Object>) map1.get("unqualified_food_item");
                if (map1_2 == null) {
                    map1_2 = new HashMap<String, Object>(); //不合格 样品种类-检测项目
                }
            }

            int number = StringUtil.isNotEmpty(map1.get("number")) ? Integer.parseInt(map1.get("number").toString()) : 0;

            check_number += number;
            if (map1.get("dcr_delete_flag") != null && 0 == Integer.parseInt(map1.get("dcr_delete_flag").toString())
                    && map1.get("conclusion") != null && "不合格".equals(map1.get("conclusion").toString())) {
                unqualified_number += number;
                String fn = map1.get("food_name") == null ? "" : map1.get("food_name").toString();
                String in = map1.get("item_name") == null ? "" : map1.get("item_name").toString();
                map1_2.put(fn + "-" + in, number);

                map1_1.put("unqualified_food_item", map1_2);
            }
            map1_1.put("check_number", check_number);
            map1_1.put("unqualified_number", unqualified_number);

            map.put(map1.get("reg_id").toString(), map1_1);
        }

        Iterator<Map.Entry<String, Map>> it2 = map.entrySet().iterator();
        while (it2.hasNext()) {
            Map.Entry<String, Map> me2 = it2.next();

            ReqUnitStatisticDaily reqUnitStatisticDaily = new ReqUnitStatisticDaily();
            reqUnitStatisticDaily.setDate(calendar.getTime());
            reqUnitStatisticDaily.setInsUintId(Integer.parseInt(me2.getKey()));
            reqUnitStatisticDaily.setInsUintName(me2.getValue().get("reg_name").toString());
            reqUnitStatisticDaily.setCheckNumber(Integer.parseInt(me2.getValue().get("check_number").toString()));
            reqUnitStatisticDaily.setUnqualifiedNumber(Integer.parseInt(me2.getValue().get("unqualified_number").toString()));

            StringBuffer unqualified_food_item_str = new StringBuffer();
            Map<String, Object> map2_2 = (Map<String, Object>) me2.getValue().get("unqualified_food_item");
            Iterator<Map.Entry<String, Object>> it3 = map2_2.entrySet().iterator();
            while (it3.hasNext()) {
                Map.Entry<String, Object> me3 = it3.next();
                unqualified_food_item_str.append(me3.getKey() + "-" + me3.getValue() + ",");
            }
            if (unqualified_food_item_str.length() > 0) {
                unqualified_food_item_str.deleteCharAt(unqualified_food_item_str.length() - 1);
            }
            reqUnitStatisticDaily.setUnqualifiedStatistic(unqualified_food_item_str.toString());

            //新增或更新委托单位统计
            ReqUnitStatisticDaily reqUnitStatisticDaily0 = this.selectByDate(yyyyMMdd, reqUnitStatisticDaily.getInsUintId());
            if (reqUnitStatisticDaily0 != null) {
                reqUnitStatisticDaily.setId(reqUnitStatisticDaily0.getId());
                PublicUtil.setCommonForTable(reqUnitStatisticDaily, false, null);
                this.updateBySelective(reqUnitStatisticDaily);

            } else {
                //获取委托单位日检测量
                RequesterUnit reqUnit = requesterUnitService.queryById(reqUnitStatisticDaily.getInsUintId());
                if (reqUnit == null || reqUnit.getCheckNum() == null || reqUnit.getCheckNum() < 0) {
                    reqUnitStatisticDaily.setCheckNumberDaily(0);
                } else {
                    reqUnitStatisticDaily.setCheckNumberDaily(reqUnit.getCheckNum());
                }
                PublicUtil.setCommonForTable(reqUnitStatisticDaily, true, null);
                this.insert(reqUnitStatisticDaily);
            }
        }

        /**************************** 统计送检后隔天完成检测的数据 ******************************/
        //送检后隔天完成检测的数据
        StringBuffer sql3 = new StringBuffer();
        sql3.append("SELECT tsd.food_name, tsd.item_name, tsd.sample_tube_time, " +
                " tsr.request_id reg_id, tsr.request_name reg_name " +
                "FROM data_check_recording dcr  " +
                " INNER JOIN tb_sampling_detail tsd ON dcr.sampling_detail_id = tsd.id " +
                " INNER JOIN tb_sampling ts ON tsd.sampling_id = ts.id " +
                " INNER JOIN tb_sampling_requester tsr ON tsr.sampling_id = ts.id " +
                "WHERE dcr.conclusion = '不合格' AND dcr.delete_flag = 0  " +
                " AND dcr.check_date >= ? AND dcr.check_date <= ? " +
                " AND tsd.sample_tube_time < ? " +
                " AND ts.delete_flag = 0 ");
        if (insUnitId != null) {
            sql3.append(" AND tsr.request_id = " + insUnitId + " ");
        }
        List<Map<String, Object>> list3 = jdbcTemplate.queryForList(sql3.toString(), new Object[]{DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 00:00:00"),
                DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 23:59:59"), DateUtil.formatDate(calendar.getTime(), "yyyy-MM-dd 00:00:00")});
        Iterator<Map<String, Object>> it3 = list3.iterator();
        while (it3.hasNext()) {
            Map<String, Object> map3 = it3.next();
            Calendar c4 = Calendar.getInstance();
            c4.setTime(DateUtil.parseDate(map3.get("sample_tube_time").toString(), "yyyy-MM-dd HH:mm:ss"));

            //更新日统计数据
            int reg_id = Integer.parseInt(map3.get("reg_id").toString());
            ReqUnitStatisticDaily rusd = this.selectByDate(DateUtil.formatDate(c4.getTime(), "yyyy-MM-dd"), reg_id);
            if (rusd != null) {
                int unqualifiedNumber = rusd.getUnqualifiedNumber() == null ? 0 : rusd.getUnqualifiedNumber();
                rusd.setUnqualifiedNumber(unqualifiedNumber++);

                StringBuffer us0 = new StringBuffer();
                String us1 = rusd.getUnqualifiedStatistic();
                if (StringUtil.isNotEmpty(us1)) {
                    String[] us = us1.split(",");
                    for (String food_item_unqualified : us) {
                        if (StringUtil.isNotEmpty(food_item_unqualified)) {
                            String[] fiu = food_item_unqualified.split("-");
                            if (fiu[0].equals(map3.get("food_name").toString())
                                    && fiu[1].equals(map3.get("item_name").toString())) {
                                int unqualified = Integer.parseInt(fiu[2]) + 1;
                                us0.append(fiu[0] + "-" + fiu[1] + "-" + unqualified + ",");
                            } else {
                                us0.append(food_item_unqualified + ",");
                            }
                        }
                    }
                }
                if (us0.length() > 0) {
                    us0.deleteCharAt(us0.length() - 1);
                }
                rusd.setUnqualifiedStatistic(us0.toString());
                PublicUtil.setCommonForTable(rusd, false, null);
                this.updateBySelective(rusd);
            }

            //更新月统计数据
            ReqUnitStatisticMonthly rusm = reqUnitStatisticMonthlyService.selectByDate(DateUtil.formatDate(c4.getTime(), "yyyy-MM-01"), reg_id);
            if (rusm != null) {
                int unqualifiedNumber = rusm.getUnqualifiedNumber() == null ? 0 : rusm.getUnqualifiedNumber();
                rusm.setUnqualifiedNumber(unqualifiedNumber++);

                StringBuffer us0 = new StringBuffer();
                String us1 = rusm.getUnqualifiedStatistic();
                if (StringUtil.isNotEmpty(us1)) {
                    String[] us = us1.split(",");
                    for (String food_item_unqualified : us) {
                        if (StringUtil.isNotEmpty(food_item_unqualified)) {
                            String[] fiu = food_item_unqualified.split("-");
                            if (fiu[0].equals(map3.get("food_name").toString())
                                    && fiu[1].equals(map3.get("item_name").toString())) {
                                int unqualified = Integer.parseInt(fiu[2]) + 1;
                                us0.append(fiu[0] + "-" + fiu[1] + "-" + unqualified + ",");
                            } else {
                                us0.append(food_item_unqualified + ",");
                            }
                        }
                    }
                }
                if (us0.length() > 0) {
                    us0.deleteCharAt(us0.length() - 1);
                }
                rusm.setUnqualifiedStatistic(us0.toString());
                PublicUtil.setCommonForTable(rusm, false, null);
                reqUnitStatisticMonthlyService.updateBySelective(rusm);
            }
        }

        /**************************** 统计未送检委托单位 ******************************/

        //未送检委托单位
        StringBuffer sql4 = new StringBuffer();
        sql4.append("SELECT ru.id, ru.requester_name, IF(ru.check_num IS NULL, 0, ru.check_num) check_num " +
                "FROM requester_unit ru  " +
                "WHERE ru.delete_flag = 0 AND ru.create_date <= ?  " +
                " AND ru.id NOT IN ( " +
                "  SELECT ins_uint_id " +
                "  FROM req_unit_statistic_daily   " +
                "  WHERE date = ? " +
                " ) ");

        List list4 = jdbcTemplate.queryForList(sql4.toString(), new Object[]{yyyyMMdd + " 23:59:59", yyyyMMdd});
        Iterator it4 = list4.iterator();
        while (it4.hasNext()) {
            Map map4 = (Map) it4.next();
            ReqUnitStatisticDaily reqUnitStatisticDaily = new ReqUnitStatisticDaily(calendar.getTime(), Integer.parseInt(map4.get("id").toString()),
                    map4.get("requester_name").toString(), 0, 0, null,
                    null, null, null, Integer.parseInt(map4.get("check_num").toString()));

            PublicUtil.setCommonForTable(reqUnitStatisticDaily, true, null);
            this.insert(reqUnitStatisticDaily);
        }

    }

    /**
     * 根据日期查询委托单位统计
     *
     * @param date   格式:yyyy-MM-dd
     * @param unitId 委托单位ID
     * @return
     */
    public ReqUnitStatisticDaily selectByDate(String date, Integer unitId) {
        return mapper.selectByDate(date, unitId);
    }

    /**
     * 根据日期段查询委托单位统计
     *
     * @param start  格式:yyyy-MM-dd
     * @param end    格式:yyyy-MM-dd
     * @param unitId 委托单位ID
     * @return
     */
    public List<ReqUnitStatisticDaily> selectByDate2(String start, String end, Integer unitId) {
        return mapper.selectByDate2(start, end, unitId);
    }

    /**
     * 微信端：委托单位所有统计数据
     *
     * @param model
     * @param page
     * @return
     * @author shit
     */
    public Map<String, List<ReqUnitStatisticDaily>> datagridAll(RequesterUnitModel model, Page page) throws Exception {
        Map<String, List<ReqUnitStatisticDaily>> dataMap = new HashMap<>();
        if (null != model.getKeyWords()) {
            if (DateUtil.formatDate(new Date(), "yyyy-MM-dd").equals(model.getKeyWords())) {
                //实时统计
                page = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid1", "getRowTotal1");

            } else {
                //历史统计
                page = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid2", "getRowTotal2");
            }
            String[] unitTypeArr = model.getUnitTypeArr();

            List<ReqUnitStatisticDaily> list = (List<ReqUnitStatisticDaily>) page.getResults();
            //把数据进行分类处理后放入map中
            dataMap.put("dataAll", list);
            setParam(list, dataMap, unitTypeArr);
        }
        return dataMap;
    }

    private void setParam(List<ReqUnitStatisticDaily> list, Map<String, List<ReqUnitStatisticDaily>> dataMap, String[] unitTypeArr) {
        if (list != null && unitTypeArr != null) {
            for (String unitType : unitTypeArr) {
                List<ReqUnitStatisticDaily> rudList = new ArrayList<>();
                for (ReqUnitStatisticDaily rusd : list) {
                    setRusdParam(rusd);
                    if (unitType.equals(rusd.getUnitType().toString())) {
                        rudList.add(rusd);
                    }
                }
                dataMap.put("data" + unitType, rudList);
            }
        }
    }


    /**
     * 委托单位统计数据
     *
     * @param model
     * @param page
     * @return
     * @author shit (把controller中的代码抽取到service中)
     */
    public Page datagrid(RequesterUnitModel model, Page page) throws Exception {
        if (null != model.getKeyWords()) {
            if (DateUtil.formatDate(new Date(), "yyyy-MM-dd").equals(model.getKeyWords())) {
                //实时统计
                page = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid1", "getRowTotal1");

            } else {
                //历史统计
                page = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagrid2", "getRowTotal2");
            }
            List<ReqUnitStatisticDaily> list = (List<ReqUnitStatisticDaily>) page.getResults();
            if (list != null) {
                for (ReqUnitStatisticDaily rusd : list) {
                    setRusdParam(rusd);
                }
            }
        }
        return page;
    }

    /**
     * 设置参数 应送检数、实送检数、完成率
     *
     * @param rusd
     */
    private void setRusdParam(ReqUnitStatisticDaily rusd) {
        if (rusd.getCheckNumberDaily() == null) {//应送检数
            rusd.setCheckNumberDaily(0);
        }
        if (rusd.getCheckNumber() == null) {//实送检数
            rusd.setCheckNumber(0);
        }
        if (rusd.getUnqualifiedNumber() == null) {
            rusd.setUnqualifiedNumber(0);
        }
        //计算完成率
        if (rusd.getCheckNumberDaily() == 0 && rusd.getCheckNumber() == 0) {
            rusd.setCheckRate(0.00);
        } else {
            Integer checkNumberDaily = rusd.getCheckNumberDaily() == 0 ? 1 : rusd.getCheckNumberDaily();
            rusd.setCheckRate(new BigDecimal("" + ((rusd.getCheckNumber() * 1.00) / (checkNumberDaily * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
        }

        //计算合格率
        if (rusd.getCheckNumber() == 0 && rusd.getUnqualifiedNumber() == 0) {
            rusd.setPassRate(null);
        } else {
            Integer passNum = rusd.getUnqualifiedNumber() == 0 ? rusd.getCheckNumber() : rusd.getCheckNumber() - rusd.getUnqualifiedNumber();
            rusd.setPassRate(new BigDecimal("" + ((passNum * 1.00) / (rusd.getCheckNumber() * 1.00) * 100)).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
        }
    }

    /**
     * 根据日期段查询委托单位统计(微信端)
     *
     * @param start       格式:yyyy-MM-dd
     * @param end         格式:yyyy-MM-dd
     * @param departCode  机构ID
     * @param unitTypeArr 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他   shit添加
     * @return
     * @author shit
     */
    public List<ReqUnitStatisticDaily> selectByDate3(String start, String end, String departCode, String[] unitTypeArr) {
        return mapper.selectByDate3(start, end, departCode, unitTypeArr);
    }

    /**
     * 数据统计-委托单位：获委托单位送检和应送检数据
     *
     * @param did         机构ID
     * @param start       开始时间 格式：yyyy-MM-dd
     * @param end         结束时间 格式：yyyy-MM-dd
     * @param today       今天时间 格式：yyyy-MM-dd
     * @param unitTypeArr 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他
     * @return
     * @author shit
     */
    public Map<String, Object> selectData(Integer did, String start, String end, String today, String[] unitTypeArr,BaseModel model) throws Exception {
        List<ReqStatisModel> rsmHistoryList = new ArrayList<>();
        Map<String, Object> dataMap = new HashMap<>();
        Integer req_units_max_num;  //委托单位数量
        Integer req_units_check_num = 0;  //委托单位已送检数量
        Integer req_units_uncheck_num;  //委托单位未送检数量
        Integer plan_check_num = 0;  //计划送检数量
        Integer check_num = 0;  //实际送检数量
        Integer uncheck_num;  //未送检数量
        //委托单位统计-数据获取+处理
        rsmHistoryList = getReqList(rsmHistoryList, did, start, end, today,model);
        //4.迭代最后得到的list集合并求得我们需要的值
        if (rsmHistoryList.size() > 0) {
            for (ReqStatisModel rsm : rsmHistoryList) {
                Integer checkNum = rsm.getCheckNum();//已检测量
                plan_check_num += rsm.getPlanCheckNum();//计划送检数量;
                check_num += checkNum;//实际送检数量;
                if (checkNum > 0) {
                    req_units_check_num++;//委托单位已送检数量
                }
            }
            Collections.sort(rsmHistoryList);//按照检测数量排序，谁大就排前面
            setParam2(rsmHistoryList, dataMap, unitTypeArr);
        }
        req_units_max_num = rsmHistoryList.size();//委托单位数量
        req_units_uncheck_num = req_units_max_num - req_units_check_num > 0 ? req_units_max_num - req_units_check_num : 0;//委托单位未送检数量
        uncheck_num = plan_check_num - check_num > 0 ? plan_check_num - check_num : 0;//未送检数量
        //TODO 对于列表数据，看来还需要重新写方法进行查询了,或者问问有没有别的方式，比如直接取界面的json，而不一定要发请求,如此我就不需要再写loadDatagrid2方法了
        dataMap.put("req_units_max_num", req_units_max_num);
        dataMap.put("req_units_check_num", req_units_check_num);
        dataMap.put("req_units_uncheck_num", req_units_uncheck_num);
        dataMap.put("plan_check_num", plan_check_num);
        dataMap.put("check_num", check_num);
        dataMap.put("uncheck_num", uncheck_num);
        return dataMap;
    }


    /**
     * 设置参数 dataMap中放入 data1 、data2、data3...
     *
     * @param list        委托单位数据总集合
     * @param dataMap     存储数据的map对象
     * @param unitTypeArr 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他   shit添加
     */
    private void setParam2(List<ReqStatisModel> list, Map<String, Object> dataMap, String[] unitTypeArr) {
        if (unitTypeArr != null && unitTypeArr.length > 0) {
            for (String unitType : unitTypeArr) {
                List<ReqStatisModel> rudList = new ArrayList<>();
                for (ReqStatisModel rusd : list) {
                    if (unitType.equals(rusd.getUnitType().toString())) {
                        rudList.add(rusd);
                    }
                }
                dataMap.put("data" + unitType, rudList);
            }
        }
    }


    /**
     * 查询出当天的所有委托单位送检数据
     *
     * @param did   机构ID
     * @param today 当天时间
     * @return
     * @author shit
     */
    public List<ReqStatisModel> selectDataToday(Integer did, String today,BaseModel model) {
        int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
        return mapper.selectDataToday(did, today, recheckNumber, model);
    }

    /**
     * 查询历史所有委托单位的数据，包含合格与不合格，以及送检数量
     *
     * @param did   机构ID
     * @param start 开始时间
     * @param end   结束时间
     * @return
     * @author shit
     */
    private List<ReqStatisModel> selectDataHistory(Integer did, String start, String end,BaseModel model) {
        return mapper.selectDataHistory(did, start, end,model);
    }


    private static int firstPageSize = 0;

    /**
     * 委托单位统计-获取数据
     *
     * @param start    开始时间
     * @param end      结束时间
     * @param did      机构ID
     * @param unitType 监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他
     * @return
     */
    public Page loadDatagrid2(Page page, BaseModel model, Integer did, String start, String end, String today, Integer unitType) throws Exception {
        List<ReqStatisModel> rsmHistoryList = new ArrayList<>();
        List<ReqStatisModel> dataList = new ArrayList<>();
        Calendar c1 = Calendar.getInstance();//今天
        c1.setTime(DateUtil.parseDate(today, "yyyy-MM-dd"));
        //委托单位统计-数据获取+处理
        rsmHistoryList = getReqList(rsmHistoryList, did, start, end, today,model);
        //4.迭代最后得到的list集合并求得我们需要的值
        if (rsmHistoryList.size() > 0) {
            if (unitType != 0) {
                for (ReqStatisModel rsm : rsmHistoryList) {
                    if (unitType.equals(rsm.getUnitType())) {
                        dataList.add(rsm);
                    }
                }
            } else {
                dataList = rsmHistoryList;
            }
            Collections.sort(dataList);//按照检测数量排序，谁大就排前面
        }
        //下面进行分页
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(model);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(dataList.size());
        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        List<ReqStatisModel> list2 = new ArrayList<>();
        int pageSize = page.getPageSize();//每页条数
        int totalNumber = dataList.size();
        int max = 0;
        int min = 0;
        if (firstPageSize != pageSize) {//上一次每页条数不等于这次每页条数
            page.setPageNo(1);
        }
        int pageNo = page.getPageNo();//第几页
        if (pageSize > dataList.size()) {
            max = totalNumber;
        } else {
            int maxPage = pageSize * pageNo;
            max = totalNumber > maxPage ? maxPage : totalNumber;
            min = (pageNo - 1) * pageSize;
        }
        firstPageSize = pageSize;
        for (int i = min; i < max; i++) {
            list2.add(dataList.get(i));
        }
        page.setResults(list2);
        return page;
    }


    /**
     * 委托单位统计-数据获取+处理
     *
     * @param start 开始时间
     * @param end   结束时间
     * @param did   机构ID
     * @return
     */
    private List<ReqStatisModel> getReqList(List<ReqStatisModel> rsmHistoryList, Integer did, String start, String end, String today,BaseModel model) throws Exception {
        Calendar c1 = Calendar.getInstance();//今天
        Calendar c2 = Calendar.getInstance();//结束时间
        Calendar c3 = Calendar.getInstance();//开始时间
        c1.setTime(DateUtil.parseDate(today, "yyyy-MM-dd"));
        if(StringUtil.isNotEmpty(start)){
            c3.setTime(DateUtil.parseDate(start, "yyyy-MM-dd"));
        }
        //判断当前时间大于或等于开始时间
        if (StringUtil.isEmpty(start)||c1.getTime().compareTo(c3.getTime()) >= 0) {
            //判断当天时间是否小于等于结束时间，如果是，那么数据最多截止到当天
            if (c1.getTime().compareTo(c2.getTime()) <= 0) {
                //1.查询当天所有委托单位的数据，包含合格与不合格，以及送检数量
                List<ReqStatisModel> rsmList = this.selectDataToday(did, today,model);//当天委托单位和应送检数量
                //2.查询历史所有委托单位的数据，包含合格与不合格，以及送检数量
                rsmHistoryList = this.selectDataHistory(did, start, today + " 23:59:59", model);
                //3.把当天rsmList的数据放入历史rsmHistoryList中
                if (rsmList.size() > 0) {
                    for (ReqStatisModel rsmHistory : rsmHistoryList) {
                        for (Iterator<ReqStatisModel> iterToday = rsmList.iterator(); iterToday.hasNext(); ) {
                            ReqStatisModel rsmToday = iterToday.next();
                            if (rsmHistory.getId().equals(rsmToday.getId())) {
                                rsmHistory.setCheckNum(rsmHistory.getCheckNum() + rsmToday.getCheckNum2());
                                rsmHistory.setPlanCheckNum(rsmHistory.getPlanCheckNum() + rsmToday.getPlanCheckNum());
                                rsmHistory.setUnqualifiedNum(rsmHistory.getUnqualifiedNum() + rsmToday.getUnqualifiedNum2());
                                iterToday.remove();
                            }
                        }
                    }
                    if (rsmList.size() > 0) {
                        for (ReqStatisModel rsm : rsmList) {
                            rsm.setCheckNum(rsm.getCheckNum2());
                            rsm.setUnqualifiedNum(rsm.getUnqualifiedNum2());
                            rsmHistoryList.add(rsm);
                        }
                    }
                }
            } else {
                //1.查询出历史的就是所有的
                //查询历史所有委托单位的数据，包含合格与不合格，以及送检数量
                rsmHistoryList = this.selectDataHistory(did, start + " 00:00:00", end,model);
            }
        }
        return rsmHistoryList;
    }
   /**
    * 微信端：根据委托单位的覆盖类型统计数据 
    * @description
    * @param model
    * @param page
    * @return
    * @throws Exception
    * @author xiaoyl
    * @date   2020年6月29日
    */
    @SuppressWarnings("unchecked")
	public Map<String, List<ReqUnitStatisticDaily>> datagridAllCover(RequesterUnitModel model, Page page) throws Exception {
        Map<String, List<ReqUnitStatisticDaily>> dataMap = new HashMap<>();
        List<ReqUnitStatisticDaily> listAll=new ArrayList<ReqUnitStatisticDaily>();
        List<RequesterUnitType> rutList=unitTypeMapper.selectByIds(model.getUnitTypeArr());//根据ID查询监控类型
        List<Integer> childDeparts= departMapper.querySonDeparts(model.getDepartId());
        model.setDepartArr(childDeparts.toArray(new Integer[0]));
        Page todayPage=null;
        if(rutList!=null && rutList.size()>0) {//根据监控类型和覆盖类型进行查询数据
        	for (RequesterUnitType requesterUnitType : rutList) {
        		List<ReqUnitStatisticDaily> list=null;//当天数据统计
        		List<ReqUnitStatisticDaily> listHistory = null;//历史数据统计
        		//计算查询周期
        		String dateStr=DateUtil.date_sdf.format(new Date());
        		LocalDate date = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        		LocalDate first =null;
        		model.setCoverageType(requesterUnitType.getCoverageType());
        		model.setUnitType(requesterUnitType.getId());
        		//覆盖率=实时统计+历史统计
        		//查询当天的数据
        		model.setStartDateStr(dateStr);
        		model.setEndDateStr(dateStr);
        		todayPage = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagridToday", "getRowTotalToday");
        		list = (List<ReqUnitStatisticDaily>) todayPage.getResults();
        		if(requesterUnitType.getCoverageType()==0) {//日覆盖
        			listAll.addAll(list);
        		}else { 
	        		if(requesterUnitType.getCoverageType()==1) {//周覆盖
	        			first = date.with(TemporalAdjusters.previous(DayOfWeek.SUNDAY)).plusDays(1);
	        			model.setStartDateStr(first.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
	        		}else if(requesterUnitType.getCoverageType()==2) {//月覆盖： 获取当月第一天与最后天
	        			first = date.with(TemporalAdjusters.firstDayOfMonth());
	        			model.setStartDateStr(first.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
	        		}
	        		//周覆盖、月覆盖查询日期为非周一、当月1号时前往历史表查询，否则的话只获取当天的数据就行了
	        		if(!model.getStartDateStr().equals(model.getEndDateStr())) {
	        			//查询历史送检数据
	        			page = this.loadDatagrid(page, model, ReqUnitStatisticDailyMapper.class, "loadDatagridHistory", "getRowTotalHistory");
	        			listHistory = (List<ReqUnitStatisticDaily>) page.getResults();
	        		}
	        		//计算覆盖周期内的送检数量=实时统计+历史统计
	        		if(listHistory!=null) {
		        		Iterator<ReqUnitStatisticDaily> iterator=null;
		        		for (ReqUnitStatisticDaily bean : listHistory) {//查询历史送检数据
		        			iterator=list.iterator();
		        			while (iterator.hasNext()) {
		        				ReqUnitStatisticDaily d=iterator.next();
		        				if(bean.getInsUintId().equals(d.getInsUintId())) {//送检单位ID相同，合并检测数据并从实时列表里移除
		        					if (StringUtil.isNotEmpty(d.getCheckNumber())) {
		        						bean.setCheckNumber(bean.getCheckNumber()+d.getCheckNumber());
		        					}
		        					iterator.remove();
		        				}
								
							}
						}
	        		}
	        		if(listHistory!=null && listHistory.size()>0) listAll.addAll(listHistory);
	        		if(list!=null && list.size()>0) listAll.addAll(list);
        		}
			}
        	//把数据进行分类处理后放入map中
        	dataMap.put("dataAll", listAll);
        	setParam(listAll, dataMap, model.getUnitTypeArr());
        }
        return dataMap;
    }
    /**
     * 查询委托单位历史数据
     * @description
     * @param model
     * @return
     * @author xiaoyl
     * @date   2020年7月3日
     */
	public List<ReqUnitStatisticDaily> queryHistoryByDate(RequesterUnitModel model) {
		return mapper.queryHistoryByDate(model);
	}

}
