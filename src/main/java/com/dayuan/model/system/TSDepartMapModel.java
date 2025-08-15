package com.dayuan.model.system;

import java.util.Date;

import com.dayuan.model.BaseModel;

public class TSDepartMapModel extends BaseModel {
    /**
     *机构经纬度表PK主键
     */
    private Integer id;

    /**
     *机构表主键id
     */
    private Integer departId;
    /**
     *机构表主键id
     */
    private Integer departPid;

    /**
     *经度
     */
    private String longitude;

    /**
     *纬度
     */
    private String latitude;

    /**
     *是否显示在地图上0显示1不显示
     */
    private Short isshow;

    /**
     *是否删除0否1删除
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
    //用于项目汇总
    private String departCode;//机构code
    private String departName;//机构名称
    private String departCount;//仅子集机构数量
    private String pointCount;//全部下级检测点数量	
    private String regCount;//全部监管对象数量
    
    

    public Integer getDepartPid() {
		return departPid;
	}

	public void setDepartPid(Integer departPid) {
		this.departPid = departPid;
	}

	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getDepartCount() {
		return departCount;
	}

	public void setDepartCount(String departCount) {
		this.departCount = departCount;
	}

	public String getPointCount() {
		return pointCount;
	}

	public void setPointCount(String pointCount) {
		this.pointCount = pointCount;
	}

	public String getRegCount() {
		return regCount;
	}

	public void setRegCount(String regCount) {
		this.regCount = regCount;
	}

	/** 
     * Getter 机构经纬度表PK主键
	 * @return t_s_depart_map.id 机构经纬度表PK主键
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter机构经纬度表PK主键
	 * @param idt_s_depart_map.id
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 机构表主键id
	 * @return t_s_depart_map.depart_id 机构表主键id
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Integer getDepartId() {
        return departId;
    }

    /** 
     * Setter机构表主键id
	 * @param departIdt_s_depart_map.depart_id
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    /** 
     * Getter 经度
	 * @return t_s_depart_map.longitude 经度
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getLongitude() {
        return longitude;
    }

    /** 
     * Setter经度
	 * @param longitudet_s_depart_map.longitude
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    /** 
     * Getter 纬度
	 * @return t_s_depart_map.latitude 纬度
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getLatitude() {
        return latitude;
    }

    /** 
     * Setter纬度
	 * @param latitudet_s_depart_map.latitude
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    /** 
     * Getter 是否显示在地图上0显示1不显示
	 * @return t_s_depart_map.isShow 是否显示在地图上0显示1不显示
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Short getIsshow() {
        return isshow;
    }

    /** 
     * Setter是否显示在地图上0显示1不显示
	 * @param isshowt_s_depart_map.isShow
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setIsshow(Short isshow) {
        this.isshow = isshow;
    }

    /** 
     * Getter 是否删除0否1删除
	 * @return t_s_depart_map.delete_flag 是否删除0否1删除
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter是否删除0否1删除
	 * @param deleteFlagt_s_depart_map.delete_flag
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人id
	 * @return t_s_depart_map.create_by 创建人id
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createByt_s_depart_map.create_by
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return t_s_depart_map.create_date 创建时间
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatet_s_depart_map.create_date
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return t_s_depart_map.update_by 修改人id
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateByt_s_depart_map.update_by
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return t_s_depart_map.update_date 修改时间
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatet_s_depart_map.update_date
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 预留参数1
	 * @return t_s_depart_map.param1 预留参数1
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1t_s_depart_map.param1
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return t_s_depart_map.param2 预留参数2
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2t_s_depart_map.param2
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return t_s_depart_map.param3 预留参数3
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3t_s_depart_map.param3
     *
     * @mbg.generated Thu Sep 20 10:14:13 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}