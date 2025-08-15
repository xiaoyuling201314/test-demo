package com.dayuan.service.ledger;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.ledger.BaseLedgerStockMapper;
import com.dayuan.model.ledger.BaseLedgerStockModel;
import com.dayuan.service.BaseService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;

@Service
public class BaseLedgerStockService  extends  BaseService<BaseLedgerStock, Integer>{
	
	@Autowired
	private BaseLedgerStockMapper  mapper;
	@Autowired
	private BaseRegulatoryTypeService  baseRegulatoryTypeService;
	@Override
	public BaseMapper<BaseLedgerStock, Integer> getMapper() {
		return mapper;
	}
	public  List<BaseLedgerStockModel> loadRegReport(String String, String regTypeId,String type,String month,String season,String year,String start,String end) {
		return mapper.loadRegReport(String, regTypeId,type,month,season,year,start,end);
	}
	/**
	 * 获取冷库类型市场数据
	 * @param String
	 * @param regTypeId
	 * @param type
	 * @param month
	 * @param season
	 * @param year
	 * @param start
	 * @param end
	 * @return
	 */
	public  List<BaseLedgerStockModel> loadRegReport2(String String, String regTypeId,String type,String month,String season,String year,String start,String end) {
		return mapper.loadRegReport2(String, regTypeId,type,month,season,year,start,end);
	}
	
    /**
     * 通过经营户、样品、进货日期获取进货台账
     * @param regId	监管对象ID
     * @param businessId	经营户ID
     * @param foodName	样品名称
     * @param batchNumber	批次
     * @param stockDate	进货日期(日期格式：yyyy-MM-dd)
     * @return
     */
	public BaseLedgerStock queryByBatchNumber(Integer regId, Integer businessId, String foodName, String batchNumber, String stockDate) {
		
		//溯源信息，不通过样品批次查询台账数据
		batchNumber = null;
		
		//经营户ID为空
		if(businessId == null) {
			//查询监管对象类型
			BaseRegulatoryType regType = baseRegulatoryTypeService.queryByRegId(regId);
			
			if(regType == null) {
				return null;
			
			//类型-有经营户
			}else if(regType.getShowBusiness() == 1) {
				//由于经营户ID为空，不能确定溯源信息
				return null;
			
			//类型-监管对象不能录入台账
			}else if(regType.getStockType() == 0){
				return null;
			}
		}
		
		return mapper.queryByBatchNumber(regId, businessId, foodName, batchNumber, stockDate);
	}

	/**
	 * 根据经营户id、foodName 批号查询批号是否存在
	 * @param bean
	 * @return
	 */
	public   BaseLedgerStock selectByBatchNumber(BaseLedgerStock bean) {
		return mapper.selectByBatchNumber( bean);
	}
	
	/**
	 * 端州微信-根据经营户ID查询 录入了进货台账的档口数量
	 * @param businessIds 经营户IDs
	 * @param start 开始日期
	 * @param end 结束日期
	 * @return 录入了进货台账的档口数量
	 * @author LuoYX
	 * @date 2018年6月27日
	 */
	public Integer getEnterStockCount(List<Integer> businessIds,String start,String end) {
		return mapper.getEnterStockCount(businessIds,start,end);
	}
	/**
	 * 端州微信-进货统计
	 * @param regIds 市场IDs
	 * @param start 开始时间
	 * @param end 结束时间
	 * @return 每个市场的档口数量、已录入台账数量
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	public List<Map<String, Object>> queryStockByRegIds(List<Integer> regIds, String start, String end) {
		return mapper.queryStockByRegIds(regIds,start,end);
	}
	/**
	 * 端州微信-进货台账详情
	 * @param regId
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	public List<Map<String, Object>> queryByRegId(Integer regId, String start, String end) {
		return mapper.queryByRegId(regId, start, end);
	}

	/**
	 * 通过检测数据ID查询台账
	 * @param rid 检测数据ID
	 * @return
	 */
	public BaseLedgerStock queryByRid(Integer rid) {
		return mapper.queryByRid(rid);
	}

}
