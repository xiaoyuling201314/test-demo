package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseDevicePointRel;
import com.dayuan.mapper.BaseMapper;

public interface BaseDevicePointRelMapper extends BaseMapper<BaseDevicePointRel, String> {

	BaseDevicePointRel selectByDeviceId(String deviceId);
	
	List<BaseDevicePointRel> selectByPointId(Integer pointId);
	/**
	 * // 删除仪器与 项目的关联关系
	 * @param departId
	 * @author LuoYX
	 * @date 2018年6月15日
	 */
	void removeRelation(Integer departId);
	
	List<BaseDevicePointRel> selectRelation(Integer departId);
	
	List<BaseDevicePointRel> selectByDeviceIds(String deviceId);
	
}