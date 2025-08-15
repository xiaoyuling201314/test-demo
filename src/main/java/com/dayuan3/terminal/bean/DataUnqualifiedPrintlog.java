package com.dayuan3.terminal.bean;

import java.util.Date;

/**
 * 	不合格复检单打印记录
 * @author xiaoyl
 * @date   2019年9月23日
 */
public class DataUnqualifiedPrintlog {
	
    public DataUnqualifiedPrintlog() {
		super();
	}

	public DataUnqualifiedPrintlog(Integer recordId, String createBy, String createUsername, Date createDate) {
		super();
		this.recordId = recordId;
		this.createBy = createBy;
		this.createUsername = createUsername;
		this.createDate = createDate;
	}

	/**
     * ID
     */
    private Integer id;

    /**
     * 检测记录ID
     */
    private Integer recordId;

    /**
     * 打印人id
     */
    private String createBy;

    /**
     * 打印人姓名
     */
    private String createUsername;

    /**
     * 打印时间
     */
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改人姓名
     */
    private String updateUsername;

    /**
     * 修改时间
     */
    private Date updateDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRecordId() {
        return recordId;
    }

    public void setRecordId(Integer recordId) {
        this.recordId = recordId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public String getCreateUsername() {
        return createUsername;
    }

    public void setCreateUsername(String createUsername) {
        this.createUsername = createUsername == null ? null : createUsername.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public String getUpdateUsername() {
        return updateUsername;
    }

    public void setUpdateUsername(String updateUsername) {
        this.updateUsername = updateUsername == null ? null : updateUsername.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}