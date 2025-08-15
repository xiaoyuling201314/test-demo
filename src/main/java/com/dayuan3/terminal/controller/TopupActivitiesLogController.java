package com.dayuan3.terminal.controller;

import java.util.HashMap;
import java.util.Map;

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
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.model.TopupActivitiesLogModel;
import com.dayuan3.terminal.service.TopupActivitiesLogService;
import com.dayuan3.terminal.service.TopupActivitiesService;

@Controller
@RequestMapping("activitiesLog")
public class TopupActivitiesLogController {
private Logger log = Logger.getLogger(TopupActivitiesLogController.class);
	
	@Autowired
	private  TopupActivitiesLogService logService;
	@Autowired
	private TopupActivitiesService activitiesService;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response,Integer actId) {
		Map<String, Object> mapData = new HashMap<>();
		try {
			TopupActivities bean=				activitiesService.queryById(actId);
			mapData.put("actId", actId);	
			mapData.put("theme", bean.getTheme());	//活动主题
		} catch (Exception e) {
			log.info("***************************"+e.getMessage()); 
		}
		return new ModelAndView("/terminal/activities/logList",mapData);
	}
	
	
	
	/**
	 * 数据列表
	 * @param model
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(TopupActivitiesLogModel model,Page page,String search){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("desc");
			page = logService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
}
