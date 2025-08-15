package com.dayuan3.common.bean;

import java.util.Date;

import com.dayuan.model.BaseModel;

/**
 * 不合格处理查看
 * 
 * @author xiaoyl
 * @date 2019年9月20日
 */
public class DataUnqualifiedModel extends BaseModel {

	/**
	 * 检测结果表
	 */

	private String id; // 检测结果id

	private String checkAccord; // 检测依据

	private String limitValue; // 限定值

	private String checkResult; // 检测结果(检测值)

	private String checkUnit; // 检测结果单位

	private String conclusion; // 检测结论

	private Date checkDate; // 检测时间

	private String checkCode;// 检测编号

	private String auditorName; // 审核人员

	private String uploadName; // 上报人员

	private Date uploadDate; // 上报时间

	private String departName;// 检测机构

	private String deviceModel; // 检测模块

	private String deviceMethod; // 检测方法

	private String deviceCompany; // 仪器厂家

	private String dataSource; // 数据来源

	private Short reloadFlag; // 上传次数

	/**
	 * 抽检单
	 */
	private String samplingId; // 抽样单ID

	private String samplingNo; // 抽样单号

	private Date samplingDate; // 抽样日期

	/**
	 * 抽检单详情
	 */
	private String samplingDetailId; // 抽样明细ID

	private String sampleTubeCode;// 样品编号
	
	private Date sampleTubeTime;// 收样时间

	/**
	 * 检测点
	 */

	private String pointName; // 检测点名称

	private String checkUsername; // 检测人员名称

	private String itemName; // 检测项目

	private String foodName; // 食品种类名称

	private String deviceCode; // 检测仪器编号

	private String deviceName; // 检测仪器名称

	private String address; // 检测点地址(通讯地址)

	private String regName;// 委托单位

	private int printCount;//打印次数
	
	/*********** 用于过滤数据 *************/
	private String checkDateStartDateStr;
	private String checkDateEndDateStr;

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCheckAccord() {
		return checkAccord;
	}

	public void setCheckAccord(String checkAccord) {
		this.checkAccord = checkAccord;
	}

	public String getLimitValue() {
		return limitValue;
	}

	public void setLimitValue(String limitValue) {
		this.limitValue = limitValue;
	}

	public String getCheckResult() {
		if(checkResult!=null && !checkResult.equals("阴性")) {
			return checkResult+checkUnit;
		}
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	public String getCheckUnit() {
		return checkUnit;
	}

	public void setCheckUnit(String checkUnit) {
		this.checkUnit = checkUnit;
	}

	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public String getSamplingNo() {
		return samplingNo;
	}

	public void setSamplingNo(String samplingNo) {
		this.samplingNo = samplingNo;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public Date getSamplingDate() {
		return samplingDate;
	}

	public void setSamplingDate(Date samplingDate) {
		this.samplingDate = samplingDate;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getCheckUsername() {
		return checkUsername;
	}

	public void setCheckUsername(String checkUsername) {
		this.checkUsername = checkUsername;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDeviceCode() {
		return deviceCode;
	}

	public void setDeviceCode(String deviceCode) {
		this.deviceCode = deviceCode;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public String getAuditorName() {
		return auditorName;
	}

	public void setAuditorName(String auditorName) {
		this.auditorName = auditorName;
	}

	public String getUploadName() {
		return uploadName;
	}

	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getDeviceMethod() {
		return deviceMethod;
	}

	public void setDeviceMethod(String deviceMethod) {
		this.deviceMethod = deviceMethod;
	}

	public String getDeviceCompany() {
		return deviceCompany;
	}

	public void setDeviceCompany(String deviceCompany) {
		this.deviceCompany = deviceCompany;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getSamplingId() {
		return samplingId;
	}

	public void setSamplingId(String samplingId) {
		this.samplingId = samplingId;
	}

	public Short getReloadFlag() {
		return reloadFlag;
	}

	public void setReloadFlag(Short reloadFlag) {
		this.reloadFlag = reloadFlag;
	}

	public String getSamplingDetailId() {
		return samplingDetailId;
	}

	public void setSamplingDetailId(String samplingDetailId) {
		this.samplingDetailId = samplingDetailId;
	}

	public String getCheckDateStartDateStr() {
		return checkDateStartDateStr;
	}

	public void setCheckDateStartDateStr(String checkDateStartDateStr) {
		this.checkDateStartDateStr = checkDateStartDateStr;
	}

	public String getCheckDateEndDateStr() {
		return checkDateEndDateStr;
	}

	public void setCheckDateEndDateStr(String checkDateEndDateStr) {
		this.checkDateEndDateStr = checkDateEndDateStr;
	}

	public String getSampleTubeCode() {
		return sampleTubeCode;
	}

	public void setSampleTubeCode(String sampleTubeCode) {
		this.sampleTubeCode = sampleTubeCode;
	}

	public Date getSampleTubeTime() {
		return sampleTubeTime;
	}

	public void setSampleTubeTime(Date sampleTubeTime) {
		this.sampleTubeTime = sampleTubeTime;
	}

	public int getPrintCount() {
		return printCount;
	}

	public void setPrintCount(int printCount) {
		this.printCount = printCount;
	}

}
