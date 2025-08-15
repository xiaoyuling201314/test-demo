package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDevice;
import com.dayuan.bean.data.BaseFoodType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Dz
 * @description 针对表【base_device(仪器基础表)】的数据库操作Mapper
 * @createDate 2025-06-22 17:13:41
 * @Entity com.dayuan.bean.data.BaseDevice
 */
public interface BaseDeviceMapper extends BaseMapper<BaseDevice> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseFoodType> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);
	
	List<BaseDevice> queryAllDeviceByPointId(@Param("pointId")Integer pointId, @Param("departId")Integer departId, @Param("deviceStyle")String deviceStyle);
    
	//BaseDevice queryByDeviceCode(String deviceCode);

	List<String> queryByDeviceType(String deviceTypeId);

	BaseDevice queryBySerialNumber(String serialNumber);
	
	List<BaseDevice> queryBySeriesAndCode(@Param("deviceSeriesId")String deviceSeriesId, @Param("deviceCode")String deviceCode);
	/**
	 * @Description 根据仪器出厂编号查询仪器信息
	 * @Date 2022/02/11 16:25
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	BaseDevice queryByDeviceCode(String deviceCode);
}