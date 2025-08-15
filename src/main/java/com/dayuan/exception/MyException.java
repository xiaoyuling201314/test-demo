package com.dayuan.exception;

/**
 * 自定义异常类
 * @author Dz  
 * @date 2017年12月1日
 */
public class MyException extends Exception {
	
	private String text;//异常信息
	private String code;//异常编码

	public MyException() {
		super();
	}

	public MyException(String message, Throwable cause,
                       boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public MyException(String message, Throwable cause) {
		super(message, cause);
	}

	public MyException(String message) {
		super(message);
	}
	
	public MyException(String message, String text, String code) {
		super(message);
		this.text = text;
		this.code = code;
	}

	public MyException(Throwable cause) {
		super(cause);
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	

}
