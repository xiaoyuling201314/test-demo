package com.dayuan3.common.bean;

import java.util.Date;

/**
 * sys_pay_log
 */
public class SysPayLog {

	public SysPayLog() {
		super();
	}

	public SysPayLog(String userid, String username, String payNumber, Short operatorWay, Short paySource,
			String description, Double money, String payAccount, String remoteip, String requesturi, String module,
			String className, String func, Short operatorResult, String exception, Date operatetime,
			String requestParam) {
		super();
		this.userid = userid;
		this.username = username;
		this.payNumber = payNumber;
		this.operatorWay = operatorWay;
		this.paySource = paySource;
		this.money = money;
		this.payAccount = payAccount;
		this.remoteip = remoteip;
		this.requesturi = requesturi;
		this.module = module;
		this.className = className;
		this.func = func;
		this.requestParam = requestParam;
		this.operatorResult = operatorResult;
		this.description = description;
		this.exception = exception;
		this.operatetime = operatetime;
	}
	public SysPayLog(String payNumber, Short operatorWay, Short paySource,Short payStatus,
			String description, Double money, String payAccount, String remoteip, String requesturi, String module,
			String className, String func, Short operatorResult,  Date operatetime,String exception) {
		super();
		this.payNumber = payNumber;
		this.operatorWay = operatorWay;
		this.paySource = paySource;
		this.payStatus=payStatus;
		this.money = money;
		this.payAccount = payAccount;
		this.remoteip = remoteip;
		this.requesturi = requesturi;
		this.module = module;
		this.className = className;
		this.func = func;
		this.operatorResult = operatorResult;
		this.description = description;
		this.operatetime = operatetime;
		this.exception = exception;
	}
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 用户ID
	 */
	private String userid;

	/**
	 * 用户姓名
	 */
	private String username;

	/**
	 * 交易流水号
	 */
	private String payNumber;

	/**
	 * 操作服务端: 0 自助终端，1 app,2 后台
	 */
	private Short operatorWay;

	/**
	 * 支付方式：0 微信，1支付宝，2余额
	 */
	private Short paySource;
	/**
	 * 支付状态：1 生成预付款，2查询状态，3取消付款，4支付成功
	 */
	private Short payStatus;

	/**
	 * 收款金额：元
	 */
	private Double money;

	/**
	 * 付款账号
	 */
	private String payAccount;

	/**
	 * 登录机器
	 */
	private String remoteip;

	/**
	 * 请求地址
	 */
	private String requesturi;

	/**
	 * 操作的模块
	 */
	private String module;

	/**
	 * 调用类名称
	 */
	private String className;

	/**
	 * 调用方法名称
	 */
	private String func;

	/**
	 * 提交参数
	 */
	private String requestParam;

	/**
	 * 执行结果：0 成功，1取消
	 */
	private Short operatorResult;

	/**
	 * 描述信息
	 */
	private String description;

	/**
	 * 异常信息
	 */
	private String exception;

	/**
	 * 操作时间
	 */
	private Date operatetime;

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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid == null ? null : userid.trim();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username == null ? null : username.trim();
	}

	public String getPayNumber() {
		return payNumber;
	}

	public void setPayNumber(String payNumber) {
		this.payNumber = payNumber == null ? null : payNumber.trim();
	}

	public Short getOperatorWay() {
		return operatorWay;
	}

	public void setOperatorWay(Short operatorWay) {
		this.operatorWay = operatorWay;
	}

	public Short getPaySource() {
		return paySource;
	}

	public void setPaySource(Short paySource) {
		this.paySource = paySource;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount == null ? null : payAccount.trim();
	}

	public String getRemoteip() {
		return remoteip;
	}

	public void setRemoteip(String remoteip) {
		this.remoteip = remoteip == null ? null : remoteip.trim();
	}

	public String getRequesturi() {
		return requesturi;
	}

	public void setRequesturi(String requesturi) {
		this.requesturi = requesturi == null ? null : requesturi.trim();
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module == null ? null : module.trim();
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className == null ? null : className.trim();
	}

	public String getFunc() {
		return func;
	}

	public void setFunc(String func) {
		this.func = func == null ? null : func.trim();
	}

	public String getRequestParam() {
		return requestParam;
	}

	public void setRequestParam(String requestParam) {
		this.requestParam = requestParam == null ? null : requestParam.trim();
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

	public Date getOperatetime() {
		return operatetime;
	}

	public void setOperatetime(Date operatetime) {
		this.operatetime = operatetime;
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

	public Short getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(Short payStatus) {
		this.payStatus = payStatus;
	}
	
}