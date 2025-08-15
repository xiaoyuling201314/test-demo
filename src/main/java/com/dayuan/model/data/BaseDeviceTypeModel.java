package com.dayuan.model.data;

import java.util.Date;

import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.model.BaseModel;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月16日
 */
public class BaseDeviceTypeModel extends BaseModel {

	private BaseDeviceType baseBean;
	
	private String id;
	
	private String number;

	private String brand;
	
	private Short type;//0仪器,1检测箱

    private String deviceName;      //仪器名称

    private String deviceSeries;	//仪器系列

    private String deviceVersion;	//仪器版本
    
    private String deviceType;//仪器类型
    
    private String deviceMaker;		//生产厂家

    private String description;		//功能描述
    
    private Short checked;			//是否审核： 0未审核，1审核
    
    private String filePath;		// 仪器图片存放路径file_path
    
    private Short deleteFlag;

    private String createBy;

    private Date createDate;
    
    private String updateBy;

    private Date updateDate;
    
	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceSeries() {
		return deviceSeries;
	}

	public void setDeviceSeries(String deviceSeries) {
		this.deviceSeries = deviceSeries;
	}

	public String getDeviceVersion() {
		return deviceVersion;
	}

	public void setDeviceVersion(String deviceVersion) {
		this.deviceVersion = deviceVersion;
	}

	public String getDeviceMaker() {
		return deviceMaker;
	}

	public void setDeviceMaker(String deviceMaker) {
		this.deviceMaker = deviceMaker;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
		this.createBy = createBy;
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
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public BaseDeviceType getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(BaseDeviceType baseBean) {
		this.baseBean = baseBean;
	}

}