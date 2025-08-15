package com.dayuan.mapper.data;

import com.dayuan.bean.data.BasePointVideoSurveillance;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 监控摄像头Mapper
 * @author LuoYX
 * @date 2018年5月8日
 */
public interface BasePointVideoSurveillanceMapper extends BaseMapper<BasePointVideoSurveillance, Integer> {
	
	List<BasePointVideoSurveillance> selectByPointId(Integer pointId);
	/**
	* @Description 查询所有乐橙云相关的摄像头或者根据传入的设备号查询数据
	* @Date 2022/07/18 15:38
	* @Author xiaoyl
	* @Param
	* @return
	*/
    List<BasePointVideoSurveillance> queryLeChengVideo(@Param("dev") String dev);
	/**
	 * @Description 查询所有乐橙API的在线设备，用于东营可视化大屏进行播放
	 * @Date 2022/09/26 9:53
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	List<BasePointVideoSurveillance> queryAllOnlineVideo(@Param("departId")Integer departId);
}