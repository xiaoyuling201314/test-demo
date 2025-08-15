package com.dayuan3.terminal.model;

import java.math.BigDecimal;
import java.util.Date;

import com.dayuan.model.BaseModel;

/**
 * 财务汇总model
 * 
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class IncomeModel extends BaseModel {
	
	private String payDate;// 收费日期
	
	private double checkMoney;// 检测费
	
	private double printMoney;// 打印费
	
	private Integer checkCount;// 检测次数
	
	private Integer printCount;// 打印次数
	
	private double total;// 合计

	private String startDateStr;//查询开始时间
	
	private String endDateStr;//查询结束时间
	
	private Integer samplingId;//订单ID
	
	 /*********** 用于过滤数据 *************/
    private String checkDateStartDateStr;
    private String checkDateEndDateStr;

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public double getCheckMoney() {
		BigDecimal big=new BigDecimal(checkMoney);
		return big.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	public void setCheckMoney(double checkMoney) {
		this.checkMoney = checkMoney;
	}

	public double getPrintMoney() {
		/*
		 * BigDecimal big=new BigDecimal(printMoney); return big.setScale(2,
		 * BigDecimal.ROUND_HALF_UP).doubleValue();
		 */
		return printMoney;
	}

	public void setPrintMoney(double printMoney) {
		this.printMoney = printMoney;
	}

	public Integer getCheckCount() {
		return checkCount;
	}

	public void setCheckCount(Integer checkCount) {
		this.checkCount = checkCount;
	}

	public Integer getPrintCount() {
		return printCount;
	}

	public void setPrintCount(Integer printCount) {
		this.printCount = printCount;
	}

	public double getTotal() {
		BigDecimal big=new BigDecimal(total);
		return big.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getStartDateStr() {
		return startDateStr;
	}

	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr;
	}

	public String getEndDateStr() {
		return endDateStr;
	}

	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}

	public Integer getSamplingId() {
		return samplingId;
	}

	public void setSamplingId(Integer samplingId) {
		this.samplingId = samplingId;
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

}