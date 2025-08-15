package com.dayuan.controller.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dayuan.bean.system.TSUser;
import com.dayuan.logs.aop.SystemLog;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.ValidformJson;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSRole;
import com.dayuan.bean.system.TSRoleFunction;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.TreeNode;
import com.dayuan.model.system.TSRoleModel;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSRoleFunctionService;
import com.dayuan.service.system.TSRoleService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月2日
 */
@Controller
@RequestMapping("/system/role")
public class TSRoleController extends BaseController {
	private final Logger log=Logger.getLogger(TSRoleController.class);
	@Autowired
	private TSRoleService tsRoleService;
	@Autowired
	private TSFunctionService tSFunctionService;
	@Autowired
	private TSRoleFunctionService tSRoleFunctionService;
	@Autowired
	private TSOperationService tSOperationService;
	
	/**
	 * 用户角色列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>();
		List<TSRole> list=null;
		try {
			list = tsRoleService.getRoleList();
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		map.put("list", list);
		return new ModelAndView("/system/role/list",map);
	}

	/**
	 * 角色权限控制页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/permission")
	public ModelAndView permission(HttpServletRequest request,HttpServletResponse response,String id,Short functionType){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			TSRole bean = tsRoleService.queryById(id);
			List<TSFunction> firstMenu = tSFunctionService.queryMenuByPid(null,functionType);
			List<TSFunction> resultList = new ArrayList<>();
			int firstCount = 0;
			for (TSFunction tsFunction : firstMenu) {//查询二级菜单和三级数量
				List<TSFunction> secondMenu = tsFunction.getSubMenu();
				firstCount = 0;
				for (TSFunction tsFunction2 : secondMenu) {
					firstCount += tsFunction2.getSubTotal();
				}
				if(firstCount<secondMenu.size()){//当只有二级菜单，没有三级菜单时设置一级菜单子类为secondMenu.size()
					firstCount=secondMenu.size();
				}
				tsFunction.setSubTotal(firstCount);
				resultList.add(tsFunction);
			}
			map.put("firstMenu", resultList);
			map.put("bean", bean);
			map.put("functionType", functionType);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/system/role/permission",map);
	}
	
	/**
	 * 角色管理 - 角色名称重复验证
	 * @param roleId 角色ID
	 * @param roleName 角色名称
	 * @return
	 */
	@RequestMapping("/selectByRoleName")
    @ResponseBody
    public ValidformJson selectByRoleName(String roleId, String roleName){
		ValidformJson json =new ValidformJson();
    	try {
    		TSRole role = tsRoleService.selectByRoleName(roleName);
    		if (role != null && !role.getId().equals(roleId)) {
    			json.setStatus("n");
    			json.setInfo("该角色名称已存在");
			}
		} catch (Exception e) {
			json.setStatus("n");
			json.setInfo("操作失败");
		}
    	return json;
    }
	
	/**
	 * 新增/编辑菜单权限和操作按钮权限
	 * @param request
	 * @param response
	 * @param menuIds
	 * @param btnIds
	 * @param roleId
	 * @return
	 */
	@RequestMapping("/addMunes")
	@ResponseBody
	public AjaxJson addMunes(HttpServletRequest request,HttpServletResponse response,String menuIds,String btnIds,String deleteIds,String roleId){
		AjaxJson jsonObject = new AjaxJson();	
		try {
			String[] menuList = menuIds == null ? null : menuIds.split(",");
			TSRoleFunction bean = null;
			String[] btnList = btnIds == null ? null : btnIds.split(",");
			String[] deleteIdsList = deleteIds == null ? null : deleteIds.split(",");
			//1.根据角色ID删除未选择的菜单和权限
			if (deleteIdsList != null && deleteIdsList.length > 0) {
				tSRoleFunctionService.deleteByFunctionId(deleteIdsList,roleId);
			}
			List<TSRoleFunction> list=tSRoleFunctionService.queryRoleId(roleId);
			//2.遍历已选择的菜单列表，与已有的权限进行对比，不存在则进行新增授权
			for (String menu : menuList) {
				if(menu == null || menu.trim() == ""){//FunctionId为空，跳过新增
					continue;
				}
				int count = 0;
				if(list.size()>0){
					for (TSRoleFunction tsRoleFunction : list) {
						if (tsRoleFunction.getFunctionId().equals(menu)) {
							count = 1;
						}
					}
				}
				if (count == 0) {
					bean = new TSRoleFunction();
					bean.setId(UUIDGenerator.generate());
					bean.setFunctionId(menu);
					bean.setMark((short) 0);
					bean.setRoleId(roleId);
					PublicUtil.setCommonForTable(bean, true);
					tSRoleFunctionService.insert(bean);
				}
			}
			//3.遍历已选择的操作权限列表，与已有的权限进行对比，不存在则进行新增授权
			for (String btn : btnList) {
				if(btn == null || btn.trim() == ""){//FunctionId为空，跳过新增
					continue;
				}
				int count = 0;
				if(list.size()>0){
					for (TSRoleFunction tsRoleFunction : list) {
						if (tsRoleFunction.getFunctionId().equals(btn)) {
							count = 1;
						}
					}
				}
				if (count == 0) {
					bean = new TSRoleFunction();
					bean.setId(UUIDGenerator.generate());
					bean.setFunctionId(btn);
					bean.setMark((short) 1);
					bean.setRoleId(roleId);
					PublicUtil.setCommonForTable(bean, true);
					tSRoleFunctionService.insert(bean);
				}
			}
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return jsonObject;
	}

	@RequestMapping("/queryRight")
	@ResponseBody
	public AjaxJson queryRight(String roleId,HttpServletRequest request,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			List<TSRoleFunction> list = tSRoleFunctionService.queryRoleId(roleId);
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return jsonObj;
	}
	
	@RequestMapping("/queryRoleList")
	@ResponseBody
	public List<TreeNode> queryRoleList(HttpServletRequest request,HttpServletResponse response){
		List<TreeNode> departTree=null;
		try {
			departTree = tsRoleService.queryTypeTree();
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return departTree;
	}
	
	@RequestMapping("/queryRoleLists")
	@ResponseBody
	public List<TSRole> queryRoleLists(HttpServletRequest request,HttpServletResponse response){
		List<TSRole> list=null;
		try {
			list = tsRoleService.getRoleList();
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return list;
	}
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(TSRoleModel model,Page page,HttpServletResponse response) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("asc");
			//add by xiaoyl 2023/02/14 非管理员，只能查看已授权的角色
			TSUser tsUser = PublicUtil.getSessionUser();
			if(!("999").equals(tsUser.getRoleId())){
				TSRole role = tsRoleService.queryById(tsUser.getRoleId());
				String[] roleIds =null;
				if (StringUtil.isNotEmpty(role.getChildrenId())) {
					roleIds=  role.getChildrenId().split(",");
				} else {
					roleIds=new String[]{tsUser.getRoleId()};
				}
				model.setRoleIds(roleIds);
			}
			page = tsRoleService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 新增/修改用户信息方法
	 * @param role
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	@SystemLog(module = "角色管理",methods = "新增与编辑",type = 1,serviceClass = "TSRoleService")
	public  AjaxJson save(TSRole role,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		AjaxJson jsonObject = new AjaxJson();	
		try {
//			delete by xiaoyl 2022/04/22 去掉默认排序，因为这里会导致角色配置的时候会重置为0，在新增的时候如果为空则设置为0
//			role.setSorting(role.getSorting()==null ? 0 : role.getSorting());
			if (StringUtil.isEmpty(role.getId())) {
				role.setSorting(role.getSorting()==null ? 0 : role.getSorting());
				PublicUtil.setCommonForTable(role, true);
				role.setId(UUIDGenerator.generate());
				tsRoleService.insert(role);
			} else {
				PublicUtil.setCommonForTable(role, false);
				tsRoleService.updateBySelective(role);
			} 
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> map=new HashMap<>();
		map.put("id",role.getId());
		jsonObject.setAttributes(map);
		return jsonObject;
	}
	
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSRole bean = tsRoleService.queryById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return jsonObject;
	}

	@RequestMapping("/queryByIds")
	@ResponseBody
	public AjaxJson queryByIds(String id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		Map<String, Object> map=new HashMap<>();
		try {
			TSRole role = tsRoleService.queryById(id);
			map.put("role", role);
			jsonObject.setAttributes(map);
			List<TSRole>  roleList = tsRoleService.getRoleList();
			jsonObject.setObj(roleList);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		return jsonObject;
	}

	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	@SystemLog(module = "角色管理",methods = "删除",type = 3,serviceClass = "TSRoleService")
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			tsRoleService.delete(ida);
		} catch (Exception e) {
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 复制角色
	 * @param request
	 * @param response
	 * @param id 角色ID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/copyRole")
	@ResponseBody
	@SystemLog(module = "角色管理",methods = "复制角色",type = 1,serviceClass = "TSRoleService")
	public AjaxJson copyRole(String id){
		AjaxJson jsonObject = new AjaxJson();
		String roleId = "";
		try {
			TSRole role = tsRoleService.copyRole(id);
			if (role != null) {
				roleId = role.getId();
			} else {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("复制失败，找不到角色["+id+"]");
			}
		} catch (Exception e) {
			jsonObject.setSuccess(false);
			jsonObject.setMsg("复制失败");
			log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> map=new HashMap<>();
		map.put("id", roleId);
		jsonObject.setAttributes(map);
		return jsonObject;
	}
	
}
