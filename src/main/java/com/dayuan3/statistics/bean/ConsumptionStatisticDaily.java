package com.dayuan3.statistics.bean;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class ConsumptionStatisticDaily extends BaseBean2 {

    private Date date;

    private Integer userId;

    private String userName;

    private String userPhone;

    private Integer qtyOrder;

    private Integer qtyOrderDetails;

    private Double feeOrder;

    private Double fee1;

    private Double fee2;

    private Double fee3;

    private String param1;

    private String param2;

    private String param3;

    public ConsumptionStatisticDaily() {
    }

    public ConsumptionStatisticDaily(Date date, Integer userId, String userName, String userPhone, Integer qtyOrder, Integer qtyOrderDetails, Double feeOrder, Double fee1, Double fee2, Double fee3, String param1, String param2, String param3) {
        this.date = date;
        this.userId = userId;
        this.userName = userName;
        this.userPhone = userPhone;
        this.qtyOrder = qtyOrder;
        this.qtyOrderDetails = qtyOrderDetails;
        this.feeOrder = feeOrder;
        this.fee1 = fee1;
        this.fee2 = fee2;
        this.fee3 = fee3;
        this.param1 = param1;
        this.param2 = param2;
        this.param3 = param3;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone == null ? null : userPhone.trim();
    }

    public Integer getQtyOrder() {
        return qtyOrder;
    }

    public void setQtyOrder(Integer qtyOrder) {
        this.qtyOrder = qtyOrder;
    }

    public Integer getQtyOrderDetails() {
        return qtyOrderDetails;
    }

    public void setQtyOrderDetails(Integer qtyOrderDetails) {
        this.qtyOrderDetails = qtyOrderDetails;
    }

    public Double getFeeOrder() {
        return feeOrder;
    }

    public void setFeeOrder(Double feeOrder) {
        this.feeOrder = feeOrder;
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
}