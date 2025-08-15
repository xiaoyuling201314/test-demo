package com.dayuan3.terminal.bean;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 委托单位获取具体样品检测信息
 */
public class sampleDetail {

	private Integer samplingId; // 抽样单id

	private Integer samplingDetailId; // 抽样明细id

	private String samplingNo; // 订单单号

	private Date samplingDate; // 订单下单时间

	private Date payDate;// 付款时间

	private String foodName; // 样品名称

	private String itemName; // 抽检项目名称

	private String conclusion; // 检测结论
	private String supplier; // 检测结论
	private String opeName; // 检测结论

	private Date checkDate; // 检测时间

	private Date sampleTubeTime; // 收样时间

	private String collectCode;// 收样取报告码

	private BigDecimal purchaseAmount;	//进货数量（公斤）

	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getOpeName() {
		return opeName;
	}

	public void setOpeName(String opeName) {
		this.opeName = opeName;
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

	public String getSamplingNo() {
		return samplingNo;
	}

	public void setSamplingNo(String samplingNo) {
		this.samplingNo = samplingNo;
	}

	public Date getSamplingDate() {
		return samplingDate;
	}

	public void setSamplingDate(Date samplingDate) {
		this.samplingDate = samplingDate;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getConclusion() {
		return conclusion == null ? "" : conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getCollectCode() {
		return collectCode;
	}

	public void setCollectCode(String collectCode) {
		this.collectCode = collectCode;
	}

	public Date getSampleTubeTime() {
		return sampleTubeTime;
	}

	public void setSampleTubeTime(Date sampleTubeTime) {
		this.sampleTubeTime = sampleTubeTime;
	}

	public BigDecimal getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(BigDecimal purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}
}