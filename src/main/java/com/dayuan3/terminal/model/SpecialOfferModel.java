package com.dayuan3.terminal.model;

import java.util.Date;

import com.dayuan.model.BaseModel;

public class SpecialOfferModel extends BaseModel{
    /**
     *
     */
    private Integer id;

    /**
     *活动主题
     */
    private String theme;

    /**
     *标题
     */
    private String title;

    /**
     *折扣，仅允许输入0-100之间的整数
     */
    private Integer discount;

    /**
     *活动开始时间
     */
    private Date timeStart;

    /**
     *活动结束时间
     */
    private Date timeEnd;

    /**
     *cron表达式
     */
    private String scheduled;

    /**
     *活动状态0准备状态1进行中，2终止
     */
    private Short status;

    /**
     *审核状态（0 未审核，1 已审核）
     */
    private Short checked;

    /**
     *定时器开启关闭状态0：关闭 1：开启
     */
    private Short off;

    /**
     *备注
     */
    private String remark;

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
     * Getter 
	 * @return special_offer.id 
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idspecial_offer.id
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 活动主题
	 * @return special_offer.theme 活动主题
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getTheme() {
        return theme;
    }

    /** 
     * Setter活动主题
	 * @param themespecial_offer.theme
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setTheme(String theme) {
        this.theme = theme == null ? null : theme.trim();
    }

    /** 
     * Getter 标题
	 * @return special_offer.title 标题
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getTitle() {
        return title;
    }

    /** 
     * Setter标题
	 * @param titlespecial_offer.title
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    /** 
     * Getter 折扣，仅允许输入0-100之间的整数
	 * @return special_offer.discount 折扣，仅允许输入0-100之间的整数
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Integer getDiscount() {
        return discount;
    }

    /** 
     * Setter折扣，仅允许输入0-100之间的整数
	 * @param discountspecial_offer.discount
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    /** 
     * Getter 活动开始时间
	 * @return special_offer.time_start 活动开始时间
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Date getTimeStart() {
        return timeStart;
    }

    /** 
     * Setter活动开始时间
	 * @param timeStartspecial_offer.time_start
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setTimeStart(Date timeStart) {
        this.timeStart = timeStart;
    }

    /** 
     * Getter 活动结束时间
	 * @return special_offer.time_end 活动结束时间
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Date getTimeEnd() {
        return timeEnd;
    }

    /** 
     * Setter活动结束时间
	 * @param timeEndspecial_offer.time_end
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setTimeEnd(Date timeEnd) {
        this.timeEnd = timeEnd;
    }

    /** 
     * Getter cron表达式
	 * @return special_offer.scheduled cron表达式
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getScheduled() {
        return scheduled;
    }

    /** 
     * Settercron表达式
	 * @param scheduledspecial_offer.scheduled
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setScheduled(String scheduled) {
        this.scheduled = scheduled == null ? null : scheduled.trim();
    }

    /** 
     * Getter 活动状态0准备状态1进行中，2终止
	 * @return special_offer.status 活动状态0准备状态1进行中，2终止
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Short getStatus() {
        return status;
    }

    /** 
     * Setter活动状态0准备状态1进行中，2终止
	 * @param statusspecial_offer.status
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setStatus(Short status) {
        this.status = status;
    }

    /** 
     * Getter 审核状态（0 未审核，1 已审核）
	 * @return special_offer.checked 审核状态（0 未审核，1 已审核）
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Short getChecked() {
        return checked;
    }

    /** 
     * Setter审核状态（0 未审核，1 已审核）
	 * @param checkedspecial_offer.checked
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setChecked(Short checked) {
        this.checked = checked;
    }

    /** 
     * Getter 定时器开启关闭状态0：关闭 1：开启
	 * @return special_offer.off 定时器开启关闭状态0：关闭 1：开启
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Short getOff() {
        return off;
    }

    /** 
     * Setter定时器开启关闭状态0：关闭 1：开启
	 * @param offspecial_offer.off
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setOff(Short off) {
        this.off = off;
    }

    /** 
     * Getter 备注
	 * @return special_offer.remark 备注
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getRemark() {
        return remark;
    }

    /** 
     * Setter备注
	 * @param remarkspecial_offer.remark
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /** 
     * Getter 删除状态
	 * @return special_offer.delete_flag 删除状态
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagspecial_offer.delete_flag
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人员
	 * @return special_offer.create_by 创建人员
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人员
	 * @param createByspecial_offer.create_by
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return special_offer.create_date 创建时间
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatespecial_offer.create_date
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 更新人员
	 * @return special_offer.update_by 更新人员
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter更新人员
	 * @param updateByspecial_offer.update_by
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 更新时间
	 * @return special_offer.update_date 更新时间
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter更新时间
	 * @param updateDatespecial_offer.update_date
     *
     * @mbg.generated Fri Aug 23 14:45:05 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}