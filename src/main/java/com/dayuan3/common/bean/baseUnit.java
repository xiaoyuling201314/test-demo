package com.dayuan3.common.bean;


public class baseUnit {
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
	
}