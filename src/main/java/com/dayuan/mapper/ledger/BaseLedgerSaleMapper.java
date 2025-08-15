package com.dayuan.mapper.ledger;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.ledger.BaseLedgerSale;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.ledger.BaseLedgerSaleModel;

public interface BaseLedgerSaleMapper  extends BaseMapper<BaseLedgerSale, Integer>{
    /**
	 * 端州微信-销售台账统计
	 * @param regIds 市场IDs
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	List<Map<String, Object>> queryStockByRegIds(@Param("regIds")List<Integer> regIds,@Param("start") String start, @Param("end")String end);
	/**
	 * 查询市场销售台账详情
	 * @param regId
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月29日
	 */
	List<Map<String, Object>> queryByRegId(@Param("regId")Integer regId,@Param("start") String start,@Param("end") String end);
	
    List<BaseLedgerSaleModel>	loadRegReport(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId);

    List<BaseLedgerSaleModel>	loadRegReport(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId,@Param("type")String type,@Param("month")String month,@Param("season")String season,@Param("year")String year,@Param("start")String start,@Param("end")String end);
    List<BaseLedgerSaleModel>	loadRegReport2(@Param("departCode")String departCode, @Param("regTypeId")String regTypeId,@Param("type")String type,@Param("month")String month,@Param("season")String season,@Param("year")String year,@Param("start")String start,@Param("end")String end);
	
}