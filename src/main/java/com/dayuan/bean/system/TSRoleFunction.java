package com.dayuan.bean.system;

import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 角色与权限关联表
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月2日
 */
public class TSRoleFunction extends BaseBean{

    private String functionId;  //菜单ID/操作权限ID

    private String roleId;		//角色ID

    private Short mark;			//权限标识: 0菜单，1操作按钮

    public String getFunctionId() {
        return functionId;
    }

    public void setFunctionId(String functionId) {
        this.functionId = functionId == null ? null : functionId.trim();
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
    }

    public Short getMark() {
        return mark;
    }

    public void setMark(Short mark) {
        this.mark = mark;
    }

}