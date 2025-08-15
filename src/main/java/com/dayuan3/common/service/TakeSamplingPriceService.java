package com.dayuan3.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.bean.TakeSamplingPrice;
import com.dayuan3.common.mapper.InspectionReportPriceMapper;
import com.dayuan3.common.mapper.TakeSamplingPriceMapper;

/**
 * 报告费单价配置
 * @author xiaoyl
 * @date   2020年1月3日
 */
@Service
public class TakeSamplingPriceService extends BaseService<TakeSamplingPrice, Integer> {
	@Autowired
	private TakeSamplingPriceMapper mapper;

	public TakeSamplingPriceMapper getMapper() {
		return mapper;
	}
	/**
	 *  根据委托单位ID查询上门服务费
	 * @description
	 * @param id 传入空时查询全局配置
	 * @return
	 * @author xiaoyl
	 * @date   2020年3月2日
	 */
	public TakeSamplingPrice queryByRequestUnitId(Integer id){
		TakeSamplingPrice bean= mapper.queryByRequestUnitId(id);
		if(bean==null){
			bean=mapper.queryByRequestUnitId(null);
		}
		return bean;
	}
}
