package com.dayuan3.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SysOperationLog;
import com.dayuan3.common.mapper.SysOperationLogMapper;

@Service
public class SysOperationLogService extends BaseService<SysOperationLog, Integer> {
	@Autowired
	private SysOperationLogMapper mapper;

	public SysOperationLogMapper getMapper() {
		return mapper;
	}
	
	
}
