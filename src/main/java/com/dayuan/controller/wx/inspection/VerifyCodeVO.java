package com.dayuan.controller.wx.inspection;

import java.io.Serializable;
import java.util.Date;

/**
 * 手机号码验证信息的存储类
 * 实现序列化接口以便于存入磁盘，供session获取
 * Created by shit on 2018/8/19.
 */
public class VerifyCodeVO implements Serializable {
    private String verifyCode;      //验证码

    private String phoneNumber;     //发送验证码的手机号

    private Date lastSendTime;      //最近成功发送时间

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getLastSendTime() {
        return lastSendTime;
    }

    public void setLastSendTime(Date lastSendTime) {
        this.lastSendTime = lastSendTime;
    }
}
