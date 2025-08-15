package com.dayuan.mapper.ledger;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.ledger.BaseLedgerStockModel;

public interface BaseLedgerStockMapper  extends BaseMapper<BaseLedgerStock, Integer>{
    
    List<BaseLedgerStockModel>	loadRegReport(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId);

    List<BaseLedgerStockModel>	loadRegReport(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId,@Param("type")String type,@Param("month")String month,@Param("season")String season,@Param("year")String year,@Param("start")String start,@Param("end")String end);
    /**
     * 查询 针对市场录入台账情况
     * @param departCode
     * @param regTypeId
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @return
     */
    List<BaseLedgerStockModel>	loadRegReport2(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId,@Param("type")String type,@Param("month")String month,@Param("season")String season,@Param("year")String year,@Param("start")String start,@Param("end")String end);
	
    /**
	 * 根据经营户id、foodName 批号查询批号是否存在	
	 * @param bean
	 * @return
	 */
    BaseLedgerStock selectByBatchNumber(BaseLedgerStock bean);
    
    /**
     * 通过经营户、样品、进货日期获取进货台账
     * @param regId	监管对象ID
     * @param businessId	经营户ID
     * @param foodName	样品名称
     * @param batchNumber	批次
     * @param stockDate	进货日期
     * @return
     */
    BaseLedgerStock queryByBatchNumber(@Param("regId")Integer regId, @Param("businessId")Integer businessId, @Param("foodName")String foodName, @Param("batchNumber")String batchNumber, @Param("stockDate")String stockDate);

    /**
	 * 根据经营户ID查询 录入了进货台账的档口数量
	 * @param businessIds 经营户IDs
	 * @param start 开始日期
	 * @param end 结束日期
	 * @return 录入了进货台账的档口数量
	 * @author LuoYX
	 * @date 2018年6月27日
	 */
	Integer getEnterStockCount(@Param("businessIds")List<Integer> businessIds,@Param("start")String start,@Param("end")String end);

	/**
	 * 端州微信-进货统计
	 * @param regIds 市场IDs
	 * @param start 开始时间
	 * @param end 结束时间
	 * @return 每个市场的档口数量、已录入台账数量
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	List<Map<String, Object>> queryStockByRegIds(@Param("regIds")List<Integer> regIds, @Param("start")String start,@Param("end")String end);

	/**
	 * 端州微信-进货台账详情
	 * @param regId
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	List<Map<String, Object>> queryByRegId(@Param("regId")Integer regId,@Param("start") String start,@Param("end") String end);

	/**
	 * 通过检测数据ID查询台账
	 * @param rid 检测数据ID
	 * @return
	 */
    BaseLedgerStock queryByRid(@Param("rid")Integer rid);
}