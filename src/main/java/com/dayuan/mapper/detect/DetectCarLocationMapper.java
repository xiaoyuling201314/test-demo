package com.dayuan.mapper.detect;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.detect.DetectCarLocation;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.detect.DetectCarLocationModel;
/**
 * 轨迹记录表
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月20日
 */
public interface DetectCarLocationMapper extends BaseMapper<DetectCarLocation, String> {

	DetectCarLocation queryByImeiAndDate(@Param("imei")String imei, @Param("updateDate")Date updateDate);

	DetectCarLocation queryLastLocationByPointId(Integer id);

	List<DetectCarLocation> queryByList(DetectCarLocationModel model);

	List<DetectCarLocation> queryGroupDateByCarImei(String carImei);
   
}