package com.dayuan.bean.system;

import java.util.List;

import com.dayuan.bean.BaseBean;
/**
 * 
 * Description: 系统菜单表t_s_function
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class TSFunction extends BaseBean {
   
    private String parentId;   //父菜单主键
   
    private Short functionFrame;   //菜单地址打开方式
    
    private Short functionLevel;  //菜单等级
    
    private String functionName;  //菜单名称
    
    private String functionIcon;  //菜单图标
    
    private Short sorting;  //排序
    
    private String functionUrl;  //URL
    
    private Short functionType;  //菜单类型 0:云平台 1:APP 2:工作站
    /**************非数据库字段*********************/
    private List<TSFunction> subMenu;  //子菜单集合
    
    private List<TSOperation> operationList;//操作权限集合
    
    private String parentStr;//父级菜单名称,用于编辑时显示
    
    private int subTotal;		//统计子菜单数量
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId == null ? null : parentId.trim();
    }

	public Short getFunctionFrame() {
        return functionFrame;
    }

    public void setFunctionFrame(Short functionFrame) {
        this.functionFrame = functionFrame;
    }

    public Short getFunctionLevel() {
        return functionLevel;
    }

    public void setFunctionLevel(Short functionLevel) {
        this.functionLevel = functionLevel;
    }

    public String getFunctionName() {
        return functionName;
    }

    public void setFunctionName(String functionName) {
        this.functionName = functionName == null ? null : functionName.trim();
    }

    public String getFunctionIcon() {
        return functionIcon;
    }

    public void setFunctionIcon(String functionIcon) {
        this.functionIcon = functionIcon == null ? null : functionIcon.trim();
    }

    public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}

	public String getFunctionUrl() {
        return functionUrl;
    }

    public void setFunctionUrl(String functionUrl) {
        this.functionUrl = functionUrl == null ? null : functionUrl.trim();
    }

    public Short getFunctionType() {
        return functionType;
    }

    public void setFunctionType(Short functionType) {
        this.functionType = functionType;
    }

    public List<TSFunction> getSubMenu() {
		return subMenu;
	}

	public void setSubMenu(List<TSFunction> subMenu) {
		this.subMenu = subMenu;
	}

	public String getParentStr() {
		return parentStr;
	}

	public void setParentStr(String parentStr) {
		this.parentStr = parentStr;
	}

	public int getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(int subTotal) {
		this.subTotal = subTotal;
	}

	public List<TSOperation> getOperationList() {
		return operationList;
	}

	public void setOperationList(List<TSOperation> operationList) {
		this.operationList = operationList;
	}
	
}