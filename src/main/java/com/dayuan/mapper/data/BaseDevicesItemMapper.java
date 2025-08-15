package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月18日
 */
public interface BaseDevicesItemMapper extends BaseMapper<BaseDevicesItem, String> {
	/**
	 * 根据仪器ID进行批量删除检测项目关联关系
	 * @param id
	 * @return
	 */
	int deleteByDeviceId(String deviceId);

	int deleteByDeviceParameterId(String deviceParameterId);

	/**
	 * 根据检测项目和检测点查询所有可分配的仪器
	 * @param pointId 检测点ID
	 * @param itemId 检测项目ID
	 * @return
	 * @author xyl 2017-09-14
	 */
	List<BaseDevicesItem> queryDeviceByDetectName(@Param("pointId") Integer pointId, @Param("itemId") String itemId);

}