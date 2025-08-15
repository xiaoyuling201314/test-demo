package com.dayuan.mapper.system;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.system.TSOperation;
import com.dayuan.mapper.BaseMapper;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月31日
 */
public interface TSOperationMapper extends BaseMapper<TSOperation, String>  {

	TSOperation queryByOperationName(TSOperation bean);
	/**
	 * 根据角色ID和菜单ID查找按钮操作权限
	 * @param roleId 角色ID
	 * @param function_id 菜单ID
	 * @return
	 */
	List<TSOperation> queryByRoleIdAndFunctionId(@Param("roleId")String roleId,@Param("functionId")String functionId);
	
	String queryLastCode(@Param("functionId")String functionId);
	
	void deleteByFunctionId(String id);

	void enableByFunctionId(Integer id);

	/**
	 * 查询所有 按钮权限
	 * @param roleId 角色ID
	 * @return
	 * @author LuoYX
	 * @date 2018年5月25日
	 */
	List<TSOperation> queryAllPrivilegs(String roleId);


	/**
	 * 根据角色ID和菜单类型查询权限按钮
	 * @param roleId 角色ID
	 * @param type 菜单类型
	 * @author shit
	 * @return
	 */
	List<TSOperation> queryByRIdAndType(@Param("roleId") String roleId, @Param("type") Short type);
	/**
	* @Description 根据角色ID、操作权限code查询是否有该权限
	* @Date 2022/10/20 14:46
	* @Author xiaoyl
	* @Param
	* @return
	*/
	int queryByOperationCode(@Param("roleId")String roleId,@Param("operationCode")String operationCode);
}