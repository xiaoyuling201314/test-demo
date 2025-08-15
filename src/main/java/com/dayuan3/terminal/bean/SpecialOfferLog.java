package com.dayuan3.terminal.bean;

import java.util.Date;

public class SpecialOfferLog {
    /**
     *主键id
     */
    private Integer id;

    /**
     *special_offer主键id
     */
    private Integer offerId;

    /**
     *sys_user主键id
     */
    private String userId;

    /**
     *用户名称
     */
    private String userName;

    /**
     *请求ip
     */
    private String remoteip;

    /**
     *日志类型 0新建 1编辑 2开启 3关闭 4删除
     */
    private Short type;

    /**
     *操作日志
     */
    private String msg;

    /**
     *操作结果 0成功1 失败
     */
    private Short result;

    /**
     *描述
     */
    private String description;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *预留参数4
     */
    private String param1;

    /**
     *预留参数5
     */
    private String param2;

    /**
     *预留参数6
     */
    private String param3;

    /** 
     * Getter 主键id
	 * @return special_offer_log.id 主键id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter主键id
	 * @param idspecial_offer_log.id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter special_offer主键id
	 * @return special_offer_log.offer_id special_offer主键id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public Integer getOfferId() {
        return offerId;
    }

    /** 
     * Setterspecial_offer主键id
	 * @param offerIdspecial_offer_log.offer_id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setOfferId(Integer offerId) {
        this.offerId = offerId;
    }

    /** 
     * Getter sys_user主键id
	 * @return special_offer_log.user_id sys_user主键id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getUserId() {
        return userId;
    }

    /** 
     * Settersys_user主键id
	 * @param userIdspecial_offer_log.user_id
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /** 
     * Getter 用户名称
	 * @return special_offer_log.user_name 用户名称
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getUserName() {
        return userName;
    }

    /** 
     * Setter用户名称
	 * @param userNamespecial_offer_log.user_name
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    /** 
     * Getter 请求ip
	 * @return special_offer_log.remoteIP 请求ip
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getRemoteip() {
        return remoteip;
    }

    /** 
     * Setter请求ip
	 * @param remoteipspecial_offer_log.remoteIP
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setRemoteip(String remoteip) {
        this.remoteip = remoteip == null ? null : remoteip.trim();
    }

    /** 
     * Getter 日志类型 0新建 1编辑 2开启 3关闭 4删除
	 * @return special_offer_log.type 日志类型 0新建 1编辑 2开启 3关闭 4删除
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public Short getType() {
        return type;
    }

    /** 
     * Setter日志类型 0新建 1编辑 2开启 3关闭 4删除
	 * @param typespecial_offer_log.type
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setType(Short type) {
        this.type = type;
    }

    /** 
     * Getter 操作日志
	 * @return special_offer_log.msg 操作日志
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getMsg() {
        return msg;
    }

    /** 
     * Setter操作日志
	 * @param msgspecial_offer_log.msg
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setMsg(String msg) {
        this.msg = msg == null ? null : msg.trim();
    }

    /** 
     * Getter 操作结果 0成功1 失败
	 * @return special_offer_log.result 操作结果 0成功1 失败
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public Short getResult() {
        return result;
    }

    /** 
     * Setter操作结果 0成功1 失败
	 * @param resultspecial_offer_log.result
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setResult(Short result) {
        this.result = result;
    }

    /** 
     * Getter 描述
	 * @return special_offer_log.description 描述
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getDescription() {
        return description;
    }

    /** 
     * Setter描述
	 * @param descriptionspecial_offer_log.description
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    /** 
     * Getter 创建时间
	 * @return special_offer_log.create_date 创建时间
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatespecial_offer_log.create_date
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 预留参数4
	 * @return special_offer_log.param1 预留参数4
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数4
	 * @param param1special_offer_log.param1
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数5
	 * @return special_offer_log.param2 预留参数5
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数5
	 * @param param2special_offer_log.param2
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数6
	 * @return special_offer_log.param3 预留参数6
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数6
	 * @param param3special_offer_log.param3
     *
     * @mbg.generated Mon Sep 09 15:00:57 CST 2019
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}