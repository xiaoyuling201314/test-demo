package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean;

public class BaseLawsRegulations extends BaseBean {

    private String lawName;		//法律名称

    private String lawType;		//类型

    private String lawUnit;		//发布单位

    private String lawNum;		//发布文号

    private String lawStatus;	//状态

    private String lawNotes;	//说明

    private Date relDate;		//发布日期

    private Date impDate;		//实施日期

    private Date failureDate;	//失效日期

    private String urlPath;		//下载路径

    private Short useStatus;	//项目使用状态0：未使用，1：使用

    public String getLawName() {
        return lawName;
    }

    public void setLawName(String lawName) {
        this.lawName = lawName == null ? null : lawName.trim();
    }

    public String getLawType() {
        return lawType;
    }

    public void setLawType(String lawType) {
        this.lawType = lawType == null ? null : lawType.trim();
    }

    public String getLawUnit() {
        return lawUnit;
    }

    public void setLawUnit(String lawUnit) {
        this.lawUnit = lawUnit == null ? null : lawUnit.trim();
    }

    public String getLawNum() {
        return lawNum;
    }

    public void setLawNum(String lawNum) {
        this.lawNum = lawNum == null ? null : lawNum.trim();
    }

    public String getLawStatus() {
        return lawStatus;
    }

    public void setLawStatus(String lawStatus) {
        this.lawStatus = lawStatus == null ? null : lawStatus.trim();
    }

    public String getLawNotes() {
        return lawNotes;
    }

    public void setLawNotes(String lawNotes) {
        this.lawNotes = lawNotes == null ? null : lawNotes.trim();
    }

    public Date getRelDate() {
        return relDate;
    }

    public void setRelDate(Date relDate) {
        this.relDate = relDate;
    }

    public Date getImpDate() {
        return impDate;
    }

    public void setImpDate(Date impDate) {
        this.impDate = impDate;
    }

    public Date getFailureDate() {
        return failureDate;
    }

    public void setFailureDate(Date failureDate) {
        this.failureDate = failureDate;
    }

    public String getUrlPath() {
        return urlPath;
    }

    public void setUrlPath(String urlPath) {
        this.urlPath = urlPath == null ? null : urlPath.trim();
    }

    public Short getUseStatus() {
        return useStatus;
    }

    public void setUseStatus(Short useStatus) {
        this.useStatus = useStatus;
    }

}