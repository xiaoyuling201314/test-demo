package com.dayuan.model.data;

import com.dayuan.bean.BaseBean;
import com.dayuan.bean.data.BaseClient;
import com.dayuan.model.BaseModel;

/**
 * 客户信息表 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class BaseClientModel extends BaseModel {

	private BaseClient baseBean;

	public BaseClient getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(BaseClient baseBean) {
		this.baseBean = baseBean;
	}

}