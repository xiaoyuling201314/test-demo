package com.dayuan.service.ledger;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.ledger.BaseLedgerHistory;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.ledger.BaseLedgerHistoryMapper;
import com.dayuan.service.BaseService;

@Service
public class BaseLedgerHistoryService  extends BaseService<BaseLedgerHistory, String>{

	@Autowired
	private  BaseLedgerHistoryMapper mapper;
	@Override
	public BaseMapper<BaseLedgerHistory, String> getMapper() {
		
		return mapper;
	}
	
	/**
	 * 查询历史输入数据
	 * @param bean
	 * @return
	 */
	public   List<BaseLedgerHistory>		selectHistoryData(BaseLedgerHistory bean){
		return mapper.selectHistoryData(bean);
	}

}
