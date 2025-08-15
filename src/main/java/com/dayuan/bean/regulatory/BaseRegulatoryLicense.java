package com.dayuan.bean.regulatory;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

public class BaseRegulatoryLicense extends BaseBean2 {
	
	//证件来源ID（监管对象，经营户）
    private Integer sourceId;
	//证件来源ID（监管对象，经营户）
    private String sourceType;
    //证件名称
    private String licenseName;
    //证件编号
    private String licenseCode;
    //证件类型
    private Short licenseType;
    //发证日期
    private Date licenseSdate;
    //有效期至
    private Date licenseEdate;
    //许可证图片
    private String licenseImage;
    //发证机关
    private String authority;
    //法人
    private String legalPerson;
    //法人身份证
    private String idcard;
    //注册资金
    private Double capital;
    //注册日期
    private Date licenseRdate;
    //经营范围
    private String scope;
    //审核状态
    private Short checked;
    
	public Integer getSourceId() {
		return sourceId;
	}
	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getLicenseName() {
		return licenseName;
	}
	public void setLicenseName(String licenseName) {
		this.licenseName = licenseName;
	}
	public String getLicenseCode() {
		return licenseCode;
	}
	public void setLicenseCode(String licenseCode) {
		this.licenseCode = licenseCode;
	}
	public Short getLicenseType() {
		return licenseType;
	}
	public void setLicenseType(Short licenseType) {
		this.licenseType = licenseType;
	}
	public Date getLicenseSdate() {
		return licenseSdate;
	}
	public void setLicenseSdate(Date licenseSdate) {
		this.licenseSdate = licenseSdate;
	}
	public Date getLicenseEdate() {
		return licenseEdate;
	}
	public void setLicenseEdate(Date licenseEdate) {
		this.licenseEdate = licenseEdate;
	}
	public String getLicenseImage() {
		return licenseImage;
	}
	public void setLicenseImage(String licenseImage) {
		this.licenseImage = licenseImage;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getLegalPerson() {
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Double getCapital() {
		return capital;
	}
	public void setCapital(Double capital) {
		this.capital = capital;
	}
	public Date getLicenseRdate() {
		return licenseRdate;
	}
	public void setLicenseRdate(Date licenseRdate) {
		this.licenseRdate = licenseRdate;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public Short getChecked() {
		return checked;
	}
	public void setChecked(Short checked) {
		this.checked = checked;
	}

}