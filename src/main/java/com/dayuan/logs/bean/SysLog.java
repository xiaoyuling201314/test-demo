package com.dayuan.logs.bean;

import java.util.Date;

public class SysLog {

    /*
     *主键ID
     */
    private Integer id;
    /*
     *操作人ID
     */
    private String userId;
    /*
     *操作人账号
     */
    private String userName;
    /*
     *登录机器
     */
    private String remoteIp;
    /*
     *请求地址
     */
    private String requestUri;
    /*
     *日志类型 0普通操作，1新建，2编辑 ，3删除
     */
    private Short type;
    /*
     *操作的模块
     */
    private String module;
    /*
     *调用方法说明
     */
    private String func;
    /*
     *调用类名称
     */
    private String className;
    /*
     *操作数据ID
     */
    private String operatorId;
    /*
     *提交参数
     */
    String requestParam;
    /*
     *修改前数据
     */
    private String beforeData;
    /*
     *修改后数据
     */
    private String afterData;
    /*
     *执行结果：0 成功，1失败
     */
    private Short operatorResult;
    /*
     *描述信息
     */
    private String description;
    /*
     *异常信息
     */
    private String exception;
    /*
     *操作时间
     */
    private Date operateTime;
    /*
     *IP地址对应的物理地址
     */
    private String param1;
    /*
     *预留参数2
     */
    private String param2;
    /*
     *预留参数3
     */
    private String param3;

    public SysLog() {
    }

    public SysLog(String remoteIp, String requestUri,
                  Short type, String module, String func, String operatorId,String requestParam) {
        this.remoteIp = remoteIp;
        this.requestUri = requestUri;
        this.type = type;
        this.module = module;
        this.func = func;
        this.operatorId = operatorId;
        this.requestParam=requestParam;
    }
    public SysLog(String remoteIp, String requestUri,
                  Short type, String module, String func, String operatorId,String requestParam,String userName,
                  Short operatorResult,Date operateTime,String description) {
        this.remoteIp = remoteIp;
        this.requestUri = requestUri;
        this.type = type;
        this.module = module;
        this.func = func;
        this.operatorId = operatorId;
        this.requestParam=requestParam;
        this.userName=userName;
        this.operatorResult=operatorResult;
        this.operateTime=operateTime;
        this.description=description;
    }
    public SysLog(String userName, String module, String func,short operatorResult) {
        this.userName = userName;
        this.module = module;
        this.func = func;
        this.operatorResult=operatorResult;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getRemoteIp() {
        return remoteIp;
    }

    public void setRemoteIp(String remoteIp) {
        this.remoteIp = remoteIp == null ? null : remoteIp.trim();
    }

    public String getRequestUri() {
        return requestUri;
    }

    public void setRequestUri(String requestUri) {
        this.requestUri = requestUri == null ? null : requestUri.trim();
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module == null ? null : module.trim();
    }

    public String getFunc() {
        return func;
    }

    public void setFunc(String func) {
        this.func = func == null ? null : func.trim();
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public String getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(String operatorId) {
        this.operatorId = operatorId == null ? null : operatorId.trim();
    }

    public String getBeforeData() {
        return beforeData;
    }

    public void setBeforeData(String beforeData) {
        this.beforeData = beforeData == null ? null : beforeData.trim();
    }

    public String getAfterData() {
        return afterData;
    }

    public void setAfterData(String afterData) {
        this.afterData = afterData == null ? null : afterData.trim();
    }

    public Short getOperatorResult() {
        return operatorResult;
    }

    public void setOperatorResult(Short operatorResult) {
        this.operatorResult = operatorResult;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getException() {
        return exception;
    }

    public void setException(String exception) {
        this.exception = exception == null ? null : exception.trim();
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
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

    public String getRequestParam() {
        return requestParam;
    }

    public void setRequestParam(String requestParam) {
        this.requestParam = requestParam;
    }
}