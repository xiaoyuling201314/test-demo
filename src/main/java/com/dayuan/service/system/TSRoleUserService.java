package com.dayuan.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSRole;
import com.dayuan.bean.system.TSRoleUser;
import com.dayuan.mapper.system.TSRoleMapper;
import com.dayuan.mapper.system.TSRoleUserMapper;
import com.dayuan.service.BaseService;
/**
 * 角色-系统用户  关系
 * @author Bill
 *
 * 2017年8月11日
 */
@Service
public class TSRoleUserService extends BaseService<TSRoleUser, String> {

	@Autowired
	private TSRoleUserMapper roleUserMapper;
	@Autowired
	private TSRoleMapper roleMapper;
			
	public TSRoleUserMapper getMapper() {
		return roleUserMapper;
	}
	
	/**
	 * 通过用户Id获取role对象
	 * @param userId
	 * @return
	 */
	public TSRole getRoleByUserId(String userId){
		TSRoleUser roleUser = roleUserMapper.getRoleIdByUserId(userId);
		TSRole role = roleMapper.selectByPrimaryKey(roleUser.getRoleId());	
		return role;	
	}
	

}
