package com.dayuan.controller.regulatory;

import java.util.List;

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
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.regulatory.BaseRegulatoryTypeModel;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;

/**
 * 监管对象人员
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/regulatory/regulatoryType")
public class BaseRegulatoryTypeController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseRegulatoryTypeController.class);
	
	@Autowired
	private BaseRegulatoryTypeService baseRegulatoryTypeService;
	
	/**
	 * 进入监管对象类型管理界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		
		return new ModelAndView("/regulatory/regulatoryType/list");
	}
	
	
	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryTypeModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseRegulatoryTypeService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 保存监管对象类型
	 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryType type){
		AjaxJson aj = new AjaxJson();
		try {
			//唯一类型编码
			BaseRegulatoryType oldType = null;
			if(StringUtil.isNotEmpty(type.getRegTypeCode())){
				oldType = baseRegulatoryTypeService.queryByRegTypeCode(type.getRegTypeCode());
			}
			
			if(oldType == null || oldType.getId().equals(type.getId())){
				if(StringUtil.isNotEmpty(type.getId())){
					//更新
					PublicUtil.setCommonForTable(type, false);
					baseRegulatoryTypeService.updateBySelective(type);
				}else{
					//新增
					type.setId(UUIDGenerator.generate());
					type.setDeleteFlag((short)0);
					PublicUtil.setCommonForTable(type, true);
					baseRegulatoryTypeService.insert(type);
				}
				aj.setObj(type);
			}else{
				aj.setSuccess(false);
				aj.setMsg("类型编码重复");
			}
			
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
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
			BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryById(id);
			jsonObject.setObj(regulatoryType);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
		}
		return jsonObject;
	}
	
	/**
	 * 查询所有已审核的监管对象类型
	 * @param response
	 * @return
	 * @author wtt
	 * @date 2018年8月1日
	 */
	@RequestMapping("/queryAll")
	@ResponseBody
	public AjaxJson queryAll(HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			List<BaseRegulatoryType> regulatoryType = baseRegulatoryTypeService.queryAll();
			jsonObject.setObj(regulatoryType);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
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
			for (String id : ida) {
				BaseRegulatoryType type = baseRegulatoryTypeService.queryById(id);
				if(type != null){
					type.setDeleteFlag((short) 1);
					PublicUtil.setCommonForTable(type, false);
					baseRegulatoryTypeService.updateBySelective(type);
				}
			}
			
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
