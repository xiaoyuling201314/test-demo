package com.dayuan.logs.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * tb_qrcode_scan_count
 * @author 
 */
public class TbQrcodeScanCount implements Serializable {
    public TbQrcodeScanCount() {
    }

    public TbQrcodeScanCount(String module, Short scanType, String scanParam, Integer scanNumber,Date createDate) {
        this.module = module;
        this.scanParam = scanParam;
        this.scanType = scanType;
        this.scanNumber = scanNumber;
        this.createDate=createDate;
    }

    /**
     * ID
     */
    private Integer id;

    /**
     * 操作模块
     */
    private String module;

    /**
     * 扫描对象ID或抽样单号
     */
    private String scanParam;

    /**
     * 扫描类型：0 抽样单，1 监管对象，2 经营户
     */
    private Short scanType;

    /**
     * 扫描次数
     */
    private Integer scanNumber;

    /**
     * 删除状态
     */
    private Short deleteFlag;

    /**
     * 创建人id
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改时间
     */
    private Date updateDate;

    /**
     * 预留参数1
     */
    private String param1;

    /**
     * 预留参数2
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public Short getScanType() {
        return scanType;
    }

    public void setScanType(Short scanType) {
        this.scanType = scanType;
    }

    public Integer getScanNumber() {
        return scanNumber;
    }

    public void setScanNumber(Integer scanNumber) {
        this.scanNumber = scanNumber;
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

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1;
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2;
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3;
    }

    public String getScanParam() {
        return scanParam;
    }

    public void setScanParam(String scanParam) {
        this.scanParam = scanParam;
    }
}