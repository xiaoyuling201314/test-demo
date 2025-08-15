package com.dayuan3.admin.model.chain;

import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.chain.ColdChainUnit;
import com.dayuan.model.BaseModel;

/**
 * 经营单位
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月16日
 */
public class ColdChainUnitModel extends BaseModel {



	private ColdChainUnit chainUnit;
	//许可证
//	private BaseRegulatoryLicense regulatoryLicense;
	//经营者
	private InspectionUnit inspectionUnit;
	
	//当前用户机构ID
	private Integer departId;
	
	private String startTime;
	
	//当前用户机构code机构编码
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

	public ColdChainUnit getChainUnit() {
		return chainUnit;
	}

	public void setChainUnit(ColdChainUnit chainUnit) {
		this.chainUnit = chainUnit;
	}

	public InspectionUnit getInspectionUnit() {
		return inspectionUnit;
	}

	public void setInspectionUnit(InspectionUnit inspectionUnit) {
		this.inspectionUnit = inspectionUnit;
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
