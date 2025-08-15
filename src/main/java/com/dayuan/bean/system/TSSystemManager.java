package com.dayuan.bean.system;

import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

public class TSSystemManager {
    protected Integer id;           // 主键：id

    protected Short deleteFlag = 0; // 删除状态；0未删除，1删除

    protected String createBy;      // 创建人id

    protected Date createDate;      // 创建时间

    protected String updateBy;      // 修改人id

    protected Date updateDate;      // 修改时间

    private String appType;         //系统类型

    private String appName;         //软件名称

    private int version;            //版本号

    private String urlPath;         //下载路径

    private String description;     //摘要信息

    private Date impDate;           //启用日期

    private String param1;          //平台对外展示版本号

    private String introduce;        //软件简介

    private String param2;          //强制更新：0：否，1：是

    private String param3;          //操作文档路径

    private Double fileSize;        //软件大小

    private String startTime;       //启用时间

    private String startTime2;       //启用时间2用于界面展示

    private String fullName;         //后台上传文件真实名称(包括后缀名)

    private Short uploadState;       //是否平台上传(0:否 1:是)

    private Short patchState;       //是否补丁上传(0:否 1:是)

    private String versions;         //页面版本号

    private String updateContent;    //更新内容

    private String packgeFileName;        //文件名称，用于编辑时候的显示

    private String documentFileName;        //文件名称，用于编辑时候的显示

    public String getPackgeFileName() {
        return StringUtil.isNotEmpty(this.urlPath) ? this.urlPath.substring(this.urlPath.lastIndexOf("/") + 1) : "";
    }

    public void setPackgeFileName(String packgeFileName) {
        this.packgeFileName = packgeFileName;
    }

    public String getDocumentFileName() {
        return StringUtil.isNotEmpty(this.param3) ? this.param3.substring(this.param3.lastIndexOf("/") + 1) : "";
    }

    public void setDocumentFileName(String documentFileName) {
        this.documentFileName = documentFileName;
    }

    public Short getPatchState() {
        return patchState;
    }

    public void setPatchState(Short patchState) {
        this.patchState = patchState;
    }

    public String getUpdateContent() {
        return updateContent;
    }

    public void setUpdateContent(String updateContent) {
        this.updateContent = updateContent;
    }

    public String getVersions() {
        return this.param1 + "." + this.version;
    }

    public void setVersions(String versions) {
        this.versions = versions;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public Short getUploadState() {
        return uploadState;
    }

    public void setUploadState(Short uploadState) {
        this.uploadState = uploadState;
    }

    public Short getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
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
        this.updateBy = updateBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getStartTime() {
        return this.impDate == null ? "" : DateUtil.datetimeFormat.format(this.impDate);
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getStartTime2() {
        return this.impDate == null ? "" : DateUtil.date_sdf.format(this.impDate);
    }

    public void setStartTime2(String startTime2) {
        this.startTime2 = startTime2;
    }

    public Double getFileSize() {
        return fileSize;
    }

    public void setFileSize(Double fileSize) {
        this.fileSize = fileSize;
    }

    public String getAppType() {
        return appType;
    }

    public void setAppType(String appType) {
        this.appType = appType == null ? null : appType.trim();
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName == null ? null : appName.trim();
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public String getUrlPath() {
        return urlPath;
    }

    public void setUrlPath(String urlPath) {
        this.urlPath = urlPath == null ? null : urlPath.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getImpDate() {
        return impDate;
    }

    public void setImpDate(Date impDate) {
        this.impDate = impDate;
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    //不同型号仪器存放不同的路径
    public static String getPath(String str) {
        switch (str) {
            case "APP":
                return "APP/";
            case "DY-3500(I)":
                return "DY-3500/";
            case "DY-3500(P)":
                return "DY-3500/";
            case "DY-3500(BX1)":
                return "DY-3500/";
            case "LZ-4000(T)":
                return "LZ-4000/";
            case "LZ-7000":
                return "LZ-7000/";
            case "LZ3000":
                return "LZ3000/";
            case "DY-6400":
                return "DY-6400/";
            default:
                return "allUnknown/";
        }
    }
}