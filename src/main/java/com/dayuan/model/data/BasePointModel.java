package com.dayuan.model.data;

import java.util.List;

import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BasePointUser;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.model.BaseModel;

public class BasePointModel extends BaseModel {

	//检测点
	private BasePoint baseBean;

	//检测站
//	private BaseCar baseCar;
	
	//检测车
//	private BaseCentres baseCentres;
	
	//所属机构
	private TSDepart depart;
	
	//负责人
	private BaseWorkers baseWorkers;
	
	//检测点人员/检测机构人员
	private List<BasePointUser> pointUsers;
	
	private List<BaseRegulatoryObject> regs;
	private String map;//地图展示标识
	private Short signatureType;//电子签章配置：0 打印默认电子章，1自定义电子章，2 手动盖章
	
	private String signatureFile;//电子签章图片地址
	
	private String checkDepart;//检测机构
	
	private Integer IsQueryVideoS=0;//是否查询摄像头设备数量：0不查询，1 查询 add by xiaoyuling 2020-04-23 用户项目预览中直接查看监控视频
	
	private Integer IsQueryUnqualified=0;//是否查询检测点当天的不合格检测数：0不查询，1 查询 add by xiaoyuling 2020-08-28 用于项目预览中做预警提示作用
	
	public String getMap() {
		return map;
	}

	public void setMap(String map) {
		this.map = map;
	}
	
	public BasePoint getBaseBean() {
		return baseBean;
	}

	public BaseWorkers getBaseWorkers() {
		return baseWorkers;
	}

	public TSDepart getDepart() {
		return depart;
	}

	public void setDepart(TSDepart depart) {
		this.depart = depart;
	}

	public void setBaseWorkers(BaseWorkers baseWorkers) {
		this.baseWorkers = baseWorkers;
	}

	public void setBaseBean(BasePoint baseBean) {
		this.baseBean = baseBean;
	}

	public List<BasePointUser> getPointUsers() {
		return pointUsers;
	}

	public void setPointUsers(List<BasePointUser> pointUsers) {
		this.pointUsers = pointUsers;
	}

	public List<BaseRegulatoryObject> getRegs() {
		return regs;
	}

	public void setRegs(List<BaseRegulatoryObject> regs) {
		this.regs = regs;
	}

	public Integer getIsQueryVideoS() {
		return IsQueryVideoS;
	}

	public void setIsQueryVideoS(Integer isQueryVideoS) {
		IsQueryVideoS = isQueryVideoS;
	}

	public Short getSignatureType() {
		return signatureType;
	}

	public void setSignatureType(Short signatureType) {
		this.signatureType = signatureType;
	}

	public String getSignatureFile() {
		return signatureFile;
	}

	public void setSignatureFile(String signatureFile) {
		this.signatureFile = signatureFile;
	}

	public String getCheckDepart() {
		return checkDepart;
	}

	public void setCheckDepart(String checkDepart) {
		this.checkDepart = checkDepart;
	}

	public Integer getIsQueryUnqualified() {
		return IsQueryUnqualified;
	}

	public void setIsQueryUnqualified(Integer isQueryUnqualified) {
		IsQueryUnqualified = isQueryUnqualified;
	}
	
}
