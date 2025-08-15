package com.dayuan3.common.bean;

import java.math.BigDecimal;
import java.util.Date;

import com.dayuan.model.BaseModel;

/**
 * 上门服务费
 * @author xiaoyl
 * @date   2020年3月2日
 */
public class TakeSamplingPrice extends BaseModel{
    /**
     * 
     */
    private Integer id;

    /**
     * 委托单位ID，ID为空时表示全局费用，未配置用户按照此标准进行计算
     */
    private Integer requesterUnitId;
    //委托单位名称
    private String  requesterUnit;

    /**
     * 上门服务费单价
     */
    private BigDecimal price;

    /**
     * 0未审核，1审核
     */
    private Short checked;

    /**
     * 说明
     */
    private String description;

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
    private Short deleteFlag = 0;
 
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

    public Integer getRequesterUnitId() {
        return requesterUnitId;
    }

    public void setRequesterUnitId(Integer requesterUnitId) {
        this.requesterUnitId = requesterUnitId;
    }

    public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
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

	public String getRequesterUnit() {
		return requesterUnit;
	}

	public void setRequesterUnit(String requesterUnit) {
		this.requesterUnit = requesterUnit;
	}
    
    
}