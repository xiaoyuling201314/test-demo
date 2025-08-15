package com.dayuan.bean.data;

import java.util.Date;

import com.dayuan.bean.BaseBean;

/**
 * 检测机构、点人员关联表
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年9月1日
 */
public class BasePointUser extends BaseBean {

	//检测机构ID
    private Integer departId;
    //检测点ID
    private Integer pointId;
    //用户ID
    private String userId;
	//当前项目职位
    private String positionCode;
    //项目开始时间
    private Date startTime;
    //项目结束时间
    private Date endTime;
    //预留参数1
    private String param1;
    //预留参数2
    private String param2;
    //预留参数3
    private String param3;
    
    /***********************非数据库字段，用于页面显示*******************************/
    //用户名
    private String workerName;
    //人员默认职位
    private String position;
    //联系电话
    private String mobilePhone;
    //邮箱
    private String email;
    //状态
    private Short status;
    //机构名称
    private String departName;
    //检测点名称
    private String pointName;
    
    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

	public String getWorkerName() {
		return workerName;
	}

	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
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

	public String getPositionCode() {
		return positionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

}