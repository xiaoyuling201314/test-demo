package com.dayuan.bean.app;

import java.util.Date;

/**
 * 记录用户最后一次签到记录
 * tb_sign_last
 */
public class TbSignLast  {
	
    public TbSignLast() {
		super();
	}

	public TbSignLast(String userId, String userName, Short signType, String longitude, String latitude,
			String signAddress, Date signDate, String param1, String param2, String param3) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.signType = signType;
		this.longitude = longitude;
		this.latitude = latitude;
		this.signAddress = signAddress;
		this.signDate = signDate;
		this.param1 = param1;
		this.param2 = param2;
		this.param3 = param3;
	}

	/**
     * ID
     */
    private Integer id;

    /**
     *  用户ID
     */
    private String userId;

    /**
     *  用户姓名
     */
    private String userName;

    /**
     * 签到方式(0：app签到，1：app抽样，2微信签到，3上班打卡，4下班打卡)
     */
    private Short signType;

    /**
     * 经度
     */
    private String longitude;

    /**
     * 纬度
     */
    private String latitude;

    /**
     * 签到地址
     */
    private String signAddress;

    /**
     * 最后一次签到时间
     */
    private Date signDate;

    /**
     * 预留字段1
     */
    private String param1;

    /**
     * 预留字段2
     */
    private String param2;

    /**
     * 预留字段3
     */
    private String param3;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id =id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public Short getSignType() {
        return signType;
    }

    public void setSignType(Short signType) {
        this.signType = signType;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    public String getSignAddress() {
        return signAddress;
    }

    public void setSignAddress(String signAddress) {
        this.signAddress = signAddress == null ? null : signAddress.trim();
    }

    public Date getSignDate() {
        return signDate;
    }

    public void setSignDate(Date signDate) {
        this.signDate = signDate;
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
}