package com.dayuan3.api.common;

import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

/**
 * API返回数据对象
 * @author Dz
 *
 */
@Data
@AllArgsConstructor
public class MiniProgramJson<T> implements Serializable {
	/**
	 * 状态码
	 */
	@ApiModelProperty(value = "状态码：0成功，非0失败", example = "0")
	private String resultCode;

	/**
	 * 提示信息
	 */
	@ApiModelProperty(value = "提示信息",  example = "成功")
	private String msg;

	/**
	 * 返回数据
	 */
	@ApiModelProperty(value = "返回数据")
	private T data;


	public static <T> MiniProgramJson<T> data(T data) {
		return new MiniProgramJson(ErrCode.SUCCESS.getCode(), ErrCode.SUCCESS.getMsg(), data);
	}

	public static <T> MiniProgramJson<T> ok(String msg) {
		return new MiniProgramJson(ErrCode.SUCCESS.getCode(), (StrUtil.isBlank(msg) ? ErrCode.SUCCESS.getMsg() : msg), null);
	}

	public static <T> MiniProgramJson<T> ok(String msg, T data) {
		return new MiniProgramJson(ErrCode.SUCCESS.getCode(), (StrUtil.isBlank(msg) ? ErrCode.SUCCESS.getMsg() : msg), data);
	}

//	public static <T> MiniProgramJson<T> error(String code, String msg) {
//		return new MiniProgramJson(code, msg, null);
//	}
//
//	public static <T> MiniProgramJson<T> error(String code, String msg, T data) {
//		return new MiniProgramJson(code, msg, data);
//	}

	public static <T> MiniProgramJson<T> error(ErrCode rc) {
		return new MiniProgramJson(rc.getCode(), rc.getMsg(), null);
	}

	public static <T> MiniProgramJson<T> error(ErrCode rc, String msg) {
		return new MiniProgramJson(rc.getCode(), (StrUtil.isBlank(msg) ? rc.getMsg() : msg), null);
	}

	public static <T> MiniProgramJson<T> error(ErrCode rc, String msg, T data) {
		return new MiniProgramJson(rc.getCode(), (StrUtil.isBlank(msg) ? rc.getMsg() : msg), data);
	}
	
}
