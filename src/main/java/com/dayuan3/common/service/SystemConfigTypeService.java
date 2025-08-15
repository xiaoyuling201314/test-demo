package com.dayuan3.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SystemConfigType;
import com.dayuan3.common.mapper.SystemConfigTypeMapper;
/**
 * 	系统配置类型service
 * @author xiaoyl
 * @date   2019年9月25日
 */
@Service
public class SystemConfigTypeService extends BaseService<SystemConfigType, Integer> {
	@Autowired
	private SystemConfigTypeMapper mapper;

	public SystemConfigTypeMapper getMapper() {
		return mapper;
	}
	/**
	 * 查询所有配置类型
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月26日
	 */
	public List<SystemConfigType> queryAll() {
		return mapper.queryAll();
	}
	
	
}
