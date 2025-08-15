package com.dayuan.bean.system;

import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 操作权限t_s_operation
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月31日
 */
public class TSOperation extends BaseBean{

    private String functionId;		//关联菜单ID

    private String operationCode;	//页面控件code

    private String operationName;	//功能名称

    private Short sorting;			//排序
    
    private String functionIcon; 	//图标

    private String functionUrl ; //菜单URL
    public String getFunctionId() {
        return functionId;
    }

    public void setFunctionId(String functionId) {
        this.functionId = functionId == null ? null : functionId.trim();
    }

    public String getOperationCode() {
        return operationCode;
    }

    public void setOperationCode(String operationCode) {
        this.operationCode = operationCode == null ? null : operationCode.trim();
    }

    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName == null ? null : operationName.trim();
    }

    public Short getSorting() {
        return sorting;
    }

    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

	public String getFunctionIcon() {
		return functionIcon;
	}

	public void setFunctionIcon(String functionIcon) {
		this.functionIcon = functionIcon;
	}

	public String getFunctionUrl() {
		return functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl;
	}
    
}