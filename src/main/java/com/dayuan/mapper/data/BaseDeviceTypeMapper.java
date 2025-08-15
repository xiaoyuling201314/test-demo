package com.dayuan.mapper.data;

import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.data.BaseDeviceTypeModel;

import java.util.List;
import java.util.Map;

/**
 * 仪器类别维护管理Mapper
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月16日
 */
public interface BaseDeviceTypeMapper extends BaseMapper<BaseDeviceType, String> {
	/**
	 * 查询所有的类别信息
	 * @return
	 */
    List<BaseDeviceType> queryAll();

	BaseDeviceType queryByDeviceName(String deviceName);
	
	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseDeviceTypeModel> loadDatagrids(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotals(Page page);
	/**
	 * 根据SAP码查询 仪器、检测箱
	 * @param number
	 * @return
	 * @author LuoYX
	 * @date 2018年1月30日
	 */
	BaseDeviceType queryDeviceByNumber(String number);

	/**
	 * 查询出仪器的所有类型
	 * @return
	 */
	List<Map<String,Object>> selectAppType();

	/**
	 * 查询出类型和图片
	 * @return
	 * @throws Exception
	 */
	List<BaseDeviceType> selectAppTypeAndImg();
	/**
	 * @Description 根据仪器系列查询仪器类型
	 * @Date 2022/12/28 13:21
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	BaseDeviceType queryDeviceBySeries(String series);
}