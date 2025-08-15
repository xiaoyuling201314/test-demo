package com.dayuan.service.data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.TBImportHistoryMapper;
import com.dayuan.service.BaseService;

@Service
public class TBImportHistoryService extends BaseService<TBImportHistory, Integer> {

	@Autowired
	private TBImportHistoryMapper mapper;

	@Override
	public BaseMapper<TBImportHistory, Integer> getMapper() {
		return mapper;
	}

}
