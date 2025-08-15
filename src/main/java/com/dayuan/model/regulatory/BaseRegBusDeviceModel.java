package com.dayuan.model.regulatory;

import com.dayuan.model.BaseModel;

import java.io.Serializable;

/**
 * Description 仪器端嵌套网页经营户model
 *
 * @Author teng
 * @Date 2022/3/11 16:17
 */
public class BaseRegBusDeviceModel extends BaseModel implements Serializable {
    //主键ID
    private Integer id;
    //监管对象ID
    private Integer regId;
    //档口/店面名称
    private String opeShopName;
    //档口/店面编号
    private String opeShopCode;
    //经营户名称
    private String opeName;
    //经营户身份证
    private String opeIdcard;
    //统一社会信用代码
    private String creditCode;
    //经营户联系方式
    private String opePhone;
    //审核状态
    private Short checked;
    //联系人
    private String contacts;
    //经营范围
    private String businessCope;
    //备注
    private String remark;

    //类型:0:经营户;1:车辆
    private Integer type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getOpeShopName() {
        return opeShopName;
    }

    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName;
    }

    public String getOpeShopCode() {
        return opeShopCode;
    }

    public void setOpeShopCode(String opeShopCode) {
        this.opeShopCode = opeShopCode;
    }

    public String getOpeName() {
        return opeName;
    }

    public void setOpeName(String opeName) {
        this.opeName = opeName;
    }

    public String getOpeIdcard() {
        return opeIdcard;
    }

    public void setOpeIdcard(String opeIdcard) {
        this.opeIdcard = opeIdcard;
    }

    public String getCreditCode() {
        return creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode;
    }

    public String getOpePhone() {
        return opePhone;
    }

    public void setOpePhone(String opePhone) {
        this.opePhone = opePhone;
    }

    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public String getContacts() {
        return contacts;
    }

    public void setContacts(String contacts) {
        this.contacts = contacts;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getBusinessCope() {
        return businessCope;
    }

    public void setBusinessCope(String businessCope) {
        this.businessCope = businessCope;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
