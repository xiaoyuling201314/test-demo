package com.dayuan.model.dataCheck;

import java.util.Date;
import java.util.List;

import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.model.BaseModel;


/**
 * 检测数据记录
 * @author Bill
 *
 * 2017年7月28日
 */
public class DataCheckRecordingModel extends BaseModel {
	
	private DataCheckRecording bean;
	
	private Integer pointId;  //检测点id

    private String pointName;  //检测点名称
    
    private int num;//每个检测点下所有的检测结果数量
    
    private int qualified;//合格数量
    
    private int unqualified;//不合格数量
    
    private String itemId;//检测项目id
    
    private String itemName;//检测项目名字
    
    private int foodId;//食品种类id
    
    private String foodName;//食品种类名称
    
    private Integer regId;//被检单位id
    
    private String regName;//被检单位名称
    
    private String checkCode;  //检测编号
    
    private Integer taskId;
    
    private String taskName;

    private String samplingId;  //抽样单id

    private String samplingDetailId;  //抽样明细id
    
    private String foodTypeId;
    
    private String foodTypeName;
    
    private Integer regUserId;
    
    private String regUserName;
    
    private Integer departId;
    
    private String departName;

    private String checkUserid;  //检测人员id

    private String checkUsername;  //检测人员名称
    
    private String auditorId;
    
    private String auditorName;
    
    private String uploadId;
    
    private String uploadName;
    
    private Date uploadDate;

    private Date checkDate;  //检测时间

    private String checkAccordId;	//检测依据id
    
    private String checkAccord;  //检测依据

    private String deviceId;  //检测仪器id

    private String deviceName;  //检测仪器名称

    private String limitValue;  //限定值

    private String checkResult;  //检测结果(检测值)

    private String checkUnit;  //检测结果单位

    private String conclusion;  //检测结论
    
    private String deviceMethod;//检测方法
    
    private String deviceModel;	//检测模块
    
    private String deviceCompany;	//仪器厂家
    
    private Short reloadFlag;	//重传标志：0未重传，1重传
    
    private Short dataSource;  //数据来源 0检测工作站，1监管通app，2.仪器上传,3平台上传，4导入
    
    private Short statusFalg;	//状态：0为未审核，1为已审核
    
    private String type;//查询类型,月,季度,年,自定义
    
    private String month;//月份
    
    private String season;//季节
    
    private String year;//年
    
    private String start;//自定义时间的开始时间
    
    private String end;//自定义时间的结束时间
    
    private Short dataType;//0 抽样检测数据 ,1送样检测数据 
    private String date;
    
    private Integer[] departArr; //条件集合
    private Integer[] pointArr; //条件集合
    private List<Integer> foodList;//食品ID集合
    private List<Integer> departList;//机构ID集合
    private List<Integer> childDepartList;//机构ID集合

	private List<Integer> departListForStatist;//检测项目统计/食品名称统计中使用，传入所选机构下的字机构ID

    private String opeShopName;
    
    private Date checkDateStartDate;//开始时间
    
    private Date checkDateEndDate;//结束时间
    
    private String typeObj;//监管对象类型
    
    //非数据库字段
    private String time;//日期
    
    private String checkName;//数据报表，检测数据分析字段

	private String pointType;//检测点类型 "" 全部，0 政府检测室，1 检测车，2 企业检测室

	private double purchaseAmount;//抽样基数，汇总抽样明细的进货数量 add by xiaoyl 2020/11/17

	private double destoryNumber;//销毁数量，汇总不合格处理的销毁或下架数量 add by xiaoyl 2020/11/17

	private String unqualifiedFood;//阳性样品 add by xiaoyl 2020/11/17

	private String areaDepartName;//地市名称 add by xiaoyl 2021/03/05

	/**
	 * 单位统计-检测点总数
	 */
	private Integer jcdpn;
	/**
	 * 单位统计-政府检测室总数
	 */
	private Integer zfpn;
	/**
	 * 单位统计-企业检测室总数
	 */
	private Integer qypn;
	/**
	 * 单位统计-快检车总数
	 */
	private Integer carpn;
	/**
	 * 单位统计-政府检测量
	 */
	private Integer zfnum;
	/**
	 * 单位统计-企业检测量
	 */
	private Integer qynum;
	/**
	 * 单位统计-快检车检测量
	 */
	private Integer carnum;
	/**
	 * 单位统计-政府检测室不合格数量
	 */
	private Integer zfun;
	/**
	 * 单位统计-企业检测室不合格数量
	 */
	private Integer qyun;
	/**
	 * 单位统计-快检车不合格数量
	 */
	private Integer carun;
	/**
	 * 监管对象任务类型: 0无， 1省级、2市级、3县级、4街镇
	 */
	private Short taskType;
	/**
	 * 查看类型：-1 总数，0 有效数，1 无效数量
	 */
	private Integer queryType;
	/**
	 * 是否造假：0 否，1 是
	 */
	private Integer faking;
	/**
	 * 不合格处理状态：0不查询，1未处理，2已处理，3处置不当
	 */
	private Integer dealFlag;
	/**
	 * 季度：阿拉伯数据表示
	 */
	private Integer seasonNumber;

	private String departCode;//所属机构Code编码

	private Integer sorting;//排序字段

	public List<Integer> getChildDepartList() {
		return childDepartList;
	}

	public void setChildDepartList(List<Integer> childDepartList) {
		this.childDepartList = childDepartList;
	}

	public List<Integer> getFoodList() {
		return foodList;
	}

	public void setFoodList(List<Integer> foodList) {
		this.foodList = foodList;
	}

	public List<Integer> getDepartList() {
		return departList;
	}

	public void setDepartList(List<Integer> departList) {
		this.departList = departList;
	}

	public String getCheckName() {
		return checkName;
	}

	public void setCheckName(String checkName) {
		this.checkName = checkName;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
    
	public String getTypeObj() {
		return typeObj;
	}

	public void setTypeObj(String typeObj) {
		this.typeObj = typeObj;
	}

	public Date getCheckDateStartDate() {
		return checkDateStartDate;
	}

	public void setCheckDateStartDate(Date checkDateStartDate) {
		this.checkDateStartDate = checkDateStartDate;
	}

	public Date getCheckDateEndDate() {
		return checkDateEndDate;
	}

	public void setCheckDateEndDate(Date checkDateEndDate) {
		this.checkDateEndDate = checkDateEndDate;
	}

	public String getOpeShopName() {
		return opeShopName;
	}

	public void setOpeShopName(String opeShopName) {
		this.opeShopName = opeShopName;
	}

	public Integer[] getDepartArr() {
		return departArr;
	}

	public void setDepartArr(Integer[] departArr) {
		this.departArr = departArr;
	}

	public Integer[] getPointArr() {
		return pointArr;
	}

	public void setPointArr(Integer[] pointArr) {
		this.pointArr = pointArr;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getSamplingId() {
		return samplingId;
	}

	public void setSamplingId(String samplingId) {
		this.samplingId = samplingId;
	}

	public String getSamplingDetailId() {
		return samplingDetailId;
	}

	public void setSamplingDetailId(String samplingDetailId) {
		this.samplingDetailId = samplingDetailId;
	}

	public String getFoodTypeId() {
		return foodTypeId;
	}

	public void setFoodTypeId(String foodTypeId) {
		this.foodTypeId = foodTypeId;
	}

	public String getFoodTypeName() {
		return foodTypeName;
	}

	public void setFoodTypeName(String foodTypeName) {
		this.foodTypeName = foodTypeName;
	}

	public Integer getRegUserId() {
		return regUserId;
	}

	public void setRegUserId(Integer regUserId) {
		this.regUserId = regUserId;
	}

	public String getRegUserName() {
		return regUserName;
	}

	public void setRegUserName(String regUserName) {
		this.regUserName = regUserName;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getCheckUserid() {
		return checkUserid;
	}

	public void setCheckUserid(String checkUserid) {
		this.checkUserid = checkUserid;
	}

	public String getCheckUsername() {
		return checkUsername;
	}

	public void setCheckUsername(String checkUsername) {
		this.checkUsername = checkUsername;
	}

	public String getAuditorId() {
		return auditorId;
	}

	public void setAuditorId(String auditorId) {
		this.auditorId = auditorId;
	}

	public String getAuditorName() {
		return auditorName;
	}

	public void setAuditorName(String auditorName) {
		this.auditorName = auditorName;
	}

	public String getUploadId() {
		return uploadId;
	}

	public void setUploadId(String uploadId) {
		this.uploadId = uploadId;
	}

	public String getUploadName() {
		return uploadName;
	}

	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getCheckAccordId() {
		return checkAccordId;
	}

	public void setCheckAccordId(String checkAccordId) {
		this.checkAccordId = checkAccordId;
	}

	public String getCheckAccord() {
		return checkAccord;
	}

	public void setCheckAccord(String checkAccord) {
		this.checkAccord = checkAccord;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getLimitValue() {
		return limitValue;
	}

	public void setLimitValue(String limitValue) {
		this.limitValue = limitValue;
	}

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	public String getCheckUnit() {
		return checkUnit;
	}

	public void setCheckUnit(String checkUnit) {
		this.checkUnit = checkUnit;
	}

	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}

	public String getDeviceMethod() {
		return deviceMethod;
	}

	public void setDeviceMethod(String deviceMethod) {
		this.deviceMethod = deviceMethod;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getDeviceCompany() {
		return deviceCompany;
	}

	public void setDeviceCompany(String deviceCompany) {
		this.deviceCompany = deviceCompany;
	}

	public Short getReloadFlag() {
		return reloadFlag;
	}

	public void setReloadFlag(Short reloadFlag) {
		this.reloadFlag = reloadFlag;
	}

	public Short getDataSource() {
		return dataSource;
	}

	public void setDataSource(Short dataSource) {
		this.dataSource = dataSource;
	}

	public Short getStatusFalg() {
		return statusFalg;
	}

	public void setStatusFalg(Short statusFalg) {
		this.statusFalg = statusFalg;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getSeason() {
		return season;
	}

	public void setSeason(String season) {
		this.season = season;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public Integer getRegId() {
		return regId;
	}

	public void setRegId(Integer regId) {
		this.regId = regId;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public int getFoodId() {
		return foodId;
	}

	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getQualified() {
		return qualified;
	}

	public void setQualified(int qualified) {
		this.qualified = qualified;
	}

	public int getUnqualified() {
		return unqualified;
	}

	public void setUnqualified(int unqualified) {
		this.unqualified = unqualified;
	}

	public DataCheckRecording getBean() {
		return bean;
	}

	public void setBean(DataCheckRecording bean) {
		this.bean = bean;
	}

	public Integer getPointId() {
		return pointId;
	}

	public void setPointId(Integer pointId) {
		this.pointId = pointId;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Short getDataType() {
		return dataType;
	}

	public void setDataType(Short dataType) {
		this.dataType = dataType;
	}

	public String getPointType() {
		return pointType;
	}

	public void setPointType(String pointType) {
		this.pointType = pointType;
	}

	public double getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(double purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}

	public double getDestoryNumber() {
		return destoryNumber;
	}

	public void setDestoryNumber(double destoryNumber) {
		this.destoryNumber = destoryNumber;
	}

	public String getUnqualifiedFood() {
		return unqualifiedFood;
	}

	public void setUnqualifiedFood(String unqualifiedFood) {
		this.unqualifiedFood = unqualifiedFood;
	}

	public List<Integer> getDepartListForStatist() {
		return departListForStatist;
	}

	public void setDepartListForStatist(List<Integer> departListForStatist) {
		this.departListForStatist = departListForStatist;
	}

	public String getAreaDepartName() {
		return areaDepartName;
	}

	public void setAreaDepartName(String areaDepartName) {
		this.areaDepartName = areaDepartName;
	}

	public Integer getJcdpn() {
		return jcdpn;
	}

	public void setJcdpn(Integer jcdpn) {
		this.jcdpn = jcdpn;
	}

	public Integer getZfpn() {
		return zfpn;
	}

	public void setZfpn(Integer zfpn) {
		this.zfpn = zfpn;
	}

	public Integer getQypn() {
		return qypn;
	}

	public void setQypn(Integer qypn) {
		this.qypn = qypn;
	}

	public Integer getCarpn() {
		return carpn;
	}

	public void setCarpn(Integer carpn) {
		this.carpn = carpn;
	}

	public Integer getZfnum() {
		return zfnum;
	}

	public void setZfnum(Integer zfnum) {
		this.zfnum = zfnum;
	}

	public Integer getQynum() {
		return qynum;
	}

	public void setQynum(Integer qynum) {
		this.qynum = qynum;
	}

	public Integer getCarnum() {
		return carnum;
	}

	public void setCarnum(Integer carnum) {
		this.carnum = carnum;
	}

	public Integer getZfun() {
		return zfun;
	}

	public void setZfun(Integer zfun) {
		this.zfun = zfun;
	}

	public Integer getQyun() {
		return qyun;
	}

	public void setQyun(Integer qyun) {
		this.qyun = qyun;
	}

	public Integer getCarun() {
		return carun;
	}

	public void setCarun(Integer carun) {
		this.carun = carun;
	}

	public Short getTaskType() {
		return taskType;
	}

	public void setTaskType(Short taskType) {
		this.taskType = taskType;
	}

	public Integer getQueryType() {
		return queryType;
	}

	public void setQueryType(Integer queryType) {
		this.queryType = queryType;
	}

	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public Integer getFaking() {
		return faking;
	}

	public void setFaking(Integer faking) {
		this.faking = faking;
	}

	public Integer getDealFlag() {
		return dealFlag;
	}

	public void setDealFlag(Integer dealFlag) {
		this.dealFlag = dealFlag;
	}

	public Integer getSeasonNumber() {
		return seasonNumber;
	}

	public void setSeasonNumber(Integer seasonNumber) {
		this.seasonNumber = seasonNumber;
	}

	public Integer getSorting() {
		return sorting;
	}

	public void setSorting(Integer sorting) {
		this.sorting = sorting;
	}
}
