package com.dayuan.controller.system;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dayuan.logs.aop.SystemLog;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.system.TSOperationModel;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSRoleFunctionService;
import com.dayuan.util.UUIDGenerator;
/**
 * 
 * Description:操作按钮权限
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月29日
 */
@Controller
@RequestMapping("/system/operation")
public class TSOperationController extends BaseController {
	private final Logger log=Logger.getLogger(TSOperationController.class);
	@Autowired
	private TSOperationService tsOperationService;
	
	@Autowired
	private TSFunctionService tSFunctionService;
	
	@Autowired
	private TSRoleFunctionService tSRoleFunctionService;
	
	/**
	 * 用户权限列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,String id){
		Map<String, Object> map=new HashMap<>();
		try {
			TSFunction bean = tSFunctionService.queryById(id);
			map.put("bean", bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/system/operation/list",map);
	}
	
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(TSOperationModel model,Page page,HttpServletResponse response) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("asc");
			page = tsOperationService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
	/**
	 * 新增/修改用户权限方法
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	@SystemLog(module = "操作权限管理",methods = "新增与编辑",type = 1,serviceClass = "tSOperationService")
	public  AjaxJson save(TSOperation bean,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSOperation baseBean=tsOperationService.queryByOperationName(bean);
			bean.setSorting(bean.getSorting()==null ? 0 : bean.getSorting());
			if(StringUtils.isBlank(bean.getId())){//新增数据
				if (baseBean== null) {
					bean.setId(UUIDGenerator.generate());
					String operationCode=tsOperationService.queryLastCode(bean.getFunctionId());
					operationCode=UUIDGenerator.getNextCode(1, operationCode, bean.getFunctionId()+"-");
					bean.setOperationCode(operationCode);
					PublicUtil.setCommonForTable(bean, true);
					tsOperationService.insert(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该功能权限已存在，请重新输入.");
				}
			}else{//修改数据
				PublicUtil.setCommonForTable(bean, false);
				if (baseBean == null || bean.getId().equals(baseBean.getId())) {
					if (null == bean.getRemark()) {
						bean.setRemark("");
					}
					tsOperationService.updateBySelective(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该功能权限已存在，请重新输入.");
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
		TSOperation bean;
		try {
			bean = tsOperationService.queryById(id);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			} 
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
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
	@SystemLog(module = "操作权限管理",methods = "删除",type = 3,serviceClass = "tSOperationService")
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			tsOperationService.delete(ida);
			tSRoleFunctionService.deleteByFunctionIdOrOperation(null,ida);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
}
