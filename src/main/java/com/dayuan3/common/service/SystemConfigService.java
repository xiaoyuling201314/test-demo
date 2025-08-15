package com.dayuan3.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SystemConfig;
import com.dayuan3.common.mapper.SystemConfigMapper;
/**
 *	 系统配置
 * @author xiaoyl
 * @date   2019年9月25日
 */
@Service
public class SystemConfigService extends BaseService<SystemConfig, Integer> {
	@Autowired
	private SystemConfigMapper mapper;

	public SystemConfigMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据项目ID查询系统配置参数
	 * @description
	 * @param projectID
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月25日
	 */
	public List<SystemConfig> queryByProjectID(String  projectID) {
		return mapper.queryByProjectID(projectID);
	}
	/**
	 * 	根据项目ID，配置类型ID查询是否已配置
	 * @description
	 * @param projectId
	 * @param configTypeId
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月26日
	 */
	public int queryByConfigType(String projectId, Integer configTypeId) {
		return mapper.queryByConfigType(projectId,configTypeId);
	}
	
	/**
	 * 	根据配置类型ID查询配置
	 * @description
	 * @param projectId
	 * @param configTypeId
	 * @return
	 * @author xiaoyl
	 * @date   2019年9月26日
	 */
	public SystemConfig queryDataByConfigType(Integer configTypeId) {
		return mapper.queryDataByConfigType(configTypeId);
	}
}
