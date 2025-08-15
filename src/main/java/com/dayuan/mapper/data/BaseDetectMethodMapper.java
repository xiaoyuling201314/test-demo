package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseDetectMethod;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * 
 * Description:检测方法Mapper
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月17日
 */
public interface BaseDetectMethodMapper extends BaseMapper<BaseDetectMethod, String> {

	List<BaseDetectMethod> queryByModularId(String detectModularId);
	
	void deleteByDetectModularId(BaseDetectMethod bean);

	/**
	 * 根据检测方法名称去查询校验唯一性
	 * @param detectMethod
	 * @param modularId
	 * @return
	 */
    BaseDetectMethod selectByMethod(@Param("detectMethod") String detectMethod, @Param("modularId") String modularId);
}