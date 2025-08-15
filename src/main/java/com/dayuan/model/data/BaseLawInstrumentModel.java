package com.dayuan.model.data;

import java.util.Date;

import com.dayuan.model.BaseModel;
/**
 * 执法仪Model
 * @author LuoYX
 * @date 2018年8月13日
 */
public class BaseLawInstrumentModel extends BaseModel {
	private Integer id;
	private String vehiIdno;
	private String devIdno;
	private Short online;
	private Date lastLoginDate;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getVehiIdno() {
		return vehiIdno;
	}
	public void setVehiIdno(String vehiIdno) {
		this.vehiIdno = vehiIdno;
	}
	public String getDevIdno() {
		return devIdno;
	}
	public void setDevIdno(String devIdno) {
		this.devIdno = devIdno;
	}
	public Short getOnline() {
		return online;
	}
	public void setOnline(Short online) {
		this.online = online;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
}
