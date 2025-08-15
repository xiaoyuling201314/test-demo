package com.dayuan.mapper.message;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.message.TbTaskMessgaeLog;
import com.dayuan.mapper.BaseMapper;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
public interface TbTaskMessgaeLogMapper extends BaseMapper<TbTaskMessgaeLog, String>{
	/**未读信息条数
	 * @param toUserId
	 * @return
	 */
	int getCount(String userId);
	
	TbTaskMessgaeLog selectByOne(@Param("mid")String mid,@Param("uid")String uid);
}