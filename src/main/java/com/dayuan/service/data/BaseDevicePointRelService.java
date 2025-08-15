package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseDevicePointRel;
import com.dayuan.mapper.data.BaseDevicePointRelMapper;
import com.dayuan.service.BaseService;
@Service
public class BaseDevicePointRelService extends BaseService<BaseDevicePointRel, String>{
	
	@Autowired
	private BaseDevicePointRelMapper mapper;
	
	public BaseDevicePointRelMapper getMapper() {
		return mapper;
	}
	
	public List<BaseDevicePointRel> selectByPointId(Integer pointId) {
		
		return  mapper.selectByPointId(pointId);
	}

	/**
	 * // 删除仪器与 项目的关联关系
	 * @param departId
	 * @author LuoYX
	 * @date 2018年6月15日
	 */
	public void removeRelation(Integer departId) {
		mapper.removeRelation(departId);
	}
	
	public List<BaseDevicePointRel> selectRelation(Integer departId){
		return mapper.selectRelation(departId);
	}
	
	public BaseDevicePointRel selectByDeviceId(String deviceId){
		return mapper.selectByDeviceId(deviceId);
	}
	
	public List<BaseDevicePointRel> selectByDeviceIds(String deviceId){
		return mapper.selectByDeviceIds(deviceId);
	}
}
