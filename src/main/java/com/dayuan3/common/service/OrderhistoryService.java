package com.dayuan3.common.service;

import com.dayuan.bean.data.BaseFoodType;
import com.dayuan3.common.bean.Orderhistory;
import com.dayuan3.common.bean.baseFood;
import com.dayuan3.common.mapper.OrderhistoryMapper;
import com.dayuan3.terminal.bean.RequesterUnit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
 
@Service
public class OrderhistoryService {
	@Autowired
	private OrderhistoryMapper mapper;

 

  /**
   * 保存输入历史
   * @param keyId 对应表主键id
   * @param userId 用户id
   * @param keyType  0:委托单位 1样品
   * @return
   */
	public void saveOrderhistory(List<Integer> keyIds,short keyType,Integer userId) {
		//判断历史是否存在
		for (int i = 0; i < keyIds.size(); i++) {
			Integer keyId=keyIds.get(i);
			Orderhistory  bean=mapper.selectByKeyId(userId, keyType, keyId);
			if(bean!=null){//已存在  count+1
				
				if(bean.getHistoryCount()!=null){//历史数量不为空
					bean.setHistoryCount(bean.getHistoryCount()+1);
				}else{
					bean.setHistoryCount(2);
				}
				bean.setUpdateDate(new Date());
				mapper.updateByPrimaryKey(bean);
				
			}else{//历史不存在
				bean=new Orderhistory();
				Date now=new Date();
				bean.setKeyId(keyId);
				bean.setKeyType(keyType);
				bean.setCreateBy(userId);
				
				//通用
				bean.setHistoryCount(1);
				bean.setDeleteFlag((short) 0);
				bean.setType((short) 0);
				bean.setUpdateBy(userId);
				bean.setCreateDate(now);
				bean.setUpdateDate(now);
				mapper.insert(bean);
			}
		}
	}
	
 /**
  * 每生成一个订单 都必有委托单位、样品 打包处理
  * @param unitId
  * @param foodIds
  * @param userId
  */
	public void saveOrderhistory2(Integer unitId,List<Integer> foodIds,Integer userId) {
		
		//委托单位
		if(unitId!=null){
			List<Integer> keyIds= new ArrayList<>();
			keyIds.add(unitId);
			this.saveOrderhistory(keyIds, (short)0, userId);
		}
		//样品
		if(foodIds.size()>0){
			List<Integer> keyIds= new ArrayList<>();//样品id 去重，一次订单，多个同样id 只算一个
			 for (Integer foodId : foodIds) {
				 if(!keyIds.contains(foodId)){
					 keyIds.add(foodId);
				 };
			}
			this.saveOrderhistory(keyIds, (short)1, userId);
		}
		
	}
	
	/**
	 * 获取样品历史数据 
	 * @param createBy 用户id
	 * @return
	 */
	public  List<baseFood>	selectFoodHistory(Integer createBy) {
		
		return mapper.selectFoodHistory(createBy);
		
	}
	
	/**
	 * 获取委托单位历史数据 
	 * @param createBy 用户id
	 * @return
	 */
	public  List<RequesterUnit>	selectUnitHistory(Integer createBy) {
		
		return mapper.selectUnitHistory(createBy);
 
	}


	/**
	 * 根据openid和类型查询搜索的历史记录
	 * @param openid
	 * @param type 关键字类型，0:委托单位、1:样品、2:搜索历史
	 * @author shit
	 * @return
	 */
	public Orderhistory selectHisrotyByOpenid(String openid, Short type) {
		return mapper.selectHisrotyByOpenid(openid,type);
	}

	public void updateHistory(Orderhistory orderhistory) {
		mapper.updateHistory(orderhistory);
	}

	public void insertHistory(Orderhistory orderhistory) {
		mapper.insertHistory(orderhistory);
	}
}
