package com.dayuan.model.detect;


import com.dayuan.model.BaseModel;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月20日
 */
public class DetectCarLocationModel extends BaseModel {
	
	private String carImei;				//设备IMEI,关联base_point表的IMEI
	
	private String startTime;			//查询起始时间
	
	private String endTime;				//查询结束时间
	
	private Boolean showStop;			//查询停车点
	
	public String getCarImei() {
		return carImei;
	}

	public void setCarImei(String carImei) {
		this.carImei = carImei;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Boolean getShowStop() {
		return showStop;
	}

	public void setShowStop(Boolean showStop) {
		this.showStop = showStop;
	}

}