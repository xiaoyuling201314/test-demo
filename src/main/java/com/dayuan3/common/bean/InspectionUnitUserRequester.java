package com.dayuan3.common.bean;

import java.util.Date;

public class InspectionUnitUserRequester {
    /**
     *
     */
    private Integer id;

    /**
     *标签表主键id
     */
    private Integer labelId;

    /**
     *委托单位ID
     */
    private Integer requestId;

    /**
     *委托单位名称
     */
    private String requestName;

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

    /********************非数据库字段**************************/
    /**
     * 委托单位联系电话  add by xiaoyl 2020/1/14
     */
    private String linkPhone;
    
    /**
     *	 委托单位地址  add by xiaoyl 2020/1/14
     */
    private String companyAddress;
    /** 
     * Getter 
	 * @return inspection_unit_user_requester.id 
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idinspection_unit_user_requester.id
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 标签表主键id
	 * @return inspection_unit_user_requester.label_id 标签表主键id
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Integer getLabelId() {
        return labelId;
    }

    /** 
     * Setter标签表主键id
	 * @param labelIdinspection_unit_user_requester.label_id
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setLabelId(Integer labelId) {
        this.labelId = labelId;
    }

    /** 
     * Getter 委托单位ID
	 * @return inspection_unit_user_requester.request_id 委托单位ID
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Integer getRequestId() {
        return requestId;
    }

    /** 
     * Setter委托单位ID
	 * @param requestIdinspection_unit_user_requester.request_id
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    /** 
     * Getter 委托单位名称
	 * @return inspection_unit_user_requester.request_name 委托单位名称
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getRequestName() {
        return requestName;
    }

    /** 
     * Setter委托单位名称
	 * @param requestNameinspection_unit_user_requester.request_name
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setRequestName(String requestName) {
        this.requestName = requestName == null ? null : requestName.trim();
    }

    /** 
     * Getter 预留参数1
	 * @return inspection_unit_user_requester.param1 预留参数1
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1inspection_unit_user_requester.param1
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return inspection_unit_user_requester.param2 预留参数2
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2inspection_unit_user_requester.param2
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return inspection_unit_user_requester.param3 预留参数3
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3inspection_unit_user_requester.param3
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    /** 
     * Getter 删除状态：0_未删除,1_已删除
	 * @return inspection_unit_user_requester.delete_flag 删除状态：0_未删除,1_已删除
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态：0_未删除,1_已删除
	 * @param deleteFlaginspection_unit_user_requester.delete_flag
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人ID
	 * @return inspection_unit_user_requester.create_by 创建人ID
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人ID
	 * @param createByinspection_unit_user_requester.create_by
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return inspection_unit_user_requester.create_date 创建时间
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDateinspection_unit_user_requester.create_date
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人ID
	 * @return inspection_unit_user_requester.update_by 修改人ID
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人ID
	 * @param updateByinspection_unit_user_requester.update_by
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return inspection_unit_user_requester.update_date 修改时间
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDateinspection_unit_user_requester.update_date
     *
     * @mbg.generated Fri Jan 03 09:19:21 CST 2020
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

	public String getLinkPhone() {
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
    
}