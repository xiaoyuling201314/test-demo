package com.dayuan3.terminal.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.SpecialOfferItem;
import com.dayuan3.terminal.mapper.SpecialOfferItemMapper;

@Service
public class SpecialOfferItemService extends BaseService<SpecialOfferItem, Integer>{
	@Autowired
	private SpecialOfferItemMapper mapper;

	@Override
	public BaseMapper<SpecialOfferItem, Integer> getMapper() {
		return mapper;
	}
	
	public void insertList(List<SpecialOfferItem> list){
		
		mapper.insertList(list);;
	};
	
	
	public List<SpecialOfferItem>	selectByOfferId(Integer id) {
		
		return mapper.selectByOfferId(id);
	}
	/**
	 * 根据检测项目ID查询优惠活动项目
	 * @description
	 * @param id
	 * @return
	 * @author xiaoyl
	 * @date   2020年4月9日
	 */
	public SpecialOfferItem queryByItemId(String id,Integer integer) {
		return mapper.queryByItemId(id,integer);
	}
	
}
