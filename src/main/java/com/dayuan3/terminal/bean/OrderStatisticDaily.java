package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class OrderStatisticDaily extends BaseBean2 {

    private Date date;

    private Double income;

    private Integer qtyOrder;

    private Integer qtyWxOrder;

    private Integer qtyZdOrder;

    private Integer qtyWxPay;

    private Integer qtyZfbPay;

    private Integer qtyFood;

    private String foodStatistic;

    private Integer qtyItem;

    private String itemStatistic;

    private Integer qtyReqUnit;

    private String reqUnitStatistic;

    private Integer qtyInsUnit;

    private String insUnitStatistic;

    private String param1;

    private String param2;

    private String param3;

    private Integer qtyAllReqUnit;

    private Integer qtyAllInsUnit;

    private Integer qtyYePay;

    private Double incomeYe;

    private Double incomeWx;

    private Double incomeZfb;

    private Double incomeCz;

    private Double refundWxZfb;

    private Double refundYe;

    private Double refundCz;

    private Integer qtyCz;

    private Integer qtyCzUser;

    private Double incomeOrder;

    private Double feeCheck;

    private Double feePrint;

    private Double feeReport;

    private Double feeTakeSampling;

    private Double fee1;

    private Double fee2;

    private Double fee3;

    private Integer qtyInsUser;

    private String insUserStatistic;

    private Integer foodNum;//所有样品个数 shit

    public OrderStatisticDaily() {
    }

    public OrderStatisticDaily(Date date, Double income, Integer qtyOrder, Integer qtyWxOrder, Integer qtyZdOrder, Integer qtyWxPay, Integer qtyZfbPay, Integer qtyFood, String foodStatistic, Integer qtyItem, String itemStatistic, Integer qtyReqUnit, String reqUnitStatistic, Integer qtyInsUnit, String insUnitStatistic, String param1, String param2, String param3, Integer qtyAllReqUnit, Integer qtyAllInsUnit, Integer qtyYePay, Double incomeYe, Double incomeWx, Double incomeZfb, Double incomeCz, Double refundWxZfb, Double refundYe, Double refundCz, Integer qtyCz, Integer qtyCzUser, Double incomeOrder, Double feeCheck, Double feePrint, Double feeReport, Double feeTakeSampling, Double fee1, Double fee2, Double fee3, Integer qtyInsUser, String insUserStatistic) {
        this.date = date;
        this.income = income;
        this.qtyOrder = qtyOrder;
        this.qtyWxOrder = qtyWxOrder;
        this.qtyZdOrder = qtyZdOrder;
        this.qtyWxPay = qtyWxPay;
        this.qtyZfbPay = qtyZfbPay;
        this.qtyFood = qtyFood;
        this.foodStatistic = foodStatistic;
        this.qtyItem = qtyItem;
        this.itemStatistic = itemStatistic;
        this.qtyReqUnit = qtyReqUnit;
        this.reqUnitStatistic = reqUnitStatistic;
        this.qtyInsUnit = qtyInsUnit;
        this.insUnitStatistic = insUnitStatistic;
        this.param1 = param1;
        this.param2 = param2;
        this.param3 = param3;
        this.qtyAllReqUnit = qtyAllReqUnit;
        this.qtyAllInsUnit = qtyAllInsUnit;
        this.qtyYePay = qtyYePay;
        this.incomeYe = incomeYe;
        this.incomeWx = incomeWx;
        this.incomeZfb = incomeZfb;
        this.incomeCz = incomeCz;
        this.refundWxZfb = refundWxZfb;
        this.refundYe = refundYe;
        this.refundCz = refundCz;
        this.qtyCz = qtyCz;
        this.qtyCzUser = qtyCzUser;
        this.incomeOrder = incomeOrder;
        this.feeCheck = feeCheck;
        this.feePrint = feePrint;
        this.feeReport = feeReport;
        this.feeTakeSampling = feeTakeSampling;
        this.fee1 = fee1;
        this.fee2 = fee2;
        this.fee3 = fee3;
        this.qtyInsUser = qtyInsUser;
        this.insUserStatistic = insUserStatistic;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Double getIncome() {
        return income;
    }

    public void setIncome(Double income) {
        this.income = income;
    }

    public Integer getQtyOrder() {
        return qtyOrder;
    }

    public void setQtyOrder(Integer qtyOrder) {
        this.qtyOrder = qtyOrder;
    }

    public Integer getQtyWxOrder() {
        return qtyWxOrder;
    }

    public void setQtyWxOrder(Integer qtyWxOrder) {
        this.qtyWxOrder = qtyWxOrder;
    }

    public Integer getQtyZdOrder() {
        return qtyZdOrder;
    }

    public void setQtyZdOrder(Integer qtyZdOrder) {
        this.qtyZdOrder = qtyZdOrder;
    }

    public Integer getQtyWxPay() {
        return qtyWxPay;
    }

    public void setQtyWxPay(Integer qtyWxPay) {
        this.qtyWxPay = qtyWxPay;
    }

    public Integer getQtyZfbPay() {
        return qtyZfbPay;
    }

    public void setQtyZfbPay(Integer qtyZfbPay) {
        this.qtyZfbPay = qtyZfbPay;
    }

    public Integer getQtyFood() {
        return qtyFood;
    }

    public void setQtyFood(Integer qtyFood) {
        this.qtyFood = qtyFood;
    }

    public String getFoodStatistic() {
        return foodStatistic;
    }

    public void setFoodStatistic(String foodStatistic) {
        this.foodStatistic = foodStatistic == null ? null : foodStatistic.trim();
    }

    public Integer getQtyItem() {
        return qtyItem;
    }

    public void setQtyItem(Integer qtyItem) {
        this.qtyItem = qtyItem;
    }

    public String getItemStatistic() {
        return itemStatistic;
    }

    public void setItemStatistic(String itemStatistic) {
        this.itemStatistic = itemStatistic == null ? null : itemStatistic.trim();
    }

    public Integer getQtyReqUnit() {
        return qtyReqUnit;
    }

    public void setQtyReqUnit(Integer qtyReqUnit) {
        this.qtyReqUnit = qtyReqUnit;
    }

    public String getReqUnitStatistic() {
        return reqUnitStatistic;
    }

    public void setReqUnitStatistic(String reqUnitStatistic) {
        this.reqUnitStatistic = reqUnitStatistic == null ? null : reqUnitStatistic.trim();
    }

    public Integer getQtyInsUnit() {
        return qtyInsUnit;
    }

    public void setQtyInsUnit(Integer qtyInsUnit) {
        this.qtyInsUnit = qtyInsUnit;
    }

    public String getInsUnitStatistic() {
        return insUnitStatistic;
    }

    public void setInsUnitStatistic(String insUnitStatistic) {
        this.insUnitStatistic = insUnitStatistic == null ? null : insUnitStatistic.trim();
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

    public Integer getQtyAllReqUnit() {
        return qtyAllReqUnit;
    }

    public void setQtyAllReqUnit(Integer qtyAllReqUnit) {
        this.qtyAllReqUnit = qtyAllReqUnit;
    }

    public Integer getQtyAllInsUnit() {
        return qtyAllInsUnit;
    }

    public void setQtyAllInsUnit(Integer qtyAllInsUnit) {
        this.qtyAllInsUnit = qtyAllInsUnit;
    }

    public Integer getQtyYePay() {
        return qtyYePay;
    }

    public void setQtyYePay(Integer qtyYePay) {
        this.qtyYePay = qtyYePay;
    }

    public Double getIncomeYe() {
        return incomeYe;
    }

    public void setIncomeYe(Double incomeYe) {
        this.incomeYe = incomeYe;
    }

    public Double getIncomeWx() {
        return incomeWx;
    }

    public void setIncomeWx(Double incomeWx) {
        this.incomeWx = incomeWx;
    }

    public Double getIncomeZfb() {
        return incomeZfb;
    }

    public void setIncomeZfb(Double incomeZfb) {
        this.incomeZfb = incomeZfb;
    }

    public Double getIncomeCz() {
        return incomeCz;
    }

    public void setIncomeCz(Double incomeCz) {
        this.incomeCz = incomeCz;
    }

    public Double getRefundWxZfb() {
        return refundWxZfb;
    }

    public void setRefundWxZfb(Double refundWxZfb) {
        this.refundWxZfb = refundWxZfb;
    }

    public Double getRefundYe() {
        return refundYe;
    }

    public void setRefundYe(Double refundYe) {
        this.refundYe = refundYe;
    }

    public Double getRefundCz() {
        return refundCz;
    }

    public void setRefundCz(Double refundCz) {
        this.refundCz = refundCz;
    }

    public Integer getQtyCz() {
        return qtyCz;
    }

    public void setQtyCz(Integer qtyCz) {
        this.qtyCz = qtyCz;
    }

    public Integer getQtyCzUser() {
        return qtyCzUser;
    }

    public void setQtyCzUser(Integer qtyCzUser) {
        this.qtyCzUser = qtyCzUser;
    }

    public Double getIncomeOrder() {
        return incomeOrder;
    }

    public void setIncomeOrder(Double incomeOrder) {
        this.incomeOrder = incomeOrder;
    }

    public Double getFeeCheck() {
        return feeCheck;
    }

    public void setFeeCheck(Double feeCheck) {
        this.feeCheck = feeCheck;
    }

    public Double getFeePrint() {
        return feePrint;
    }

    public void setFeePrint(Double feePrint) {
        this.feePrint = feePrint;
    }

    public Double getFeeReport() {
        return feeReport;
    }

    public void setFeeReport(Double feeReport) {
        this.feeReport = feeReport;
    }

    public Double getFeeTakeSampling() {
        return feeTakeSampling;
    }

    public void setFeeTakeSampling(Double feeTakeSampling) {
        this.feeTakeSampling = feeTakeSampling;
    }

    public Double getFee1() {
        return fee1;
    }

    public void setFee1(Double fee1) {
        this.fee1 = fee1;
    }

    public Double getFee2() {
        return fee2;
    }

    public void setFee2(Double fee2) {
        this.fee2 = fee2;
    }

    public Double getFee3() {
        return fee3;
    }

    public void setFee3(Double fee3) {
        this.fee3 = fee3;
    }

    public Integer getQtyInsUser() {
        return qtyInsUser;
    }

    public void setQtyInsUser(Integer qtyInsUser) {
        this.qtyInsUser = qtyInsUser;
    }

    public String getInsUserStatistic() {
        return insUserStatistic;
    }

    public void setInsUserStatistic(String insUserStatistic) {
        this.insUserStatistic = insUserStatistic;
    }

    public Integer getFoodNum() {
        return foodNum;
    }

    public void setFoodNum(Integer foodNum) {
        this.foodNum = foodNum;
    }
}