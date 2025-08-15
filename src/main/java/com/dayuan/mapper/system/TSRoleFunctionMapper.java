package com.dayuan.mapper.system;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.system.TSRoleFunction;
import com.dayuan.mapper.BaseMapper;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月2日
 */
public interface TSRoleFunctionMapper extends BaseMapper<TSRoleFunction,String> {
	/**
	 * 根据角色ID查询菜单与操作列表
	 * @param roleId
	 * @return
	 */
	List<TSRoleFunction> queryRoleId(String roleId);
	/**
	 * 根据角色ID批量删除操作权限
	 * @param functionIds 权限ID列表
	 * @param roleId 角色ID
	 * @author xyl 2017-09-16
	 */
	void deleteByFunctionId(@Param("functionIds")String[] functionIds,@Param("roleId")String roleId);
	/**
	 * 根据菜单ID或操作按钮ID列表进行关联关系删除
	 * @param id
	 * @param ida
	 */
	void deleteByFunctionIdOrOperation(@Param("functionId")String id,@Param("ida")String[] ida);

}