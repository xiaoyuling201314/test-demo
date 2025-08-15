package com.dayuan3.common.mapper;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.InspectionReportPrice;
import com.dayuan3.common.bean.TakeSamplingPrice;
/**
 * 上门服务费管理
 * @author xiaoyl
 * @date   2020年3月2日
 */
public interface TakeSamplingPriceMapper extends BaseMapper<TakeSamplingPrice, Integer> {
	/**
	 * 根据委托单位ID查询上门服务费
	 * @description
	 * @param id
	 * @return
	 * @author xiaoyl
	 * @date   2020年3月2日
	 */
	TakeSamplingPrice queryByRequestUnitId(@Param("id")Integer id);

}