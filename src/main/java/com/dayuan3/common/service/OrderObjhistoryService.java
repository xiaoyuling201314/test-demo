package com.dayuan3.common.service;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan3.common.bean.OrderObjhistory;
import com.dayuan3.common.mapper.OrderObjhistoryMapper;

@Service
public class OrderObjhistoryService {
	@Autowired
	private OrderObjhistoryMapper mapper;
	
	
	
	 /**
	   * 保存输入历史
	   * @param keyId 对应表主键id
	   * @param userId 用户id
	   * @param keyType  0:来源 1档口
	   * @param supplier 当keyType=1时 不能为空
	   * @return
	   */
	public void saveOrderhistory(List<String>  keywords,short keyType,Integer userId,List<String> suppliers) {
		
		if(keyType==0){//处理来源
				for (int i = 0; i < keywords.size(); i++) {
					String	keyword=keywords.get(i);
				
					if(keyword!=null&&keyword!=""){
							OrderObjhistory bean=	  mapper.selectByKeyword(userId, keyType, keyword,null);
							
						
								if(bean!=null){//历史已存在
									
									if(bean.getHistoryCount()!=null){//不为空+1
										bean.setHistoryCount(bean.getHistoryCount()+1);
									}else{
										bean.setHistoryCount(2);
									}
									bean.setUpdateDate(new Date());
									mapper.updateByPrimaryKey(bean);
									
								}else{//新增历史记录
									bean = new  OrderObjhistory();
									
									bean.setKeyword(keyword);
									bean.setKeyType(keyType);
									bean.setCreateBy(userId);
									bean.setHistoryCount(1);
									Date now=new Date();
									bean.setDeleteFlag((short) 0);
									bean.setUpdateBy(userId);
									bean.setCreateDate(now);
									bean.setUpdateDate(now);
									mapper.insert(bean); 
								}
						}
				}
		  
		}else if(keyType==1){//处理档口
			for (int i = 0; i < keywords.size(); i++) {
				String	keyword=keywords.get(i);
			
				if(keyword!=null&&keyword!=""){
					
					if(suppliers.get(i)==null||suppliers.get(i)==""){
						continue;
					}
						OrderObjhistory bean=	  mapper.selectByKeyword(userId, keyType, keyword,suppliers.get(i));
					
							if(bean!=null){//历史已存在
								
								if(bean.getHistoryCount()!=null){//不为空+1
									bean.setHistoryCount(bean.getHistoryCount()+1);
								}else{
									bean.setHistoryCount(2);
								}
								bean.setUpdateDate(new Date());
								mapper.updateByPrimaryKey(bean);
								
							}else{//新增历史记录
								bean = new  OrderObjhistory();
								 bean.setRegname(suppliers.get(i));
								bean.setKeyword(keyword);
								bean.setKeyType(keyType);
								bean.setCreateBy(userId);
								bean.setHistoryCount(1);
								Date now=new Date();
								bean.setDeleteFlag((short) 0);
								bean.setUpdateBy(userId);
								bean.setCreateDate(now);
								bean.setUpdateDate(now);
								mapper.insert(bean); 
							}
					}
			}
			
			
		}
		
	}
	/**
	 * 
	 * @param suppliers 来源list
	 * @param opes 档口list 必须和suppliers 一一对应
	 * @param 
	 * @param userId 用户id
	 */
	public void saveOrderhistory2(List<String> suppliers,List<String> opes,Integer userId) {
		
		//1.处理来源
		if(suppliers.size()>0){
			List<String> list=new ArrayList<String>();
			for (int i = 0; i < suppliers.size(); i++) {//遍历来源
				if(!list.contains(suppliers.get(i))){//不存在则加入进去
					list.add(suppliers.get(i));
				};
			}
			saveOrderhistory(list, (short) 0, userId,null);
		}
		
		//2.处理档口
		if(opes.size()>0){
			List<String> list1=new ArrayList<String>();
			List<String> list2=new ArrayList<String>();
			for (int i = 0; i < opes.size(); i++) {//遍历来源
				boolean existOpe=list1.contains(opes.get(i));
				if(!existOpe||(existOpe&&list2.contains(opes.get(i)))){//1.档口不存在2.档口 存在且市场名不存在 添加进去
					list1.add(opes.get(i));
					list2.add(suppliers.get(i));
				};
			}
			saveOrderhistory(list1, (short) 1, userId,list2);
		}
	}
	/**
	 * 
	 * @param suppliers 来源list
	 * @param opes 档口list 必须和suppliers 一一对应
	 * @param 
	 * @param userId 用户id
	 */
	public void saveOrderhistory3(List<Integer> supplierIds,List<String> suppliers,List<String> opes,Integer userId) {
		
		//1.处理来源
		if(suppliers.size()>0){
			List<String> list=new ArrayList<String>();
			for (int i = 0; i < suppliers.size(); i++) {//遍历来源
				if(!list.contains(suppliers.get(i))){//不存在则加入进去
					list.add(suppliers.get(i));
				};
			}
			saveOrderhistory2(supplierIds,list, (short) 0, userId,null);
		}
		
		//2.处理档口
		if(opes.size()>0){
			List<String> list1=new ArrayList<String>();
			List<String> list2=new ArrayList<String>();
			for (int i = 0; i < opes.size(); i++) {//遍历来源
				boolean existOpe=list1.contains(opes.get(i));
				if(!existOpe||(existOpe&&list2.contains(opes.get(i)))){//1.档口不存在2.档口 存在且市场名不存在 添加进去
					list1.add(opes.get(i));
					list2.add(suppliers.get(i));
				};
			}
			saveOrderhistory(list1, (short) 1, userId,list2);
		}
	}
	
	
	
	 /**
	   * 保存输入历史
	   * @param keyId 对应表主键id
	   * @param userId 用户id
	   * @param keyType  0:来源 1档口
	   * @param supplier 当keyType=1时 不能为空
	   * @return
	   */
	public void saveOrderhistory2(List<Integer> supplierIds,List<String>  keywords,short keyType,Integer userId,List<String> suppliers) {
		
		if(keyType==0){//处理来源
				for (int i = 0; i < keywords.size(); i++) {
					String	keyword=keywords.get(i);
				
					if(keyword!=null&&keyword!=""){
							OrderObjhistory bean=	  mapper.selectByKeyword(userId, keyType, keyword,null);
							
						
								if(bean!=null){//历史已存在
									
									if(bean.getHistoryCount()!=null){//不为空+1
										bean.setHistoryCount(bean.getHistoryCount()+1);
									}else{
										bean.setHistoryCount(2);
									}
									bean.setUpdateDate(new Date());
									mapper.updateByPrimaryKey(bean);
									
								}else{//新增历史记录
									bean = new  OrderObjhistory();
									bean.setKeyId(supplierIds.get(i));
									bean.setKeyword(keyword);
									bean.setKeyType(keyType);
									bean.setCreateBy(userId);
									bean.setHistoryCount(1);
									Date now=new Date();
									bean.setDeleteFlag((short) 0);
									bean.setUpdateBy(userId);
									bean.setCreateDate(now);
									bean.setUpdateDate(now);
									mapper.insert(bean); 
								}
						}
				}
		  
		}else if(keyType==1){//处理档口
			for (int i = 0; i < keywords.size(); i++) {
				String	keyword=keywords.get(i);
			
				if(keyword!=null&&keyword!=""){
					
					if(suppliers.get(i)==null||suppliers.get(i)==""){
						continue;
					}
						OrderObjhistory bean=	  mapper.selectByKeyword(userId, keyType, keyword,suppliers.get(i));
					
							if(bean!=null){//历史已存在
								
								if(bean.getHistoryCount()!=null){//不为空+1
									bean.setHistoryCount(bean.getHistoryCount()+1);
								}else{
									bean.setHistoryCount(2);
								}
								bean.setUpdateDate(new Date());
								mapper.updateByPrimaryKey(bean);
								
							}else{//新增历史记录
								bean = new  OrderObjhistory();
								 bean.setRegname(suppliers.get(i));
								bean.setKeyword(keyword);
								bean.setKeyType(keyType);
								bean.setCreateBy(userId);
								bean.setHistoryCount(1);
								Date now=new Date();
								bean.setDeleteFlag((short) 0);
								bean.setUpdateBy(userId);
								bean.setCreateDate(now);
								bean.setUpdateDate(now);
								mapper.insert(bean); 
							}
					}
			}
			
			
		}
		
	}
	
	/**
	 * 根据keyType 查询来源、档口 历史
	 * @param createBy 用户id
	 * @param keyType 0：来源 1档口
	 * @param regname 非必填
	 * @return
	 */
		public  List<OrderObjhistory>  selectObjHistory(Integer userId,short keyType,String regname) {
			
			return mapper.selectObjHistory(userId, keyType, regname);
			 
		}
		
 
	
}
