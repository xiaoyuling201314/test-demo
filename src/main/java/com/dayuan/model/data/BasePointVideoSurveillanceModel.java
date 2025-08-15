package com.dayuan.model.data;

import java.util.Date;
import java.util.List;

import com.dayuan.model.BaseModel;

/**
 * 监控摄像头 Model
 * @author LuoYX
 * @date 2018年5月8日
 */
public class BasePointVideoSurveillanceModel extends BaseModel {

	private String pointName;
	private String surveillanceName;
	private Date registerDate;
	private List<Integer> departIds;
	private Integer pointId;
	
	public Integer getPointId() {
		return pointId;
	}
	public void setPointId(Integer pointId) {
		this.pointId = pointId;
	}
	public String getPointName() {
		return pointName;
	}
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}
	public String getSurveillanceName() {
		return surveillanceName;
	}
	public void setSurveillanceName(String surveillanceName) {
		this.surveillanceName = surveillanceName;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public List<Integer> getDepartIds() {
		return departIds;
	}
	public void setDepartIds(List<Integer> departIds) {
		this.departIds = departIds;
	}
}
