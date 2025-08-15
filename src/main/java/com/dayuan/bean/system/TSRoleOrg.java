package com.dayuan.bean.system;

import com.dayuan.bean.BaseBean;

/**
 * 角色-机构 关系
 * @author Bill
 *
 * 2017年8月11日
 */
public class TSRoleOrg extends BaseBean {
   
    private String departId;  //机构id

    private String roleId;  //角色id

    public String getDepartId() {
        return departId;
    }

    public void setDepartId(String departId) {
        this.departId = departId == null ? null : departId.trim();
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
    }
}