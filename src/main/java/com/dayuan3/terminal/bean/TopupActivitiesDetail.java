package com.dayuan3.terminal.bean;

import java.math.BigDecimal;
import java.util.Date;

public class TopupActivitiesDetail {
	/**
     *主键
     */
    private Integer id;

    /**
     *优惠活动主表
     */
    private Integer actId;

    /**
     *充值金额
     */
    private BigDecimal actualMoney;

    /**
     *赠送金额
     */
    private BigDecimal giftMoney;

    /**
     *有效状态(0:无效,1:有效)
     */
    private Short checked;

    /**
     *排序
     */
    private Short sorting;

    /**
     *删除状态
     */
    private Short deleteFlag;

    /**
     *创建人员
     */
    private String createBy;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *更新人员
     */
    private String updateBy;

    /**
     *更新时间
     */
    private Date updateDate;

    /** 
     * Getter 主键
	 * @return topup_activities_detail.id 主键
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter主键
	 * @param idtopup_activities_detail.id
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 优惠活动主表
	 * @return topup_activities_detail.act_id 优惠活动主表
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Integer getActId() {
        return actId;
    }

    /** 
     * Setter优惠活动主表
	 * @param actIdtopup_activities_detail.act_id
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setActId(Integer actId) {
        this.actId = actId;
    }

    /** 
     * Getter 充值金额
	 * @return topup_activities_detail.actual_money 充值金额
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public BigDecimal getActualMoney() {
        return actualMoney;
    }

    /** 
     * Setter充值金额
	 * @param actualMoneytopup_activities_detail.actual_money
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setActualMoney(BigDecimal actualMoney) {
        this.actualMoney = actualMoney;
    }

    /** 
     * Getter 赠送金额
	 * @return topup_activities_detail.gift_money 赠送金额
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public BigDecimal getGiftMoney() {
        return giftMoney;
    }

    /** 
     * Setter赠送金额
	 * @param giftMoneytopup_activities_detail.gift_money
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setGiftMoney(BigDecimal giftMoney) {
        this.giftMoney = giftMoney;
    }

    /** 
     * Getter 有效状态(0:无效,1:有效)
	 * @return topup_activities_detail.checked 有效状态(0:无效,1:有效)
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Short getChecked() {
        return checked;
    }

    /** 
     * Setter有效状态(0:无效,1:有效)
	 * @param checkedtopup_activities_detail.checked
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setChecked(Short checked) {
        this.checked = checked;
    }

    /** 
     * Getter 排序
	 * @return topup_activities_detail.sorting 排序
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Short getSorting() {
        return sorting;
    }

    /** 
     * Setter排序
	 * @param sortingtopup_activities_detail.sorting
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

    /** 
     * Getter 删除状态
	 * @return topup_activities_detail.delete_flag 删除状态
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagtopup_activities_detail.delete_flag
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人员
	 * @return topup_activities_detail.create_by 创建人员
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人员
	 * @param createBytopup_activities_detail.create_by
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return topup_activities_detail.create_date 创建时间
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatetopup_activities_detail.create_date
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 更新人员
	 * @return topup_activities_detail.update_by 更新人员
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter更新人员
	 * @param updateBytopup_activities_detail.update_by
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 更新时间
	 * @return topup_activities_detail.update_date 更新时间
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter更新时间
	 * @param updateDatetopup_activities_detail.update_date
     *
     * @mbg.generated Tue Oct 29 09:55:58 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}