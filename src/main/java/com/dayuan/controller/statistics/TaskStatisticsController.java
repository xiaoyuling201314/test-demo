package com.dayuan.controller.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.controller.BaseController;


/**
 * 任务统计:东莞项目新增功能，根据检测点统计计划任务，点击查看详细的配置情况和完成情况
 * @author xiaoyl
 * @date   2020年8月28日
 */
@Controller
@RequestMapping("/task/statistics")
public class TaskStatisticsController extends BaseController {
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/task/statistics/list");
	}
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/task/statistics/detail");
	}
}
