package com.dayuan.bean.data;

import com.dayuan.bean.BaseBean;

import java.util.Date;

/**
 * 人员表base_workers
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月18日
 */
public class BaseWorkers extends BaseBean {

    private String workerName;            //姓名

    private Short gender;                //性别：0=男，1=女

    private Integer departId;            //组织机构id

    private Integer pointId;                //检测点ID

    private String position;            //职位

    private Short status;                //状态：0=在任，1=离职

    private String mobilePhone;            //手机号

    private String officePhone;            //办公座机

    private String signatureFile;        //签名文件

    private String wechat;                //微信号

    private String email;                //邮箱

    private String address;                //通讯地址

    private String reserved1;            //预留字段1

    private String reserved2;            //预留字段2

    private String reserved3;            //预留字段3

    private String reserved4;            //预留字段4

    private String reserved5;            //预留字段5

    private String jobState;             //是否正式员工

    private String idNumber;             //证件号码

    private String departNameStr;         //所属机构

    private String pointNameStr;          //所属检测点


    public String getDepartNameStr() {
        return departNameStr;
    }

    public void setDepartNameStr(String departNameStr) {
        this.departNameStr = departNameStr;
    }

    public String getPointNameStr() {
        return pointNameStr;
    }

    public void setPointNameStr(String pointNameStr) {
        this.pointNameStr = pointNameStr;
    }

    /***********************非数据库字段，用于页面显示*******************************/
    //用户名所属检测点字符串
    private String pointsNameStr;

    private Date startDate;//项目开始周期

    private Date endDate;//项目结束周期

    private String projectName;//项目名称

    private String pointName;//检测点名称

    public String getJobState() {
        return jobState;
    }

    public void setJobState(String jobState) {
        this.jobState = jobState;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName == null ? null : workerName.trim();
    }

    public Short getGender() {
        return gender;
    }

    public void setGender(Short gender) {
        this.gender = gender;
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone == null ? null : mobilePhone.trim();
    }

    public String getOfficePhone() {
        return officePhone;
    }

    public void setOfficePhone(String officePhone) {
        this.officePhone = officePhone == null ? null : officePhone.trim();
    }

    public String getSignatureFile() {
        return signatureFile;
    }

    public void setSignatureFile(String signatureFile) {
        this.signatureFile = signatureFile == null ? null : signatureFile.trim();
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat == null ? null : wechat.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getReserved1() {
        return reserved1;
    }

    public void setReserved1(String reserved1) {
        this.reserved1 = reserved1 == null ? null : reserved1.trim();
    }

    public String getReserved2() {
        return reserved2;
    }

    public void setReserved2(String reserved2) {
        this.reserved2 = reserved2 == null ? null : reserved2.trim();
    }

    public String getReserved3() {
        return reserved3;
    }

    public void setReserved3(String reserved3) {
        this.reserved3 = reserved3 == null ? null : reserved3.trim();
    }

    public String getReserved4() {
        return reserved4;
    }

    public void setReserved4(String reserved4) {
        this.reserved4 = reserved4 == null ? null : reserved4.trim();
    }

    public String getReserved5() {
        return reserved5;
    }

    public void setReserved5(String reserved5) {
        this.reserved5 = reserved5 == null ? null : reserved5.trim();
    }

    public String getPointsNameStr() {
        return pointsNameStr;
    }

    public void setPointsNameStr(String pointsNameStr) {
        this.pointsNameStr = pointsNameStr;
    }

}