package com.dayuan3.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.InspectionUnitUserRequester;
import com.dayuan3.common.mapper.InspectionUnitUserRequesterMapper;

@Service
public class InspectionUnitUserRequesterService extends BaseService<InspectionUnitUserRequester, Integer>{
	@Autowired
	private InspectionUnitUserRequesterMapper mapper;

	@Override
	public BaseMapper<InspectionUnitUserRequester, Integer> getMapper() {
		return mapper;
	}
	
	/**
	 * 根据标签查询委托单位
	 * @param userId
	 * @return
	 */
	public List<InspectionUnitUserRequester> selectByLabelId(Integer userId) {
		return mapper.selectByLabelId(userId);
	};
}
