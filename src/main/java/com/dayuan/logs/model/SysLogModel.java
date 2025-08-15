package com.dayuan.logs.model;

import com.dayuan.bean.data.BaseStandard;
import com.dayuan.logs.bean.SysLog;
import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * 检测标准
 * @author Bill
 *
 * 2017年7月31日
 */
public class SysLogModel extends BaseModel {
	
	private SysLog sysLog;

	private String operateTimeStartDate;//开始时间

	private String operateTimeEndDate;//结束时间

	public SysLog getSysLog() {
		return sysLog;
	}

	public void setSysLog(SysLog sysLog) {
		this.sysLog = sysLog;
	}

	public String getOperateTimeStartDate() {
		return operateTimeStartDate;
	}

	public void setOperateTimeStartDate(String operateTimeStartDate) {
		this.operateTimeStartDate = operateTimeStartDate;
	}

	public String getOperateTimeEndDate() {
		return operateTimeEndDate;
	}

	public void setOperateTimeEndDate(String operateTimeEndDate) {
		this.operateTimeEndDate = operateTimeEndDate;
	}
}