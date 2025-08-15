package com.dayuan.model.wx.inspection;

import com.dayuan.model.BaseModel;

/**
 * Author: shit
 * Date: 2018/11/12 10:51
 * Content:
 */
public class PointModel extends BaseModel {
    private Integer id;

    private String pointName; // 检测点名称

    private String pointCode; // 检测点编号

    private String pointType; // 检测点类型

    private Integer departId; // 所属组织机构ID

    private String managerId; // 负责人ID

    private String phone; // 联系方式

    private String regionId; // 地域ID

    private String address; // 地址

    private String placeX;// 坐标x

    private String placeY;// 坐标y

    private String departName;// 机构名称

    private String managerName;// 负责人

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    // add by Luo start
    //检测点性质ID => base_point_type.id
    private String pointTypeId;

    private Integer sampleDelivery;// 送样(0:不接受,1:接受)

    private Integer pointId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getPointCode() {
        return pointCode;
    }

    public void setPointCode(String pointCode) {
        this.pointCode = pointCode;
    }

    public String getPointType() {
        return pointType;
    }

    public void setPointType(String pointType) {
        this.pointType = pointType;
    }

    @Override
    public Integer getDepartId() {
        return departId;
    }

    @Override
    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId;
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

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getPointTypeId() {
        return pointTypeId;
    }

    public void setPointTypeId(String pointTypeId) {
        this.pointTypeId = pointTypeId;
    }

    public Integer getSampleDelivery() {
        return sampleDelivery;
    }

    public void setSampleDelivery(Integer sampleDelivery) {
        this.sampleDelivery = sampleDelivery;
    }

    @Override
    public Integer getPointId() {
        return pointId;
    }

    @Override
    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }
}

