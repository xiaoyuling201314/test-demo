package com.dayuan.bean.data;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

/**
 * 检测点表base_point Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class BasePoint extends BaseBean2 {
	private static final long serialVersionUID = 1L;

//	private Integer id;
	private String pointName; // 检测点名称

	private String pointCode; // 检测点编号

	private String pointType; // 检测点类型 0:检测站,1检测车

	private Integer departId; // 所属组织机构ID

	private String managerId; // 负责人ID

	private String phone; // 联系方式

	private Short sorting; // 排序

	private String regionId; // 地域ID

	private String licensePlate; // 车牌

	private String imei; // 定位设备IMEI

	private String address; // 地址

	private String placeX;// 坐标x

	private String placeY;// 坐标y

	private Integer mapDisplay;// 大屏地图检测室定位：0_隐藏,1_显示

	private String departName;// 机构名称

	private String workerName;// 用户名

	private Integer members;// 人员数

	private Integer device;// 设备数
	
	// add by Luo start
	//检测点性质ID => base_point_type.id
	private String pointTypeId;
	//市场、企业类型时 关联的监管对象ID => base_regulatory_object.id
	private String regulatoryId;
	// add by Luo end
	
	private Integer sampleDelivery;// 送样(0:不接受,1:接受)
	
	private Integer pointId;
	
	private Integer videoType;
	
	
	private Short signatureType=0;//电子签章配置：0 打印默认电子章，1自定义电子章，2 不添加电子章，手动盖章
	
	private String signatureFile;//电子签章图片地址
	
	private String checkDepart;//检测机构
	/*************************非数据库字段**************************************/
	
	private Integer vedioNumbers;//摄像头数量
	
	private Integer unqualifiedNumber;//检测点当天的不合格检测数

	private String regulatoryName;//监管对象名称

	private Integer checkNumber;//检测数量

	/**
	 * 在线状态：0 离线，1在线，-1设备号异常
	 */
	private Short onlineStatus;
	/**
	 * 最后一次状态的同步时间
	 */
	private Date syncStatusDate;
	/**
	 *存储类型：0 无，1 TF内存卡，2 云存储
	 */
	private Short storageType;

	public Integer getVideoType() {
		return videoType;
	}

	public void setVideoType(Integer videoType) {
		this.videoType = videoType;
	}

	public Integer getPointId() {
		return pointId;
	}

	public void setPointId(Integer pointId) {
		this.pointId = pointId;
	}

	public String getWorkerName() {
		return workerName;
	}

	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}

	public Integer getMembers() {
		return members;
	}

	public void setMembers(Integer members) {
		this.members = members;
	}

	public Integer getDevice() {
		return device;
	}

	public void setDevice(Integer device) {
		this.device = device;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName == null ? null : pointName.trim();
	}

	public String getPointCode() {
		return pointCode;
	}

	public void setPointCode(String pointCode) {
		this.pointCode = pointCode == null ? null : pointCode.trim();
	}

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType == null ? null : pointType.trim();
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId == null ? null : managerId.trim();
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone == null ? null : phone.trim();
	}

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}

	public String getRegionId() {
		return regionId;
	}

	public void setRegionId(String regionId) {
		this.regionId = regionId;
	}

	public String getLicensePlate() {
		return licensePlate;
	}

	public void setLicensePlate(String licensePlate) {
		this.licensePlate = licensePlate;
	}

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPlaceX() {
		return placeX;
	}

	public void setPlaceX(String placeX) {
		this.placeX = placeX;
	}

	public String getPlaceY() {
		return placeY;
	}

	public void setPlaceY(String placeY) {
		this.placeY = placeY;
	}

	public String getPointTypeId() {
		return pointTypeId;
	}

	public void setPointTypeId(String pointTypeId) {
		this.pointTypeId = pointTypeId;
	}

	public String getRegulatoryId() {
		return regulatoryId;
	}

	public void setRegulatoryId(String regulatoryId) {
		this.regulatoryId = regulatoryId;
	}

	public Integer getSampleDelivery() {
		return sampleDelivery;
	}

	public void setSampleDelivery(Integer sampleDelivery) {
		this.sampleDelivery = sampleDelivery;
	}

	public Integer getVedioNumbers() {
		return vedioNumbers;
	}

	public void setVedioNumbers(Integer vedioNumbers) {
		this.vedioNumbers = vedioNumbers;
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

	public Integer getUnqualifiedNumber() {
		return unqualifiedNumber;
	}

	public void setUnqualifiedNumber(Integer unqualifiedNumber) {
		this.unqualifiedNumber = unqualifiedNumber;
	}

	public String getRegulatoryName() {
		return regulatoryName;
	}

	public void setRegulatoryName(String regulatoryName) {
		this.regulatoryName = regulatoryName;
	}

	public Integer getCheckNumber() {
		return checkNumber;
	}

	public void setCheckNumber(Integer checkNumber) {
		this.checkNumber = checkNumber;
	}

	public Short getOnlineStatus() {
		return onlineStatus;
	}

	public void setOnlineStatus(Short onlineStatus) {
		this.onlineStatus = onlineStatus;
	}

	public Date getSyncStatusDate() {
		return syncStatusDate;
	}

	public void setSyncStatusDate(Date syncStatusDate) {
		this.syncStatusDate = syncStatusDate;
	}

	public Short getStorageType() {
		return storageType;
	}

	public void setStorageType(Short storageType) {
		this.storageType = storageType;
	}

	public Integer getMapDisplay() {
		return mapDisplay;
	}

	public void setMapDisplay(Integer mapDisplay) {
		this.mapDisplay = mapDisplay;
	}
}