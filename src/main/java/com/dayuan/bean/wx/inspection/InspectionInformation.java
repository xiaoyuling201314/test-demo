package com.dayuan.bean.wx.inspection;

import com.dayuan.bean.BaseBean;

import java.util.Date;

/**
 * 检测数据记录表:data_check_recording
 *
 * @author dy 2018年08月08日
 */
public class InspectionInformation extends BaseBean {

    private Integer rid; //

    private String checkCode;  //检测编号

    private Integer taskId;

    private String taskName;

    private Integer samplingId;  //抽样单id

    private Integer samplingDetailId;  //抽样明细id

    private Integer foodTypeId;

    private String foodTypeName;

    private Integer foodId;

    private String foodName;

    private Integer regId;

    private String regName;

    private Integer regUserId;

    private String regUserName;

    private Integer departId;

    private String departName;

    private Integer pointId;  //检测点id

    private String pointName;  //检测点名称

    private String checkUserid;  //检测人员id

    private String checkUsername;  //检测人员名称

    private String auditorId;

    private String auditorName;

    private String uploadId;

    private String uploadName;

    private Date uploadDate;

    private String itemId;  //检测项目id

    private String itemName;  //检测项目

    private Date checkDate;  //检测时间

    private String checkAccordId;    //检测依据id

    private String checkAccord;  //检测依据

    private String deviceId;  //检测仪器id

    private String deviceName;  //检测仪器名称

    private String limitValue;  //限定值

    private String checkResult;  //检测结果(检测值)

    private String checkUnit;  //检测结果单位

    private String conclusion;  //检测结论

    private String deviceMethod;//检测方法

    private String deviceModel;    //检测模块

    private String deviceCompany;    //仪器厂家

    private Short reloadFlag;    //重传标志：0未重传，1重传

    private Short dataSource;  //数据来源 0检测工作站，1监管通app，2.仪器上传,3平台上传，4导入

    private Short statusFalg;    //状态：0为未审核，1为已审核

    private Integer param1;    //任务明细ID

    private String param2;    //抽样数量

    private String param3;    //预留参数3
    private Short dataType;//0 抽样检测数据 ,1送样检测数据 
    /**************非数据库字段****************************/

    private String regUserCode;    //经营户编号

    private String samplingDetailCode;  //抽样明细编号

    private Date samplingDate;  //抽样时间

    private String samplingUsername; //抽样人姓名

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
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

    public Integer getFoodTypeId() {
        return foodTypeId;
    }

    public void setFoodTypeId(Integer foodTypeId) {
        this.foodTypeId = foodTypeId;
    }

    public String getFoodTypeName() {
        return foodTypeName;
    }

    public void setFoodTypeName(String foodTypeName) {
        this.foodTypeName = foodTypeName;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
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

    public String getCheckAccordId() {
        return checkAccordId;
    }

    public void setCheckAccordId(String checkAccordId) {
        this.checkAccordId = checkAccordId;
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

    public Short getStatusFalg() {
        return statusFalg;
    }

    public void setStatusFalg(Short statusFalg) {
        this.statusFalg = statusFalg;
    }

    public String getCheckCode() {
        return checkCode == null ? "" : checkCode.trim();
    }

    public void setCheckCode(String checkCode) {
        this.checkCode = checkCode;
    }

    public Integer getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(Integer samplingId) {
        this.samplingId = samplingId;
    }

    public Integer getSamplingDetailId() {
        return samplingDetailId;
    }

    public void setSamplingDetailId(Integer samplingDetailId) {
        this.samplingDetailId = samplingDetailId;
    }

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public String getPointName() {
        return pointName == null ? "" : pointName.trim();
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getCheckUserid() {
        return checkUserid == null ? "" : checkUserid.trim();
    }

    public void setCheckUserid(String checkUserid) {
        this.checkUserid = checkUserid;
    }

    public String getCheckUsername() {
        return checkUsername == null ? "" : checkUsername.trim();
    }

    public void setCheckUsername(String checkUsername) {
        this.checkUsername = checkUsername;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId == null ? "" : itemId.trim();
    }

    public String getItemName() {
        return itemName == null ? "" : itemName.trim();
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public String getCheckAccord() {
        return checkAccord;
    }

    public void setCheckAccord(String checkAccord) {
        this.checkAccord = checkAccord == null ? "" : checkAccord.trim();
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId == null ? "" : deviceId.trim();
    }

    public String getDeviceName() {
        return deviceName == null ? "" : deviceName.trim();
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getLimitValue() {
        return limitValue == null ? "" : limitValue.trim();
    }

    public void setLimitValue(String limitValue) {
        this.limitValue = limitValue;
    }

    public String getCheckResult() {
        return checkResult == null ? "" : checkResult.trim();
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getCheckUnit() {
        return checkUnit == null ? "" : checkUnit.trim();
    }

    public void setCheckUnit(String checkUnit) {
        this.checkUnit = checkUnit;
    }

    public String getConclusion() {
        return conclusion == null ? "" : conclusion.trim();
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }

    public Short getDataSource() {
        return dataSource;
    }

    public void setDataSource(Short dataSource) {
        this.dataSource = dataSource;
    }

    public String getDeviceMethod() {
        return deviceMethod;
    }

    public void setDeviceMethod(String deviceMethod) {
        this.deviceMethod = deviceMethod;
    }

    public Integer getParam1() {
        return param1;
    }

    public void setParam1(Integer param1) {
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

    public String getRegUserCode() {
        return regUserCode;
    }

    public void setRegUserCode(String regUserCode) {
        this.regUserCode = regUserCode;
    }

    public String getSamplingDetailCode() {
        return samplingDetailCode;
    }

    public void setSamplingDetailCode(String samplingDetailCode) {
        this.samplingDetailCode = samplingDetailCode;
    }

    public Date getSamplingDate() {
        return samplingDate;
    }

    public void setSamplingDate(Date samplingDate) {
        this.samplingDate = samplingDate;
    }

    public String getSamplingUsername() {
        return samplingUsername;
    }

    public void setSamplingUsername(String samplingUsername) {
        this.samplingUsername = samplingUsername;
    }

    public Short getDataType() {
        return dataType;
    }

    public void setDataType(Short dataType) {
        this.dataType = dataType;
    }
}