package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.data.BaseItemType;

public interface BaseItemTypeMapper extends BaseMapper<BaseItemType, String> {

	List<BaseItemType> queryAll();
	
	List<BaseItemType> queryByFoodId(@Param("ids")String[] ids);

}