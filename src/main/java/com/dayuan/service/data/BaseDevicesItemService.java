package com.dayuan.service.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.mapper.data.BaseDevicesItemMapper;
import com.dayuan.service.BaseService;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月18日
 */
@Service
public class BaseDevicesItemService extends BaseService<BaseDevicesItem, String> {
	@Autowired
	private BaseDevicesItemMapper mapper;
	
	public BaseDevicesItemMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 
	 * @param deviceParameterId 仪器类型与检测项目关联ID
	 * @author xyl
	 * @return
	 */
	public int deleteByDeviceParameterId(String deviceParameterId)throws Exception {
		return mapper.deleteByDeviceParameterId(deviceParameterId);
	}
	
	/**
	 * 根据仪器ID进行批量删除检测项目关联关系
	 * @param id
	 * @return
	 */
	public int deleteByDeviceId(String deviceId){
		return mapper.deleteByDeviceId(deviceId);
	}

	/**
	 * 根据检测项目和检测点查询所有可分配的仪器
	 * @param pointId 检测点ID
	 * @param itemId 检测项目ID
	 */
	public List<BaseDevicesItem> queryDeviceByDetectName(Integer pointId, String itemId){
		return mapper.queryDeviceByDetectName(pointId, itemId);
	}

}