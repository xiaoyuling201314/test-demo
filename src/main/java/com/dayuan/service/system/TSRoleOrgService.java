package com.dayuan.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSRoleOrg;
import com.dayuan.mapper.system.TSOperationMapper;
import com.dayuan.mapper.system.TSRoleOrgMapper;
import com.dayuan.service.BaseService;
/**
 * 角色-机构  关系
 * @author Bill
 *
 * 2017年8月11日
 */
@Service
public class TSRoleOrgService extends BaseService<TSRoleOrg, String> {

	@Autowired
	private TSRoleOrgMapper mapper;

	public TSRoleOrgMapper getMapper() {
		return mapper;
	}

	
	

}
