package com.dayuan.model.wx.inspection;

import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * 查看你送我检信息的用户
 * Created by dy on 2018/8/3.
 */
public class InspectionUserModel extends BaseModel {
    private Integer id;//主键

    private Integer regId;//送检人id

    private String userName;//用户名称

    private String password;//密码

    private String mobilePhone;//手机号码

    private String openid;//微信用户唯一id

    private String wechat;//微信号

    private Date createDate;//创建时间

    private String createBy;//创建人id

    private Date updateDate;//修改时间

    private String updateBy;//修改人id

    private String param1;//预留参数1

    private String param2;//预留参数2

    private String param3;//预留参数3
    /**
     *性别：男，女
     */
    private String sex;

    /**
     *用户个人资料填写的省份
     */
    private String province;

    /**
     *普通用户个人资料填写的城市
     */
    private String city;

    /**
     *国家
     */
    private String country;

    /**
     *头像路径（最后一个值表示正方形头像大小0，46，64,96，132可选，0表示大小为640*640）
     */
    private String headimgurl;

    /**
     *机构id，对应不同的微信公众号
     */
    private Integer departId;

    /**
     *微信昵称
     */
    private String nickName;

    /**
     *微信公众号唯一ID
     */
    private String appId;

    /**
     *绑定时间
     */
    private Date bindTime;

    /**
     *解绑时间
     */
    private Date relieveTime;
    
    private String dateStart;//开始时间
    private String dateEnd;//结束时间
    private String search;//搜索
    

    

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getHeadimgurl() {
		return headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}



	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public Date getBindTime() {
		return bindTime;
	}

	public void setBindTime(Date bindTime) {
		this.bindTime = bindTime;
	}

	public Date getRelieveTime() {
		return relieveTime;
	}

	public void setRelieveTime(Date relieveTime) {
		this.relieveTime = relieveTime;
	}

	private Integer inspectionNumber;//送检次数

    private Integer bindNumber = 0;//绑定的总次数,默认为0，避免数据库为null时导致null+1报错

    public Integer getInspectionNumber() {
        return inspectionNumber;
    }

    public void setInspectionNumber(Integer inspectionNumber) {
        this.inspectionNumber = inspectionNumber;
    }

    public Integer getBindNumber() {
        return bindNumber;
    }

    public void setBindNumber(Integer bindNumber) {
        this.bindNumber = bindNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
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
}
