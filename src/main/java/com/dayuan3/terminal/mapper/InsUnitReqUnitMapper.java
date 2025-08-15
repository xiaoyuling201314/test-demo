package com.dayuan3.terminal.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.InsUnitReqUnit;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.model.InsUnitReqUnitModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 送检单位和委托单位中间表Mapper
 *
 * @author shit
 * @date 2019年01月06日
 */
public interface InsUnitReqUnitMapper extends BaseMapper<InsUnitReqUnit, Integer> {
	/**
	 * 根据送检单位和委托单位ID查询待选委托单位信息
	 * @description
	 * @param inspectionId 送检单位ID
	 * @param labelId      委托单位标签ID
	 * @return
	 * @author xiaoyl
	 * @param keyWords 
	 * @date   2020年1月9日
	 */
	List<InsUnitReqUnit> loadInspectionUnit(@Param("inspectionId")Integer inspectionId,@Param("labelId")Integer labelId,@Param("keyWords")String keyWords);

	/**
	 * 微信端根据送检单位Id查询送检单位配置的委托单位
	 * @param model
	 * @return
	 */
	List<InsUnitReqUnit> getDataByInspId(InsUnitReqUnitModel model);

	/**
	 * 根据送检单位ID查询出未存在关联关系的委托单位集合
	 * @param inspId
	 * @param reqName
	 * @return
	 */
    List<RequesterUnit> getReqByInspId(@Param("inspId") Integer inspId, @Param("reqName") String reqName);
}