package com.dayuan.service.DataCheck;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.dataCheck.CheckReportData;
import com.dayuan.mapper.dataCheck.CheckReportDataMapper;
import com.dayuan.service.BaseService;
@Service
public class CheckReportDataService extends BaseService<CheckReportData, Integer> {
	
	@Autowired
	private CheckReportDataMapper mapper;
	
	public CheckReportDataMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据检测记录ID查询是否为重传
	 * @description
	 * @param rid
	 * @return
	 * @author xiaoyl
	 * @date   2020年3月10日
	 */
	public CheckReportData queryByRecordingId(Integer rid) {
		return mapper.queryByRecordingId(rid);
	}
}