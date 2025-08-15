package com.dayuan.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSType;
import com.dayuan.mapper.system.TSTypeMapper;
import com.dayuan.service.BaseService;

/**
 * 字典表
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年1月9日
 */
@Service
public class TSTypeService extends BaseService<TSType, String> {
	
	@Autowired
	private TSTypeMapper mapper;
	
	public TSTypeMapper getMapper() {
		return mapper;
	}

	/**
	 * 通过类型编号查询类型字典
	 * @param typeCode 类型编号
	 * @return
	 */
	public TSType queryByTypeCode(String typeCode){
		return mapper.queryByTypeCode(typeCode);
	}
}
