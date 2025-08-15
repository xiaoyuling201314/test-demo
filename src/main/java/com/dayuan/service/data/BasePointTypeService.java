package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BasePointType;
import com.dayuan.mapper.data.BasePointTypeMapper;
import com.dayuan.service.BaseService;

/**
 * 检测点类型
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2017年12月13日
 */
@Service
public class BasePointTypeService extends BaseService<BasePointType, Integer> {
	
	@Autowired
	private BasePointTypeMapper mapper;
	
	public BasePointTypeMapper getMapper() {
		return mapper;
	}

	/**
	 * 加载检测点性质
	 * @return
	 * @author LuoYX
	 * @date 2018年2月2日
	 */
	public List<BasePointType> selectAllType() {
		return mapper.selectAllType();
	}
}
