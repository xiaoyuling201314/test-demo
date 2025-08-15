package com.dayuan.model.system;

import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.BaseModel;

/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月31日
 */
public class TSOperationModel extends BaseModel {

	private TSOperation baseBean;

	public TSOperation getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(TSOperation baseBean) {
		this.baseBean = baseBean;
	}

}