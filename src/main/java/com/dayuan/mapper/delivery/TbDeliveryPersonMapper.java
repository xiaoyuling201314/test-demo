package com.dayuan.mapper.delivery;

import com.dayuan.bean.delivery.TbDeliveryPerson;
import com.dayuan.mapper.BaseMapper;

public interface TbDeliveryPersonMapper extends BaseMapper<TbDeliveryPerson, Integer> {

	TbDeliveryPerson queryByLicensePlate(String licensePlate);
	
}