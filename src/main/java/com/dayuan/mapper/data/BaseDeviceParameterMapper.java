package com.dayuan.mapper.data;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.model.data.BaseDeviceParameterModel;
import com.dayuan.model.data.DeviceParameterExportModel;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.data.BaseDeviceParameter;

/**
 * @author Dz
 * @description 针对表【base_device_parameter(仪器检测项目表)】的数据库操作Mapper
 * @createDate 2025-06-24 12:11:05
 * @Entity com.dayuan.bean.data.BaseDeviceParameter
 */
public interface BaseDeviceParameterMapper extends BaseMapper<BaseDeviceParameter> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseDetectItem> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	BaseDeviceParameter queryByUniqueDeviceItem(BaseDeviceParameter bean);

	List<BaseDeviceParameter> queryByDeviceTypeId(String deviceTypeId);

	List<BaseDeviceParameter> queryByDeviceItem(@Param("deviceTypeId")String deviceTypeId, @Param("itemId")String itemId);

	List<BaseDeviceParameter> queryByItemG(@Param("itemId")String itemId);

    List<DeviceParameterExportModel> queryListForExport(@Param("obj")BaseDeviceParameterModel model, @Param("ids")List<String> listIds);
}