package com.dayuan.model.data;

import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * Created by dy on 2018/5/10.
 */
public class BasePointVideoDataModel extends BaseModel {
    private Integer id;

    private String title;                 // 视屏名称

    private Date uptime;                  // 上传时间

    private String src;                   // 视屏保存路径

    private Integer state;                //状态

    private String remark;                // 备注信息

    private String userId;                //上传人员id

    private Double fileSize;                //文件大小


    public Double getFileSize() {
        return fileSize;
    }

    public void setFileSize(Double fileSize) {
        this.fileSize = fileSize;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getUptime() {
        return uptime;
    }

    public void setUptime(Date uptime) {
        this.uptime = uptime;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
