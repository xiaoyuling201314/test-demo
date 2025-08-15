package com.dayuan.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSRoleFunction;
import com.dayuan.mapper.system.TSRoleFunctionMapper;
import com.dayuan.service.BaseService;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月2日
 */
@Service
public class TSRoleFunctionService extends BaseService<TSRoleFunction, String> {

	@Autowired
	private TSRoleFunctionMapper mapper;

	public TSRoleFunctionMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据角色ID查询关联权限信息
	 * @param roleId
	 * @return
	 */
	public List<TSRoleFunction> queryRoleId(String roleId) {
		return mapper.queryRoleId(roleId);
	}
	/**
	 * * 根据菜单ID或操作按钮权限ID进行批量删除
	 * @param deleteIdsList 菜单与操作权限ID列表
	 * @param roleId 角色ID
	 * @author xyl 2017-09-16
	 */
	public void deleteByFunctionId(String[] deleteIdsList,String roleId) {
		mapper.deleteByFunctionId(deleteIdsList,roleId);
	}
	/**
	 * 根据Function功能ID或者操作按钮ID列表进行删除
	 * @param id
	 * @param object
	 * @author xyl
	 */
	public void deleteByFunctionIdOrOperation(String id, String[] ida) {
		mapper.deleteByFunctionIdOrOperation(id,ida);
	}
}
