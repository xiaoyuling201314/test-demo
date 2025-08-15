package com.dayuan3.common.mapper;

import java.util.List;

import com.dayuan3.common.bean.InspectionUnitUserRequester;
import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.InspectionUnitUserLabel;

public interface InspectionUnitUserLabelMapper extends BaseMapper<InspectionUnitUserLabel, Integer>{
    
	
	/**
	 * 用户id查询标签
	 * @param userId
	 * @return
	 */
	List<InspectionUnitUserLabel> selectByUserId(@Param("userId")Integer userId,@Param("rowStart")Integer rowStart,@Param("rowEnd")Integer rowEnd);

	/**
	 * 当前用户设置默认标签页
	 * @param userId
	 * @param id
	 */
	void updateSetDefault(@Param("userId")Integer userId,@Param("id")Integer id);
	/**
	 * 取消默认标签
	 * @param userId
	 * @param id
	 */
	void updateQxDefault(@Param("userId")Integer userId,@Param("id")Integer id);

	List<InspectionUnitUserLabel> queryAllByLastUpdateTime(@Param("userId")Integer userId, @Param("lastUpdateTime")String lastUpdateTime);
	
	InspectionUnitUserLabel selectLabelName(@Param("userId")Integer userId, @Param("labelName")String labelName);

	/**
	 * 查询该人员全部委托单位个数
	 * @param inspId
	 * @param userId
	 * @return
	 */
	int selectAllCountLabel(@Param("inspId") Integer inspId, @Param("userId") Integer userId);

	/**
	 * 查询该人员全部委托单位
	 * @param inspId
	 * @param userId
	 * @return
	 */
    List<InspectionUnitUserRequester> selectAllLabelList(@Param("inspId") Integer inspId, @Param("userId") Integer userId);

	/**
	 * 求得当前用户分组的总数量
	 * @param userId
	 * @author shit
	 * @return
	 */
	Integer selectLabelNum(@Param("userId") Integer userId);
}