//package com.dayuan.service.delivery;
//
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.dayuan.bean.delivery.TbDelivery;
//import com.dayuan.bean.delivery.TbDeliveryPerson;
//import com.dayuan.bean.sampling.TbSampling;
//import com.dayuan.bean.sampling.TbSamplingDetail;
//import com.dayuan.mapper.delivery.TbDeliveryMapper;
//import com.dayuan.model.delivery.DeliveryModel;
//import com.dayuan.service.BaseService;
//import com.dayuan.util.DateUtil;
//
///**
// * 入场登记
// * @author Dz
// *
// */
//@Service
//public class TbDeliveryService extends BaseService<TbDelivery, Integer> {
//
//	@Autowired
//	private TbDeliveryMapper mapper;
//	@Autowired
//	private TbDeliveryPersonService deliveryPersonService;
//
//	public TbDeliveryMapper getMapper() {
//		return mapper;
//	}
//
//	/**
//	 * //保存入场登记信息
//	 * @param delivery 入场登记信息
//	 * @param deliveryPerson 车主信息
//	 * @throws Exception
//	 */
//	public void save(TbDelivery delivery, TbDeliveryPerson deliveryPerson) throws Exception {
//		TbDeliveryPerson oldDeliveryPerson = deliveryPersonService.queryByLicensePlate(deliveryPerson.getLicensePlate());
//		//保存入场登记车主信息
//		if(null != oldDeliveryPerson) {
//			//更新车主
//			deliveryPerson.setId(oldDeliveryPerson.getId());
//			deliveryPerson.setCreateBy(null);
//			deliveryPerson.setCreateDate(null);
//			deliveryPersonService.updateBySelective(deliveryPerson);
//		}else {
//			//新增车主
//			deliveryPersonService.insertSelective(deliveryPerson);
//		}
//
//		//保存入场登记信息
//		delivery.setPersonId(deliveryPerson.getId());
//		this.insert(delivery);
//	}
//
//	/**
//	 * 根据登记日期获取入场信息
//	 * @param deliveryDate 登记日期
//	 * @return
//	 */
//	public List<DeliveryModel> queryByDeliveryDate(Date deliveryDate, List<Integer> regIds) {
//		if(null == deliveryDate) {
//			return mapper.queryByDeliveryDate(null, regIds);
//		}
//		String date = DateUtil.date_sdf.format(deliveryDate);
//		return mapper.queryByDeliveryDate(date, regIds);
//	}
//
//	/**
//	 * 根据登记ID获取入场信息
//	 * @param id 登记ID
//	 * @return
//	 */
//	public DeliveryModel queryDeliveryById(Integer id) {
//		return mapper.queryDeliveryById(id);
//	}
//
//	/**
//	 * 更新入场登记已抽样记录
//	 * @param sampling	抽样单
//	 * @param list	抽样单明细
//	 */
//	public void updateSamplingId(TbSampling sampling,List<TbSamplingDetail> list) {
//		String samplingDate = DateUtil.date_sdf.format(sampling.getSamplingDate());	//获取抽样日期
//		for(TbSamplingDetail detail : list){
//			mapper.updateSamplingId(samplingDate, sampling.getId(), detail.getId(), sampling.getRegId(), sampling.getOpeId(), detail.getFoodName());
//		}
//	}
//
//}
