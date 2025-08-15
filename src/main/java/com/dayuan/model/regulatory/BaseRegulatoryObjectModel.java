package com.dayuan.model.regulatory;

import java.util.Date;

import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.model.BaseModel;

/**
 * 经营单位
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月16日
 */
public class BaseRegulatoryObjectModel extends BaseModel {
	
	//监管对象
	private BaseRegulatoryObject regulatoryObject;
	//许可证
//	private BaseRegulatoryLicense regulatoryLicense;
	//经营者
	private BaseRegulatoryBusiness regulatoryBusiness;
	
	//当前用户机构ID
	private Integer departId;
	
	private String startTime;
	
	//当前用户机构code
	private String departCode;
	private String map;//地图展示标识
	private Integer IsQueryUnqualified=0;//是否查询监管对象当天的不合格检测数：0不查询，1 查询 add by xiaoyuling 2020-08-28 用于项目预览中做预警提示作用
	
	
	public String getMap() {
		return map;
	}

	public void setMap(String map) {
		this.map = map;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public BaseRegulatoryObject getRegulatoryObject() {
		return regulatoryObject;
	}

	public void setRegulatoryObject(BaseRegulatoryObject regulatoryObject) {
		this.regulatoryObject = regulatoryObject;
	}

	public BaseRegulatoryBusiness getRegulatoryBusiness() {
		return regulatoryBusiness;
	}

	public void setRegulatoryBusiness(BaseRegulatoryBusiness regulatoryBusiness) {
		this.regulatoryBusiness = regulatoryBusiness;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public Integer getIsQueryUnqualified() {
		return IsQueryUnqualified;
	}

	public void setIsQueryUnqualified(Integer isQueryUnqualified) {
		IsQueryUnqualified = isQueryUnqualified;
	}
	 
}
