package com.dayuan.bean.system;

import com.dayuan.bean.BaseBean;

/**
 * 角色-用户 关系
 * @author Bill
 *
 * 2017年8月11日
 */
public class TSRoleUser extends BaseBean {

    private String roleId;  //角色id

    private String userId;  //系统用户id

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }
}