package com.dayuan.service.detect;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.detect.DetectCarLocation;
import com.dayuan.mapper.detect.DetectCarLocationMapper;
import com.dayuan.model.detect.DetectCarLocationModel;
import com.dayuan.service.BaseService;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月20日
 */
@Service
public class DetectCarLocationService extends BaseService<DetectCarLocation, String> {

	@Autowired
	private DetectCarLocationMapper mapper;

	public DetectCarLocationMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据定位设备imei和定位时间进行定位数据查找，用于解决重复写入问题
	 * @param imei
	 * @param updateDate
	 * @return
	 */
	public DetectCarLocation queryByImeiAndDate(String imei, Date updateDate) {
		return mapper.queryByImeiAndDate(imei,updateDate);
	}
	/**
	 * 根据检测车Id查询车辆最后位置
	 * @param id
	 * @return
	 * @author xyl 2017-10-20
	 */
	public DetectCarLocation queryLastLocationByPointId(Integer id) {
		return mapper.queryLastLocationByPointId(id);
	}
	public List<DetectCarLocation> queryByList(DetectCarLocationModel model) {
		return mapper.queryByList(model);
	}
	/**
	 * 根据定位设备IMEI号码查询有数据的日期，筛选前10条
	 * @param carImei 定位设备IMEI号码
	 * @return
	 * @author xyl 2017-11-08
	 */
	public List<DetectCarLocation> queryGroupDateByCarImei(String carImei) {
		return mapper.queryGroupDateByCarImei(carImei);
	}
	
	
}
