package com.dayuan.model.data;

import com.dayuan.bean.data.BaseDevice;
import com.dayuan.model.BaseModel;

/**
 * 客户信息表 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class BaseDeviceModel extends BaseModel {

	private BaseDevice baseBean;
	
	private int flag;//查询标识，是查询检测点还是检测机构下的设备信息

	public BaseDevice getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(BaseDevice baseBean) {
		this.baseBean = baseBean;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

}