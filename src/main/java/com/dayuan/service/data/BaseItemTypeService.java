package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseItemType;
import com.dayuan.mapper.data.BaseDetectItemMapper;
import com.dayuan.mapper.data.BaseItemTypeMapper;
import com.dayuan.service.BaseService;
import com.dayuan.util.StringUtil;

/**
 * 
 * Description: 检测项目类型
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月9日
 */
@Service
public class BaseItemTypeService extends BaseService<BaseItemType, String> {
	
	@Autowired
	private BaseItemTypeMapper mapper;
	
	public BaseItemTypeMapper getMapper() {
		return mapper;
	}
	/**
	 * 查询所有的检测项目类型
	 * @author xyl
	 * @return
	 */
	public List<BaseItemType> queryAll() {
		return mapper.queryAll();
	}
	
	/**
	 * 根据食品种类查询检测项目类型
	 * @param ids
	 * @return
	 */
	public List<BaseItemType> queryByFoodId(String foodIds){
		String [] ids = null;
		if(StringUtil.isNotEmpty(foodIds)) {
			ids = foodIds.split(",");
		}
		return mapper.queryByFoodId(ids);
	}

}
