package com.dayuan3.common.bean;

import java.math.BigDecimal;
import java.util.Date;

import com.dayuan.model.BaseModel;

/**
 * 送检报告单价管理
 * @author xiaoyl
 * @date   2020年1月3日
 */
public class InspectionReportPrice extends BaseModel{
    /**
     * 
     */
    private Integer id;

    /**
     * 送检单位ID，ID为空时表示全局单价，为配置单价的单位按照此标准进行计算
     */
    private Integer inspectionUnitId;
    
    //送检单位名称
    private String  companyName;
    
    /**
     * 报告费单价
     */
    private double reportPrice;

    /**
     * 0未审核，1审核
     */
    private Short checked;

    /**
     * 备注
     */
    private String remark;

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

    /**
     * 删除状态：0_未删除,1_已删除
     */
    private Short deleteFlag=0;

    /**
     * 创建人ID
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改人ID
     */
    private String updateBy;

    /**
     * 修改时间
     */
    private Date updateDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getInspectionUnitId() {
        return inspectionUnitId;
    }

    public void setInspectionUnitId(Integer inspectionUnitId) {
        this.inspectionUnitId = inspectionUnitId;
    }

    public double getReportPrice() {
        return reportPrice;
    }

    public void setReportPrice(double reportPrice) {
        this.reportPrice = reportPrice;
    }

    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
    
    
}