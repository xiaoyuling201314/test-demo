package com.dayuan3.common.bean;

/**
 * 自助终端--查询所有委托单位
 * @author xiaoyl
 * @date   2019年7月23日
 */
public class TerminalRequestUnit {
	private Integer id; //食品id
	/**
	 * 委托单位名称
	 */
	private String requesterName;
	/**
	 * 联系人
	 */
	private String linkUser;

	/**
	 * 联系电话
	 */
	private String linkPhone;
	
	/**
	 * 委托单位首字母
     */
    private String requesterFirstLetter;

    /**
              * 委托单位全拼音
     */
    private String requesterFullLetter;
    

    /**
     * 委托单位别名
     */
    private String requesterOtherName;
    
    /**
     * 委托单位地址
     */
    private String companyAddress;
    

	public String getRequesterOtherName() {
		return requesterOtherName;
	}

	public void setRequesterOtherName(String requesterOtherName) {
		this.requesterOtherName = requesterOtherName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRequesterName() {
		return requesterName;
	}

	public void setRequesterName(String requesterName) {
		this.requesterName = requesterName;
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
		this.linkPhone = linkPhone;
	}

	public String getRequesterFirstLetter() {
		return requesterFirstLetter;
	}

	public void setRequesterFirstLetter(String requesterFirstLetter) {
		this.requesterFirstLetter = requesterFirstLetter;
	}

	public String getRequesterFullLetter() {
		return requesterFullLetter;
	}

	public void setRequesterFullLetter(String requesterFullLetter) {
		this.requesterFullLetter = requesterFullLetter;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	
}