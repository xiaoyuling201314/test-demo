package com.dayuan.model.dataCheck;

import java.math.BigDecimal;
import java.util.Date;


/**
 * 接口上传检测数据数据模型
 */
public class IDataCheckRecordingModel {

	private Integer rid;//检测结果rid

	private String id;  //检测结果id

	private Integer samplingId; //抽样ID

	private Integer samplingDetailId; //抽样明细ID

	private Integer foodId;//项目对应食品种类id

	private String foodName; // 食品种类名称

	private String itemId;//项目对应食品种类-检测项目id列表

	private String itemName;  //检测项目

	private String itemVulgo;   //检测项目俗称

	private String checkResult;  //检测结果(检测值)

	private String limitValue;  //限定值

	private String checkAccordId;  //检测依据

	private String checkAccord;  //检测依据

	private String checkUnit;  //检测结果单位

	private String conclusion;  //检测结论

	private Date samplingDate; // 抽样日期

	private String samplingUser;    //采样人

	private Double samplingNumber;      //采样数量（公斤）

	private String samplingAddress;     //采样地址

	private Date purchaseDate; // 进货日期

	private BigDecimal purchaseAmount; // 进货数量（公斤）

	private String supplier; // 供应商

	private String supplierAddress; // 供货者/生产者地址

	private String supplierPerson; // 供货者/生产者名联系人

	private String supplierPhone; // 供货者/生产者联系电话

	private String batchNumber; // 批号

	private String origin; // 产地

	private Integer regId; // 被检单位ID

	private String regName; // 被检单位名称

	private Integer regUserId; // 经营户ID

	private String regUserName; // 经营户名称

	private String operatorName;    //经营者姓名

	private String operatorPhone;   //经营者联系方式

	private String operatorSign;    //经营者签名

	private String checkUserid;  //检测人员ID

	private String checkUsername;  //检测人员姓名

	private Date checkDate;  //检测时间

	private String deviceId; //检测仪器ID

	private String deviceName; //检测仪器名称

	private String deviceModel; //检测模块

	private String deviceMethod; //检测方法

	private String reagent; //试剂

	private String checkWay;    //检测方式（试剂条检测、快检仪检测）

	private String deviceCompany; //仪器厂家

	private String checkPosition; //检测定位(x,y)

	private String remark; //备注

	private Integer dataType; //数据类型：0：抽样检测；1：送样检测；默认0

	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getSamplingId() {
		return samplingId;
	}

	public void setSamplingId(Integer samplingId) {
		this.samplingId = samplingId;
	}

	public Integer getSamplingDetailId() {
		return samplingDetailId;
	}

	public void setSamplingDetailId(Integer samplingDetailId) {
		this.samplingDetailId = samplingDetailId;
	}

	public Integer getFoodId() {
		return foodId;
	}

	public void setFoodId(Integer foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemVulgo() {
		return itemVulgo;
	}

	public void setItemVulgo(String itemVulgo) {
		this.itemVulgo = itemVulgo;
	}

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	public String getLimitValue() {
		return limitValue;
	}

	public void setLimitValue(String limitValue) {
		this.limitValue = limitValue;
	}

	public String getCheckAccordId() {
		return checkAccordId;
	}

	public void setCheckAccordId(String checkAccordId) {
		this.checkAccordId = checkAccordId;
	}

	public String getCheckAccord() {
		return checkAccord;
	}

	public void setCheckAccord(String checkAccord) {
		this.checkAccord = checkAccord;
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

	public Date getSamplingDate() {
		return samplingDate;
	}

	public void setSamplingDate(Date samplingDate) {
		this.samplingDate = samplingDate;
	}

	public String getSamplingUser() {
		return samplingUser;
	}

	public void setSamplingUser(String samplingUser) {
		this.samplingUser = samplingUser;
	}

	public Double getSamplingNumber() {
		return samplingNumber;
	}

	public void setSamplingNumber(Double samplingNumber) {
		this.samplingNumber = samplingNumber;
	}

	public String getSamplingAddress() {
		return samplingAddress;
	}

	public void setSamplingAddress(String samplingAddress) {
		this.samplingAddress = samplingAddress;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public BigDecimal getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(BigDecimal purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getSupplierAddress() {
		return supplierAddress;
	}

	public void setSupplierAddress(String supplierAddress) {
		this.supplierAddress = supplierAddress;
	}

	public String getSupplierPerson() {
		return supplierPerson;
	}

	public void setSupplierPerson(String supplierPerson) {
		this.supplierPerson = supplierPerson;
	}

	public String getSupplierPhone() {
		return supplierPhone;
	}

	public void setSupplierPhone(String supplierPhone) {
		this.supplierPhone = supplierPhone;
	}

	public String getBatchNumber() {
		return batchNumber;
	}

	public void setBatchNumber(String batchNumber) {
		this.batchNumber = batchNumber;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public Integer getRegId() {
		return regId;
	}

	public void setRegId(Integer regId) {
		this.regId = regId;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public Integer getRegUserId() {
		return regUserId;
	}

	public void setRegUserId(Integer regUserId) {
		this.regUserId = regUserId;
	}

	public String getRegUserName() {
		return regUserName;
	}

	public void setRegUserName(String regUserName) {
		this.regUserName = regUserName;
	}

	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public String getOperatorPhone() {
		return operatorPhone;
	}

	public void setOperatorPhone(String operatorPhone) {
		this.operatorPhone = operatorPhone;
	}

	public String getOperatorSign() {
		return operatorSign;
	}

	public void setOperatorSign(String operatorSign) {
		this.operatorSign = operatorSign;
	}

	public String getCheckUserid() {
		return checkUserid;
	}

	public void setCheckUserid(String checkUserid) {
		this.checkUserid = checkUserid;
	}

	public String getCheckUsername() {
		return checkUsername;
	}

	public void setCheckUsername(String checkUsername) {
		this.checkUsername = checkUsername;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
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

	public String getReagent() {
		return reagent;
	}

	public void setReagent(String reagent) {
		this.reagent = reagent;
	}

	public String getCheckWay() {
		return checkWay;
	}

	public void setCheckWay(String checkWay) {
		this.checkWay = checkWay;
	}

	public String getDeviceCompany() {
		return deviceCompany;
	}

	public void setDeviceCompany(String deviceCompany) {
		this.deviceCompany = deviceCompany;
	}

	public String getCheckPosition() {
		return checkPosition;
	}

	public void setCheckPosition(String checkPosition) {
		this.checkPosition = checkPosition;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDataType() {
		return dataType;
	}

	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}
}
