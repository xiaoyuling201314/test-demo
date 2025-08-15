package com.dayuan.model.system;

import com.dayuan.bean.system.TSRole;
import com.dayuan.model.BaseModel;

/**
 * 用户角色
 * @author Bill
 *
 * 2017年8月9日
 */
public class TSRoleModel extends BaseModel {

	private TSRole baseBean;

	private  String[] roleIds;//角色ID

	public TSRole getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(TSRole baseBean) {
		this.baseBean = baseBean;
	}

	public String[] getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String[] roleIds) {
		this.roleIds = roleIds;
	}
}