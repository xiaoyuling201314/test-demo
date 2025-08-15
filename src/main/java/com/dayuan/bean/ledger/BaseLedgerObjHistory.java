package com.dayuan.bean.ledger;

import java.util.Date;

public class BaseLedgerObjHistory {
    /**
     *id主键
     */
    private Integer id;

    /**
     *用户id
     */
    private Integer userId;

    /**
     *用户类型0经营户1市场2食药监
     */
    private Short userType;

    /**
     *输入关键字/词
     */
    private String keyword;

    /**
     *关键字类型，0是进货1销售
     */
    private Short keyType;

    /**
     *市场名称
     */
    private String regname;

    /**
     *经营户：当关键词类型为档口时有值
     */
    private String opeUser;

    /**
     *电话：当关键词类型为档口时有值
     */
    private String phone;

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
    
    private Short type;

    
    public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	/** 
     * Getter id主键
	 * @return base_ledger_obj_history.id id主键
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setterid主键
	 * @param idbase_ledger_obj_history.id
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 用户id
	 * @return base_ledger_obj_history.user_id 用户id
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Integer getUserId() {
        return userId;
    }

    /** 
     * Setter用户id
	 * @param userIdbase_ledger_obj_history.user_id
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /** 
     * Getter 用户类型0经营户1市场2食药监
	 * @return base_ledger_obj_history.user_type 用户类型0经营户1市场2食药监
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Short getUserType() {
        return userType;
    }

    /** 
     * Setter用户类型0经营户1市场2食药监
	 * @param userTypebase_ledger_obj_history.user_type
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setUserType(Short userType) {
        this.userType = userType;
    }

    /** 
     * Getter 输入关键字/词
	 * @return base_ledger_obj_history.keyword 输入关键字/词
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getKeyword() {
        return keyword;
    }

    /** 
     * Setter输入关键字/词
	 * @param keywordbase_ledger_obj_history.keyword
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setKeyword(String keyword) {
        this.keyword = keyword == null ? null : keyword.trim();
    }

    /** 
     * Getter 关键字类型，0是进货1销售市场
	 * @return base_ledger_obj_history.key_type 关键字类型，0是进货1销售市场
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Short getKeyType() {
        return keyType;
    }

    /** 
     * Setter关键字类型，0是进货1销售市场
	 * @param keyTypebase_ledger_obj_history.key_type
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setKeyType(Short keyType) {
        this.keyType = keyType;
    }

    /** 
     * Getter 市场名称
	 * @return base_ledger_obj_history.regName 市场名称
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getRegname() {
        return regname;
    }

    /** 
     * Setter市场名称
	 * @param regnamebase_ledger_obj_history.regName
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setRegname(String regname) {
        this.regname = regname == null ? null : regname.trim();
    }

    /** 
     * Getter 经营户：当关键词类型为档口时有值
	 * @return base_ledger_obj_history.ope_user 经营户：当关键词类型为档口时有值
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getOpeUser() {
        return opeUser;
    }

    /** 
     * Setter经营户：当关键词类型为档口时有值
	 * @param opeUserbase_ledger_obj_history.ope_user
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setOpeUser(String opeUser) {
        this.opeUser = opeUser == null ? null : opeUser.trim();
    }

    /** 
     * Getter 电话：当关键词类型为档口时有值
	 * @return base_ledger_obj_history.phone 电话：当关键词类型为档口时有值
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getPhone() {
        return phone;
    }

    /** 
     * Setter电话：当关键词类型为档口时有值
	 * @param phonebase_ledger_obj_history.phone
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    /** 
     * Getter 查询次数
	 * @return base_ledger_obj_history.history_count 查询次数
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Integer getHistoryCount() {
        return historyCount;
    }

    /** 
     * Setter查询次数
	 * @param historyCountbase_ledger_obj_history.history_count
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setHistoryCount(Integer historyCount) {
        this.historyCount = historyCount;
    }

    /** 
     * Getter 创建人id
	 * @return base_ledger_obj_history.create_by 创建人id
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createBybase_ledger_obj_history.create_by
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return base_ledger_obj_history.create_date 创建时间
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatebase_ledger_obj_history.create_date
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return base_ledger_obj_history.update_by 修改人id
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateBybase_ledger_obj_history.update_by
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return base_ledger_obj_history.update_date 修改时间
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatebase_ledger_obj_history.update_date
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 删除状态
	 * @return base_ledger_obj_history.delete_flag 删除状态
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagbase_ledger_obj_history.delete_flag
     *
     * @mbg.generated Wed Jul 04 16:35:33 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }
}