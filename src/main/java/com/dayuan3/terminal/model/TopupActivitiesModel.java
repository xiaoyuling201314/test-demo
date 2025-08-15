package com.dayuan3.terminal.model;

import java.util.Date;
import java.util.List;

import com.dayuan.model.BaseModel;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;

public class TopupActivitiesModel  extends BaseModel{
    /**
     *
     */
    private Integer id;

    /**
     *活动主题
     */
    private String theme;

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
	 * @return topup_activities.id 
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idtopup_activities.id
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 活动主题
	 * @return topup_activities.theme 活动主题
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public String getTheme() {
        return theme;
    }

    /** 
     * Setter活动主题
	 * @param themetopup_activities.theme
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setTheme(String theme) {
        this.theme = theme == null ? null : theme.trim();
    }

    /** 
     * Getter 活动开始时间
	 * @return topup_activities.time_start 活动开始时间
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Date getTimeStart() {
        return timeStart;
    }

    /** 
     * Setter活动开始时间
	 * @param timeStarttopup_activities.time_start
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setTimeStart(Date timeStart) {
        this.timeStart = timeStart;
    }

    /** 
     * Getter 活动结束时间
	 * @return topup_activities.time_end 活动结束时间
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Date getTimeEnd() {
        return timeEnd;
    }

    /** 
     * Setter活动结束时间
	 * @param timeEndtopup_activities.time_end
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setTimeEnd(Date timeEnd) {
        this.timeEnd = timeEnd;
    }

    /** 
     * Getter cron表达式
	 * @return topup_activities.scheduled cron表达式
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public String getScheduled() {
        return scheduled;
    }

    /** 
     * Settercron表达式
	 * @param scheduledtopup_activities.scheduled
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setScheduled(String scheduled) {
        this.scheduled = scheduled == null ? null : scheduled.trim();
    }

    /** 
     * Getter 活动状态0准备状态1进行中，2终止
	 * @return topup_activities.status 活动状态0准备状态1进行中，2终止
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Short getStatus() {
        return status;
    }

    /** 
     * Setter活动状态0准备状态1进行中，2终止
	 * @param statustopup_activities.status
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setStatus(Short status) {
        this.status = status;
    }

    /** 
     * Getter 审核状态（0 未审核，1 已审核）
	 * @return topup_activities.checked 审核状态（0 未审核，1 已审核）
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Short getChecked() {
        return checked;
    }

    /** 
     * Setter审核状态（0 未审核，1 已审核）
	 * @param checkedtopup_activities.checked
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setChecked(Short checked) {
        this.checked = checked;
    }

    /** 
     * Getter 定时器开启关闭状态0：关闭 1：开启
	 * @return topup_activities.off 定时器开启关闭状态0：关闭 1：开启
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Short getOff() {
        return off;
    }

    /** 
     * Setter定时器开启关闭状态0：关闭 1：开启
	 * @param offtopup_activities.off
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setOff(Short off) {
        this.off = off;
    }

    /** 
     * Getter 备注
	 * @return topup_activities.remark 备注
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public String getRemark() {
        return remark;
    }

    /** 
     * Setter备注
	 * @param remarktopup_activities.remark
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /** 
     * Getter 删除状态
	 * @return topup_activities.delete_flag 删除状态
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagtopup_activities.delete_flag
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人员
	 * @return topup_activities.create_by 创建人员
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人员
	 * @param createBytopup_activities.create_by
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return topup_activities.create_date 创建时间
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatetopup_activities.create_date
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 更新人员
	 * @return topup_activities.update_by 更新人员
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter更新人员
	 * @param updateBytopup_activities.update_by
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 更新时间
	 * @return topup_activities.update_date 更新时间
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter更新时间
	 * @param updateDatetopup_activities.update_date
     *
     * @mbg.generated Mon Oct 28 10:51:47 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}