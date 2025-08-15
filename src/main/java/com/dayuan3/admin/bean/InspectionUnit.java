package com.dayuan3.admin.bean;

import com.dayuan.bean.BaseBean2;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.Date;

/**
 * Description 经营单位管理
 * @Author xiaoyl
 * @Date 2025/6/10 14:12
 */
@Data
public class InspectionUnit extends BaseBean2 {
    public InspectionUnit() {
    }

    public InspectionUnit(Integer coldUnitId, String companyName, String companyCode, Short companyType, String creditCode, String legalPerson, String legalPhone) {
        this.coldUnitId = coldUnitId;
        this.companyName = companyName;
        this.companyCode = companyCode;
        this.companyType = companyType;
        this.creditCode = creditCode;
        this.legalPerson = legalPerson;
        this.legalPhone = legalPhone;
    }

    /**
     * 冷链单位ID
     */
    private Integer coldUnitId;

    /**
     * 单位名称
     */
    private String companyName;

    /**
     * 仓口编号
     */
    private String companyCode;

    /**
     * 单位类型：0企业，1个人
     */
    private Short companyType;

    /**
     * 社会信用代码/身份证号码/经营户身份证号
     */
    private String creditCode;

    /**
     * 法定代表人
     */
    private String legalPerson;

    /**
     * 法人联系方式
     */
    private String legalPhone;

    /**
     * 详细地址
     */
    private String companyAddress;

    /**
     * 联系人
     */
    private String linkUser;

    /**
     * 联系方式
     */
    private String linkPhone;

    /**
     * 二维码图片名称
     */
    private String qrcode;
    /**
     * 扫描二维码次数
     */
    private Short scanNum;

    /**
     * 经营范围
     */
    private String businessCope;
    /**
     * 审核状态（0 未审核，1 已审核）
     */
    private Short checked = 0;

    /**
     * 附件地址
     */
    private String filePath;

    /**
     * 坐标X,经度
     */
    private String longitude;

    /**
     * 坐标y，纬度
     */
    private String latitude;


    /**
     * 预留参数1
     */
    private String param1;

    /**
     * 预留参数2
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;

    private String remark;

    /**************非数据库字段****************************/

    private String coldUnitName;//冷链单位名称
    private int userNumber;    //送检单位用户数量
    private int reqNumber;    //全局委托单位数量

    public Integer getColdUnitId() {
        return coldUnitId;
    }

    public void setColdUnitId(Integer coldUnitId) {
        this.coldUnitId = coldUnitId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }

    public Short getCompanyType() {
        return companyType;
    }

    public void setCompanyType(Short companyType) {
        this.companyType = companyType;
    }

    public String getCreditCode() {
        return creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode;
    }

    public String getLegalPerson() {
        return legalPerson;
    }

    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson;
    }

    public String getLegalPhone() {
        return legalPhone;
    }

    public void setLegalPhone(String legalPhone) {
        this.legalPhone = legalPhone;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public String getLinkUser() {
        return linkUser;
    }

    public void setLinkUser(String linkUser) {
        this.linkUser = linkUser;
    }

    public String getLinkPhone() {
        return linkPhone;
    }

    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone;
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode;
    }

    public Short getScanNum() {
        return scanNum;
    }

    public void setScanNum(Short scanNum) {
        this.scanNum = scanNum;
    }

    public String getBusinessCope() {
        return businessCope;
    }

    public void setBusinessCope(String businessCope) {
        this.businessCope = businessCope;
    }

    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

// 非数据库字段

    public String getColdUnitName() {
        return coldUnitName;
    }

    public void setColdUnitName(String coldUnitName) {
        this.coldUnitName = coldUnitName;
    }

    public int getUserNumber() {
        return userNumber;
    }

    public void setUserNumber(int userNumber) {
        this.userNumber = userNumber;
    }

    public int getReqNumber() {
        return reqNumber;
    }

    public void setReqNumber(int reqNumber) {
        this.reqNumber = reqNumber;
    }


    }