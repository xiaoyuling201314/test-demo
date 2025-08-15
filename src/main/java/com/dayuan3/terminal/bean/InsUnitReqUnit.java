package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;

/**
 * 送检单位和委托单位中间表对象
 *
 * @author shit
 * @date 2019年01月06日
 */
public class InsUnitReqUnit extends BaseBean2 {
    private Integer inspectionId;//送检单位ID
    private Integer requestId;//委托单位ID
    private String requestName;//委托单位名称
    private String creditCode;//委托单位信用代码
    private Short state;     //单位状态（0 营业，1 停业）
    private Short unitType;  //单位类型(1：餐饮  2：学校  3：食堂  4：供应商)
    private Integer[] reqIds = new Integer[]{};  //新增的时候,存储改送检单位对应的委托单位ID

    private String reqIdStr;//该送检单位对应的所有委托单位ID的字符串,逗号隔开 如: 1,2,3
    private Short param1 = 0;//预留参数1
    private String param2;//预留参数2
    private String param3;//预留参数3

    /********************非数据库字段**************************/
    /**
     * 委托单位联系电话  add by xiaoyl 2020/1/14
     */
    private String linkPhone;
    /**
     * 委托单位地址  add by shit 2020/03/11
     */
    private String companyAddress;

    public Integer getInspectionId() {
        return inspectionId;
    }

    public void setInspectionId(Integer inspectionId) {
        this.inspectionId = inspectionId;
    }

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public String getRequestName() {
        return requestName;
    }

    public void setRequestName(String requestName) {
        this.requestName = requestName;
    }

    public String getCreditCode() {
        return creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode;
    }

    public Short getState() {
        return state;
    }

    public void setState(Short state) {
        this.state = state;
    }

    public Short getUnitType() {
        return unitType;
    }

    public void setUnitType(Short unitType) {
        this.unitType = unitType;
    }

    public Integer[] getReqIds() {
        return reqIds;
    }

    public void setReqIds(Integer[] reqIds) {
        this.reqIds = reqIds;
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

    public String getReqIdStr() {
        return reqIdStr == null ? "" : reqIdStr;
    }

    public void setReqIdStr(String reqIdStr) {
        this.reqIdStr = reqIdStr;
    }

    public String getLinkPhone() {
        return linkPhone;
    }

    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone;
    }

    public Short getParam1() {
        return param1;
    }

    public void setParam1(Short param1) {
        this.param1 = param1;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }
}