package com.dayuan.model.system;

import java.util.List;

import com.dayuan.bean.system.TSFunction;
import com.dayuan.model.BaseModel;

/**
 * @Company: 食安科技
 * @author bill
 * @date 2017年8月7日
 */
public class RoleFunctionModel extends BaseModel {
	
	/**
	 * 菜单
	 */
	
	private String id;   //主键
	
    private String parentId;   //父菜单主键
    
    private Short functionFrame;   //菜单地址打开方式
    
    private Short functionLevel;  //菜单等级
    
    private String functionName;  //菜单名称
    
    private String functionIcon;  //菜单图标
    
    private Short sorting;  //排序
    
    private String functionUrl;  //URL
    
    private Short functionType;  //菜单类型
    
    
    
    /**
     * 关联表
     */
    private String functionId;  //菜单id

    private String roleId;		//角色id

    private String dataRule;	//数据权限规则ID

    private String operation;	//页面控件权限编码
    
    private List<RoleFunctionModel> subMenu;  //子菜单集合

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
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
		this.functionName = functionName;
	}

	public String getFunctionIcon() {
		return functionIcon;
	}

	public void setFunctionIcon(String functionIcon) {
		this.functionIcon = functionIcon;
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
		this.functionUrl = functionUrl;
	}

	public Short getFunctionType() {
		return functionType;
	}

	public void setFunctionType(Short functionType) {
		this.functionType = functionType;
	}




	public String getFunctionId() {
		return functionId;
	}

	

	public List<RoleFunctionModel> getSubMenu() {
		return subMenu;
	}

	public void setSubMenu(List<RoleFunctionModel> subMenu) {
		this.subMenu = subMenu;
	}

	public void setFunctionId(String functionId) {
		this.functionId = functionId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getDataRule() {
		return dataRule;
	}

	public void setDataRule(String dataRule) {
		this.dataRule = dataRule;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}
    
    
}