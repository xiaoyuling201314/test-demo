package com.dayuan.service.system;

import com.dayuan.bean.system.TSFunction;
import com.dayuan.mapper.system.TSFunctionMapper;
import com.dayuan.model.data.TreeNode;
import com.dayuan.model.system.RoleFunctionModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.StringUtil;
import com.dayuan3.api.vo.TSFunctionRespVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


@Service("tSFunctionService")
public class TSFunctionService extends BaseService<TSFunction, String> {

    @Autowired
    private TSFunctionMapper mapper;

    public TSFunctionMapper getMapper() {
        return mapper;
    }


    /**
     * 获取所有菜单
     *
     * @return
     */
    public List<TSFunction> getMenus() {
        List<TSFunction> menus = mapper.getMenus();
        return menus;
    }

    /**
     * 根据角色id获取(云平台)菜单
     *
     * @param roleId
     * @return
     */
    public List<RoleFunctionModel> getRoleMenus(String roleId) {
        List<RoleFunctionModel> menus = mapper.getRoleMenus(roleId);
        return menus;
    }

    /**
     * 根据主菜单获取二级菜单
     *
     * @param id        当前选中的菜单ID
     * @param currentId 编辑的菜单ID
     * @return
     */
//	public List<RoleFunctionModel> getSubordination(RoleFunctionModel roleFuntion) {
//		List<RoleFunctionModel> menus  = functionMapper.getSubordination(roleFuntion);
//		return menus;
//	} 
//	
    public List<TreeNode> queryMenuTree(String currentId, String id, Short functionType) throws Exception {
        List<TreeNode> trees = new ArrayList<TreeNode>();
        List<TSFunction> menus = mapper.queryMenuByPid(id, functionType);
        if (StringUtil.isEmpty(id)) {//控制只在第一行加入请选择菜单，因为第一次调用id为空
            TreeNode treeNode = new TreeNode();
            treeNode.setId(null);
            treeNode.setText("请选择");
            trees.add(treeNode);
        }

        for (Iterator iter = menus.iterator(); iter.hasNext(); ) {
            TSFunction menu = (TSFunction) iter.next();
            if (!StringUtil.isEmpty(currentId) && currentId.equals(menu.getId())) {//shit更改 删除当前被编辑的菜单
                iter.remove();
            } else {
                TreeNode tree = new TreeNode();
                tree.setId(menu.getId());
                tree.setText(menu.getFunctionName());
                List<TSFunction> childMenu = mapper.queryMenuByPid(menu.getId(), functionType);
                if (childMenu != null && childMenu.size() > 0) {
                    tree.setState("closed");
                }
                trees.add(tree);
            }
        }
        return trees;
    }

/*	*//**
     * 重写数据列表方法
     * @param page 分页参数
     * @return 任务列表
     *//*
    public Page loadDatagrid(Page page, TSFunctionModel t) throws Exception{
		// 初始化分页参数
		if (null == page) {
			page = new Page();
		}
		// 设置查询条件
		page.setObj(t);
		// 每次查询记录总数量,防止新增或删除记录后总数量错误
		List<TSFunction> dataList =null;
		if(t.getBaseBean()==null){
			dataList =mapper.queryMenuByPid(null);//查询所有一级菜单
//			page.setRowTotal(getMapper().getRowTotal(page));
		}else{
			dataList =mapper.queryMenuByName(t.getBaseBean().getFunctionName());
		}
		List<String> resultList=new ArrayList<>();
		String ids="";
		for (TSFunction tsFunction : dataList) {
			ids=mapper.queryAllChild(tsFunction.getId());
			String[] idsList2=ids.split(",");
			List<String> idsList=mapper.queryMenuByIdList(idsList2);
			resultList.addAll(idsList);
			if(resultList.size()>=page.getPageNo()*page.getPageSize()){//判断获取的数据量是否足够，例如:每页显示10条，要获取第3页，则需要>=3*10条数据
				page.setRowTotal(resultList.size());
				break;
			}
		}
		int endIndex=page.getPageNo()*page.getPageSize();
		if(resultList.size()>=endIndex){
			page.setResults(resultList.subList((page.getPageNo()-1)*page.getPageSize(),endIndex ));
		}else if(endIndex>resultList.size()){
			page.setResults(resultList.subList((page.getPageNo()-1)*page.getPageSize(),resultList.size()));
		}else{
			page.setResults(resultList);
		}
		page.setRowTotal(resultList.size());
		// 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
		return page;
	}*/

    /**
     * 根据ID查询菜单以及子类
     *
     * @param id
     * @return
     */
    public List<TSFunction> querySubFunction(String id, Integer deleteFlag) {
        return mapper.querySubFunction(id, deleteFlag);
    }


    public List<TSFunction> queryMenuByPid(String id, Short functionType) {
        return mapper.queryMenuByPid(id, functionType);
    }

    /**
     * 根据角色ID权限获取菜单
     *
     * @param roleId
     * @return
     */
    public List<TSFunction> queryByRoleId(String roleId) {
        return mapper.queryByRoleId(roleId);
    }

    /**
     * 根据请求url查找菜单
     *
     * @return
     */
    public TSFunction queryByFunctionUrl(String functionUrl) throws Exception {
        return mapper.queryByFunctionUrl(functionUrl);
    }


    public String queryMaxIdByPid(String id) {
        return mapper.queryMaxIdByPid(id);
    }


    public TSFunction queryByFunctionName(TSFunction bean) {
        return mapper.queryByFunctionName(bean);
    }


    public void deleteByFunctionId(String id) throws Exception {
        //TODO 暂未实现
        //删除菜单与功能权限关联关系
        //删除操作权限
        mapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据parent查询最大的排序码
     *
     * @param parentId
     * @param functionType
     * @return
     */
    public String queryMaxSortingByPid(String parentId, Short functionType) {
        return mapper.queryMaxSortingByPid(parentId, functionType);
    }

    public int queryMaxId() {
        return mapper.queryMaxId();
    }


    /**
     * 查询出除了最顶级菜单之外的所有菜单
     *
     * @param functionName
     * @param functionType
     * @return
     * @throws Exception
     */
    public List<TSFunction> selectFunctionAll(Short functionLevel, String functionName, Short functionType) throws Exception {
        return mapper.selectFunctionAll(functionLevel, functionName, functionType);
    }

    /**
     * 根据二级菜单查询三级菜单
     *
     * @param id
     * @return
     */
    public List<TSFunction> selectSystemByParentId(String functionName, String id) throws Exception {
        return mapper.selectSystemByParentId(functionName, id);
    }

    /**
     * 查询出除了最顶级菜单之外的所有菜单
     *
     * @param functionName
     * @param functionType
     * @return
     */
    public List<TSFunction> selectFunctionAllNot1(String functionName, Short functionType) {
        return mapper.selectFunctionAllNot1(functionName, functionType);
    }

    /**
     * 菜单的启用
     *
     * @param id
     * @throws Exception
     */
    public void enableStart(Integer id) throws Exception {
        mapper.enableStart(id);
    }

    /**
     * 菜单界面的展示查询shit
     *
     * @param functionName
     * @param functionType
     * @param deleteFlag
     * @return
     */
    public List<TSFunction> selectFunctionDatagrid(String functionName, Short functionType, Short deleteFlag) throws Exception {
        List<TSFunction> list = new ArrayList<>();
        //===============================functionName="" 情况1、2 使用同一种查询==================================
        if (StringUtil.isEmpty(functionName)) {
            //方式三减少数据库的访问，使用迭代
            //1.查询出最顶级菜单
            List<TSFunction> tsFunctions = this.selectFunctionAll(new Short("1"), functionName, functionType);
            //2.查询出除了最顶级菜单之外的所有三级菜单
            List<TSFunction> tsFunctionsAll = this.selectFunctionAll(new Short("3"), functionName, functionType);
            if (tsFunctions.size() > 0) {//一级菜单有那就逐级查询,因为二级菜单和三级菜单不可能单独存在
                for (TSFunction tsFunction : tsFunctions) {
                    //添加一级菜单
                    if (deleteFlag == null || deleteFlag == tsFunction.getDeleteFlag()) {
                        list.add(tsFunction);
                    }

                    //查询一级菜单的子级菜单(二级菜单)
                    List<TSFunction> tsFunction21 = this.selectSystemByParentId(functionName, tsFunction.getId());
                    for (TSFunction function21 : tsFunction21) {
                        //设置启用和未启用状态（父机构为未启用，子机构全部为未启用）更加便捷的方式，直接把父菜单delete_flag状态传进去
                        if (tsFunction.getDeleteFlag() == 1) {
                            function21.setDeleteFlag(tsFunction.getDeleteFlag());
                        }

                        //添加二级菜单
                        if (deleteFlag == null || deleteFlag == function21.getDeleteFlag()) {
                            list.add(function21);
                        }

                        for (TSFunction functionAll : tsFunctionsAll) {
                            if (function21.getId().equals(functionAll.getParentId())) {
                                if (function21.getDeleteFlag() == 1) {
                                    functionAll.setDeleteFlag(function21.getDeleteFlag());
                                }
                                //添加三级菜单
                                if (deleteFlag == null || deleteFlag == functionAll.getDeleteFlag()) {
                                    list.add(functionAll);
                                }
                            }
                        }
                    }
                }
            }
        } else {//===============================情况3:functionName != "" functionType = -1 ,查询出该条件下的所有菜单==================================
            //1.查询出最顶级菜单
            List<TSFunction> tsFunctions = this.selectFunctionAll(new Short("1"), functionName, functionType);
            //2.查询出所有二级菜单
            List<TSFunction> tsFunctions2 = this.selectFunctionAll(new Short("2"), functionName, functionType);
            //3.查询出除了最顶级菜单之外的所有三级菜单
            List<TSFunction> tsFunctions3 = this.selectFunctionAll(new Short("3"), functionName, functionType);
            //0-true 如果最顶级菜单存在
            if (tsFunctions.size() > 0) {
                //1-true 如果二级菜单存在 把二级菜单添加到其父级菜单中
                if (tsFunctions2.size() > 0 && tsFunctions3.size() > 0) {//如果二三级菜单都不为空
                    for (TSFunction tsf1 : tsFunctions) {
                        //添加一级菜单
                        if (deleteFlag == null || deleteFlag == tsf1.getDeleteFlag()) {
                            list.add(tsf1);
                        }

                        List<TSFunction> submenus2 = getSubmenu(tsf1, tsFunctions2);//获取二级子菜单
                        for (TSFunction submenu : submenus2) {
                            //添加二级菜单
                            if (deleteFlag == null || deleteFlag == submenu.getDeleteFlag()) {
                                list.add(submenu);
                            }

                            List<TSFunction> submenus3 = getSubmenu(submenu, tsFunctions3);//获取三级子菜单
                            for (TSFunction submenus30 : submenus3) {
                                //添加三级菜单
                                if (deleteFlag == null || deleteFlag == submenus30.getDeleteFlag()) {
                                    list.add(submenus30);
                                }
                            }
                        }
                    }
                    //去除已经被选中的
                    tsFunctions2.removeAll(list);
                    tsFunctions3.removeAll(list);
                    list.addAll(tsFunctions2);
                    list.addAll(tsFunctions3);
                } else if (tsFunctions2.size() > 0 && tsFunctions3.size() <= 0) {//1-false 否则直接添加进集合
                    for (TSFunction tsf1 : tsFunctions) {
                        list.add(tsf1);
                        List<TSFunction> submenus2 = getSubmenu(tsf1, tsFunctions2);//获取二级子菜单
                        list.addAll(submenus2);
                    }
                    tsFunctions2.removeAll(list);
                    list.addAll(tsFunctions2);
                } else if (tsFunctions2.size() <= 0 && tsFunctions3.size() <= 0) {
                    list.addAll(tsFunctions);
                } else if (tsFunctions2.size() <= 0 && tsFunctions3.size() > 0) {
                    list.addAll(tsFunctions);
                    list.addAll(tsFunctions3);
                }

            } else {//0-false 如果最顶级菜单不存在
                if (tsFunctions2.size() > 0) {//1-true 如果二级菜单存在
                    if (tsFunctions3.size() > 0) {
                        for (TSFunction tsf2 : tsFunctions2) {
                            //添加二级菜单
                            if (deleteFlag == null || deleteFlag == tsf2.getDeleteFlag()) {
                                list.add(tsf2);
                            }

                            for (Iterator iter = tsFunctions3.iterator(); iter.hasNext(); ) {
                                TSFunction tsf3 = (TSFunction) iter.next();
                                if (tsf2.getId().equals(tsf3.getParentId())) {//如果是其子菜单就添加进入
                                    if (tsf2.getDeleteFlag() == 1) {
                                        tsf3.setDeleteFlag(tsf2.getDeleteFlag());
                                    }
                                    //添加三级菜单
                                    if (deleteFlag == null || deleteFlag == tsf3.getDeleteFlag()) {
                                        list.add(tsf3);
                                    }
                                    iter.remove();//添加后删除添加过去的
                                }
                            }
                        }
                        list.addAll(tsFunctions3);
                    } else {
                        for (TSFunction tsf2 : tsFunctions2) {
                            //添加二级菜单
                            if (deleteFlag == null || deleteFlag == tsf2.getDeleteFlag()) {
                                list.add(tsf2);
                            }
                        }
                    }
                } else {//1-false如果二级菜单不存在
                    if (tsFunctions3.size() > 0) {
                        for (TSFunction tsf3 : tsFunctions3) {
                            //添加三级菜单
                            if (deleteFlag == null || deleteFlag == tsf3.getDeleteFlag()) {
                                list.add(tsf3);
                            }
                        }
                    }
                }
            }
        }
        return list;
    }

    private List<TSFunction> getSubmenu(TSFunction tsf1, List<TSFunction> tsFunctions) {
        List<TSFunction> list = new ArrayList<>();
        for (TSFunction tsFunction : tsFunctions) {
            if (tsf1.getId().equals(tsFunction.getParentId())) {
                if (tsf1.getDeleteFlag() == 1) {
                    tsFunction.setDeleteFlag(tsf1.getDeleteFlag());
                }
                list.add(tsFunction);
            }
        }
        return list;
    }

    /**
     * 根据角色ID和菜单类型查询菜单
     * @param roleId
     * @param type 0：云平台 1：APP 2：工作站 3：公众号
     * @return
     * @author shit
     */
    public List<TSFunction> queryByRIdAndType(String roleId, Short type) {
        return mapper.queryByRIdAndType(roleId,type);
    }
    /**
    * @Description 根据登录用户的角色ID查询是否有指定地址的权限
    * @Date 2022/10/20 14:23
    * @Author xiaoyl
    * @Param
    * @return
    */
    public TSFunction queryVisualPrivile(String roleId,String functionUrl) {
        return mapper.queryVisualPrivile(roleId,functionUrl);
    }

    public List<TSFunctionRespVo> getRolesForWX(String roleId,Integer functionType, int level) {
        return mapper.getRolesForWX(roleId,functionType,level);
    }
}
