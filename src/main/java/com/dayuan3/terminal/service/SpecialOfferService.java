package com.dayuan3.terminal.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.SpecialOffer;
import com.dayuan3.terminal.bean.SpecialOfferItem;
import com.dayuan3.terminal.mapper.SpecialOfferItemMapper;
import com.dayuan3.terminal.mapper.SpecialOfferMapper;
import com.ibm.icu.text.DecimalFormat;

@Service
public class SpecialOfferService extends BaseService<SpecialOffer, Integer>{
	
	@Autowired
	private SpecialOfferMapper mapper;
	@Autowired
	private SpecialOfferItemMapper  itemmapper;
	@Autowired
	private  SpecialOfferLogService logService;
	
	@Override
	public BaseMapper<SpecialOffer, Integer> getMapper() {
		return mapper;
	}
	
 

	
 /**
  *   处理活动定时计划
  * @param bean 
  * @param items 参与处理的检测项目
  * @throws Exception
  */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void dealOffer(SpecialOffer bean,String items) throws Exception{
		SpecialOffer	specialOffer=	mapper.selectByPrimaryKey(bean.getId());
		//处理活动检测项目
		if(specialOffer!=null){//编辑
			//删除已存在活动检测项目
			PublicUtil.setCommonForTable(bean, false);
			itemmapper.deleteByOfferId(bean.getId());
			mapper.updateByPrimaryKeySelective(bean);
			if(bean.getChecked()==1){
			logService.writeLog(bean.getId(), (short) 1, "编辑活动,已审核!", true, 1,bean,items);
			}else{
			logService.writeLog(bean.getId(), (short) 1, "编辑活动,未通过审核", true, 1,bean,items);	
			}
		}else{
			PublicUtil.setCommonForTable(bean, true);
			bean.setStatus((short) 0);
			mapper.insertSelective(bean);
			if(bean.getChecked()==1){
				logService.writeLog(bean.getId(), (short) 0, "新增活动,已审核!", true, 1,bean,items);
			}else{
				logService.writeLog(bean.getId(), (short) 0, "新增活动,未通过审核", true, 1,bean,items);
			}
		} 
		String[] ida = items.split(",");
		List<SpecialOfferItem> list=new ArrayList<SpecialOfferItem>();
		SpecialOfferItem item =new SpecialOfferItem();
		for (int i = 0; i < ida.length; i++) {
			item =new SpecialOfferItem();
			item.setItemId(ida[i]);
			item.setOfferId(bean.getId());;
			list.add(item);
		}
		itemmapper.insertList(list);
		
		
		 
	}
	
	
	/**
	 *  开启活动 修改检测项目折扣信息
	 * @param id
	 * @param type 0 定时开启 1立即开启；立即考试需要修改开始时间
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void openItem(Integer id,Integer type) throws Exception{
		Date now=new Date();
		SpecialOffer	specialOffer=	mapper.selectByPrimaryKey(id);
		List<SpecialOfferItem> list=	itemmapper.selectByOfferId(id);
		String[] ida =new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ida[i]=list.get(i).getItemId();
		}
		//设置检测项目折扣
		/*
		 * DecimalFormat df=new DecimalFormat("0.0000"); Double dis=(double)
		 * (specialOffer.getDiscount()/100) ; Double.parseDouble(df.format(dis));
		 */
		itemmapper.updateItemById(specialOffer.getDiscount(), specialOffer.getId(), ida);	
		if(type==1){//立即开始活动 需要记录开始时间
			specialOffer.setTimeStart(now);	
		}
		specialOffer.setStatus((short) 1);
		specialOffer.setCreateBy("dings");
		specialOffer.setUpdateDate(new Date());
		mapper.updateByPrimaryKey(specialOffer);
		
	}
	
	/**
	 * 取消活动检测项目折扣
	 * @param id
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void closeItem(Integer id) throws Exception{
	 
		//重置检测项目折扣
		itemmapper.updateResetItem(id);
		SpecialOffer bean=	mapper.selectByPrimaryKey(id);
		bean.setStatus((short) 2);
		bean.setCreateBy("dings");
		bean.setUpdateDate(new Date());
		mapper.updateByPrimaryKey(bean);
		 
	}
	
	/**
	 * 查询时间冲突的活动
	 * @param timeStart
	 * @param timeEnd
	 * @return
	 */
	public	List<SpecialOffer> selectByTime(String timeStart,String timeEnd){
		return mapper.selectByTime(timeStart, timeEnd);
	};
	
	/**
	 * 删除活动需要先终止活动
	 * @param id
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public	void deleteList(Integer id)throws Exception{
		//1.先查看当前活动状态
		SpecialOffer bean=	mapper.selectByPrimaryKey(id); 
		if(bean.getStatus()==1){//活动进行中 
			//重置检测项目折扣
			itemmapper.updateResetItem(id);
		} 
		mapper.deleteByPrimaryKey(id);
		
	};
	
	/**
	 * 关闭活动
	 * @param id
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public	void closeList(Integer id)throws Exception{
		//1.先查看当前活动状态
		SpecialOffer bean=	mapper.selectByPrimaryKey(id); 
		if(bean.getStatus()==1){//活动进行中 
			//重置检测项目折扣
			itemmapper.updateResetItem(id);
		} 
		bean.setStatus((short) 2);
		bean.setUpdateBy("dings");
		bean.setUpdateDate(new Date());
		mapper.updateByPrimaryKey(bean);
		
	};
	
	/**
	 * 开机启动启动查询 需要加入定时计划的活动
	 * @return
	 * @throws Exception
	 */
	public	List<SpecialOffer> selectOfferList()throws Exception{
	 
		return mapper.selectOfferList();
	 
	};

//	/**
//	 * 通过活动ID和检测项目ID获取进行中的活动
//	 * @param offerId	优惠活动ID
//	 * @param itemId	检测项目ID
//	 * @return
//	 */
//	public SpecialOffer queryByItem(Integer offerId, String itemId) {
//		return mapper.queryByItem(offerId, itemId);
//	}
	
}
