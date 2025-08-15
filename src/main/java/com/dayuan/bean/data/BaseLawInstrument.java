package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

/**
 * 执法仪Bean
 * @author LuoYX
 * @date 2018年8月13日
 */
public class BaseLawInstrument extends BaseBean2 {
	private String vehiIdno;
	private String devIdno;
	private Short online;
	private Date lastLoginDate;

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
