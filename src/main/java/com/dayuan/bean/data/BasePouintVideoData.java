package com.dayuan.bean.data;

import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

/**
 * 视屏资料
 * createBy:shit 2018/5/10
 */
public class BasePouintVideoData {
    public static final Integer VIDEO_STATE_NO = 0;//未审核状态
    public static final Integer VIDEO_STATE_OK = 1;//已审核状态
    private Integer id;

    private String title;                 // 视屏名称

    private Date uptime;                  // 上传时间

    private String src;                   // 视屏保存路径

    private Integer state;                //状态

    private String remark;                // 备注信息

    private String userId;                //上传人员id

    private Double fileSize;                //上传人员id

    private MultipartFile file;             //文件

    private Integer videoType;                 //类型

    private String updateBy;                   //更新人id

    private Date updateDate;                   //更新时间

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getVideoType() {
        return videoType;
    }

    public void setVideoType(Integer videoType) {
        this.videoType = videoType;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

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
