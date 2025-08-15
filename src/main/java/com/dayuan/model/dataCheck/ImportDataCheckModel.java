package com.dayuan.model.dataCheck;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.metadata.BaseRowModel;

/**
 * @Description 检测数据导入对应对象
 * @Author xiaoyl
 * @Date 2021-10-25 15:36
 */
public class ImportDataCheckModel{
    public ImportDataCheckModel() {
    }

    public ImportDataCheckModel(String pointName, String regName, String regUserName, String foodName, String ckItem, String liValue, String ckResult, String conclusion, String ckUser, String ckDate, String auditor, String upUser, String deviceName, String modul, String method, String deviceComp, String remark) {
        this.pointName = pointName;
        this.regName = regName;
        this.regUserName = regUserName;
        this.foodName = foodName;
        this.ckItem = ckItem;
        this.liValue = liValue;
        this.ckResult = ckResult;
        this.conclusion = conclusion;
        this.ckUser = ckUser;
        this.ckDate = ckDate;
        this.auditor = auditor;
        this.upUser = upUser;
        this.deviceName = deviceName;
        this.modul = modul;
        this.method = method;
        this.deviceComp = deviceComp;
        this.remark = remark;
    }

    @ExcelProperty(value = "检测点名称",index = 0)
    String pointName; //检测点名称(必填)
    @ExcelProperty(value = "被检单位",index = 1)
    String regName;//被检单位(必填)
    @ExcelProperty(value = "档口编号",index = 2)
    String regUserName;//档口编号(必填)
    @ExcelProperty(value = "样品名称",index = 3)
    String foodName;//样品名称(必填)
    @ExcelProperty(value = "检测项目",index = 4)
    String ckItem;//检测项目(必填)
    @ExcelProperty(value = "限定值",index =5)
    String liValue;//限定值
    @ExcelProperty(value = "检测值",index = 6)
    String ckResult;//检测值(必填)
    @ExcelProperty(value = "检测结论",index = 7)
    String conclusion;//检测结论(必填)
    @ExcelProperty(value = "检测人员",index = 8)
    String ckUser;//检测人员(必填)
    @ExcelProperty(value = "检测时间",index = 9)
    String ckDate;//检测时间(必填)
    @ExcelProperty(value = "审核人员姓名",index = 10)
    String auditor;//审核人员姓名
    @ExcelProperty(value = "上报人员姓名",index = 11)
    String upUser;//上报人员姓名
    @ExcelProperty(value = "检测设备名称",index = 12)
    String deviceName;//检测设备名称
    @ExcelProperty(value = "检测模块",index = 13)
    String modul;//检测模块
    @ExcelProperty(value = "检测方法",index = 14)
    String method;//检测方法
    @ExcelProperty(value = "仪器生产厂家",index = 15)
    String deviceComp;//仪器生产厂家
    @ExcelProperty(value = "备注",index = 16)
    String remark;//备注

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getRegUserName() {
        return regUserName;
    }

    public void setRegUserName(String regUserName) {
        this.regUserName = regUserName;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getCkItem() {
        return ckItem;
    }

    public void setCkItem(String ckItem) {
        this.ckItem = ckItem;
    }

    public String getLiValue() {
        return liValue;
    }

    public void setLiValue(String liValue) {
        this.liValue = liValue;
    }

    public String getCkResult() {
        return ckResult;
    }

    public void setCkResult(String ckResult) {
        this.ckResult = ckResult;
    }

    public String getConclusion() {
        return conclusion;
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }

    public String getCkUser() {
        return ckUser;
    }

    public void setCkUser(String ckUser) {
        this.ckUser = ckUser;
    }

    public String getCkDate() {
        return ckDate;
    }

    public void setCkDate(String ckDate) {
        this.ckDate = ckDate;
    }

    public String getAuditor() {
        return auditor;
    }

    public void setAuditor(String auditor) {
        this.auditor = auditor;
    }

    public String getUpUser() {
        return upUser;
    }

    public void setUpUser(String upUser) {
        this.upUser = upUser;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getModul() {
        return modul;
    }

    public void setModul(String modul) {
        this.modul = modul;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getDeviceComp() {
        return deviceComp;
    }

    public void setDeviceComp(String deviceComp) {
        this.deviceComp = deviceComp;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
