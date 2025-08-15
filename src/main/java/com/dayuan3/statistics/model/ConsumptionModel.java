package com.dayuan3.statistics.model;

import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * 消费统计model
 *
 * @author Dz
 * @date 2020年03月17日
 */
public class ConsumptionModel extends BaseModel {

    private Integer id;

    private Date date;

    private Integer userId;

    private String userName;

    private String userPhone;

    private Integer qtyOrder;

    private Integer qtyOrderDetails;

    private Double feeOrder;

    /****************** 非表字段 *******************/

    private String type;
    private String year;
    private String month;
    private String season;
    private String start;
    private String end;

    private String identifiedNumber;//身份证号码
    private String companyName;// 单位名称
    private String userType;//用户类型： 0 个人，1 企业,2供应商
    private Short supplier = 0;//是否供应商用户：0否，1是


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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
        this.userName = userName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getIdentifiedNumber() {
        return identifiedNumber;
    }

    public void setIdentifiedNumber(String identifiedNumber) {
        this.identifiedNumber = identifiedNumber;
    }

    public String getCompanyName() {
        return "0".equals(this.userType) ? this.identifiedNumber : this.companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public Short getSupplier() {
        return supplier;
    }

    public void setSupplier(Short supplier) {
        this.supplier = supplier;
    }
}