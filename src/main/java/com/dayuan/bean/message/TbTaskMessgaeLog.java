package com.dayuan.bean.message;

import java.util.Date;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
public class TbTaskMessgaeLog {
    private Integer id;

    private String messageId;

    private String userId;

    private Short readStatus;

    private Short deleteFlag = 0;

    private Date readTime;
    
    
    @Override
	public String toString() {
		return "TbTaskMessgaeLog [id=" + id + ", messageId=" + messageId + ", userId=" + userId + ", readStatus="
				+ readStatus + ", deleteFlag=" + deleteFlag + ", readTime=" + readTime + "]";
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId == null ? null : messageId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Short getReadStatus() {
        return readStatus;
    }

    public void setReadStatus(Short readStatus) {
        this.readStatus = readStatus;
    }

    public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Date getReadTime() {
        return readTime;
    }

    public void setReadTime(Date readTime) {
        this.readTime = readTime;
    }
}