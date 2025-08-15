package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BasePointType;
import com.dayuan.mapper.BaseMapper;

/**
 * 检测点类型
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2017年12月13日
 */
public interface BasePointTypeMapper extends BaseMapper<BasePointType, Integer> {

	/**
	 * 查询检测点性质
	 * @return
	 * @author LuoYX
	 * @date 2018年2月2日
	 */
	List<BasePointType> selectAllType();
}