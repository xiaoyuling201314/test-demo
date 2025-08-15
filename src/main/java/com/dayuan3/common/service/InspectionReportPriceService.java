package com.dayuan3.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.mapper.InspectionReportPriceMapper;

/**
 * 报告费单价配置
 * @author xiaoyl
 * @date   2020年1月3日
 */
@Service
public class InspectionReportPriceService extends BaseService<InspectionReportPrice, Integer> {
	@Autowired
	private InspectionReportPriceMapper mapper;

	public InspectionReportPriceMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据送检单位ID查询报告费单价
	 * @description
	 * @param id
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月3日
	 */
	public InspectionReportPrice queryByInspectionUnitId(Integer id){
		InspectionReportPrice bean= mapper.queryByInspectionUnitId(id);
		if(bean==null){
			bean=mapper.queryByInspectionUnitId(null);
		}
		return bean;
	}
}
