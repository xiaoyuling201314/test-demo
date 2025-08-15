package com.dayuan.bean.detect;

import com.dayuan.bean.BaseBean;
/**
 * 快检车定位轨迹记录表
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月19日
 */
public class DetectCarLocation extends BaseBean {

    private String carImei;				//设备IMEI,关联base_point表的IMEI

    private String longitude;		//经度

    private String latitude;		//纬度

    private int speed;				//速度

    private String direction;			//方向

    private String positioningType;		//定位类型

    private String mobileCc;			//移动用户所属国家代号Mobile Country Code(MCC)

    private String mobileNc;			//移动网号码Mobile Network Code(MNC)

    private String locationAc;			//位置区码 Location Area Code (LAC)

    private String cellId;				//移动基站Cell Tower ID(Cell ID)

    private String param1;				//预留参数1

    private String param2;				//预留参数2

    private String param3;				//预留参数3

    /*****************非数据库字段，用于显示***********************/
    private String pointName;			//快检车名称
    
    private String licensePlate;		//车牌号码
    
    private String showDate;			//有轨迹的日期
    public String getCarImei() {
        return carImei;
    }

    public void setCarImei(String carImei) {
        this.carImei = carImei == null ? null : carImei.trim();
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

    public Integer getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction == null ? null : direction.trim();
    }

    public String getPositioningType() {
        return positioningType;
    }

    public void setPositioningType(String positioningType) {
        this.positioningType = positioningType == null ? null : positioningType.trim();
    }

    public String getMobileCc() {
        return mobileCc;
    }

    public void setMobileCc(String mobileCc) {
        this.mobileCc = mobileCc == null ? null : mobileCc.trim();
    }

    public String getMobileNc() {
        return mobileNc;
    }

    public void setMobileNc(String mobileNc) {
        this.mobileNc = mobileNc == null ? null : mobileNc.trim();
    }

    public String getLocationAc() {
        return locationAc;
    }

    public void setLocationAc(String locationAc) {
        this.locationAc = locationAc == null ? null : locationAc.trim();
    }

    public String getCellId() {
        return cellId;
    }

    public void setCellId(String cellId) {
        this.cellId = cellId == null ? null : cellId.trim();
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

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getLicensePlate() {
		return licensePlate;
	}

	public void setLicensePlate(String licensePlate) {
		this.licensePlate = licensePlate;
	}

	public String getShowDate() {
		return showDate;
	}

	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}
    
}