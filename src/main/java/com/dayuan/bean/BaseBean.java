package com.dayuan.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xyl 时间:2017年8月7日下午4:21:09
 */
public class BaseBean implements Serializable {

	protected String id; // 主键：id

	protected String remark; // 备注

	protected Short deleteFlag = 0; // 删除状态；0未删除，1删除
	
	protected Short sorting = 1;	//排序

	protected String createBy; // 创建人id

	protected Date createDate; // 创建时间

	protected String updateBy; // 修改人id

	protected Date updateDate; // 修改时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
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
	
	
}
