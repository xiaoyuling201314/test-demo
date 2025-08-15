package com.dayuan.model.system;

import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.BaseModel;

/**
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class TSFunctionModel extends BaseModel {

	private TSFunction baseBean;

	public TSFunction getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(TSFunction baseBean) {
		this.baseBean = baseBean;
	}

}