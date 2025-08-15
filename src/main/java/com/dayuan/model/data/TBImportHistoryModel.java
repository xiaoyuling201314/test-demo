package com.dayuan.model.data;

import com.dayuan.model.BaseModel;

public class TBImportHistoryModel extends BaseModel {
	/**
	 * 导入人ID
	 */
	private String userId;
	/**
	 * 导入类型：1检测数据导入
	 */
	private Integer importType;
	private String departName;
	private String departCode;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getImportType() {
		return importType;
	}
	public void setImportType(Integer importType) {
		this.importType = importType;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getDepartCode() {
		return departCode;
	}
	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}
}
