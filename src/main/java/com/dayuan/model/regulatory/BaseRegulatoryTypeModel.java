package com.dayuan.model.regulatory;

import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.model.BaseModel;

/**
 * 经营单位
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年9月11日
 */
public class BaseRegulatoryTypeModel extends BaseModel {
	
	//监管对象类型
	private BaseRegulatoryType regulatoryType;

	public BaseRegulatoryType getRegulatoryType() {
		return regulatoryType;
	}

	public void setRegulatoryType(BaseRegulatoryType regulatoryType) {
		this.regulatoryType = regulatoryType;
	}
	
}
