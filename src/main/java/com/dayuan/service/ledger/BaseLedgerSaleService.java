package com.dayuan.service.ledger;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.ledger.BaseLedgerSale;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.ledger.BaseLedgerSaleMapper;
import com.dayuan.model.ledger.BaseLedgerSaleModel;
import com.dayuan.service.BaseService;

@Service
public class BaseLedgerSaleService extends BaseService<BaseLedgerSale, Integer>{

	@Autowired
	private BaseLedgerSaleMapper mapper;
	@Override
	public BaseMapper<BaseLedgerSale, Integer> getMapper() {
		return mapper;
	}
	
	/**
	 * 端州微信-销售台账统计
	 * @param regIds 市场IDs
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月28日
	 */
	public List<Map<String, Object>> queryStockByRegIds(List<Integer> regIds, String start, String end) {
		return mapper.queryStockByRegIds(regIds,start,end);
	}

	/**
	 * 查询市场销售台账详情
	 * @param regId
	 * @param start
	 * @param end
	 * @return
	 * @author LuoYX
	 * @date 2018年6月29日
	 */
	public List<Map<String, Object>> queryByRegId(Integer regId, String start, String end) {
		return mapper.queryByRegId(regId,start,end);
	}
	
	
	public  List<BaseLedgerSaleModel> loadRegReport(String String, String regTypeId,String type,String month,String season,String year,String start,String end) {
		return mapper.loadRegReport(String, regTypeId,type,month,season,year,start,end);
	}
	/**
	 * 查询市场台账数据信息
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
	public  List<BaseLedgerSaleModel> loadRegReport2(String String, String regTypeId,String type,String month,String season,String year,String start,String end) {
		return mapper.loadRegReport2(String, regTypeId,type,month,season,year,start,end);
	}

}
