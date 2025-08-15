package com.dayuan.model.app;

import java.util.Date;

import com.dayuan.bean.app.TbSignIn;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.BaseModel;

/**
 * 人员签到
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年3月2日
 */
public class TbSignInModel extends BaseModel {
	
	private int id;	//人员签到主键
	
	private String departName;	//机构名称
	
	private String pointName;	//检测点名称
	
    private String longitude;	//经度

    private String latitude;	//纬度

    private String address;	//地址
    
    private Short signType;//签到方式(0：app签到，1：app抽样，2微信签到，3上班打卡，4下班打卡

    protected Date createDate; //签到时间
    
    private String userId;  //账号ID
    
    private String userName;  //账号
    
    private String realname;  //姓名
    
    private String param1;	//签到类型 
    
    private String param2;	//抽样单号
    
    
    private Integer signCount;//签到次数  add by xiaoyl 2020/05/11
    
    private Integer samplingCount;//抽样签到次数 add by xiaoyl 2020/05/11
    
    private Integer punchCount;//上下班打卡次数 add by xiaoyl 2020/05/11
    
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getAddress() {
		if(address==null) {
			address="";
		}else {
			address=address.contains("null")  ? "" : address;
		}
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public Integer getSignCount() {
		return signCount;
	}

	public void setSignCount(Integer signCount) {
		this.signCount = signCount;
	}

	public Integer getSamplingCount() {
		return samplingCount;
	}

	public void setSamplingCount(Integer samplingCount) {
		this.samplingCount = samplingCount;
	}

	public Integer getPunchCount() {
		return punchCount;
	}

	public void setPunchCount(Integer punchCount) {
		this.punchCount = punchCount;
	}

	public Short getSignType() {
		return signType;
	}

	public void setSignType(Short signType) {
		this.signType = signType;
	}

}