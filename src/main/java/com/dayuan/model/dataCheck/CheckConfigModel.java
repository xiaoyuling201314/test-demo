package com.dayuan.model.dataCheck;


import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.model.BaseModel;


/**
 * 不合格处置
 * @author Bill
 *
 * 2017年7月28日
 */
public class CheckConfigModel extends BaseModel {
	
	private DataUnqualifiedConfig baseBean;

	public DataUnqualifiedConfig getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(DataUnqualifiedConfig baseBean) {
		this.baseBean = baseBean;
	}
	
	
}
