package com.dayuan3.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.SystemConfig;
/**
 * 	系统配置
 * @author xiaoyl
 * @date   2019年9月25日
 */
public interface SystemConfigMapper extends BaseMapper<SystemConfig, Integer> {

	List<SystemConfig> queryByProjectID(String projectID);

	int queryByConfigType(@Param("projectId")String projectId,@Param("configTypeId")Integer configTypeId);

	SystemConfig queryDataByConfigType(@Param("configTypeId")Integer configTypeId);

}