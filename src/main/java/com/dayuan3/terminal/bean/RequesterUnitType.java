package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;

/**
 * 委托单位类型
 * 
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class RequesterUnitType extends BaseBean2 {

	/**
	 * 单位类型
	 */
	private String unitType;

	/**
	 * 0未审核，1审核
	 */
	private Short checked;
	
	/**
	 * 覆盖类型：0日覆盖、1周覆盖、2月覆盖
	 */
	private Short coverageType=0;

	public String getUnitType() {
		return unitType;
	}

	public void setUnitType(String unitType) {
		this.unitType = unitType == null ? null : unitType.trim();
	}

	public Short getChecked() {
		return checked;
	}

	public void setChecked(Short checked) {
		this.checked = checked;
	}

	public Short getCoverageType() {
		return coverageType;
	}

	public void setCoverageType(Short coverageType) {
		this.coverageType = coverageType;
	}
	

}