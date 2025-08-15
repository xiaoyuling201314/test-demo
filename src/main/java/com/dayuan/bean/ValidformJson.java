package com.dayuan.bean;

/**
 * Validform实时验证
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年1月18日
 */
public class ValidformJson {
	
	private String info = "验证通过";	//验证信息
	
	private String status = "y";	//验证状态:y通过,n不通过
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
