package com.dayuan.controller.system;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSRoleFunctionService;
import com.dayuan.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统菜单
 *
 * @author Dz
 */
@Controller
@RequestMapping("/system/menu")
public class TSFunctionController extends BaseController {

    private final Logger log = Logger.getLogger(TSFunctionController.class);

    @Autowired
    private TSFunctionService tSFunctionService;
    @Autowired
    private TSOperationService tSOperationService;

    @Autowired
    private TSRoleFunctionService tSRoleFunctionService;

    /**
     * 菜单管理列表
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {

        return new ModelAndView("/system/menu/list");
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(String functionName, Short functionType, Short deleteFlag, Page page) throws Exception {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            List<TSFunction> list = tSFunctionService.selectFunctionDatagrid(functionName, functionType, deleteFlag);
            page.setResults(list);
            ajaxJson.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("操作失败");
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return ajaxJson;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(String id, HttpServletResponse response) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        TSFunction bean = tSFunctionService.queryById(id);
        if (bean == null) {
            jsonObject.setSuccess(false);
            jsonObject.setMsg("没有找到对应的记录!");
        }
        jsonObject.setObj(bean);
        return jsonObject;
    }

    /**
     * 新增/修改用户信息方法
     *
     * @param bean
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    @ResponseBody
    @SystemLog(module = "菜单管理",methods = "新增与编辑",type = 1,serviceClass = "tSFunctionService")
    public AjaxJson save(TSFunction bean, HttpServletRequest request, HttpServletResponse response) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        TSFunction tsFunction = null;
        
        int id = tSFunctionService.queryMaxId() + 1;    //ID自增长
        String sorting;
        short level;
        TSFunction model = null;
        if (!StringUtil.isEmpty(bean.getParentId())) {//选择了父级菜单，查找父级菜单ID并设置菜单级别
            model = tSFunctionService.queryById(bean.getParentId());
            level = (short) (model.getFunctionLevel() + 1);
            
        } else {//创建一级菜单
            level = (short) 1;
            bean.setParentId(null);
            
        }
        bean.setFunctionLevel(level);
        //1.根据parentId查询最大的排序码
        sorting = tSFunctionService.queryMaxSortingByPid(bean.getParentId(), bean.getFunctionType());
        int sorting2 = 0;
        switch (level) {
            case 1://一级菜单时:若查询最大的排序码不为空则+1000；为空则设置为：1000
                sorting2 = sorting != null ? Integer.parseInt(sorting) + 1000 : 1000;
                break;
            case 2://二级菜单时:若查询最大的排序码不为空则+100；为空则设置为：父类排序码+100
                sorting2 = sorting != null ? Integer.parseInt(sorting) + 100 : model.getSorting() + 100;
                break;
            case 3://三级菜单时:若查询最大的排序码不为空则+1；为空则设置为：父类排序码+1
                sorting2 = sorting != null ? Integer.parseInt(sorting) + 1 : model.getSorting() + 1;
                break;
            default:
                sorting2 = sorting != null ? Integer.parseInt(sorting) + 1 : model.getSorting() + 1;
                break;
        }
        try {
            // 新增数据
            if (StringUtils.isBlank(bean.getId())) {
                tsFunction = tSFunctionService.queryByFunctionName(bean);
                if (tsFunction == null) {
                    bean.setId(Integer.toString(id));
                    bean.setSorting((short) sorting2);
                    PublicUtil.setCommonForTable(bean, true);
                    tSFunctionService.insertSelective(bean);
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该菜单已存在，请重新输入.");
                }

            // 修改数据
            } else {
                if (bean.getRemark() == null) {
                    bean.setRemark("");
                }

                tsFunction = tSFunctionService.queryById(bean.getId());
                //如果该菜单的父id为空且编辑到的菜单的父id也为空 或者该菜单父id==编辑到的菜单的父id（也就是没有改变父菜单） || tsFunction.getParentId().equals(bean.getParentId())
                if ((StringUtil.isEmpty(tsFunction.getParentId()) && StringUtil.isEmpty(bean.getParentId()))) {//未修改父级菜单
                    if (tsFunction == null || bean.getId().equals(tsFunction.getId())) {
                        PublicUtil.setCommonForTable(bean, false);
                        tSFunctionService.updateBySelective(bean);
                    } else {
                        jsonObject.setSuccess(false);
                        jsonObject.setMsg("该菜单已存在，请重新输入.");
                    }
                } else if (tsFunction != null && StringUtil.isNotEmpty(tsFunction.getParentId()) && tsFunction.getParentId().equals(bean.getParentId())) {//未改变
                    PublicUtil.setCommonForTable(bean, false);
                    tSFunctionService.updateBySelective(bean);
                } else {
                    tsFunction = tSFunctionService.queryByFunctionName(bean);
                    if (tsFunction == null) {//修改父级菜单,删除之前的记录
                        bean.setSorting((short) sorting2);
                        if (bean.getFunctionLevel() == 1) bean.setParentId(null);
                        tSFunctionService.updateBySelective(bean);
                    } else {
                        jsonObject.setSuccess(false);
                        jsonObject.setMsg("该菜单已存在，请重新输入.");
                    }
                }
            }

        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",bean.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }

//    /**
//     * 通过主菜单获取子菜单
//     * @param url
//     * @param classifyId
//     * @return
//     * @throws Exception
//     */
//	@RequestMapping("/roleFunctionList")
//	@ResponseBody
//	public AjaxJson getSubordination(HttpServletResponse response,RoleFunctionModel roleFuntion) throws Exception{
//		AjaxJson jsonObj = new AjaxJson();
//		
//		List<RoleFunctionModel> roleFunctionList = tSFunctionService.getSubordination(roleFuntion);
//		
//		jsonObj.setObj(roleFunctionList);
//		
//		return jsonObj;
//	}

    /**
     * 新增菜单时加载父级菜单
     *
     * @param request
     * @param response
     * @param id
     * @return
     */
    @RequestMapping("/menuTree")
    @ResponseBody
    public List<TreeNode> menuTree(HttpServletRequest request, HttpServletResponse response, String currentId, String id, Short functionType) {
        List<TreeNode> departTree = null;
        try {
            departTree = tSFunctionService.queryMenuTree(currentId, id, functionType);
        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return departTree;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param request
     * @param response
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @SystemLog(module = "菜单管理",methods = "删除",type = 3,serviceClass = "tSFunctionService")
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            for (String id : ida) {
                List<TSFunction> functions = tSFunctionService.querySubFunction(id, 0);
                for (TSFunction function : functions) {
                    tSRoleFunctionService.deleteByFunctionIdOrOperation(function.getId(), null);
                    tSOperationService.deleteByFunctionId(function.getId());
                    tSFunctionService.delete(function.getId());
                }
            }

        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 菜单的启用功能
     */
    @RequestMapping("/enable_start")
    @ResponseBody
    public AjaxJson enableStart(Integer id) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            TSFunction function1 = tSFunctionService.queryById(id.toString());
            if (function1 != null) {
                tSFunctionService.enableStart(Integer.parseInt(function1.getId()));
                tSOperationService.enableByFunctionId(Integer.parseInt(function1.getId()));

                //有上级菜单
                if (!StringUtils.isBlank(function1.getParentId())) {
                    TSFunction function2 = tSFunctionService.queryById(function1.getParentId());
                    if (function2 != null) {
                        tSFunctionService.enableStart(Integer.parseInt(function2.getId()));
                        tSOperationService.enableByFunctionId(Integer.parseInt(function2.getId()));

                        if (!StringUtils.isBlank(function2.getParentId())) {
                            TSFunction function3 = tSFunctionService.queryById(function2.getParentId());
                            if (function3 != null) {
                                tSFunctionService.enableStart(Integer.parseInt(function3.getId()));
                                tSOperationService.enableByFunctionId(Integer.parseInt(function3.getId()));
                            }
                        }
                    }
                }

                //有下级菜单
                List<TSFunction> subFunction2 = tSFunctionService.querySubFunction(id.toString(), 1);
                if (subFunction2 != null) {
                    for (TSFunction subFunction20 : subFunction2) {
                        tSFunctionService.enableStart(Integer.parseInt(subFunction20.getId()));
                        tSOperationService.enableByFunctionId(Integer.parseInt(subFunction20.getId()));
                    }
                }
            }
            ajaxJson.setMsg("启用成功");
        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("启用失败");
        }
        return ajaxJson;
    }
}
