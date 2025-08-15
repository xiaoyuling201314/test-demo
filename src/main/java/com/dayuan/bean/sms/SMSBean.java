package com.dayuan.bean.sms;

import java.util.Map;

/**
 * Author: shit
 * Date: 2019-11-13 11:13
 * Content: 短信接口Bean
 */
public class SMSBean {
    private String phone;                   //电话号码
    private String signName;                //短信签名
    private String templateId;              //模板ID
    private String serviceId;               //短信服务ID
    private String paramJsonStr;            //模板参数 json字符串格式
    private Map<String, String> paramMap;   //模板参数 map方式
    private String serviceIdDefault;        //默认使用的服务名称
    private Short type = 0;                 //短信类型 0：验证码短信 1：通知短信（不传则默认验证码方式）

    public String getSignName() {
        return signName;
    }

    public void setSignName(String signName) {
        this.signName = signName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getServiceId() {
        return serviceId;
    }

    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    public String getParamJsonStr() {
        return paramJsonStr;
    }

    public void setParamJsonStr(String paramJsonStr) {
        this.paramJsonStr = paramJsonStr;
    }

    public Map<String, String> getParamMap() {
        return paramMap;
    }

    public void setParamMap(Map<String, String> paramMap) {
        this.paramMap = paramMap;
    }

    public String getServiceIdDefault() {
        return serviceIdDefault;
    }

    public void setServiceIdDefault(String serviceIdDefault) {
        this.serviceIdDefault = serviceIdDefault;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }
}
