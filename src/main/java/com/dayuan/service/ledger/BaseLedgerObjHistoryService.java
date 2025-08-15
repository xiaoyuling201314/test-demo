package com.dayuan.service.ledger;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.ledger.BaseLedgerObjHistory;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.ledger.BaseLedgerObjHistoryMapper;
import com.dayuan.service.BaseService;

@Service
public class BaseLedgerObjHistoryService extends BaseService<BaseLedgerObjHistory, String>{

	@Autowired
	private  BaseLedgerObjHistoryMapper mapper;
	@Override
	public BaseMapper<BaseLedgerObjHistory, String> getMapper() {
		
		return mapper;
		
	}
	/**
	 * 获取历史数据
	 * @param bean
	 * @return
	 */
	public   List<BaseLedgerObjHistory>		selectHistoryData(BaseLedgerObjHistory bean){
		return mapper.selectHistoryData(bean);
	}
	/**
	 * 获取市场历史数据
	 * @param bean
	 * @return
	 */
	public   List<BaseLedgerObjHistory>		selectHistoryObj(BaseLedgerObjHistory bean){
		return mapper.selectHistoryObj(bean);
	}
	
	/**
	 * 获取档口历史数据
	 * @param bean
	 * @return
	 */
	public   List<BaseLedgerObjHistory>		selectHistoryBus(BaseLedgerObjHistory bean){
		return mapper.selectHistoryBus(bean);
	}
	

}
