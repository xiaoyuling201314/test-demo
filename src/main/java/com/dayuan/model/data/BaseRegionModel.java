package com.dayuan.model.data;

import com.dayuan.model.BaseModel;

public class BaseRegionModel  extends BaseModel {

	private String regionName;
	private Long count;
	private Integer qualCount;
	private Integer unqualCount;
	public BaseRegionModel() {
	}
	public BaseRegionModel(String regionName, Long count, Integer qualCount, Integer unqualCount) {
		this.regionName = regionName;
		this.count = count;
		this.qualCount = qualCount;
		this.unqualCount = unqualCount;
	}
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public Integer getQualCount() {
		return qualCount;
	}
	public void setQualCount(Integer qualCount) {
		this.qualCount = qualCount;
	}
	public Integer getUnqualCount() {
		return unqualCount;
	}
	public void setUnqualCount(Integer unqualCount) {
		this.unqualCount = unqualCount;
	}
}
