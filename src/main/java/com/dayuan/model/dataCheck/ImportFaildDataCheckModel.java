package com.dayuan.model.dataCheck;

import com.dayuan.controller.dataCheck.ImportDataCheckController;

import java.util.List;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2021-10-26 8:56
 */
public class ImportFaildDataCheckModel {
    public static String[] headers = {"检测点名称", "被检单位", "档口编号", "样品名称", "检测项目", "限定值", "检测值",
            "检测结论", "检测人员", "检测时间", "审核人员姓名", "上报人员姓名", "检测设备名称", "检测模块", "检测方法", "仪器生产厂家", "备注", "导入失败原因"};
    public static String[] fields = {"pointName", "regName", "regUserName", "foodName", "ckItem", "liValue", "ckResult",
            "conclusion", "ckUser", "ckDate", "auditor", "upUser", "deviceName", "modul", "method", "deviceComp", "remark", "errMsg"};
    String errMsg;
    String pointName;//检测点名称(必填)
    String regName;//被检单位(必填)
    String regUserName;//档口编号(必填)
    String foodName;//样品名称(必填)
    String ckItem;//检测项目(必填)
    String liValue;//限定值
    String ckResult;//检测值(必填)
    String conclusion;//检测结论(必填)
    String ckUser;//检测人员(必填)
    String ckDate;//检测时间(必填)
    String auditor;//审核人员姓名
    String upUser;//上报人员姓名
    String deviceName;//检测设备名称
    String modul;//检测模块
    String method;//检测方法
    String deviceComp;//仪器生产厂家
    String remark;//备注

    private void addToProblems(List<ImportFaildDataCheckModel> problems, String pointName, String regName, String regUserName, String foodName, String ckItem, String liValue, String ckResult,
                               String conclusion, String ckUser, String ckDate, String auditor, String upUser, String deviceName, String modul, String method, String deviceComp, String remark, String errMsg) {
        ImportFaildDataCheckModel r = new ImportFaildDataCheckModel();
        r.setPointName(pointName);
        r.setRegName(regName);
        r.setRegUserName(regUserName);
        r.setFoodName(foodName);
        r.setCkItem(ckItem);
        r.setCkResult(ckResult);
        r.setLiValue(liValue);
        r.setConclusion(conclusion);
        r.setCkUser(ckUser);
        r.setCkDate(ckDate);
        r.setAuditor(auditor);
        r.setUpUser(upUser);
        r.setDeviceName(deviceName);
        r.setModul(modul);
        r.setMethod(method);
        r.setDeviceComp(deviceComp);
        r.setRemark(remark);
        r.setErrMsg(errMsg);
        problems.add(r);
    }

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }

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

    public String getCkResult() {
        return ckResult;
    }

    public void setCkResult(String ckResult) {
        this.ckResult = ckResult;
    }

    public String getLiValue() {
        return liValue;
    }

    public void setLiValue(String liValue) {
        this.liValue = liValue;
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
