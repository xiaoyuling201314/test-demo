package com.dayuan.bean.message;

import java.util.Date;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
public class TbTaskMessgae{
    private Integer id;

    private String fromUserId;

    private String toUserId;

    private String toUserType;

    private String title;

    private String filePath;

    private Date sendtime;

    private String fileName;

    private Integer groupId;

    private String content;
    
    private Short deleteFlag;
    
    private Integer groupPointId;
    
    public Integer getGroupPointId() {
		return groupPointId;
	}

	public void setGroupPointId(Integer groupPointId) {
		this.groupPointId = groupPointId;
	}

	@Override
	public String toString() {
		return "TbTaskMessgae [id=" + id + ", fromUserId=" + fromUserId + ", toUserId=" + toUserId + ", toUserType="
				+ toUserType + ", title=" + title + ", filePath=" + filePath + ", sendtime=" + sendtime + ", fileName="
				+ fileName + ", groupId=" + groupId + ", content=" + content + "]";
	}
    
    public Short getDeleteFlag() {
		return deleteFlag;
	}


	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFromUserId() {
        return fromUserId;
    }

    public void setFromUserId(String fromUserId) {
        this.fromUserId = fromUserId == null ? null : fromUserId.trim();
    }

    public String getToUserId() {
        return toUserId;
    }

    public void setToUserId(String toUserId) {
        this.toUserId = toUserId == null ? null : toUserId.trim();
    }

    public String getToUserType() {
        return toUserType;
    }

    public void setToUserType(String toUserType) {
        this.toUserType = toUserType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}