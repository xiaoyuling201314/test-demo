package com.dayuan3.terminal.model;

import com.dayuan.model.BaseModel;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 发票model
 * 
 * @author Dz
 * @date 2019年10月23日
 */
public class InvoiceModel extends BaseModel {
    /**
     *主键
     */
    private Integer id;

    /**
     *抬头类型0企业单位1个人/非企业单位
     */
    private Short type;

    /**
     *发票抬头
     */
    private String title;

    /**
     *税号
     */
    private String tallageno;

    /**
     *流水号
     */
    private String number;

    /**
     *备注
     */
    private String remark;

    /**
     *税金
     */
    private BigDecimal price;

    /**
     *开票时间
     */
    private Date invoiceDate;

    /**
     *发票状态0处理中1成功2失败
     */
    private Short status;

    /**
     *邮箱
     */
    private String email;

    /**
     * 发票地址
     */
    private String filePath;

    /**
     * 订单主键
     */
    private Integer samplingId;

    /**
     * 订单号
     */
    private String samplingNo;

    /**
     * 开票人姓名
     */
    private String username;

    /**
     * 开票人联系方式
     */
    private String phone;

    /************* 查询条件 *************/
    private String startTimeStr;
    private String endTimeStr;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTallageno() {
        return tallageno;
    }

    public void setTallageno(String tallageno) {
        this.tallageno = tallageno;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Integer getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(Integer samplingId) {
        this.samplingId = samplingId;
    }

    public String getSamplingNo() {
        return samplingNo;
    }

    public void setSamplingNo(String samplingNo) {
        this.samplingNo = samplingNo;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStartTimeStr() {
        return startTimeStr;
    }

    public void setStartTimeStr(String startTimeStr) {
        this.startTimeStr = startTimeStr;
    }

    public String getEndTimeStr() {
        return endTimeStr;
    }

    public void setEndTimeStr(String endTimeStr) {
        this.endTimeStr = endTimeStr;
    }
}