package com.dayuan3.terminal.model;

import com.dayuan.model.BaseModel;

/**
 * 送检单位和委托单位中间表Model
 *
 * @author shit
 * @date 2019年01月06日
 */
public class InsUnitReqUnitModel extends BaseModel {
	/**
	 * 委托单位名称
	 */
	private String requestName;

	/**
	 * 查询条件:送检单位Id
	 */
	private String inspId;

	public String getRequestName() {
		return requestName;
	}

	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}

	public String getInspId() {
		return inspId;
	}

	public void setInspId(String inspId) {
		this.inspId = inspId;
	}
}