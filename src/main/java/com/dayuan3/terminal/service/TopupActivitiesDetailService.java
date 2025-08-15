package com.dayuan3.terminal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.mapper.TopupActivitiesDetailMapper;

@Service
public class TopupActivitiesDetailService extends BaseService<TopupActivitiesDetail, Integer>{

	@Autowired
	private TopupActivitiesDetailMapper mapper;
	
	@Override
	public BaseMapper<TopupActivitiesDetail, Integer> getMapper() {
		return mapper;
	}

}
