package com.dayuan.model.wx;

import java.util.Date;

import com.dayuan.model.BaseModel;

public class WxsignInModel extends BaseModel {
    /**
     *自增主键
     */
    private Integer id;

    /**
     *经度
     */
    private String longitude;

    /**
     *纬度
     */
    private String latitude;

    /**
     *地址
     */
    private String address;

    /**
     *签到方式(0微信签到)
     */
    private Short signType;

    /**
     *是否删除
     */
    private Short deleteFlag;

    /**
     *创建人id
     */
    private String createBy;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *修改人id
     */
    private String updateBy;

    /**
     *修改时间
     */
    private Date updateDate;

    /**
     *预留参数1
     */
    private String param1;

    /**
     *预留参数2
     */
    private String param2;

    /**
     *预留参数3
     */
    private String param3;
    
    private Integer departId;
    private Integer pointId;
	private String departName;	//机构名称
	private String pointName;	//检测点名称
	private String userId;  //账号ID
	    
	 private String userName;  //账号
	    
	  private String nickName;  //姓名
	    

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	/** 
     * Getter 自增主键
	 * @return tb_wxsign_in.id 自增主键
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter自增主键
	 * @param idtb_wxsign_in.id
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 经度
	 * @return tb_wxsign_in.longitude 经度
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getLongitude() {
        return longitude;
    }

    /** 
     * Setter经度
	 * @param longitudetb_wxsign_in.longitude
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    /** 
     * Getter 纬度
	 * @return tb_wxsign_in.latitude 纬度
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getLatitude() {
        return latitude;
    }

    /** 
     * Setter纬度
	 * @param latitudetb_wxsign_in.latitude
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    /** 
     * Getter 地址
	 * @return tb_wxsign_in.address 地址
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getAddress() {
        return address;
    }

    /** 
     * Setter地址
	 * @param addresstb_wxsign_in.address
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    /** 
     * Getter 签到方式(0微信签到)
	 * @return tb_wxsign_in.sign_type 签到方式(0微信签到)
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public Short getSignType() {
        return signType;
    }

    /** 
     * Setter签到方式(0微信签到)
	 * @param signTypetb_wxsign_in.sign_type
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setSignType(Short signType) {
        this.signType = signType;
    }

    /** 
     * Getter 是否删除
	 * @return tb_wxsign_in.delete_flag 是否删除
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter是否删除
	 * @param deleteFlagtb_wxsign_in.delete_flag
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人id
	 * @return tb_wxsign_in.create_by 创建人id
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createBytb_wxsign_in.create_by
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return tb_wxsign_in.create_date 创建时间
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatetb_wxsign_in.create_date
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return tb_wxsign_in.update_by 修改人id
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateBytb_wxsign_in.update_by
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return tb_wxsign_in.update_date 修改时间
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatetb_wxsign_in.update_date
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 预留参数1
	 * @return tb_wxsign_in.param1 预留参数1
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1tb_wxsign_in.param1
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return tb_wxsign_in.param2 预留参数2
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2tb_wxsign_in.param2
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return tb_wxsign_in.param3 预留参数3
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3tb_wxsign_in.param3
     *
     * @mbg.generated Sat Jul 14 17:56:58 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}