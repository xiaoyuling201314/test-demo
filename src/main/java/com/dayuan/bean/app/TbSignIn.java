package com.dayuan.bean.app;

import com.dayuan.bean.BaseBean;

public class TbSignIn extends BaseBean{

    private String longitude;

    private String latitude;

    private String address;
    
    private Short signType;//签到方式(0：app签到，1：app抽样，2微信签到，3上班打卡，4下班打卡

    private String param1;	//签到方式(0：手机定位签到，1：抽样单签到)

    private String param2;	//抽样单号

    private String param3;

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
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

	public Short getSignType() {
		return signType;
	}

	public void setSignType(Short signType) {
		this.signType = signType;
	}
    
}