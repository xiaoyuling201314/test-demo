package com.dayuan.bean.regulatory;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

public class BaseRegulatoryPersonnel extends BaseBean2 {
    //监管对象ID
	private Integer regId;
	//人员名称
    private String name;
    //职称
    private String jobTitle;
    //身份证号
    private String idcard;
    //联系方式
    private String phone;
    //健康证编号
    private String proofCode;
    //健康证发证日期
    private Date proofSdate;
    //健康证有效期至
    private Date proofEdate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle == null ? null : jobTitle.trim();
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard == null ? null : idcard.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getProofCode() {
        return proofCode;
    }

    public void setProofCode(String proofCode) {
        this.proofCode = proofCode == null ? null : proofCode.trim();
    }

    public Date getProofSdate() {
        return proofSdate;
    }

    public void setProofSdate(Date proofSdate) {
        this.proofSdate = proofSdate;
    }

    public Date getProofEdate() {
        return proofEdate;
    }

    public void setProofEdate(Date proofEdate) {
        this.proofEdate = proofEdate;
    }

    public Short getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public Short getSorting() {
        return sorting;
    }

    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }
}