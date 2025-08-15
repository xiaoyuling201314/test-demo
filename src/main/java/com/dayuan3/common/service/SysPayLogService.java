package com.dayuan3.common.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SysPayLog;
import com.dayuan3.common.mapper.SysPayLogMapper;

@Service
public class SysPayLogService extends BaseService<SysPayLog, Integer> {
	@Autowired
	private SysPayLogMapper mapper;
	
	public SysPayLogMapper getMapper() {
		return mapper;
	}
	
}
