package com.dayuan.bean.ledger;

import java.util.Date;

public class BaseLedgerHistory {
    /**
     *台账输入、搜索历史表
     */
    private Integer id;

    /**
     *历史记录id
     */
    private Integer userId;

    /**
     *用户类型0是其他1是进货台账用户2销售台账
     */
    private Short userType;

    /**
     *输入关键字/词
     */
    private String keyword;

    /**
     *关键字类型，0是市场名、1是档口2食品
     */
    private Short keyType;

    /**
     *查询次数
     */
    private Integer historyCount;

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
     *删除状态
     */
    private Short deleteFlag;
    /**
     * 经营户/市场 录入历史
     */
    private Short type;

    
    public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	/** 
     * Getter 台账输入、搜索历史表
	 * @return base_ledger_history.id 台账输入、搜索历史表
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter台账输入、搜索历史表
	 * @param idbase_ledger_history.id
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 历史记录id
	 * @return base_ledger_history.user_id 历史记录id
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Integer getUserId() {
        return userId;
    }

    /** 
     * Setter历史记录id
	 * @param userIdbase_ledger_history.user_id
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /** 
     * Getter 用户类型0是其他1是台账用户
	 * @return base_ledger_history.user_type 用户类型0是其他1是台账用户
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Short getUserType() {
        return userType;
    }

    /** 
     * Setter用户类型0是其他1是台账用户
	 * @param userTypebase_ledger_history.user_type
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setUserType(Short userType) {
        this.userType = userType;
    }

    /** 
     * Getter 输入关键字/词
	 * @return base_ledger_history.keyword 输入关键字/词
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public String getKeyword() {
        return keyword;
    }

    /** 
     * Setter输入关键字/词
	 * @param keywordbase_ledger_history.keyword
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    /** 
     * Getter 关键字类型，0是市场名、1是档口2食品
	 * @return base_ledger_history.key_type 关键字类型，0是市场名、1是档口2食品
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Short getKeyType() {
        return keyType;
    }

    /** 
     * Setter关键字类型，0是市场名、1是档口2食品
	 * @param keyTypebase_ledger_history.key_type
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setKeyType(Short keyType) {
        this.keyType = keyType;
    }

    /** 
     * Getter 查询次数
	 * @return base_ledger_history.history_count 查询次数
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Integer getHistoryCount() {
        return historyCount;
    }

    /** 
     * Setter查询次数
	 * @param historyCountbase_ledger_history.history_count
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setHistoryCount(Integer historyCount) {
        this.historyCount = historyCount;
    }

    /** 
     * Getter 创建人id
	 * @return base_ledger_history.create_by 创建人id
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createBybase_ledger_history.create_by
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return base_ledger_history.create_date 创建时间
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatebase_ledger_history.create_date
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return base_ledger_history.update_by 修改人id
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateBybase_ledger_history.update_by
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return base_ledger_history.update_date 修改时间
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatebase_ledger_history.update_date
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 删除状态
	 * @return base_ledger_history.delete_flag 删除状态
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagbase_ledger_history.delete_flag
     *
     * @mbg.generated Wed Jun 27 11:15:02 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }
}