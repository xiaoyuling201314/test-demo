package com.dayuan.bean.system;

import com.dayuan.bean.BaseBean;

public class TSRole extends BaseBean {

    private String rolename; //角色名字

    private Short status; //状态 0使用 1停用
    
    private Short sorting;//排序字段
    
    private String childrenId;//子角色ID
    
    public String getChildrenId() {
		return childrenId;
	}

	public void setChildrenId(String childrenId) {
		this.childrenId = childrenId;
	}

	public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename == null ? null : rolename.trim();
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}
    
}