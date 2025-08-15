package com.dayuan3.common.bean;

import java.util.Date;

/**
 * 系统参数配置 system_config
 * 
 * @author xiaoyl
 * @date 2019年9月25日
 */
public class SystemConfig {
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 项目ID
	 */
	private String projectId="1";

	/**
	 * 系统参数类型ID
	 */
	private Integer configTypeId;

	/**
	 * 配置参数：json字符串格式
	 */
	private String configParam;

	/**
	 * 描述信息
	 */
	private String description;

	/**
	 * 创建人id
	 */
	private String createBy;

	/**
	 * 创建时间
	 */
	private Date createDate;

	/**
	 * 修改人id
	 */
	private String updateBy;

	/**
	 * 修改时间
	 */
	private Date updateDate;

	/**
	 * 删除状态:0_未删除,1_已删除
	 */
	private Short deleteFlag;

	/**
	 * 预留参数1
	 */
	private String param1;

	/**
	 * 预留参数2
	 */
	private String param2;

	/**
	 * 预留参数3
	 */
	private String param3;
	
	/************************非数据库字段******************************************/

	/**
	 * 配置类型编号，1001递增
	 */
	private String configCode;
	/**
	 *	 配置类型名称
	 */
	private String configTypeName;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId == null ? null : projectId.trim();
	}

	public Integer getConfigTypeId() {
		return configTypeId;
	}

	public void setConfigTypeId(Integer configTypeId) {
		this.configTypeId = configTypeId;
	}

	public String getConfigParam() {
		return configParam;
	}

	public void setConfigParam(String configParam) {
		this.configParam = configParam == null ? null : configParam.trim();
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description == null ? null : description.trim();
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

	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1 == null ? null : param1.trim();
	}

	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2 == null ? null : param2.trim();
	}

	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3 == null ? null : param3.trim();
	}

	public String getConfigCode() {
		return configCode;
	}

	public void setConfigCode(String configCode) {
		this.configCode = configCode;
	}

	public String getConfigTypeName() {
		return configTypeName;
	}

	public void setConfigTypeName(String configTypeName) {
		this.configTypeName = configTypeName;
	}
	
}