package com.dayuan3.terminal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.SpecialOfferItem;

public interface SpecialOfferItemMapper  extends BaseMapper<SpecialOfferItem, Integer>{
   
    int updateByPrimaryKey(SpecialOfferItem record);
    
    	void    insertList(@Param("list")List<SpecialOfferItem> list);
    	
    	List<SpecialOfferItem>	selectByOfferId(Integer id);
    	
    	/**
    	 * 重置检测项目折扣价格 初始化100% 为空则重置全部
    	 */
    	void updateResetItem(@Param("offerId")Integer offerId);
     
    	/**
    	 * 活动设置检测项目折扣
    	 * @param discount
    	 * @param id
    	 * @param ids
    	 */
    	void 	updateItemById(@Param("discount")Double discount,@Param("offerId")int offerId,@Param("ids")String[] ids);
    	
    	/**
    	 * 删除活动管理检测项目
    	 * @param id
    	 */
    	void 	deleteByOfferId(int id);

		SpecialOfferItem queryByItemId(@Param("itemId")String id,@Param("offerId")Integer integer);

}