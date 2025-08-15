package com.dayuan3.common.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.InspectionUnitUserAddress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @comment 送检用户地址管理表
 * @author shit
 * @Date 2020-03-12
 */
public interface InspectionUnitUserAddressMapper extends BaseMapper<InspectionUnitUserAddress, Integer>{
    
	
	/**
	 * 根据用户ID查询配置的地址
	 * @param userId
	 * @return
	 */
	List<InspectionUnitUserAddress> selectByUserId(@Param("userId")Integer userId);

	/**
	 * 设置默认标签/取消默认
	 *
	 * @param iuua
	 */
	void updateDefault(InspectionUnitUserAddress iuua);

}