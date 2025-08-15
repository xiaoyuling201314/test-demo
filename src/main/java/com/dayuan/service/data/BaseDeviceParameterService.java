package com.dayuan.service.data;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.BaseDeviceParameterModel;
import com.dayuan.model.data.DeviceParameterExportModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseDeviceParameter;
import com.dayuan.mapper.data.BaseDeviceParameterMapper;
import com.dayuan.service.BaseService;

/**
 * @author Dz
 * @description 针对表【base_device_parameter(仪器检测项目表)】的数据库操作Service
 * @createDate 2025-06-24 12:11:05
 */
public interface BaseDeviceParameterService extends IService<BaseDeviceParameter> {

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;

	/**
	 * 根据仪器系列，检测项目，检测模块查询检测项目信息
	 * @param bean
	 * @return
	 */
	public BaseDeviceParameter queryByUniqueDeviceItem(BaseDeviceParameter bean) throws Exception;
	
	/**
	 * 根据仪器系列，检测项目查询检测项目信息
	 * @return
	 */
	public List<BaseDeviceParameter> queryByDeviceItem(String deviceTypeId, String itemId) throws Exception;
	
	/**
	 * 根据检测项目查询检测项目信息(以检测模块、检测方法分组)
	 * @return
	 */
	public List<BaseDeviceParameter> queryByItemG(String itemId) throws Exception;

    public List<DeviceParameterExportModel> queryListForExport(BaseDeviceParameterModel model, List<String> listIds);
}
