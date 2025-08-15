package com.dayuan.model.regulatory;

import com.dayuan.model.BaseModel;

import java.io.Serializable;

/**
 * Description 仪器端嵌套网页被检单位model
 *
 * @Author teng
 * @Date 2022/3/11 16:17
 */
public class BaseRegObjDeviceModel extends BaseModel implements Serializable {
    //主键ID
    private Integer id;
    //机构ID
    private Integer departId;
    //监管对象名称
    private String regName;
    //详细地址
    private String regAddress;
    //审核状态
    private Short checked;
    //监管对象类型
    private String regType;
    //经营户数量
    private int businessNumber;
    //经营单位类型：农贸市场/批发市场 1是农贸市场
    private String managementType;

    //监管对象类型名称
    private String regTypeName;
    //显示经营者,0隐藏,1展示
    private Short showBusiness;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getRegAddress() {
        return regAddress;
    }

    public void setRegAddress(String regAddress) {
        this.regAddress = regAddress;
    }

    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public String getRegType() {
        return regType;
    }

    public void setRegType(String regType) {
        this.regType = regType;
    }

    public int getBusinessNumber() {
        return businessNumber;
    }

    public void setBusinessNumber(int businessNumber) {
        this.businessNumber = businessNumber;
    }

    public String getManagementType() {
        return managementType;
    }

    public void setManagementType(String managementType) {
        this.managementType = managementType;
    }

    public String getRegTypeName() {
        return regTypeName;
    }

    public void setRegTypeName(String regTypeName) {
        this.regTypeName = regTypeName;
    }

    public Short getShowBusiness() {
        return showBusiness;
    }

    public void setShowBusiness(Short showBusiness) {
        this.showBusiness = showBusiness;
    }
}
