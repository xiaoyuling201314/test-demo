package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseLawInstrument;
import com.dayuan.mapper.BaseMapper;

/**
 * 执法仪
 * @author LuoYX
 * @date 2018年8月13日
 */
public interface BaseLawInstrumentMapper extends BaseMapper<BaseLawInstrument, Integer> {
	
		
	  List<BaseLawInstrument>  queryAll();
	  
	  List<BaseLawInstrument> selectByDevIdno(String devIdno);

}
