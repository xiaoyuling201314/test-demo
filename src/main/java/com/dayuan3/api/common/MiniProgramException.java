package com.dayuan3.api.common;

public class MiniProgramException extends Exception {

	/**
	 * 错误代码、提示信息
	 */
	private ErrCode errCode;
//	/**
//	 * 参数名
//	 */
//	private String param;
//	/**
//	 * 自定义提示信息
//	 */
//	private String tips;

	public MiniProgramException() {
		super();
	}

	public MiniProgramException(ErrCode errCode, String param, String tips) {
		super(tips);
		this.errCode = errCode;
		errCode.setParam(param);
		errCode.setTips(tips);
	}

//	public MiniProgramException(ErrCode code, String param, String tips) {
//		super();
//		this.code = code;
//		this.param = param;
//		this.tips = tips;
//	}


	public ErrCode getErrCode() {
		return errCode;
	}

	public void setErrCode(ErrCode errCode) {
		this.errCode = errCode;
	}

//	public String getParam() {
//		return param;
//	}
//
//	public void setParam(String param) {
//		this.param = param;
//	}

//	public String getTips() {
//		String msg = (tips != null && !"".equals(tips.trim())) ? tips :
//				(param != null && !"".equals(param.trim()) ? code.getMsg().replace("%s", param) : code.getMsg());
//		return msg;
//	}
//
//	public void setTips(String tips) {
//		this.tips = tips;
//	}

}
