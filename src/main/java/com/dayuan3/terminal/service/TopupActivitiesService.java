package com.dayuan3.terminal.service;

import com.alibaba.fastjson.JSONArray;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan.util.UUIDGenerator;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.mapper.TopupActivitiesDetailMapper;
import com.dayuan3.terminal.mapper.TopupActivitiesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class TopupActivitiesService extends BaseService<TopupActivities, Integer>{

	@Autowired
	private TopupActivitiesMapper mapper;
	@Autowired
	private TopupActivitiesDetailMapper  activitiesDetailMapper;
	@Autowired
	private TopupActivitiesLogService  logService;
	
	@Override
	public BaseMapper<TopupActivities, Integer> getMapper() {
		return mapper;
	}
	
	/**
	 * 根据活动获取充值优惠
	 * @param id
	 * @return
	 */
	public List<TopupActivitiesDetail> selectByActId(Integer id) {
		 
		return activitiesDetailMapper.selectByActId(id);
	}
	
	/**
	 * 新增-编辑活动
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public TopupActivities save(TopupActivities bean,String details) throws Exception{
		List<TopupActivitiesDetail>	list=JSONArray.parseArray(details, TopupActivitiesDetail.class);
		if(list.size()==0){//活动配置不能为空
			throw new MyException("请至少选配一种充值优惠!");
		}
		TSUser user =	PublicUtil.getSessionUser();
		TopupActivities  activities=mapper.selectByPrimaryKey(bean.getId());
		Date now =new Date();
		if(activities!=null){//编辑
			if(activities.getStatus()==1){
				throw new MyException("活动已在进行中禁止修改!");
			}
			bean.setUpdateDate(now);
			bean.setUpdateBy(user.getId().toString());
			mapper.updateByPrimaryKeySelective(bean);
			//金额配置 删除全部配置  有id的直接更新，无id的新增
		
			activitiesDetailMapper.deleteAllByActId(user.getId(), bean.getId());
			for (TopupActivitiesDetail detail : list) {
				detail.setActId(bean.getId());
				if(detail.getId()!=null){//更新
					detail.setDeleteFlag((short) 0);
					PublicUtil.setCommonForTable(detail, false);
					activitiesDetailMapper.updateByPrimaryKeySelective(detail);
				}else{//新增
					PublicUtil.setCommonForTable(detail, true);
					activitiesDetailMapper.insertSelective(detail);
				}
			}
			bean.setDetailList(list);
			if(bean.getChecked()==1){
				logService.writeLog(bean.getId(), (short) 1, "编辑保存活动，审核通过", true, 1,bean);
				}else{
				logService.writeLog(bean.getId(), (short) 1, "编辑活动,未通过审核", true, 1,bean);	
				}
		}else{//新增
			
			bean.setCreateDate(now);
			bean.setUpdateDate(now);
			bean.setCreateBy(user.getId().toString());
			bean.setUpdateBy(user.getId().toString());
			mapper.insertSelective(bean);
			for (TopupActivitiesDetail detail : list) {
				PublicUtil.setCommonForTable(detail, true);
				detail.setActId(bean.getId());
			}
			activitiesDetailMapper.insertList(list);
			bean.setDetailList(list);
			if(bean.getChecked()==1){
				logService.writeLog(bean.getId(), (short) 0, "新增活动,审核通过!", true, 1,bean);
			}else{
				logService.writeLog(bean.getId(), (short) 0, "新增活动,未通过审核!", true, 1,bean);
			}
		}
		
		
		
		return bean;
		
	}
	

	
	/**
	 * 删除活动详情充值金额
	 */
	public void deleteDeatil(Integer[] idas) {
		activitiesDetailMapper.deleteByPrimaryKey(idas);
	}
	
	/**
	 * 开启活动
	 * @param id
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public  void  openItem(Integer id,TSUser user) throws Exception{
		TopupActivities  activities=mapper.selectByPrimaryKey(id);
		//1.验证活动时间
		if(activities.getChecked()==1&&activities.getStatus()==0){
			
			List<TopupActivitiesDetail>	 list=		activitiesDetailMapper.selectByActId(id);
			activities.setDetailList(list);
			activities.setStatus((short) 1);
			activities.setUpdateDate(new Date());
			activities.setTimeStart(new Date());
			if(user!=null){
				activities.setUpdateBy(user.getId());//用户开启
			}else{
				activities.setUpdateBy("tool");//定时器开启
			}
			mapper.updateByPrimaryKeySelective(activities);
			CommonDataController.activitie_uuid=UUIDGenerator.generate();
			CommonDataController.activitie=activities;
		}else{
			if(activities.getChecked()==0){
				throw new MyException("活动未审核,开启失败!");
			}
			if(activities.getStatus()==1){
				throw new MyException("活动不在准备状态-0!开启失败");
			}
		}
	}
		/**
		 * 重启服务器获取参数
		 * @param id
		 * @param user
		 * @throws Exception
		 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public  void  resItem(Integer id,TSUser user) throws Exception{
		TopupActivities  activities=mapper.selectByPrimaryKey(id);
		//1.验证活动时间
		if(activities.getChecked()==1&&activities.getStatus()==1){
			
			List<TopupActivitiesDetail>	 list=		activitiesDetailMapper.selectByActId(id);
			activities.setDetailList(list);
		 
			CommonDataController.activitie=activities;
			CommonDataController.activitie_uuid=UUIDGenerator.generate();
		}else{
			if(activities.getChecked()==0){
				throw new MyException("活动未审核,开启失败!");
			}
			if(activities.getStatus()==1){
				throw new MyException("活动不在准备状态-1!开启失败");
			}
		}
		
		
	}
	/**
	 * 关闭活动
	 * @param id
	 * @param user
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public  void  closeItem(Integer id,TSUser user) throws Exception{
		TopupActivities  activities=mapper.selectByPrimaryKey(id);
		//1.验证活动时间
			activities.setStatus((short) 2);
			activities.setUpdateDate(new Date());
			if(user!=null){
				activities.setUpdateBy(user.getId());//用户开启
			}else{
				activities.setUpdateBy("tool");//定时器开启
			}
			mapper.updateByPrimaryKeySelective(activities);
			CommonDataController.activitie=null;
			CommonDataController.activitie_uuid=null;
	 
	}
		
	/**
	 * 查询活动是否冲突
	 * @param timeStart
	 * @param timeEnd
	 * @return
	 */
	public	List<TopupActivities> selectByTime(String timeStart,String timeEnd){
		return mapper.selectByTime(timeStart, timeEnd);
	};
	
	  /**
		 * 开启启动查询 需要加入定时计划的活动
		 * @return
		 */
	public  List<TopupActivities> selectOfferList(){
		
		return mapper.selectOfferList();
	};

}
