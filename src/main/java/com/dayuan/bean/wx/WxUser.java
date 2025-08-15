package com.dayuan.bean.wx;

import java.util.Date;

public class WxUser {
    /**
     *微信用户绑定表主键
     */
    private Integer id;

    /**
     *用户类型 0普通人1管理人员
     */
    private Short type;

    /**
     *手机号备用
     */
    private String phone;

    /**
     *用户表唯一id
     */
    private String userId;

    /**
     *微信用户昵称-备用
     */
    private String nickName;

    /**
     *微信用户唯一id
     */
    private String openid;

    /**
     *删除状态 1是已删除 0是未删除
     */
    private Short delete_flag;
    
    //是否允许绑定 0:否 1：是
    private Short status;
    
    
    
    

    public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	/**
     *创建时间
     */
    private Date create_date;

    /**
     *创建人id
     */
    private String create_by;

    /**
     *修改时间
     */
    private Date update_date;

    /**
     *修改人id
     */
    private String update_by;

    /**
     *修改时间
     */
    private Date delete_date;

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
    
    private String pwd;//登录密码
    private String realname;
    private String pname;
    private String dname;
    private Integer departId;//机构id
    private Integer pointId;//检测点id	
    private String userName;//用户名称
    private String password;//密码

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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

    public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

    /** 
     * Getter 微信用户绑定表主键
	 * @return wx_user.id 微信用户绑定表主键
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter微信用户绑定表主键
	 * @param idwx_user.id
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 预留字段 表示用户类型
	 * @return wx_user.type 预留字段 表示用户类型
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Short getType() {
        return type;
    }

    /** 
     * Setter预留字段 表示用户类型
	 * @param typewx_user.type
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setType(Short type) {
        this.type = type;
    }

    /** 
     * Getter 手机号备用
	 * @return wx_user.phone 手机号备用
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getPhone() {
        return phone;
    }

    /** 
     * Setter手机号备用
	 * @param phonewx_user.phone
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    /** 
     * Getter 用户表唯一id
	 * @return wx_user.userId 用户表唯一id
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getUserId() {
        return userId;
    }

    /** 
     * Setter用户表唯一id
	 * @param userIdwx_user.userId
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /** 
     * Getter 微信用户昵称-备用
	 * @return wx_user.nickName 微信用户昵称-备用
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getNickName() {
        return nickName;
    }

    /** 
     * Setter微信用户昵称-备用
	 * @param nickNamewx_user.nickName
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    /** 
     * Getter 微信用户唯一id
	 * @return wx_user.openid 微信用户唯一id
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getOpenid() {
        return openid;
    }

    /** 
     * Setter微信用户唯一id
	 * @param openidwx_user.openid
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setOpenid(String openid) {
        this.openid = openid == null ? null : openid.trim();
    }

    /** 
     * Getter 删除状态 1是已删除 0是未删除
	 * @return wx_user.delete_flag 删除状态 1是已删除 0是未删除
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Short getDelete_flag() {
        return delete_flag;
    }

    /** 
     * Setter删除状态 1是已删除 0是未删除
	 * @param delete_flagwx_user.delete_flag
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setDelete_flag(Short delete_flag) {
        this.delete_flag = delete_flag;
    }

    /** 
     * Getter 创建时间
	 * @return wx_user.create_date 创建时间
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Date getCreate_date() {
        return create_date;
    }

    /** 
     * Setter创建时间
	 * @param create_datewx_user.create_date
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    /** 
     * Getter 创建人id
	 * @return wx_user.create_by 创建人id
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getCreate_by() {
        return create_by;
    }

    /** 
     * Setter创建人id
	 * @param create_bywx_user.create_by
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setCreate_by(String create_by) {
        this.create_by = create_by == null ? null : create_by.trim();
    }

    /** 
     * Getter 修改时间
	 * @return wx_user.update_date 修改时间
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Date getUpdate_date() {
        return update_date;
    }

    /** 
     * Setter修改时间
	 * @param update_datewx_user.update_date
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    /** 
     * Getter 修改人id
	 * @return wx_user.update_by 修改人id
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getUpdate_by() {
        return update_by;
    }

    /** 
     * Setter修改人id
	 * @param update_bywx_user.update_by
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setUpdate_by(String update_by) {
        this.update_by = update_by == null ? null : update_by.trim();
    }

    /** 
     * Getter 修改时间
	 * @return wx_user.delete_date 修改时间
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public Date getDelete_date() {
        return delete_date;
    }

    /** 
     * Setter修改时间
	 * @param delete_datewx_user.delete_date
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setDelete_date(Date delete_date) {
        this.delete_date = delete_date;
    }

    /** 
     * Getter 预留参数1
	 * @return wx_user.param1 预留参数1
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1wx_user.param1
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return wx_user.param2 预留参数2
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2wx_user.param2
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return wx_user.param3 预留参数3
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3wx_user.param3
     *
     * @mbg.generated Tue May 22 11:51:12 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}