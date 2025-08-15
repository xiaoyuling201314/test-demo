package com.dayuan3.common.model;

import com.dayuan.model.BaseModel;

/**
 * 	系统参数配置model
 * @author xiaoyl
 * @date   2019年9月26日
 */
public class SystemConfigModel  extends BaseModel {
	private String projectID;//项目ID

	public String getProjectID() {
		return projectID;
	}

	public void setProjectID(String projectID) {
		this.projectID = projectID;
	}
	
}