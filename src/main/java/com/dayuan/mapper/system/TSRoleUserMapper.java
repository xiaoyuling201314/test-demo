package com.dayuan.mapper.system;

import com.dayuan.bean.system.TSRoleUser;
import com.dayuan.mapper.BaseMapper;
/**
 * 角色-系统用户 关系
 * @author Bill
 *
 * 2017年8月11日
 */
public interface TSRoleUserMapper extends BaseMapper<TSRoleUser, String> {
	
	/**
	 * 通过userId获取TSRoleUser
	 * @param userId
	 * @return 
	 */
	TSRoleUser getRoleIdByUserId(String userId);
}