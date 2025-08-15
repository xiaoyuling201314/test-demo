package com.dayuan.service.statistics;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.statistics.DataMonthlyStatistics;
import com.dayuan.mapper.statistics.DataMonthlyStatisticsMapper;
import com.dayuan.service.BaseService;
@Service("DataMonthlyStatisticsService")
public class DataMonthlyStatisticsService extends BaseService<DataMonthlyStatistics, Integer>{
	@Autowired
	private DataMonthlyStatisticsMapper mapper;
	
	public DataMonthlyStatisticsMapper getMapper() {
		return mapper;
	}
}
