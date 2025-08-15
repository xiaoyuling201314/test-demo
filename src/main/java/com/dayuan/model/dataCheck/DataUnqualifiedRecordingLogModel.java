package com.dayuan.model.dataCheck;

import com.dayuan.model.BaseModel;

import java.util.Date;

public class DataUnqualifiedRecordingLogModel extends BaseModel {
    private Integer id;          //主键
    private Integer durId;       //不合格数据表ID data_unqualified_recording.id
    private Short sendState;     //发送状态:0发送成功,1发送失败,2发送失败
    private String content;      //日志内容
    private String userName;     //发送人名称
    private String realname;     //发送人昵称
    private Date sendTime;       //发送时间
    private String sendRemark;   //发送短信的备注信息
    private String createBy;     //创建人id
    private Date createDate;     //创建时间
    private String updateBy;     //修改人id
    private Date updateDate;     //修改时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDurId() {
        return durId;
    }

    public void setDurId(Integer durId) {
        this.durId = durId;
    }

    public Short getSendState() {
        return sendState;
    }

    public void setSendState(Short sendState) {
        this.sendState = sendState;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
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

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getSendRemark() {
        return sendRemark;
    }

    public void setSendRemark(String sendRemark) {
        this.sendRemark = sendRemark;
    }
}