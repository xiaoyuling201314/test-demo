package com.dayuan3.common.bean;

import java.util.Date;

public class OrderObjhistory {
    /**
     *id主键
     */
    private Integer id;

    /**
     *用户类型-预留字段
     */
    private Short userType;

    /**
     *输入关键字/词
     */
    private String keyword;

    /**
     *对应表主键id
     */
    private Integer keyId;

    /**
     *关键字类型，0:来源、1:档口
     */
    private Short keyType;

    /**
     *来源，当key_type=1时，会存入
     */
    private String regname;

    /**
     *查询次数
     */
    private Integer historyCount;

    /**
     *inspection_unit_user表主键id
     */
    private Integer createBy;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *修改人id
     */
    private Integer updateBy;

    /**
     *修改时间
     */
    private Date updateDate;

    /**
     *删除状态
     */
    private Short deleteFlag;

    /**
     *存储类型-预留字段
     */
    private Short type;

    /** 
     * Getter id主键
	 * @return order_obj_history.id id主键
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setterid主键
	 * @param idorder_obj_history.id
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 用户类型-预留字段
	 * @return order_obj_history.user_type 用户类型-预留字段
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Short getUserType() {
        return userType;
    }

    /** 
     * Setter用户类型-预留字段
	 * @param userTypeorder_obj_history.user_type
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setUserType(Short userType) {
        this.userType = userType;
    }

    /** 
     * Getter 输入关键字/词
	 * @return order_obj_history.keyword 输入关键字/词
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public String getKeyword() {
        return keyword;
    }

    /** 
     * Setter输入关键字/词
	 * @param keywordorder_obj_history.keyword
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    /** 
     * Getter 对应表主键id
	 * @return order_obj_history.key_id 对应表主键id
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Integer getKeyId() {
        return keyId;
    }

    /** 
     * Setter对应表主键id
	 * @param keyIdorder_obj_history.key_id
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setKeyId(Integer keyId) {
        this.keyId = keyId;
    }

    /** 
     * Getter 关键字类型，0:来源、1:档口
	 * @return order_obj_history.key_type 关键字类型，0:来源、1:档口
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Short getKeyType() {
        return keyType;
    }

    /** 
     * Setter关键字类型，0:来源、1:档口
	 * @param keyTypeorder_obj_history.key_type
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setKeyType(Short keyType) {
        this.keyType = keyType;
    }

    /** 
     * Getter 来源，当key_type=1时，会存入
	 * @return order_obj_history.regname 来源，当key_type=1时，会存入
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public String getRegname() {
        return regname;
    }

    /** 
     * Setter来源，当key_type=1时，会存入
	 * @param regnameorder_obj_history.regname
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setRegname(String regname) {
        this.regname = regname == null ? null : regname.trim();
    }

    /** 
     * Getter 查询次数
	 * @return order_obj_history.history_count 查询次数
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Integer getHistoryCount() {
        return historyCount;
    }

    /** 
     * Setter查询次数
	 * @param historyCountorder_obj_history.history_count
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setHistoryCount(Integer historyCount) {
        this.historyCount = historyCount;
    }

    /** 
     * Getter inspection_unit_user表主键id
	 * @return order_obj_history.create_by inspection_unit_user表主键id
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Integer getCreateBy() {
        return createBy;
    }

    /** 
     * Setterinspection_unit_user表主键id
	 * @param createByorder_obj_history.create_by
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    /** 
     * Getter 创建时间
	 * @return order_obj_history.create_date 创建时间
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDateorder_obj_history.create_date
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return order_obj_history.update_by 修改人id
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Integer getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateByorder_obj_history.update_by
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    /** 
     * Getter 修改时间
	 * @return order_obj_history.update_date 修改时间
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDateorder_obj_history.update_date
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 删除状态
	 * @return order_obj_history.delete_flag 删除状态
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagorder_obj_history.delete_flag
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 存储类型-预留字段
	 * @return order_obj_history.type 存储类型-预留字段
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public Short getType() {
        return type;
    }

    /** 
     * Setter存储类型-预留字段
	 * @param typeorder_obj_history.type
     *
     * @mbg.generated Tue Jul 23 08:59:00 CST 2019
     */
    public void setType(Short type) {
        this.type = type;
    }
}