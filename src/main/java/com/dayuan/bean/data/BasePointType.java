package com.dayuan.bean.data;

import java.util.Date;

public class BasePointType {
	// 主键
	private Integer id;
	// 检测点类型
	private String pointType;
	// 监管对象,0无,1有
	private Short regulatory;
	// 监管对象类型ID
	private String regualtoryTypeId;
	// 排序
	private Short sorting;
	// 0未审核，1已审核
	private Short checked;
	// 0未删除，1已删除
	private Short deleteFlag;
	// 创建人id
	private String createBy;
	// 创建时间
	private Date createDate;
	// 修改人id
	private String updateBy;
	// 修改时间
	private Date updateDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType == null ? null : pointType.trim();
	}

	public Short getRegulatory() {
		return regulatory;
	}

	public void setRegulatory(Short regulatory) {
		this.regulatory = regulatory;
	}

	public String getRegualtoryTypeId() {
		return regualtoryTypeId;
	}

	public void setRegualtoryTypeId(String regualtoryTypeId) {
		this.regualtoryTypeId = regualtoryTypeId;
	}

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}

	public Short getChecked() {
		return checked;
	}

	public void setChecked(Short checked) {
		this.checked = checked;
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
		this.createBy = createBy == null ? null : createBy.trim();
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
		this.updateBy = updateBy == null ? null : updateBy.trim();
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
}