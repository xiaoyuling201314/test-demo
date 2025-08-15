package com.dayuan3.terminal.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.bean.TopupActivitiesLog;
import com.dayuan3.terminal.mapper.TopupActivitiesLogMapper;

@Service
public class TopupActivitiesLogService extends BaseService<TopupActivitiesLog, Integer>{
	@Autowired
	private TopupActivitiesLogMapper mapper;

	@Override
	public BaseMapper<TopupActivitiesLog, Integer> getMapper() {
		 
		return mapper;
	}
	
	/**
	 * 活动操作日志
	 * @param offerId  活动id
	 * @param type 操作类型 0新建 1编辑 2开启 3关闭 4删除 5 定时计划 6服务器重启
	 * @param msg 日志信息
	 * @param result 操作结果
	 * @param userType 用户类型 0 定时器 1用户操作
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void writeLog(Integer actId,short type,String msg,boolean result,Integer userType,TopupActivities activities) throws Exception{
		TopupActivitiesLog bean= new TopupActivitiesLog();
		bean.setActId(actId);
		bean.setType(type);
		bean.setMsg(msg);
		if(activities!=null){//编辑时保存参数
			bean.setDescription(JSONObject.toJSON(activities).toString());
		}
		if(result){//操作结果
			bean.setResult((short) 0);
		}else{
			bean.setResult((short) 1);
		}
		if(userType==0){//定时操作
			bean.setUserId("0");
			bean.setUserName("定时器");
			bean.setCreateDate(new Date());;
		}else{
			TSUser user = PublicUtil.getSessionUser();
			if(user!=null){
				bean.setUserId(user.getId());
				bean.setUserName(user.getRealname());
				bean.setCreateDate(new Date());
			}
		}
		mapper.insertSelective(bean);
		 
	}
}
