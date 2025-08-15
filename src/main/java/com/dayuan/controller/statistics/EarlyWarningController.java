package com.dayuan.controller.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.controller.BaseController;
import com.dayuan3.common.util.SystemConfigUtil;


/**
 * 预警管理
 * @author xiaoyl
 * @date   2020年8月31日
 */
@Controller
@RequestMapping("/waring/manage")
public class EarlyWarningController extends BaseController {
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		String standardTime=SystemConfigUtil.RECHECK_CONFIG.getString("standard_time");
		String recheckTimeout=SystemConfigUtil.RECHECK_CONFIG.getString("recheck_timeout");
		request.setAttribute("standardTime", standardTime);
		request.setAttribute("recheckTimeout", recheckTimeout);
		return new ModelAndView("/waring/manage/list");
	}
	@RequestMapping("/unqualified_list")
	public ModelAndView unqualified_list(HttpServletRequest request,HttpServletResponse response,Integer monitorType,String description){
		request.setAttribute("monitorType", monitorType);
		request.setAttribute("description", description);
		return new ModelAndView("/waring/manage/unqualified_list");
	}
	//进入待复检页面
	@RequestMapping("/handle_list")
	public ModelAndView handl_list(HttpServletRequest request,HttpServletResponse response,Integer monitorType,String description){
		request.setAttribute("monitorType", monitorType);
		request.setAttribute("description", description);
		return new ModelAndView("/waring/manage/handle_list");
	}
}
