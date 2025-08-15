package com.dayuan.mapper.delivery;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.delivery.TbDelivery;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.delivery.DeliveryModel;

public interface TbDeliveryMapper extends BaseMapper<TbDelivery, Integer> {

	List<DeliveryModel> queryByDeliveryDate(@Param("date") String date,@Param("regIds")List<Integer> regIds);

	DeliveryModel queryDeliveryById(Integer id);

	void updateSamplingId(@Param("samplingDate") String samplingDate, @Param("samplingId")Integer samplingId, @Param("detailId")Integer detailId, @Param("regId") Integer regId, @Param("opeId") Integer opeId, @Param("foodName") String foodName);

}