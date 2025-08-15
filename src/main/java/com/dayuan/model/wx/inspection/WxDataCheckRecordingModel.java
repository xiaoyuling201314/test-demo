package com.dayuan.model.wx.inspection;

import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * 检测数据记录表:data_check_recording
 *
 * @author dy 2018年08月08日
 */
public class WxDataCheckRecordingModel extends BaseModel {

    private Integer id;         //检测数据id

    private Integer samplingId;  //抽样单id

    private Integer foodId;

    private String foodName;    //样品名称

    private Integer regId;

    private String regName;     //送检人

    private String pointName;   //检测点名称

    private String checkUserid;  //检测人员id

    private String checkUsername;  //检测人员名称

    private String itemId;      //检测项目id

    private String itemName;    //检测项目

    private Date checkDate;     //检测时间

    private String deviceId;    //检测仪器id

    private String deviceName;   //检测仪器名称

    private String checkResult;  //检测结果(检测值)

    private String conclusion;   //检测结论

    private String deviceMethod;  //检测方法

    private String deviceModel;    //检测模块

    private String deviceCompany;   //仪器厂家

    private Short dataSource;  //数据来源 0检测工作站，1监管通app，2.仪器上传,3平台上传，4导入

    private Short statusFalg;    //状态：0为未审核，1为已审核

    private Date samplingDate;  //抽样时间

    private String samplingUsername; //抽样人姓名

    private String departName;  //机构名称

    private String samplingNo;  //抽样单号

    private String regLinkPhone;  //联系电话

    private String opePhone;  //微信号

    private String opeShopName;  //地址

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(Integer samplingId) {
        this.samplingId = samplingId;
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

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
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

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
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

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
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

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getSamplingNo() {
        return samplingNo;
    }

    public void setSamplingNo(String samplingNo) {
        this.samplingNo = samplingNo;
    }

    public String getRegLinkPhone() {
        return regLinkPhone;
    }

    public void setRegLinkPhone(String regLinkPhone) {
        this.regLinkPhone = regLinkPhone;
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
}