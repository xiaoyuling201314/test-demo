package com.dayuan.controller.task;

import java.util.HashMap;
import java.util.List;
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
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.task.TbTask;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.task.RecTaskModel;
import com.dayuan.model.task.TaskDetailModel;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.StringUtil;

/**
 * 任务管理
 * @author Dz
 *
 */
@Controller
@RequestMapping("/taskDetail")
public class TaskDetailController extends BaseController {
	private final Logger log = Logger.getLogger(TaskDetailController.class);
	
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskDetailService taskDetailService;
	
	/**
	 * 数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(HttpServletRequest request, HttpServletResponse response, TaskDetailModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			//获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			if(null != tsUser){
				TbTaskDetail detail = model.getDetail();
				if(detail == null){
					detail = new TbTaskDetail();
				}
				if(StringUtil.isNotEmpty(tsUser.getPointId())){
					detail.setReceiveNodeid(tsUser.getPointId());
				}else if(StringUtil.isNotEmpty(tsUser.getDepartId())){
					detail.setReceivePointid(tsUser.getDepartId());
				}
				model.setDetail(detail);
			}
			page.setOrder("desc");
			page = taskDetailService.loadDatagrid(page, model);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		jsonObj.setObj(page);
		return jsonObj;
	}
	
	
	/**
	 * 打开任务转发界面
	 * @param id	任务明细ID
	 * @return
	 */
	@RequestMapping("/goTaskForward")
	public ModelAndView taskForwarding(HttpServletRequest request,HttpServletResponse response,String id){
		Map<String,Object> map =  new HashMap<String, Object>();
		RecTaskModel recTask = null; //接收任务
		TbTask task = null;	//转发主任务
		List<TbTaskDetail> details = null;	//转发任务明细
		String fileName = ""; //附件名称

		try {
			if(StringUtil.isNotEmpty(id)){
				//修改任务接收状态
				TbTaskDetail taskDetail = taskDetailService.queryById(id);
				if(null != taskDetail){
					taskDetail.setReceiveStatus((short) 1);
					PublicUtil.setCommonForTable(taskDetail, false);
					taskDetailService.updateBySelective(taskDetail);
				}
				
				recTask = taskDetailService.getRecTask(id);
				task = taskService.getSecTask(id);
				if(null != task){
					details = taskDetailService.getDetailsByPid(task.getId().toString());
				}
				if (null != recTask.getFilePath()) {
					String[] fileStr = recTask.getFilePath().split("/");
					fileName = fileStr[fileStr.length - 1];
				}
			}

		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		
		map.put("recTask", recTask);
		map.put("task", task);
		map.put("details", details);
		map.put("fileName", fileName);
		return new ModelAndView("/task/taskForward",map);
	}
	
	/**
	 * 打开查看任务详情
	 * @param id 任务明细ID
	 * @return
	 */
	@RequestMapping("/viewReceiveTask")
	public ModelAndView viewReceiveTask(HttpServletRequest request,HttpServletResponse response,String id){
		Map<String,Object> map =  new HashMap<String, Object>();
		RecTaskModel recTask = null; //接收任务
		String fileName = "";
		try {
			if(StringUtil.isNotEmpty(id)){
				recTask = taskDetailService.getRecTask(id);
				//detail = taskDetailService.queryById(id);
				if(recTask!=null){
					//更新任务接收状态
					if(recTask.getReceiveStatus() != 1) {
						TbTaskDetail td = new TbTaskDetail();
						td.setId(Integer.parseInt(recTask.getId()));
						td.setReceiveStatus((short) 1);
						PublicUtil.setCommonForTable(td, false);
						taskDetailService.updateBySelective(td);
					}
					if (null != recTask.getFilePath()) {
						String[] fileStr = recTask.getFilePath().split("/");
						fileName = fileStr[fileStr.length - 1];
					}
				}
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		
		map.put("recTask", recTask);
		map.put("fileName", fileName);
		return new ModelAndView("/task/viewReceiveTask",map);
	}
	
}
