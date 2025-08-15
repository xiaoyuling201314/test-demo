package com.dayuan.service.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.message.TbTaskMessgaeLog;
import com.dayuan.mapper.message.TbTaskMessgaeLogMapper;
import com.dayuan.service.BaseService;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
@Service
public class TbTaskMessgaeLogService extends BaseService<TbTaskMessgaeLog, String>{
	@Autowired
	private TbTaskMessgaeLogMapper mapper;
	
	public TbTaskMessgaeLogMapper getMapper() {
		
		return mapper;
	}
	
	public int insertMessageLog(TbTaskMessgaeLog messgaeLog){
		int count=mapper.insertSelective(messgaeLog);
		return count>0?1:0;	
	}
	
	public int getCount(String userId){
		int count=mapper.getCount(userId);
		return count;
		
	}
	public TbTaskMessgaeLog selectByOne(String mid,String uid){
		return mapper.selectByOne(mid,uid);
	}
}
