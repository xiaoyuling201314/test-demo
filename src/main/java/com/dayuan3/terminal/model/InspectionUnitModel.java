package com.dayuan3.terminal.model;

import com.dayuan.model.BaseModel;

/**
 * 送样单位model
 * @author xiaoyl
 * @date   2019年7月1日
 */
public class InspectionUnitModel extends BaseModel {
	 /**
     * 送检单位类型：0企业，1个人
     */
	
	


    private Integer id ;
	private Integer coldUnitId;

	private String companyName;
	private String companyCode;
	private Short companyType;
	private String creditCode;
	private String legalPerson;
	private String legalPhone;
	private String companyAddress;
	private String linkUser;
	private String linkPhone;
	private String remark;
	private Short checked;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getColdUnitId(){return coldUnitId;}
	public void setColdUnitId(Integer coldUnitId){this.coldUnitId=coldUnitId;}


	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String  companyName) {
		this.companyName = companyName;
	}

	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String  companyCode) {
		this.companyCode= companyCode;
	}

    
	public Short getCompanyType() {
		return companyType;
	}

	public void setCompanyType(Short companyType) {
		this.companyType = companyType;
	}


	public String getCreditCode(){

		return creditCode;
	}
   	public void setCreditCode(String creditCode){this.creditCode=creditCode;}

	public String getLegalPerson() {
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

	public String getLegalPhone() {
		return legalPhone;
	}
	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone == null ? null : legalPhone.trim();
	}

	public String getLinkUser() {
		return linkUser;
	}
	public void setLinkUser(String linkUser) {
		this.linkUser = linkUser;
	}

	public String getLinkPhone() {
		return linkPhone;
	}
	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone == null ? null : linkPhone.trim();
	}

	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}


	public Short getChecked() {
		return checked;
	}
	public void setChecked(Short checked) {
		this.checked = checked;
	}

	public String getRemark(){ return remark;}
	public void setRemark(String remark){this.remark=remark;}
    
}