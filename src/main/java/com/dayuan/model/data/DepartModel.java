package com.dayuan.model.data;

import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.model.BaseModel;

public class DepartModel extends BaseModel {

	//部门的行政区域IDs: regionIds[0]=国,regionIds[1]=省,regionIds[2]=市,regionIds[3]=县
	private String[] regionIds;
	//当前机构
	private TSDepart depart;
	
	//上级机构
	private TSDepart superior;
	
	//负责人
	private BaseWorkers principal;

	public TSDepart getSuperior() {
		return superior;
	}

	public void setSuperior(TSDepart superior) {
		this.superior = superior;
	}

	public TSDepart getDepart() {
		return depart;
	}

	public void setDepart(TSDepart depart) {
		this.depart = depart;
	}

	public BaseWorkers getPrincipal() {
		return principal;
	}

	public void setPrincipal(BaseWorkers principal) {
		this.principal = principal;
	}

	public String[] getRegionIds() {
		return regionIds;
	}

	public void setRegionIds(String[] regionIds) {
		this.regionIds = regionIds;
	}
}
