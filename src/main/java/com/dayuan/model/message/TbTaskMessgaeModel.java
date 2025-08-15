package com.dayuan.model.message;

import java.util.Date;

import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.model.BaseModel;

public class TbTaskMessgaeModel extends BaseModel{
	private String id;

    private String fromUserId;

    private String toUserId;

    private String toUserType;

    private String title;

    private String filePath;

    private Date sendtime;

    private String fileName;

	private String departName;

    private String content;
    
    private Integer groupId;
    
    private String realname;  //昵称
    
    private String userName;
    
	private String messageId;
	
	private Short deleteFlag;
	
	private String groupPointId;//检测点ID
	
	private Short flag;//标识：1检测任务，2消息
	
	public Short getFlag() {
		return flag;
	}

	public void setFlag(Short flag) {
		this.flag = flag;
	}

	public String getGroupPointId() {
		return groupPointId;
	}

	public void setGroupPointId(String groupPointId) {
		this.groupPointId = groupPointId;
	}

	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getMessageId() {
		return messageId;
	}

	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFromUserId() {
		return fromUserId;
	}

	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId;
	}

	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
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
		this.title = title;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	public String getFilename() {
		return fileName;
	}

	public void setFilename(String fileName) {
		this.fileName = fileName;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	private TbTaskMessgae tbTaskMessgae;

	public TbTaskMessgae getTbTaskMessgae() {
		return tbTaskMessgae;
	}

	public void setTbTaskMessgae(TbTaskMessgae tbTaskMessgae) {
		this.tbTaskMessgae = tbTaskMessgae;
	}

}
