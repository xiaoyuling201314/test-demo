package com.dayuan.model.delivery;

import java.util.List;

import com.dayuan.bean.delivery.TbDelivery;
import com.dayuan.bean.delivery.TbDeliveryPerson;
import com.dayuan.model.BaseModel;


public class DeliveryModel extends BaseModel {
	
	//车主
	private TbDeliveryPerson deliveryPerson;
	//入场登记信息
	private TbDelivery delivery;
	
	
	/************** 查询条件 ****************/
	//用户可查询的市场ID
	private List<Integer> regIds;

	public TbDeliveryPerson getDeliveryPerson() {
		return deliveryPerson;
	}

	public void setDeliveryPerson(TbDeliveryPerson deliveryPerson) {
		this.deliveryPerson = deliveryPerson;
	}

	public TbDelivery getDelivery() {
		return delivery;
	}

	public void setDelivery(TbDelivery delivery) {
		this.delivery = delivery;
	}

	public List<Integer> getRegIds() {
		return regIds;
	}

	public void setRegIds(List<Integer> regIds) {
		this.regIds = regIds;
	}
	
	

}
