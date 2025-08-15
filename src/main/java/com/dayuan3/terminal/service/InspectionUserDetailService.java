package com.dayuan3.terminal.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.terminal.bean.InspectionUserDetail;
import com.dayuan3.terminal.mapper.InspectionUserDetailMapper;

@Service
public class InspectionUserDetailService extends BaseService<InspectionUserDetail, Integer>{
	@Autowired
	private  InspectionUserDetailMapper mapper;

	@Override
	public BaseMapper<InspectionUserDetail, Integer> getMapper() {
		return mapper;
	}
	/**
	 * 查询用户送检(单位)信息列表
	 * @param userId
	 * @param rowStart
	 * @param rowEnd
	 * @return
	 */
	public List<InspectionUserDetail> queryByUserId(@Param("userId")Integer userId,@Param("rowStart")Integer rowStart,@Param("rowEnd")Integer rowEnd) {
		
		return mapper.queryByUserId(userId, rowStart, rowEnd);
	}
	
	
}
