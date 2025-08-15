package com.dayuan.service.system;

import java.util.ArrayList;
import java.util.List;

import com.dayuan.bean.system.TSRoleFunction;
import com.dayuan.common.PublicUtil;
import com.dayuan.util.UUIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSRole;
import com.dayuan.mapper.system.TSRoleMapper;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.BaseService;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TSRoleService extends BaseService<TSRole, String> {

	@Autowired
	private TSRoleMapper mapper;
	@Autowired
	private TSRoleFunctionService roleFunctionService;

	public TSRoleMapper getMapper() {
		return mapper;
	}

	/**
	 * 获取所有未删除角色
	 * @return
	 */
	public List<TSRole> getRoleList(){
		return mapper.getRoleList();
	}
	
	/**
	 * 获取所有未删除已审核的角色
	 * @return
	 */
	public List<TSRole> getCRoleList(){
		return mapper.getCRoleList();
	}
	
	/**
	 * 根据角色名查找
	 * @param roleName
	 * @return
	 */
	public TSRole selectByRoleName(String roleName){
		return mapper.selectByRoleName(roleName);
	}

	public List<TreeNode> queryTypeTree() throws Exception{
		List<TreeNode> trees = new ArrayList<TreeNode>();
		List<TSRole> menus = mapper.getRoleList();
		for(TSRole menu : menus){
			TreeNode tree = new TreeNode();
			tree.setId(menu.getId());
			tree.setText(menu.getRolename());
			
			trees.add(tree);
		}
		return trees;
	}

	/**
	 * 复制角色
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public TSRole copyRole(String id) throws Exception {
		//复制角色
		TSRole role = queryById(id);
		if (role != null) {
			role.setId(UUIDGenerator.generate());
			role.setRolename(role.getRolename()+"(1)");
			PublicUtil.setCommonForTable(role, true);
			insert(role);

			//复制角色权限
			List<TSRoleFunction> rfs = roleFunctionService.queryRoleId(id);
			if (rfs != null) {
				for (TSRoleFunction rf : rfs) {
					rf.setId(UUIDGenerator.generate());
					rf.setRoleId(role.getId());
					PublicUtil.setCommonForTable(rf, true);
					roleFunctionService.insert(rf);
				}
			}
		}
		return role;
	}

}
