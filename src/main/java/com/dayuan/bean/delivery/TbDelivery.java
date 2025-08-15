package com.dayuan.bean.delivery;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

public class TbDelivery extends BaseBean2 {

	//入场登记编号
	private String deliveryNo;
	//送货人ID
    private Integer personId;
	//机构ID
    private Integer departId;
	//抽样单ID
    private Integer samplingId;
	//机构ID
    private Integer samplingDetailId;
	//食品名称ID
    private String foodId;
	//食品名称
    private String foodName;
	//被检单位ID
    private Integer regId;
	//被检单位名称
    private String regName;
	//档口ID
    private String opeId;
	//档口编号
    private String opeCode;
	//食品图片
    private String photos;
	//入场登记时间
    private Date deliveryDate;
	//预留参数1
    private String param1;
	//预留参数2
    private String param2;
	//预留参数3
    private String param3;

    public String getDeliveryNo() {
		return deliveryNo;
	}

	public void setDeliveryNo(String deliveryNo) {
		this.deliveryNo = deliveryNo;
	}

	public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public Integer getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(Integer samplingId) {
        this.samplingId = samplingId;
    }

    public String getFoodId() {
        return foodId;
    }

    public void setFoodId(String foodId) {
        this.foodId = foodId == null ? null : foodId.trim();
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName == null ? null : foodName.trim();
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

    public String getOpeId() {
        return opeId;
    }

    public void setOpeId(String opeId) {
        this.opeId = opeId == null ? null : opeId.trim();
    }

    public String getOpeCode() {
        return opeCode;
    }

    public void setOpeCode(String opeCode) {
        this.opeCode = opeCode == null ? null : opeCode.trim();
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos == null ? null : photos.trim();
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
    
    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getSamplingDetailId() {
        return samplingDetailId;
    }

    public void setSamplingDetailId(Integer samplingDetailId) {
        this.samplingDetailId = samplingDetailId;
    }
}