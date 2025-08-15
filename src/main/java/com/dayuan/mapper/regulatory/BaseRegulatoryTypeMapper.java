package com.dayuan.mapper.regulatory;

import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.mapper.BaseMapper;

import java.util.List;

public interface BaseRegulatoryTypeMapper extends BaseMapper<BaseRegulatoryType, String>{
	
	/**
	 * 根据类型编码,查询监管对象类型
	 * @param regTypeCode 类型编码
	 * @return
	 */
	BaseRegulatoryType queryByRegTypeCode(String regTypeCode);
	
	/**
	 * 查询所有监管对象类型
	 * @return
	 */
	List<BaseRegulatoryType> queryAll();
	
	/**
	 * 根据类型名查找
	 * @param regType
	 * @return
	 */
	BaseRegulatoryType selectByRegType(String regType);

	/**
	 * 通过类型名称查询监管对象类型
	 */
	BaseRegulatoryType queryByTypeName(String typeName);
	
	/**
	 * 通过监管对象ID查询监管对象类型
	 */
	BaseRegulatoryType queryByRegId(Integer regId);

	/**
	 * 查询一个默认的监管类型（最小的sorting参数）
	 *
	 * @return
	 */
	BaseRegulatoryType queryOneBySortAsc();

	/**
	 * 根据机构ID查询监管对象接入情况并按照监管对象类型分组
	 */
    List<BaseRegulatoryType> queryRegTypeGroup(Integer departId);
}