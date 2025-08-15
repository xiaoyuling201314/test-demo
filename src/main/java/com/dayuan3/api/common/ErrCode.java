package com.dayuan3.api.common;
/**
 * 接口异常代码
 *
 * Dz 2020/05/15
 */
public enum ErrCode {

	/**
	 * 异常代码、提示
	 */
	SUCCESS("0", "SUCCESS"),

	UNKNOWN_ERROR("10000", "未知错误"),
	NO_PERMISSION("10001", "权限不足"),
	PARAM_REQUIRED("10002", "必填参数[%s]"),
	PARAM_ILLEGAL("10003", "错误参数[%s]"),
	DATA_NOT_FOUND("10004", "数据不存在"),
	DATA_REPEAT("10005", "数据已存在"),
	DATA_ABNORMAL("10006", "数据异常"),
	DATA_IS_EMPTY("10007", "%s不能为空"),
	DATA_IS_EMPTY2("10008", "%s不能为空或空字符串"),
	FILE_UPLOAD_FAILED("10009", "文件上传失败"),
	POSITIVE_REPORT("10010", "检测出阳性样品，暂无报告"),
	HF_VALIDSIGN_FAILD("10011", "汇付签名验证失败"),

	LOGIN_TIMEOUT("10100", "授权失效，请重新登录！"),
	LOGIN_FAILED("10101", "用户名或密码错误"),
	USER_NAME_EXISTS("10102", "用户已存在"),
	USER_NAME_NOT_EXISTS("10103", "用户不存在"),
	PASSWORD_INCORRECT("10104", "密码错误"),
	OLD_PASSWORD_ERROR("10105", "旧密码错误"),
	CAPTCHA_TIMEOUT("10106", "验证码失效，请重新获取！"),
	CAPTCHA_ERROR("10107", "验证码错误"),
	PARAM_BIND_ERROR("10108", "错误参数[%s]"),
	INVALID_TOKEN("40000","用户TOKEN失效，请重新登录"),
	AUTO_LOGIN_ERROR("5000", "微信code自动登录失败"),
	AUTH_ERROR("401", "未经授权"),
	HTTP_405("405", "请求方式错误"),
	HTTP_415("415", "Content-Type错误");


	/**
	 * 错误代码
	 */
	private String code;
	/**
	 * 提示信息
	 */
	private String msg;

	/**
	 * 参数名
	 */
	private String param;

	/**
	 * 自定义提示信息
	 */
	private String tips;

	private ErrCode(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public String getCode() {
		return this.code;
	}

	public String getMsg() {
		String m = (param != null && !"".equals(param.trim()) ? msg.replace("%s", param) : msg);
		return m;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getTips() {
		String m = (tips != null && !"".equals(tips.trim())) ? tips :
				(param != null && !"".equals(param.trim()) ? msg.replace("%s", param) : msg);
		return m;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

}
