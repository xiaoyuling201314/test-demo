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
import com.dayuan3.terminal.bean.SpecialOffer;
import com.dayuan3.terminal.model.SpecialOfferLogModel;
import com.dayuan3.terminal.service.SpecialOfferLogService;
import com.dayuan3.terminal.service.SpecialOfferService;
/**
 * 优惠活动操作日志
 *
 * @author cola_hu
 *2019年9月9日
 */
@Controller
@RequestMapping("specialOfferLog")
public class SpecialOfferLogController {
	private Logger log = Logger.getLogger(SpecialOfferLogController.class);
	
	@Autowired
	private  SpecialOfferLogService logService;
	@Autowired
	private SpecialOfferService specialOfferService;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response,Integer offerId) {
		Map<String, Object> mapData = new HashMap<>();
		try {
		SpecialOffer bean=	specialOfferService.queryById(offerId);
			mapData.put("offerId", offerId);	
			mapData.put("theme", bean.getTheme());	
		} catch (Exception e) {
			log.info("***************************"+e.getMessage()); 
		}
		return new ModelAndView("/terminal/specialOffer/logList",mapData);
	}
	
	
	
	/**
	 * 数据列表
	 * @param model
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(SpecialOfferLogModel model,Page page,String search){
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
