package com.dayuan3.terminal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.SpecialOffer;

public interface SpecialOfferMapper extends  BaseMapper<SpecialOffer, Integer>{
   
    
    /**
     * 	查询时间区间的活动  
     * @param timeStart
     * @param timeEnd
     * @return
     */
	List<SpecialOffer> selectByTime(@Param("timeStart")String timeStart,@Param("timeEnd")String timeEnd);
	
	/**
	 * 开启启动查询 需要加入定时计划的活动
	 * @return
	 */
    List<SpecialOffer> selectOfferList();

//	/**
//	 * 通过活动ID和检测项目ID获取进行中的活动
//	 * @param offerId	优惠活动ID
//	 * @param itemId	检测项目ID
//	 * @return
//	 */
//	SpecialOffer queryByItem(@Param("offerId")Integer offerId, @Param("itemId") String itemId);

}