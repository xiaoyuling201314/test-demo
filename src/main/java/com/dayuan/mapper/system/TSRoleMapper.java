package com.dayuan.mapper.system;

import java.util.List;

import com.dayuan.bean.system.TSRole;
import com.dayuan.mapper.BaseMapper;
/**
 * 用户角色
 * @author Bill
 *
 * 2017年8月9日
 */
public interface TSRoleMapper extends BaseMapper<TSRole, String> {

	/**
	 * 获取所有未删除角色
	 * @return
	 */
	List<TSRole> getRoleList();
	
	/**
	 * 获取所有未删除已审核的角色
	 * @return
	 */
	List<TSRole> getCRoleList();
	
	/**
	 * 根据角色名查找
	 * @param roleName
	 * @return
	 */
	TSRole selectByRoleName(String roleName);
	
}