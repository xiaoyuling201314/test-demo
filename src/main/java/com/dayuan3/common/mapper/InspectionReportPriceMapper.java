package com.dayuan3.common.mapper;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.InspectionReportPrice;
/**
 * 送检报告费单价管理
 * @author xiaoyl
 * @date   2020年1月3日
 */
public interface InspectionReportPriceMapper extends BaseMapper<InspectionReportPrice, Integer> {
	/**
	 * 根据送检单位ID查询报告费单价
	 * @description
	 * @param id
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月3日
	 */
	InspectionReportPrice queryByInspectionUnitId(@Param("id")Integer id);
}