package com.dayuan3.common.bean;

import java.util.Date;

public class InspectionUnitUserLabel {
	
    public InspectionUnitUserLabel() {
		super();
	}

	public InspectionUnitUserLabel(Integer id, Integer userId, String labelName,Integer num) {
		super();
		this.id = id;
		this.userId = userId;
		this.labelName = labelName;
		this.num=num;
	}

	/**
     *
     */
    private Integer id;

    /**
     *送检用户ID
     */
    private Integer userId;

    /**
     *委托单位名称
     */
    private String labelName;

    /**
     *是否默认地址0否1是
     */
    private Short isdefault;

    /**
     *备注
     */
    private String remark;
    
    /**
     * 标签首字母
     */
    private String labelFirstLetter;

    /**
     * 标签全拼音
     */
    private String labelFullLetter;

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

    /**
     *删除状态：0_未删除,1_已删除
     */
    private Short deleteFlag;

    /**
     *创建人ID
     */
    private String createBy;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *修改人ID
     */
    private String updateBy;

    /**
     *修改时间
     */
    private Date updateDate;
    /**
     * 标签下委托单位数量
     */
    private Integer num;
    

    public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	/** 
     * Getter 
	 * @return inspection_unit_user_label.id 
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idinspection_unit_user_label.id
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 送检用户ID
	 * @return inspection_unit_user_label.user_id 送检用户ID
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Integer getUserId() {
        return userId;
    }

    /** 
     * Setter送检用户ID
	 * @param userIdinspection_unit_user_label.user_id
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /** 
     * Getter 委托单位名称
	 * @return inspection_unit_user_label.label_name 委托单位名称
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getLabelName() {
        return labelName;
    }

    /** 
     * Setter委托单位名称
	 * @param labelNameinspection_unit_user_label.label_name
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setLabelName(String labelName) {
        this.labelName = labelName == null ? null : labelName.trim();
    }

    /** 
     * Getter 是否默认地址0否1是
	 * @return inspection_unit_user_label.isDefault 是否默认地址0否1是
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Short getIsdefault() {
        return isdefault;
    }

    /** 
     * Setter是否默认地址0否1是
	 * @param isdefaultinspection_unit_user_label.isDefault
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setIsdefault(Short isdefault) {
        this.isdefault = isdefault;
    }

    /** 
     * Getter 备注
	 * @return inspection_unit_user_label.remark 备注
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getRemark() {
        return remark;
    }

    /** 
     * Setter备注
	 * @param remarkinspection_unit_user_label.remark
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /** 
     * Getter 预留参数1
	 * @return inspection_unit_user_label.param1 预留参数1
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1inspection_unit_user_label.param1
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return inspection_unit_user_label.param2 预留参数2
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2inspection_unit_user_label.param2
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return inspection_unit_user_label.param3 预留参数3
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3inspection_unit_user_label.param3
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    /** 
     * Getter 删除状态：0_未删除,1_已删除
	 * @return inspection_unit_user_label.delete_flag 删除状态：0_未删除,1_已删除
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态：0_未删除,1_已删除
	 * @param deleteFlaginspection_unit_user_label.delete_flag
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人ID
	 * @return inspection_unit_user_label.create_by 创建人ID
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人ID
	 * @param createByinspection_unit_user_label.create_by
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return inspection_unit_user_label.create_date 创建时间
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDateinspection_unit_user_label.create_date
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人ID
	 * @return inspection_unit_user_label.update_by 修改人ID
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人ID
	 * @param updateByinspection_unit_user_label.update_by
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return inspection_unit_user_label.update_date 修改时间
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDateinspection_unit_user_label.update_date
     *
     * @mbg.generated Fri Jan 03 09:21:48 CST 2020
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    public String getLabelFirstLetter() {
        return labelFirstLetter;
    }

    public void setLabelFirstLetter(String labelFirstLetter) {
        this.labelFirstLetter = labelFirstLetter == null ? null : labelFirstLetter.trim();
    }

    public String getLabelFullLetter() {
        return labelFullLetter;
    }

    public void setLabelFullLetter(String labelFullLetter) {
        this.labelFullLetter = labelFullLetter == null ? null : labelFullLetter.trim();
    }
}