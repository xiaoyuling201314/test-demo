package com.dayuan.model.dataCheck;

import com.dayuan.bean.data.TbFile;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.model.BaseModel;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 检测数据记录
 *
 * @author Bill
 * 2017年7月28日
 */
public class CheckResultModel extends BaseModel {

    /**
     * 检测结果表
     */
    private Integer id;  //检测结果id
    private String checkRecordingId;  //原检测结果id
    private Integer rid;//PK
    private String checkAccord;  //检测依据

    private String limitValue;  //限定值

    private String checkResult;  //检测结果(检测值)

    private String checkUnit;  //检测结果单位

    private String conclusion;  //检测结论

    private Integer taskId; //任务ID

    private String taskName; //任务名称

    private Date checkDate;  //检测时间

    private String checkCode;//检测编号

    private String auditorName; //审核人员

    private String uploadName; //上报人员

    private Date uploadDate; //上报时间

    private String departName;//检测机构

    private String deviceModel; //检测模块

    private String deviceMethod; //检测方法

    private String deviceCompany; //仪器厂家

    private String dataSource; //数据来源

    private Short reloadFlag;   //上传次数

    private String remark2; //检测数据备注

    private String param1; //任务明细ID

    private String param2; //上传第三方平台标识: 0:未上传; 1:上传成功; 2:上传失败

    private String param3; //导入文件

    private String checkVoucher; //检测凭证

    private String param5; //上传第三方平台失败原因

    private Integer param6;	//数据有效性：0正常，1上传超时，2手工录入无附件，3手工录入超时且无附件，4人工审核无效数据(有效改为无效)，5其他，9造假数据

    private Integer param7;//数据审核状态：0 未审核，1 已审核

    private Date time1; //上传第三方平台时间

    private String param8; //检测定位(经纬度+地址 以,隔开)

    private Integer handledAssessment;//add by xiaoyl 2022/05/17 甘肃系统任务考核；不合格处理考核状态：默认为NULL，表示未处理；不合格处理状态：0正常，1超时未处理，2超时处理，3不合规，4超时不合规，5造假。

    private String handledRemark;	//add by xiaoyl 2022/05/17 甘肃系统任务考核；考核状态理备注说明

    /**
     * 附加表
     */
    private Integer addendumId; //附加表ID

    private String operatorName;    //经营者姓名

    private String operatorPhone;   //经营者联系方式

    private String operatorSign;    //经营者签名

    private String samplingUser;    //采样人

    private String samplingPosition;    //采样定位（x,y）

    private String samplingAddress;     //采样地址

    private Double samplingNumber;      //采样数量（公斤）

    private String checkWay;    //检测方式（试剂条检测、快检仪检测）

    private String reagent; //试剂

    private String itemVulgo;   //检测项目俗称

    /**
     * 抽检单
     */
    private String samplingId; // 抽样单ID

    private String samplingNo; // 抽样单号

    private Integer regId; // 被检单位ID

    private String regName; // 被检单位名称

    private String regLicence; // 被检单位-证号号码

    private String regLinkPerson; // 被检单位-单位负责人

    private String regLinkPhone; // 被检单位联系电话

    private Integer opeId; // 经营户ID

    private String opeName; // 经营户名称

    private String opePerson; // 营业人

    private String opePhone; // 经营户联系电话

    private String opeShopName; // 档口名称

    private Date samplingDate; // 抽样日期

    private String ope_shop_code; //档口编号

    private Integer personal;//标识:0_抽样单, 1_送检单, 2_订单

    private String regAddres;//送样人地址

    private String inspectionCompany;   //订单-送样单位
    private String samplingUsername;    //订单-送样人名称
    private String samplingUserPhone;   //订单-送样人联系方式

    /**
     * 抽检单详情
     */
    private String samplingDetailId; //抽样明细ID

    private BigDecimal sampleNumber; // 抽样数量（公斤）

    private BigDecimal purchaseAmount; // 进货数量（公斤）

    private Date purchaseDate; // 进货日期

    private String origin; // 产地

    private String supplier; // 供应商

    private String supplierAddress; // 供货者/生产者地址

    private String supplierPerson; // 供货者/生产者名联系人

    private String supplierPhone; // 供货者/生产者联系电话

    private String batchNumber; // 批号

    private String sampleCode;//样品编号

    /**
     * 检测点
     */

    private String pointName;  //检测点名称

    private String checkUsername;  //检测人员名称

    /**
     * 检测项目
     */

    private String itemName;  //检测项目

    /**
     * 食品类型
     */

    private String foodName; // 食品种类名称

    private Integer foodParentId;//食品类型ID，东营大屏数据统计指定的类型ID，例如10011，肉类

    private String foodParentName;//食品类型名称，东营大屏数据统计指定的类型ID，例如10011，肉类
    /**
     * 检测使用仪器
     */

    private String deviceCode;  //检测仪器编号

    private String deviceName;  //检测仪器名称

    /**
     * 处理人
     */

    private String workerName;  //结果处理人

    private String address;  //检测点地址(通讯地址)

    private Short dataType;//0抽样检测数据, 1送样检测数据, 2订单检测数据
    /**
     * 不合格处理
     */
    private Integer dutId;    //不合格处理ID

    private String spersonName;  //送检人

    private String supervisor;  //监督人

    private String supervisorPhone;  //监督人联系电话

    private Short udealType;  //处理状态  0合格处理 1不合格处理 2有异议合格处理 3有异议不合格处理  

    private Short dealMethod;  //处理状态 0处理中 1已处理(控制列表显示关键字)

    private String recheckDepart;  //复检机构

    private String remark;  //备注

    private Date sendDate;  //送检日期

    private Date createDate;  //处理日期

    private String regAddress; //被检单位地址

    private String recheckDate;//复检日期

    private String handName; //处置内容

    private int showFlag;//处置标识

    private String dealImgurl;//处理图片

    private String dealUser;//处理人

    private String dealDepart;//处理机构

    private String recheckResult;//复检结果

    private String recheckValue;//复检值

    private Date updateDate;//处理时间

    private Double destroyCount;//销毁数量
    private String foodTypeName;//检测样品所属种类
    private String[] foodIds;//项目对应食品种类id
    private String[] itemIds;//项目对应食品种类-检测项目id列表

    private int recheckNuber;   //复检次数

    private List<TbFile> tbFiles = new ArrayList<>();//附件集合

    private String fFilePaths;//不合格处理附件字符串
    
    private BaseLedgerStock ledgerStock; //溯源信息
    
    private String issend; //是否推送 0:未推送 1：已推送
    
    private Integer queryNoneFile=0;//过滤查询待处理中是否有文档：0 不过滤，1 筛选没有附件的数据
    
    private Integer queryTimeOutHandel=0;//过滤距离检测时间超时N小时的待处理数据：0不过滤，1 过滤

    private List<TbTaskDetail> taskDetails;    //查询抽检任务检测数据


    /*查询条件 非表字段*/
    //监管对象类型
    private String regTypeId;
    //监管对象ID
    private Integer[] regIds;
    //检测时间范围-起始时间
    private String checkDateStartDateStr;
    //检测时间范围-结束时间
    private String checkDateEndDateStr;
    //检测点类型
    private Integer pointType;
    //数据有效性：0有效，1无效
    private Integer dataValidity;
    //疑似阳性：0否，1是
    private Integer suspected;


    public String getIssend() {
		return issend;
	}

	public void setIssend(String issend) {
		this.issend = issend;
	}

	public List<TbFile> getTbFiles() {
        return tbFiles;
    }

    public void setTbFiles(List<TbFile> tbFiles) {
        this.tbFiles = tbFiles;
    }

    public String getDealDepart() {
        return dealDepart;
    }

    public void setDealDepart(String dealDepart) {
        this.dealDepart = dealDepart;
    }

    public String[] getFoodIds() {
        return foodIds;
    }

    public void setFoodIds(String[] foodIds) {
        this.foodIds = foodIds;
    }

    public String[] getItemIds() {
        return itemIds;
    }

    public void setItemIds(String[] itemIds) {
        this.itemIds = itemIds;
    }

    public String getFoodTypeName() {
        return foodTypeName;
    }

    public void setFoodTypeName(String foodTypeName) {
        this.foodTypeName = foodTypeName;
    }


    public Double getDestroyCount() {
        return destroyCount;
    }

    public void setDestroyCount(Double destroyCount) {
        this.destroyCount = destroyCount;
    }


    public String getCheckDateStartDateStr() {
        return checkDateStartDateStr;
    }

    public void setCheckDateStartDateStr(String checkDateStartDateStr) {
        this.checkDateStartDateStr = checkDateStartDateStr;
    }

    public String getCheckDateEndDateStr() {
        return checkDateEndDateStr;
    }

    public void setCheckDateEndDateStr(String checkDateEndDateStr) {
        this.checkDateEndDateStr = checkDateEndDateStr;
    }

    public Integer getPointType() {
        return pointType;
    }

    public void setPointType(Integer pointType) {
        this.pointType = pointType;
    }

    public Date getSendDate() {
        return sendDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public void setSendDate(Date sendDate) {
        this.sendDate = sendDate;
    }

    public String getSpersonName() {
        return spersonName;
    }

    public void setSpersonName(String spersonName) {
        this.spersonName = spersonName;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public String getRecheckDepart() {
        return recheckDepart;
    }

    public void setRecheckDepart(String recheckDepart) {
        this.recheckDepart = recheckDepart;
    }

    public Short getUdealType() {
        return udealType;
    }

    public void setUdealType(Short udealType) {
        this.udealType = udealType;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getCheckAccord() {
        return checkAccord;
    }

    public String getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(String supervisor) {
        this.supervisor = supervisor;
    }

    public String getSupervisorPhone() {
        return supervisorPhone;
    }

    public void setSupervisorPhone(String supervisorPhone) {
        this.supervisorPhone = supervisorPhone;
    }

    public void setCheckAccord(String checkAccord) {
        this.checkAccord = checkAccord;
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

    public String getSamplingNo() {
        return samplingNo;
    }

    public void setSamplingNo(String samplingNo) {
        this.samplingNo = samplingNo;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getRegLicence() {
        return regLicence;
    }

    public void setRegLicence(String regLicence) {
        this.regLicence = regLicence;
    }

    public String getRegLinkPerson() {
        return regLinkPerson;
    }

    public void setRegLinkPerson(String regLinkPerson) {
        this.regLinkPerson = regLinkPerson;
    }

    public String getRegLinkPhone() {
        return regLinkPhone;
    }

    public void setRegLinkPhone(String regLinkPhone) {
        this.regLinkPhone = regLinkPhone;
    }

    public String getOpeName() {
        return opeName;
    }

    public void setOpeName(String opeName) {
        this.opeName = opeName;
    }

    public String getOpePerson() {
        return opePerson;
    }

    public void setOpePerson(String opePerson) {
        this.opePerson = opePerson;
    }

    public String getOpePhone() {
        return opePhone;
    }

    public void setOpePhone(String opePhone) {
        this.opePhone = opePhone;
    }

    public String getOpeShopName() {
        return opeShopName;
    }

    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName;
    }

    public Date getSamplingDate() {
        return samplingDate;
    }

    public void setSamplingDate(Date samplingDate) {
        this.samplingDate = samplingDate;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public BigDecimal getSampleNumber() {
        return sampleNumber;
    }

    public void setSampleNumber(BigDecimal sampleNumber) {
        this.sampleNumber = sampleNumber;
    }

    public BigDecimal getPurchaseAmount() {
        return purchaseAmount;
    }

    public void setPurchaseAmount(BigDecimal purchaseAmount) {
        this.purchaseAmount = purchaseAmount;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getSupplierAddress() {
        return supplierAddress;
    }

    public void setSupplierAddress(String supplierAddress) {
        this.supplierAddress = supplierAddress;
    }

    public String getSupplierPerson() {
        return supplierPerson;
    }

    public void setSupplierPerson(String supplierPerson) {
        this.supplierPerson = supplierPerson;
    }

    public String getSupplierPhone() {
        return supplierPhone;
    }

    public void setSupplierPhone(String supplierPhone) {
        this.supplierPhone = supplierPhone;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getCheckUsername() {
        return checkUsername;
    }

    public void setCheckUsername(String checkUsername) {
        this.checkUsername = checkUsername;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDeviceCode() {
        return deviceCode;
    }

    public void setDeviceCode(String deviceCode) {
        this.deviceCode = deviceCode;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public Short getDealMethod() {
        return dealMethod;
    }

    public void setDealMethod(Short dealMethod) {
        this.dealMethod = dealMethod;
    }

    public String getCheckCode() {
        return checkCode;
    }

    public void setCheckCode(String checkCode) {
        this.checkCode = checkCode;
    }

    public String getSampleCode() {
        return sampleCode;
    }

    public void setSampleCode(String sampleCode) {
        this.sampleCode = sampleCode;
    }

    public String getAuditorName() {
        return auditorName;
    }

    public void setAuditorName(String auditorName) {
        this.auditorName = auditorName;
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

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public void setDeviceModel(String deviceModel) {
        this.deviceModel = deviceModel;
    }

    public String getDeviceMethod() {
        return deviceMethod;
    }

    public void setDeviceMethod(String deviceMethod) {
        this.deviceMethod = deviceMethod;
    }

    public String getDeviceCompany() {
        return deviceCompany;
    }

    public void setDeviceCompany(String deviceCompany) {
        this.deviceCompany = deviceCompany;
    }

    public String getDataSource() {
        return dataSource;
    }

    public void setDataSource(String dataSource) {
        this.dataSource = dataSource;
    }

    public String getRegAddress() {
        return regAddress;
    }

    public void setRegAddress(String regAddress) {
        this.regAddress = regAddress;
    }

    public String getOpe_shop_code() {
        return ope_shop_code;
    }

    public void setOpe_shop_code(String ope_shop_code) {
        this.ope_shop_code = ope_shop_code;
    }

    public Integer getDutId() {
        return dutId;
    }

    public void setDutId(Integer dutId) {
        this.dutId = dutId;
    }

    public String getRecheckDate() {
        return recheckDate;
    }

    public void setRecheckDate(String recheckDate) {
        this.recheckDate = recheckDate;
    }

    public String getHandName() {
        return handName;
    }

    public void setHandName(String handName) {
        this.handName = handName;
    }

    public int getShowFlag() {
        return showFlag;
    }

    public void setShowFlag(int showFlag) {
        this.showFlag = showFlag;
    }

    public String getDealImgurl() {
        return dealImgurl;
    }

    public void setDealImgurl(String dealImgurl) {
        this.dealImgurl = dealImgurl;
    }

    public String getDealUser() {
        return dealUser;
    }

    public void setDealUser(String dealUser) {
        this.dealUser = dealUser;
    }

    public String getRecheckResult() {
        return recheckResult;
    }

    public void setRecheckResult(String recheckResult) {
        this.recheckResult = recheckResult;
    }

    public String getRecheckValue() {
        return recheckValue;
    }

    public void setRecheckValue(String recheckValue) {
        this.recheckValue = recheckValue;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getAddendumId() {
        return addendumId;
    }

    public void setAddendumId(Integer addendumId) {
        this.addendumId = addendumId;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getOperatorPhone() {
        return operatorPhone;
    }

    public void setOperatorPhone(String operatorPhone) {
        this.operatorPhone = operatorPhone;
    }

    public String getOperatorSign() {
        return operatorSign;
    }

    public void setOperatorSign(String operatorSign) {
        this.operatorSign = operatorSign;
    }

    public String getSamplingUser() {
        return samplingUser;
    }

    public void setSamplingUser(String samplingUser) {
        this.samplingUser = samplingUser;
    }

    public String getSamplingPosition() {
        return samplingPosition;
    }

    public void setSamplingPosition(String samplingPosition) {
        this.samplingPosition = samplingPosition;
    }

    public String getSamplingAddress() {
        return samplingAddress;
    }

    public void setSamplingAddress(String samplingAddress) {
        this.samplingAddress = samplingAddress;
    }

    public Double getSamplingNumber() {
        return samplingNumber;
    }

    public void setSamplingNumber(Double samplingNumber) {
        this.samplingNumber = samplingNumber;
    }

    public String getCheckWay() {
        return checkWay;
    }

    public void setCheckWay(String checkWay) {
        this.checkWay = checkWay;
    }

    public String getReagent() {
        return reagent;
    }

    public void setReagent(String reagent) {
        this.reagent = reagent;
    }

    public String getItemVulgo() {
        return itemVulgo;
    }

    public void setItemVulgo(String itemVulgo) {
        this.itemVulgo = itemVulgo;
    }

    public String getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(String samplingId) {
        this.samplingId = samplingId;
    }

    public Short getReloadFlag() {
        return reloadFlag;
    }

    public void setReloadFlag(Short reloadFlag) {
        this.reloadFlag = reloadFlag;
    }

    public String getInspectionCompany() {
        return inspectionCompany;
    }

    public void setInspectionCompany(String inspectionCompany) {
        this.inspectionCompany = inspectionCompany;
    }

    public String getSamplingUsername() {
        return samplingUsername;
    }

    public void setSamplingUsername(String samplingUsername) {
        this.samplingUsername = samplingUsername;
    }

    public String getSamplingUserPhone() {
        return samplingUserPhone;
    }

    public void setSamplingUserPhone(String samplingUserPhone) {
        this.samplingUserPhone = samplingUserPhone;
    }

    public String getSamplingDetailId() {
        return samplingDetailId;
    }

    public void setSamplingDetailId(String samplingDetailId) {
        this.samplingDetailId = samplingDetailId;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public Integer getOpeId() {
        return opeId;
    }

    public void setOpeId(Integer opeId) {
        this.opeId = opeId;
    }

    public Integer getPersonal() {
        return personal;
    }

    public void setPersonal(Integer personal) {
        this.personal = personal;
    }

    public String getRegAddres() {
        return regAddres;
    }

    public void setRegAddres(String regAddres) {
        this.regAddres = regAddres;
    }

    public Short getDataType() {
        return dataType;
    }

    public void setDataType(Short dataType) {
        this.dataType = dataType;
    }

    public String getRegTypeId() {
        return regTypeId;
    }

    public void setRegTypeId(String regTypeId) {
        this.regTypeId = regTypeId;
    }

    public String getRemark2() {
        return remark2;
    }

    public void setRemark2(String remark2) {
        this.remark2 = remark2;
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1;
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2;
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3;
    }


    public int getRecheckNuber() {
        return recheckNuber <= 1 ? 0 : recheckNuber - 1;
    }

    public void setRecheckNuber(int recheckNuber) {
        this.recheckNuber = recheckNuber;
    }

	public BaseLedgerStock getLedgerStock() {
		return ledgerStock;
	}

	public void setLedgerStock(BaseLedgerStock ledgerStock) {
		this.ledgerStock = ledgerStock;
	}

	public Integer getQueryNoneFile() {
		return queryNoneFile;
	}

	public void setQueryNoneFile(Integer queryNoneFile) {
		this.queryNoneFile = queryNoneFile;
	}

	public Integer getQueryTimeOutHandel() {
		return queryTimeOutHandel;
	}

	public void setQueryTimeOutHandel(Integer queryTimeOutHandel) {
		this.queryTimeOutHandel = queryTimeOutHandel;
	}

    public List<TbTaskDetail> getTaskDetails() {
        return taskDetails;
    }

    public void setTaskDetails(List<TbTaskDetail> taskDetails) {
        this.taskDetails = taskDetails;
    }

    public String getCheckVoucher() {
        return checkVoucher;
    }

    public void setCheckVoucher(String checkVoucher) {
        this.checkVoucher = checkVoucher;
    }

    public Integer[] getRegIds() {
        return regIds;
    }

    public void setRegIds(Integer[] regIds) {
        this.regIds = regIds;
    }

    public String getParam5() {
        return param5;
    }

    public void setParam5(String param5) {
        this.param5 = param5;
    }

    public Date getTime1() {
        return time1;
    }

    public void setTime1(Date time1) {
        this.time1 = time1;
    }

    public String getfFilePaths() {
        return fFilePaths;
    }

    public void setfFilePaths(String fFilePaths) {
        this.fFilePaths = fFilePaths;
    }

    public String getCheckRecordingId() {
        return checkRecordingId;
    }

    public void setCheckRecordingId(String checkRecordingId) {
        this.checkRecordingId = checkRecordingId;
    }

    public Integer getParam6() {
        return param6;
    }

    public void setParam6(Integer param6) {
        this.param6 = param6;
    }

    public Integer getDataValidity() {
        return dataValidity;
    }

    public void setDataValidity(Integer dataValidity) {
        this.dataValidity = dataValidity;
    }

    public String getParam8() {
        return param8;
    }

    public void setParam8(String param8) {
        this.param8 = param8;
    }

    public Integer getHandledAssessment() {
        return handledAssessment;
    }

    public void setHandledAssessment(Integer handledAssessment) {
        this.handledAssessment = handledAssessment;
    }

    public String getHandledRemark() {
        return handledRemark;
    }

    public void setHandledRemark(String handledRemark) {
        this.handledRemark = handledRemark;
    }

    public Integer getParam7() {
        return param7;
    }

    public void setParam7(Integer param7) {
        this.param7 = param7;
    }

    public Integer getFoodParentId() {
        return foodParentId;
    }

    public void setFoodParentId(Integer foodParentId) {
        this.foodParentId = foodParentId;
    }

    public String getFoodParentName() {
        return foodParentName;
    }

    public void setFoodParentName(String foodParentName) {
        this.foodParentName = foodParentName;
    }

    public Integer getSuspected() {
        return suspected;
    }

    public void setSuspected(Integer suspected) {
        this.suspected = suspected;
    }
}
