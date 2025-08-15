package com.dayuan3.terminal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.mapper.RequesterUnitTypeMapper;

/**
 * 
 * @author xiaoyl
 * @date   2019年7月1日
 */
@Service
public class RequesterUnitTypeService extends BaseService<RequesterUnitType, Integer> {
	@Autowired
	private RequesterUnitTypeMapper mapper;

	public RequesterUnitTypeMapper getMapper() {
		return mapper;
	}
	/**
	 * 查询所有的单位类型
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月2日
	 */
	public List<RequesterUnitType> queryAllType() {
		return mapper.queryAllType();
	}

	/**
	 * 根据ID查询监控类型
	 * @param ids
	 * @return
	 * @author shit
	 */
	public List<RequesterUnitType> selectByIds(String[] ids) {
		return mapper.selectByIds(ids);
	}
	/**
	 * 根据委托单位类型名称查找数据
	 * @description
	 * @param unitType
	 * @return
	 * @author xiaoyl
	 * @date   2020年6月30日
	 */
	public RequesterUnitType selectByName(String unitType) {
		return mapper.selectByName(unitType);
	}
}
