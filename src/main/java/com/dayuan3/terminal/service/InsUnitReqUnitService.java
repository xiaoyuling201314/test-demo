package com.dayuan3.terminal.service;

import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.InsUnitReqUnit;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.mapper.InsUnitReqUnitMapper;
import com.dayuan3.terminal.model.InsUnitReqUnitModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 送检单位和委托单位中间表Service
 *
 * @author shit
 * @date 2019年01月06日
 */
@Service
public class InsUnitReqUnitService extends BaseService<InsUnitReqUnit, Integer> {
	@Autowired
	private InsUnitReqUnitMapper mapper;

	public InsUnitReqUnitMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据送检单位和委托单位ID查询待选委托单位信息
	 * @description
	 * @param inspectionId 送检单位ID
	 * @param labelId      委托单位标签ID
	 * @param keyWords     委托单位查询
	 * @return
	 * @author xiaoyl
	 * @param keyWords 
	 * @date   2020年1月9日
	 */
	public List<InsUnitReqUnit> loadInspectionUnit(Integer inspectionId,Integer labelId, String keyWords){
		return mapper.loadInspectionUnit(inspectionId,labelId,keyWords);
	}

	/**
	 * 微信端根据送检单位Id查询送检单位配置的委托单位
	 * @param model
	 * @return
	 */
	public List<InsUnitReqUnit> getDataByInspId(InsUnitReqUnitModel model) {
		return mapper.getDataByInspId(model);
	}

	/**
	 * 根据送检单位ID查询出未存在关联关系的委托单位集合
	 * @param inspId
	 * @param reqName
	 * @return
	 */
	public List<RequesterUnit> getReqByInspId(Integer inspId,String reqName) {
		return mapper.getReqByInspId(inspId,reqName);
	}
}
