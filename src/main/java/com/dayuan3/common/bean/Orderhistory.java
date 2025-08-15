package com.dayuan3.common.bean;

import java.util.Date;

public class Orderhistory {
    /**
     *主键id
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
     *关键字类型，0:委托单位、1:样品
     */
    private Short keyType;

    /**
     *存储类型:0存储key_id、1存储关键字keyword 
     */
    private Short type;

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
     * Getter 主键id
	 * @return order_history.id 主键id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter主键id
	 * @param idorder_history.id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 用户类型-预留字段
	 * @return order_history.user_type 用户类型-预留字段
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Short getUserType() {
        return userType;
    }

    /** 
     * Setter用户类型-预留字段
	 * @param userTypeorder_history.user_type
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setUserType(Short userType) {
        this.userType = userType;
    }

    /** 
     * Getter 输入关键字/词
	 * @return order_history.keyword 输入关键字/词
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public String getKeyword() {
        return keyword;
    }

    /** 
     * Setter输入关键字/词
	 * @param keywordorder_history.keyword
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    /** 
     * Getter 对应表主键id
	 * @return order_history.key_id 对应表主键id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Integer getKeyId() {
        return keyId;
    }

    /** 
     * Setter对应表主键id
	 * @param keyIdorder_history.key_id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setKeyId(Integer keyId) {
        this.keyId = keyId;
    }

    /** 
     * Getter 关键字类型，0:委托单位、1:样品
	 * @return order_history.key_type 关键字类型，0:委托单位、1:样品
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Short getKeyType() {
        return keyType;
    }

    /** 
     * Setter关键字类型，0:委托单位、1:样品
	 * @param keyTypeorder_history.key_type
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setKeyType(Short keyType) {
        this.keyType = keyType;
    }

    /** 
     * Getter 存储类型:0存储key_id、1存储关键字keyword 
	 * @return order_history.type 存储类型:0存储key_id、1存储关键字keyword 
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Short getType() {
        return type;
    }

    /** 
     * Setter存储类型:0存储key_id、1存储关键字keyword 
	 * @param typeorder_history.type
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setType(Short type) {
        this.type = type;
    }

    /** 
     * Getter 查询次数
	 * @return order_history.history_count 查询次数
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Integer getHistoryCount() {
        return historyCount;
    }

    /** 
     * Setter查询次数
	 * @param historyCountorder_history.history_count
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setHistoryCount(Integer historyCount) {
        this.historyCount = historyCount;
    }

    /** 
     * Getter inspection_unit_user表主键id
	 * @return order_history.create_by inspection_unit_user表主键id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Integer getCreateBy() {
        return createBy;
    }

    /** 
     * Setterinspection_unit_user表主键id
	 * @param createByorder_history.create_by
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    /** 
     * Getter 创建时间
	 * @return order_history.create_date 创建时间
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDateorder_history.create_date
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return order_history.update_by 修改人id
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Integer getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateByorder_history.update_by
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    /** 
     * Getter 修改时间
	 * @return order_history.update_date 修改时间
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDateorder_history.update_date
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 删除状态
	 * @return order_history.delete_flag 删除状态
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagorder_history.delete_flag
     *
     * @mbg.generated Thu Jul 18 14:16:23 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }
}