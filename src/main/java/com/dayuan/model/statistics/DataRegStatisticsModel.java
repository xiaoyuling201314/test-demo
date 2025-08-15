package com.dayuan.model.statistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.dayuan.model.BaseModel;
import com.dayuan.util.DateUtil;

public class DataRegStatisticsModel extends BaseModel{
	
	private int projectId;
	
	private Date yyyyMM;
	
	private String yyyyMMStr;

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public Date getYyyyMM() {
		return yyyyMM;
	}

	public void setYyyyMM(Date yyyyMM) {
		this.yyyyMM = yyyyMM;
	}

	public String getYyyyMMStr() {
		if(yyyyMM == null) {
			return null;
		}
		SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
		return yyyy_MM.format(yyyyMM);
	}
	
}
