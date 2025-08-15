package com.dayuan3.common.mapper;

import java.util.List;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.SystemConfigType;
/**
 * 	系统配置类型
 * @author xiaoyl
 * @date   2019年9月25日
 */
public interface SystemConfigTypeMapper extends BaseMapper<SystemConfigType, Integer>{

	List<SystemConfigType> queryAll();
    
}