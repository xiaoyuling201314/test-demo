package com.dayuan.bean.dataCheck;

import java.io.Serializable;
import java.util.Date;

public class DataCheckRecordingAddendum implements Serializable {
    private Integer id;

    private Integer rid;

    private String operatorName;

    private String operatorPhone;

    private String operatorSign;

    private Date samplingDate;

    private String samplingUser;

    private String samplingPosition;

    private String samplingAddress;

    private Double samplingNumber;

    private Date purchaseDate;

    private Double purchaseAmount;

    private String supplier;

    private String supplierAddress;

    private String supplierPerson;

    private String supplierPhone;

    private String batchNumber;

    private String origin;

    private String checkWay;

    private String reagent;

    private String itemVulgo;

    private String aParam1;

    private String aParam2;

    private String aParam3;

    private static final long serialVersionUID = 1L;

    public DataCheckRecordingAddendum() {
    }

    public DataCheckRecordingAddendum(Integer rid, String operatorName, String operatorPhone, String operatorSign, Date samplingDate, String samplingUser, String samplingPosition, String samplingAddress, Double samplingNumber, Date purchaseDate, Double purchaseAmount, String supplier, String supplierAddress, String supplierPerson, String supplierPhone, String batchNumber, String origin, String checkWay, String reagent, String itemVulgo, String aParam1, String aParam2, String aParam3) {
        this.rid = rid;
        this.operatorName = operatorName;
        this.operatorPhone = operatorPhone;
        this.operatorSign = operatorSign;
        this.samplingDate = samplingDate;
        this.samplingUser = samplingUser;
        this.samplingPosition = samplingPosition;
        this.samplingAddress = samplingAddress;
        this.samplingNumber = samplingNumber;
        this.purchaseDate = purchaseDate;
        this.purchaseAmount = purchaseAmount;
        this.supplier = supplier;
        this.supplierAddress = supplierAddress;
        this.supplierPerson = supplierPerson;
        this.supplierPhone = supplierPhone;
        this.batchNumber = batchNumber;
        this.origin = origin;
        this.checkWay = checkWay;
        this.reagent = reagent;
        this.itemVulgo = itemVulgo;
        this.aParam1 = aParam1;
        this.aParam2 = aParam2;
        this.aParam3 = aParam3;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName == null ? null : operatorName.trim();
    }

    public String getOperatorPhone() {
        return operatorPhone;
    }

    public void setOperatorPhone(String operatorPhone) {
        this.operatorPhone = operatorPhone == null ? null : operatorPhone.trim();
    }

    public String getOperatorSign() {
        return operatorSign;
    }

    public void setOperatorSign(String operatorSign) {
        this.operatorSign = operatorSign == null ? null : operatorSign.trim();
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
        this.samplingUser = samplingUser == null ? null : samplingUser.trim();
    }

    public String getSamplingPosition() {
        return samplingPosition;
    }

    public void setSamplingPosition(String samplingPosition) {
        this.samplingPosition = samplingPosition == null ? null : samplingPosition.trim();
    }

    public String getSamplingAddress() {
        return samplingAddress;
    }

    public void setSamplingAddress(String samplingAddress) {
        this.samplingAddress = samplingAddress == null ? null : samplingAddress.trim();
    }

    public Double getSamplingNumber() {
        return samplingNumber;
    }

    public void setSamplingNumber(Double samplingNumber) {
        this.samplingNumber = samplingNumber;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Double getPurchaseAmount() {
        return purchaseAmount;
    }

    public void setPurchaseAmount(Double purchaseAmount) {
        this.purchaseAmount = purchaseAmount;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier == null ? null : supplier.trim();
    }

    public String getSupplierAddress() {
        return supplierAddress;
    }

    public void setSupplierAddress(String supplierAddress) {
        this.supplierAddress = supplierAddress == null ? null : supplierAddress.trim();
    }

    public String getSupplierPerson() {
        return supplierPerson;
    }

    public void setSupplierPerson(String supplierPerson) {
        this.supplierPerson = supplierPerson == null ? null : supplierPerson.trim();
    }

    public String getSupplierPhone() {
        return supplierPhone;
    }

    public void setSupplierPhone(String supplierPhone) {
        this.supplierPhone = supplierPhone == null ? null : supplierPhone.trim();
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber == null ? null : batchNumber.trim();
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin == null ? null : origin.trim();
    }

    public String getCheckWay() {
        return checkWay;
    }

    public void setCheckWay(String checkWay) {
        this.checkWay = checkWay == null ? null : checkWay.trim();
    }

    public String getReagent() {
        return reagent;
    }

    public void setReagent(String reagent) {
        this.reagent = reagent == null ? null : reagent.trim();
    }

    public String getItemVulgo() {
        return itemVulgo;
    }

    public void setItemVulgo(String itemVulgo) {
        this.itemVulgo = itemVulgo == null ? null : itemVulgo.trim();
    }

    public String getaParam1() {
        return aParam1;
    }

    public void setaParam1(String aParam1) {
        this.aParam1 = aParam1 == null ? null : aParam1.trim();
    }

    public String getaParam2() {
        return aParam2;
    }

    public void setaParam2(String aParam2) {
        this.aParam2 = aParam2 == null ? null : aParam2.trim();
    }

    public String getaParam3() {
        return aParam3;
    }

    public void setaParam3(String aParam3) {
        this.aParam3 = aParam3 == null ? null : aParam3.trim();
    }
}