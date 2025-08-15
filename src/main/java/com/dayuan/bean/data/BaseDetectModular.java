package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean;

/**
 * 
 * Description:检测模块
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月17日
 */
public class BaseDetectModular extends BaseBean {

	private String detectModular; // 检测模块
	private Short deleteFlag; // 检测模块
	private String createBy; // 检测模块
	private Date createDate; // 检测模块
	private String updateBy; // 检测模块
	private Date updateDate; // 检测模块

	private short isCheck;//是否审核0审核1未审核

	public short getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(short isCheck) {
		this.isCheck = isCheck;
	}
	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getDetectModular() {
		return detectModular;
	}

	public void setDetectModular(String detectModular) {
		this.detectModular = detectModular == null ? null : detectModular.trim();
	}

}