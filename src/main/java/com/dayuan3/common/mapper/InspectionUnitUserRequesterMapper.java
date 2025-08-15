package com.dayuan3.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.InspectionUnitUserRequester;

public interface InspectionUnitUserRequesterMapper extends BaseMapper<InspectionUnitUserRequester, Integer>{
   
	/**
	 * 查询标签下的委托单位
	 * @param userId
	 * @return
	 */
	List<InspectionUnitUserRequester>	selectByLabelId(Integer userId);
	/**
	 * 判断委托单位是否已存在 
	 * @param userId
	 * @param requestId
	 * @return
	 */
	List<InspectionUnitUserRequester>	selectByLabelIdAndresId(@Param("labelId")Integer labelId,@Param("requestId")Integer requestId);
}