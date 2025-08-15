package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 仪器检测项目关联表
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月20日
 */
public class BaseDevicesItem extends BaseBean {

    private String deviceId;		//仪器ID

    private String deviceParameterId; //仪器类型检测项目参数表id

    private Short priority;			 //优先级别
    
    private Short checked;			//启用状态，1：启用 0：未启用
    
    /*****************非数据库字段************************/
    private String serialNumber;			//仪器唯一标识

    private Date registerDate;			//仪器注册时间

    private String itemName;			//检测项目名称

    private String projectType;			//检测模块

    private String detectMethod;		//检测方法名称

	public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId == null ? null : deviceId.trim();
    }

    public String getDeviceParameterId() {
        return deviceParameterId;
    }

    public void setDeviceParameterId(String deviceParameterId) {
        this.deviceParameterId = deviceParameterId == null ? null : deviceParameterId.trim();
    }

    public Short getPriority() {
        return priority;
    }

    public void setPriority(Short priority) {
        this.priority = priority;
    }

	public BaseDevicesItem() {
		super();
	}
	
	public Short getChecked() {
		return checked;
	}

	public void setChecked(Short checked) {
		this.checked = checked;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}

	public String getDetectMethod() {
		return detectMethod;
	}

	public void setDetectMethod(String detectMethod) {
		this.detectMethod = detectMethod;
	}

	public BaseDevicesItem(String id,String deviceId, String deviceParameterId,Short deleteFlag, Short priority, Short checked,String createBy,Date createDate,String updateBy,Date updateDate) {
		super();
		this.id=id;
		this.deviceId = deviceId;
		this.deviceParameterId = deviceParameterId;
		this.deleteFlag=deleteFlag;
		this.priority = priority;
		this.checked = checked;
		this.createBy=createBy;
		this.createDate=createDate;
		this.updateBy=updateBy;
		this.updateDate=updateDate;
	}

}