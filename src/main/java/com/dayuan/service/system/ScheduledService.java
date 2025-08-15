package com.dayuan.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.Scheduled;
import com.dayuan.mapper.system.ScheduledMapper;
import com.dayuan.service.BaseService;

import java.util.List;
import java.util.Map;

@Service
public class ScheduledService extends BaseService<Scheduled, Integer>{
	@Autowired
	private ScheduledMapper mapper;
	
	public ScheduledMapper getMapper() {
		return mapper;
	}
	
	public Scheduled selectById(Integer id){
		return mapper.selectById(id);
	}

	public List<Map<String, Object>> selectDepart()throws Exception {
		return mapper.selectDepart();
	}
}
