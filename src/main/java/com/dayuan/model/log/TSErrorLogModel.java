package com.dayuan.model.log;

import com.dayuan.model.BaseModel;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
 * 仪器错误日志
 *
 * @author shit
 * @Description:
 * @Company:
 * @date 2018年6月21日
 */
public class TSErrorLogModel extends BaseModel {
    //主键
    private Integer id;
    //仪器类型(APP | DY-3500(I))
    private String deviceType;
    //出厂编码
    private String deviceCode;
    //仪器版本
    private String deviceVersion;
    //仪器唯一标识
    private String serialNumber;
    //操作系统版本
    private String systemVersion;
    //发生时间
    private Date time;
    //创建人id
    private String createBy;
    //创建人名称
    private String createName;

    //创建时间
    private Date createDate;
    //错误信息
    private String errorMessage;

    private String keyword;             //用于高级查询的模糊查询

    private String startTime; //开始时间

    private String endTime; //结束时间

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getKeyword() {
        return StringUtils.hasLength(keyword) ? keyword : null;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType == null ? null : deviceType.trim();
    }

    public String getDeviceCode() {
        return deviceCode;
    }

    public void setDeviceCode(String deviceCode) {
        this.deviceCode = deviceCode == null ? null : deviceCode.trim();
    }

    public String getDeviceVersion() {
        return deviceVersion;
    }

    public void setDeviceVersion(String deviceVersion) {
        this.deviceVersion = deviceVersion == null ? null : deviceVersion.trim();
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber == null ? null : serialNumber.trim();
    }

    public String getSystemVersion() {
        return systemVersion;
    }

    public void setSystemVersion(String systemVersion) {
        this.systemVersion = systemVersion == null ? null : systemVersion.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
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

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage == null ? null : errorMessage.trim();
    }
}