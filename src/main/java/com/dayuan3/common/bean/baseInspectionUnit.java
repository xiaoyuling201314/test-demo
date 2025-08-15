package com.dayuan3.common.bean;



/**
 * 送检单位
 * 
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class baseInspectionUnit {
	
	private Integer id;

	/**
	 * 送检单位名称/姓名
	 */
	private String companyName;

	 /**
     * 送检单位类型：0企业，1个人
     */
    private Short companyType;
 
	/**
	 * 社会信用代码/身份证号码
	 */
	private String creditCode;

	/**
	 * 法定代表人
	 */
	private String legalPerson;
	
	

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Short getCompanyType() {
		return companyType;
	}

	public void setCompanyType(Short companyType) {
		this.companyType = companyType;
	}

	public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}

	public String getLegalPerson() {
		return legalPerson;
	}

	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}

 

	 
	
}