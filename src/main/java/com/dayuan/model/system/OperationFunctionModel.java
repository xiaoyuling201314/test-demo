package com.dayuan.model.system;


import com.dayuan.model.BaseModel;
/**
 * 菜单-功能
 * @author Bill
 *
 * 2017年8月11日
 */
public class OperationFunctionModel extends BaseModel {
	
	
	private String id; //

	private String functionName; //菜单名称
	
    private String functionId; //菜单id

    private String operationCode; //页面控件code

    private String operationName; //页面名字

    private Short status; //状态

    private String operationTitle;  //功能提示

    private Short sorting;  //排序

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getFunctionId() {
		return functionId;
	}

	public void setFunctionId(String functionId) {
		this.functionId = functionId;
	}

	public String getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}

	public String getOperationName() {
		return operationName;
	}

	public void setOperationName(String operationName) {
		this.operationName = operationName;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public String getOperationTitle() {
		return operationTitle;
	}

	public void setOperationTitle(String operationTitle) {
		this.operationTitle = operationTitle;
	}

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}
    



}