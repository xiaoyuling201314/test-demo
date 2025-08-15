package com.dayuan3.common.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SysPrintLog;
import com.dayuan3.common.mapper.SysPrintLogMapper;

@Service
public class SysPrintLogService extends BaseService<SysPrintLog, Integer> {
	@Autowired
	private SysPrintLogMapper mapper;

	public SysPrintLogMapper getMapper() {
		return mapper;
	}
}
