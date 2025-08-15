package com.dayuan.controller.dataCheck;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.dataCheck.CheckConfigModel;
import com.dayuan.service.DataCheck.DataUnqualifiedConfigService;
import com.dayuan.util.StringUtil;
/**
 * 不合格处理方法
 * @author Bill
 *
 */
@Controller
@RequestMapping("/dataCheck/unqualified/config")
public class DataUnqualifiedConfigController extends BaseController {
	private final Logger log = Logger.getLogger(DataUnqualifiedConfigController.class);
	
	@Autowired
	private DataUnqualifiedConfigService dataUnqualifiedConfigService;
	
	/**
	 * 进入处理规则列表
	 */
	@RequestMapping("/list")
	public ModelAndView  configList(HttpServletRequest request,HttpServletResponse response){
		
		return new ModelAndView("/dataCheck/unqualified/config/list");
	}
	
	/**
	 * 数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(CheckConfigModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = dataUnqualifiedConfigService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(Integer id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			DataUnqualifiedConfig bean = dataUnqualifiedConfigService.queryById(id);
			if(bean  == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}
	
	/**
	 * 添加/修改
	 * @param bean
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(HttpServletRequest request, DataUnqualifiedConfig config) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(config.getId())){
				PublicUtil.setCommonForTable(config, false);
				dataUnqualifiedConfigService.updateBySelective(config);
			}else{
//				config.setId(UUIDGenerator.generate());
				PublicUtil.setCommonForTable(config, true);
				dataUnqualifiedConfigService.insert(config);
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("保存失败");
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
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			Integer[] idas = new Integer[ida.length];
			for (int i = 0; i < ida.length; i++) {
				idas[i] = Integer.parseInt(ida[i]);
			}
			dataUnqualifiedConfigService.delete(idas);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
}
