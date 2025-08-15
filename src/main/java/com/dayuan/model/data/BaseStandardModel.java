package com.dayuan.model.data;

import com.dayuan.bean.data.BaseStandard;
import com.dayuan.model.BaseModel;
/**
 * 检测标准
 * @author Bill
 *
 * 2017年7月31日
 */
public class BaseStandardModel extends BaseModel {
	
	private String stdNameCode;	//关键词查询-标准编号、标准名称
	
    private BaseStandard baseBean;

	public BaseStandard getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(BaseStandard baseBean) {
		this.baseBean = baseBean;
	}

	public String getStdNameCode() {
		return stdNameCode;
	}

	public void setStdNameCode(String stdNameCode) {
		this.stdNameCode = stdNameCode;
	}

	
    
}