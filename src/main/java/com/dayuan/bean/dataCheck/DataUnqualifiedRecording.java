package com.dayuan.bean.dataCheck;

import java.io.Serializable;
import java.util.Date;

public class DataUnqualifiedRecording implements Serializable {
    private Integer id;

    private Integer rid;//检测数据ID

    private Integer samplingId;//抽样单ID

    private Integer samplingDetailId;//抽样明细ID

    private String sampleCode;//抽样明细样品编号

    private Integer foodId;//样品ID

    private String foodName;//样品名称

    private String itemId;//检测项目ID

    private String itemName;//检测项目

    private Integer regId;//市场Id

    private String regName;//被检单位名称

    private Integer regUserId;//经营户Id

    private String regUserName;//经营户

    private Integer departId;//所属组织机构ID

    private String departName;//所属机构名称

    private Integer pointId;//检测点ID

    private String pointName;//检测点名称

    private String checkUsername;//检测人员名称

    private Date uploadDate;//上报时间

    private Date checkDate;//检测时间

    private String checkResult;//检测结果(检测值)

    private String checkUnit;//检测结果单位

    private String conclusion;//检测结论

    private Short reloadFlag;//上传次数

    private String sendPhone;//发送号码或者openid

    private Date sendTime;//发送时间

    private Short sendState;//发送状态:0_未发送,1_发送成功,2_发送失败

    private String sendRemark;//发短信的备注信息

    private Integer param1;//检测数据删除状态:0_未删除,1_已删除

    private Integer param2;//发送方式：0 短信，1微信公众号

    private String param3;//预留字段

    private String param4;//预留字段

    private Short deleteFlag;//删除状态：0_未删除,1_已删除

    private String createBy;

    private Date createDate;

    private String updateBy;

    private Date updateDate;

    private static final long serialVersionUID = 1L;

    public DataUnqualifiedRecording() {
    }

    public DataUnqualifiedRecording(Integer rid, Integer samplingId, Integer samplingDetailId, String sampleCode, Integer foodId, String foodName, String itemId, String itemName, Integer regId, String regName, Integer regUserId, String regUserName, Integer departId, String departName, Integer pointId, String pointName, String checkUsername, Date uploadDate, Date checkDate, String checkResult, String checkUnit, String conclusion, Short reloadFlag, String sendPhone, Date sendTime, Short sendState, Integer param1, Integer param2, String param3, String param4) {
        this.rid = rid;
        this.samplingId = samplingId;
        this.samplingDetailId = samplingDetailId;
        this.sampleCode = sampleCode;
        this.foodId = foodId;
        this.foodName = foodName;
        this.itemId = itemId;
        this.itemName = itemName;
        this.regId = regId;
        this.regName = regName;
        this.regUserId = regUserId;
        this.regUserName = regUserName;
        this.departId = departId;
        this.departName = departName;
        this.pointId = pointId;
        this.pointName = pointName;
        this.checkUsername = checkUsername;
        this.uploadDate = uploadDate;
        this.checkDate = checkDate;
        this.checkResult = checkResult;
        this.checkUnit = checkUnit;
        this.conclusion = conclusion;
        this.reloadFlag = reloadFlag;
        this.sendPhone = sendPhone;
        this.sendTime = sendTime;
        this.sendState = sendState;
        this.param1 = param1;
        this.param2 = param2;
        this.param3 = param3;
        this.param4 = param4;
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

    public String getSampleCode() {
        return sampleCode;
    }

    public void setSampleCode(String sampleCode) {
        this.sampleCode = sampleCode == null ? null : sampleCode.trim();
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
        this.foodName = foodName == null ? null : foodName.trim();
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId == null ? null : itemId.trim();
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName == null ? null : itemName.trim();
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
        this.regName = regName == null ? null : regName.trim();
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
        this.regUserName = regUserName == null ? null : regUserName.trim();
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
        this.departName = departName == null ? null : departName.trim();
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
        this.pointName = pointName == null ? null : pointName.trim();
    }

    public String getCheckUsername() {
        return checkUsername;
    }

    public void setCheckUsername(String checkUsername) {
        this.checkUsername = checkUsername == null ? null : checkUsername.trim();
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

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult == null ? null : checkResult.trim();
    }

    public String getCheckUnit() {
        return checkUnit;
    }

    public void setCheckUnit(String checkUnit) {
        this.checkUnit = checkUnit == null ? null : checkUnit.trim();
    }

    public String getConclusion() {
        return conclusion;
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion == null ? null : conclusion.trim();
    }

    public Short getReloadFlag() {
        return reloadFlag;
    }

    public void setReloadFlag(Short reloadFlag) {
        this.reloadFlag = reloadFlag;
    }

    public String getSendPhone() {
        return sendPhone;
    }

    public void setSendPhone(String sendPhone) {
        this.sendPhone = sendPhone == null ? null : sendPhone.trim();
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Short getSendState() {
        return sendState;
    }

    public void setSendState(Short sendState) {
        this.sendState = sendState;
    }

    public Integer getParam1() {
        return param1;
    }

    public void setParam1(Integer param1) {
        this.param1 = param1;
    }

    public Integer getParam2() {
        return param2;
    }

    public void setParam2(Integer param2) {
        this.param2 = param2;
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    public String getParam4() {
        return param4;
    }

    public void setParam4(String param4) {
        this.param4 = param4 == null ? null : param4.trim();
    }

    public Short getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getSendRemark() {
        return sendRemark;
    }

    public void setSendRemark(String sendRemark) {
        this.sendRemark = sendRemark;
    }
}