package com.dayuan.model.regulatory;

import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.model.BaseModel;

/**
 * 经营单位
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年9月11日
 */
public class BaseRegulatoryBusinessModel  extends BaseModel {
	
	//经营者
	private BaseRegulatoryBusiness regulatoryBusiness;
	
	//营业执照
	private BaseRegulatoryLicense regulatoryLicense;
	
	
	public BaseRegulatoryBusiness getRegulatoryBusiness() {
		return regulatoryBusiness;
	}
	public void setRegulatoryBusiness(BaseRegulatoryBusiness regulatoryBusiness) {
		this.regulatoryBusiness = regulatoryBusiness;
	}
	public BaseRegulatoryLicense getRegulatoryLicense() {
		return regulatoryLicense;
	}
	public void setRegulatoryLicense(BaseRegulatoryLicense regulatoryLicense) {
		this.regulatoryLicense = regulatoryLicense;
	}
	
}
