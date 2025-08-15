package com.dayuan.bean.system;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 字典表
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年1月9日
 */
public class TSType implements Serializable {
	//ID
	private Integer id;
	//父级ID
    private Integer parentId;
    //类型编号
    private String typeCode;
    //类型名称
    private String typeName;
    //类型值
    private String typeValue;
    //启用状态:0未启用，1已启用
    private Short checked;
    //备注
	protected String remark;
	//删除状态；0未删除，1删除
	protected Short deleteFlag = 0;
	//排序
	protected Short sorting = 1;
	//创建人id
	protected String createBy; 
	//创建时间
	protected Date createDate; 
	//修改人id
	protected String updateBy; 
	//修改时间
	protected Date updateDate; 
    //预留参数1
    private String param1;
    //预留参数2
    private String param2;
    //预留参数3
    private String param3;
    
    /***********************非数据库字段，用于页面显示*******************************/
    private List<TSType> tsTypes;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTypeValue() {
		return typeValue;
	}

	public void setTypeValue(String typeValue) {
		this.typeValue = typeValue;
	}

	public Short getChecked() {
		return checked;
	}

	public void setChecked(Short checked) {
		this.checked = checked;
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

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}

	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2;
	}

	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3;
	}

	public List<TSType> getTsTypes() {
		return tsTypes;
	}

	public void setTsTypes(List<TSType> tsTypes) {
		this.tsTypes = tsTypes;
	}

}