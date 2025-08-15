package com.dayuan.service.regulatory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.regulatory.BaseRegulatoryPersonnel;
import com.dayuan.mapper.regulatory.BaseRegulatoryPersonnelMapper;
import com.dayuan.service.BaseService;

/**
 * 监管对象人员
 * @author Dz
 *
 */
@Service
public class BaseRegulatoryPersonnelService extends BaseService<BaseRegulatoryPersonnel, Integer> {

	@Autowired
	private BaseRegulatoryPersonnelMapper mapper;
	
	public BaseRegulatoryPersonnelMapper getMapper() {
		return mapper;
	}
}
