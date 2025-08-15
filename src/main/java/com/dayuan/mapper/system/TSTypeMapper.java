package com.dayuan.mapper.system;

import com.dayuan.bean.system.TSType;
import com.dayuan.mapper.BaseMapper;

/**
 * 字典表
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年1月9日
 */
public interface TSTypeMapper extends BaseMapper<TSType, String> {
	/**
	 * 通过类型编号查询类型字典
	 * @param typeCode 类型编号
	 * @return
	 */
	TSType queryByTypeCode(String typeCode);
}