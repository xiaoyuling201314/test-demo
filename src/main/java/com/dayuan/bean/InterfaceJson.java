package com.dayuan.bean;

import java.io.Serializable;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.common.WebConstant;

/**
 * 接口JSON
 * @author Dz
 *
 */
public class InterfaceJson implements Serializable {

	private String msg = "操作成功";	//提示信息
	private Object obj = null;		//其他信息
	private String resultCode=WebConstant.INTERFACE_CODE0;	//状态码

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
	
	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String toJsonStr(){
		JSONObject obj = new JSONObject();
		obj.put("msg", this.getMsg());
		obj.put("obj", this.obj);
		obj.put("resultCode", this.resultCode);
		
		return obj.toJSONString();
	}

	
}
