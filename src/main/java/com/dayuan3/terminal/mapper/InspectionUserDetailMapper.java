package com.dayuan3.terminal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.InspectionUserDetail;

public interface InspectionUserDetailMapper extends BaseMapper<InspectionUserDetail, Integer>{
    
	 
	List<InspectionUserDetail> queryByUserId(@Param("userId")Integer userId,@Param("rowStart")Integer rowStart,@Param("rowEnd")Integer rowEnd);

}