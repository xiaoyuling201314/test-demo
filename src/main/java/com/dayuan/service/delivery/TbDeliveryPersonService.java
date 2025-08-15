//package com.dayuan.service.delivery;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.dayuan.bean.delivery.TbDeliveryPerson;
//import com.dayuan.mapper.delivery.TbDeliveryPersonMapper;
//import com.dayuan.service.BaseService;
//import com.dayuan.util.StringUtil;
//
///**
// * 入场登记
// * @author Dz
// *
// */
//@Service
//public class TbDeliveryPersonService extends BaseService<TbDeliveryPerson, Integer> {
//
//	@Autowired
//	private TbDeliveryPersonMapper mapper;
//
//	public TbDeliveryPersonMapper getMapper() {
//		return mapper;
//	}
//
//	/**
//	 * 根据车牌获取车主信息
//	 * @param licensePlate 车牌
//	 * @return
//	 */
//	public TbDeliveryPerson queryByLicensePlate(String licensePlate) {
//		if(StringUtil.isEmpty(licensePlate)) {
//			return null;
//		}
//		return mapper.queryByLicensePlate(licensePlate);
//	}
//
//}
