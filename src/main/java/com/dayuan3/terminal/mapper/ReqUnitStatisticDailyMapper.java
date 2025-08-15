package com.dayuan3.terminal.mapper;

import com.dayuan.bean.Page;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.BaseModel;
import com.dayuan3.terminal.bean.ReqUnitStatisticDaily;
import com.dayuan3.terminal.model.ReqStatisModel;
import com.dayuan3.terminal.model.RequesterUnitModel;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReqUnitStatisticDailyMapper extends BaseMapper<ReqUnitStatisticDaily, Integer> {

    ReqUnitStatisticDaily selectByDate(@Param("date") String date, @Param("unitId") Integer unitId);

    List<ReqUnitStatisticDaily> selectByDate2(@Param("start") String start, @Param("end") String end, @Param("unitId") Integer unitId);

    /**
     * 委托单位统计-查询分页数据
     * @param page
     * @return
     */
    List<ReqUnitStatisticDaily> loadDatagrid1(Page page);
    /**
     * 委托单位统计-历史数据（微信端）
     * @param page
     * @return
     */
    List<ReqUnitStatisticDaily> loadDatagrid2(Page page);

    /**
     * 委托单位统计-查询记录总数量
     * @param page
     * @return
     */
    int getRowTotal1(Page page);
    /**
     * 委托单位统计-历史数据（微信端）
     * @param page
     * @return
     */
    int getRowTotal2(Page page);

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
    List<ReqUnitStatisticDaily> selectByDate3(@Param("start") String start, @Param("end") String end, @Param("departCode") String departCode, @Param("array") String[] unitTypeArr);

    /**
     * 查询出当天的所有委托单位送检数据
     *
     * @param did   机构ID
     * @param today 当天时间
     * @return
     * @author shit
     */
    List<ReqStatisModel> selectDataToday(@Param("did") Integer did, @Param("today") String today, @Param("checkNumber") Integer checkNumber, @Param("obj") BaseModel model);

    /**
     * 查询历史所有委托单位的数据，包含合格与不合格，以及送检数量
     *
     * @param did   机构ID
     * @param start 开始时间
     * @param end   结束时间
     * @return
     * @author shit
     */
    List<ReqStatisModel> selectDataHistory(@Param("did") Integer did, @Param("start") String start, @Param("end") String end, @Param("obj") BaseModel model);
    
    /**
     * 委托单位统计-根据委托单位覆盖周期查询当天数据（微信端）   实时查询
     * @description
     * @param page
     * @return
     * @author xiaoyl
     * @date   2020年6月29日
     */
    List<ReqUnitStatisticDaily> loadDatagridToday(Page page);

    /**
     * 委托单位统计-根据委托单位覆盖周期进行查询-查询记录总数量
     * @param page
     * @return
     */
    int getRowTotalToday(Page page);
    
    /**
     * 委托单位统计-根据委托单位覆盖周期查询当天数据（微信端）   实时查询
     * @description
     * @param page
     * @return
     * @author xiaoyl
     * @date   2020年6月29日
     */
    List<ReqUnitStatisticDaily> loadDatagridHistory(Page page);

    /**
     * 委托单位统计-根据委托单位覆盖周期进行查询-查询记录总数量
     * @param page
     * @return
     */
    int getRowTotalHistory(Page page);

	List<ReqUnitStatisticDaily> queryHistoryByDate(RequesterUnitModel model);
}