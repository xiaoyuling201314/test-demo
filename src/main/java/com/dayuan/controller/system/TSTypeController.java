package com.dayuan.controller.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.TSType;
import com.dayuan.controller.BaseController;
import com.dayuan.service.system.TSTypeService;
/**
 * 字典表
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年1月9日
 */
@Controller
@RequestMapping("/system/tstype")
public class TSTypeController extends BaseController {
	
	Logger log = Logger.getLogger(TSTypeController.class);
	
	@Autowired
	private TSTypeService tsTypeService;
	
	/**
	 * 通过类型编号查询字典
	 */
	@RequestMapping("/queryByTypeCode")
	@ResponseBody
	public AjaxJson queryByTypeCode(HttpServletRequest request,HttpServletResponse response,String typeCode){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSType tsType  = tsTypeService.queryByTypeCode(typeCode);
			jsonObj.setObj(tsType);
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("查询失败");
		}
		return jsonObj;
	}
	
	
}
