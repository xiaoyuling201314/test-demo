package com.dayuan.controller.task;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.task.TaskStatistics;
import com.dayuan.bean.task.TbTask;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.task.RecTaskModel;
import com.dayuan.model.task.TaskModel;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;

/**
 * 任务管理
 * 
 * @author Dz
 *
 */
@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {
	private final Logger log = Logger.getLogger(TaskController.class);

	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskDetailService taskDetailService;
	@Autowired
	private TSDepartService departService;

	/**
	 * 进入快检点界面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		
		return new ModelAndView("/task/list");
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, TaskModel model, Page page) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			// 获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			if (null != tsUser && null != model) {
				if (null != model.getTask()) {
					//查看同一机构下不同用户下发任务
					model.getTask().setTaskDepartid(tsUser.getDepartId());
					//查看当前用户下发任务
					//model.getTask().setTaskAnnouncer(tsUser.getId());
					
				} else {
					TbTask task = new TbTask();
					//查看同一机构下不同用户下发任务
					task.setTaskDepartid(tsUser.getDepartId());
					//查看当前用户下发任务
					//model.getTask().setTaskAnnouncer(tsUser.getId());
					model.setTask(task);
				}
			}

			page.setOrder("DESC");
			page = taskService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * 
	 * @param request
	 * @param response
	 * @param ids
	 *            要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			for (String id : ida) {
				TbTask task = taskService.queryById(id);
				if (task == null) {
					jsonObj.setSuccess(false);
					jsonObj.setMsg("删除失败");
					return jsonObj;
				} else if (task.getTaskStatus() != 0) {
					jsonObj.setSuccess(false);
					jsonObj.setMsg("已下发任务不可删除");
					return jsonObj;
				}
			}
			taskService.delete(ida);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("删除失败");
		}
		return jsonObj;
	}

	/**
	 * 打开接收任务列表
	 */
	@RequestMapping("/receiveList")
	public ModelAndView receiveTaskList(HttpServletRequest request, HttpServletResponse response) {
		
		return new ModelAndView("/task/receiveList");
	}

	/**
	 * 打开下发任务界面
	 * 
	 * @return
	 * @throws MissSessionExceprtion 
	 */
	@RequestMapping("/goAddTask")
	public ModelAndView goAddTask(HttpServletRequest request, HttpServletResponse response, String id) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtil.isNotEmpty(id)) {// 获取下发任务信息、任务明细
				TbTask task = taskService.queryJoinById(id);	// 主任务
				List<TbTaskDetail> details = taskDetailService.getDetailsByPid(id);	// 任务明细
				String detailsStr = "";
				if (null != details) {
					detailsStr = JSON.toJSONString(details);
				}

                String fileName = ""; //附件名称
                if (null != task.getFilePath()) {
                    String[] fileStr = task.getFilePath().split("/");
                    fileName = fileStr[fileStr.length-1];
                }

				map.put("task", task);
				map.put("details", details);
				map.put("detailsStr", detailsStr);
				map.put("fileName", fileName);
			}
		} catch (Exception e) {
		    e.printStackTrace();
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		TSDepart tsd = PublicUtil.getSessionUserDepart();
		DepartTreeModel departTree = null;
		if (null != tsd) {
			departTree = departService.getDepartPoint(tsd.getId());
		}
		map.put("departTree", departTree);

		//任务类型、来源
		JSONObject config = SystemConfigUtil.CHECK_TASK_CONFIG;
		if (config != null) {
			map.put("taskType", config.getJSONArray("type"));
			map.put("taskSource", config.getJSONArray("source"));
		} else {
			map.put("taskType", new ArrayList<String>());
			map.put("taskSource", new ArrayList<String>());
		}

		return new ModelAndView("/task/addTask", map);
	}

	/**
	 * 保存任务
	 */
	@RequestMapping("/addTask")
	@ResponseBody
	public AjaxJson addTask(HttpServletRequest request, HttpServletResponse response, TaskModel taskModel,
			@RequestParam(value = "filePathImage", required = false) MultipartFile file) {
		AjaxJson aj = new AjaxJson();
		try {
			if (null != taskModel && null != taskModel.getTask()) {
                TSUser tsUser = PublicUtil.getSessionUser();
                TSDepart org = PublicUtil.getSessionUserDepart();

				TbTask task = taskModel.getTask();
				List<TbTaskDetail> tDetails = taskModel.getTaskDetails();

				if (StringUtil.isNotEmpty(task.getTaskDetailPid())) {
					// 转发任务
					RecTaskModel recTask = taskDetailService.getRecTask(task.getTaskDetailPid()); // 接收任务

					// 首次保存设置任务属性
					// if(StringUtil.isEmpty(task.getId().toString())){
					task.setFilePath(recTask.getFilePath());
					task.setTaskTitle(recTask.getTaskTitle());
					task.setTaskType(recTask.getTaskType());
					task.setTaskSource(recTask.getTaskSource());
					task.setTaskTotal(recTask.getDetailTotal());
					task.setTaskSdate(recTask.getTaskSdate());
					task.setTaskEdate(recTask.getTaskEdate());
					task.setTaskPdate(recTask.getTaskPdate());
					task.setRemark(recTask.getTaskRemark());
					// }
					task.setDeleteFlag((short) 0);
				}

				// 保存
				if (StringUtil.isNotEmpty(task.getId())) {
					// 保存附件
					if (null != file && file.getSize() > 0) {
						String fileName = uploadFile(request, "taskFile/", file, null);
						task.setFilePath("/resources/taskFile/" + fileName);
					}

                    task.setTaskDepartid(org.getId());// 发布机构ID
                    task.setTaskAnnouncer(tsUser.getId());// 发布人ID
					task.setTaskCdate(new Date());// 编制日期
					task.setSampleNumber(0);
					task.setDeleteFlag((short) 0);
					task.setViewFlag((short) 0);

					// 更新任务
					PublicUtil.setCommonForTable(task, false);
					taskService.updateById(task);
					// 处理任务明细
					List<TbTaskDetail> oldTtds = taskDetailService.getDetailsByPid(task.getId().toString()); // 旧任务明细
					if (null == tDetails || tDetails.size() == 0) {
						StringBuffer delectIds = new StringBuffer(); // 删除任务明细ID

						// 删除所有任务明细
						for (TbTaskDetail oldTtd : oldTtds) {
							delectIds.append(oldTtd.getId() + ",");
						}
						if (delectIds.length() > 0) {
							delectIds.deleteCharAt(delectIds.length() - 1);
							taskDetailService.delete(delectIds.toString().split(","));
						}
					} else {
						StringBuffer delectIds = new StringBuffer(); // 删除任务明细ID
						// 删除部分任务明细
						for (int i = 0; i < oldTtds.size(); i++) {
							for (int ii = 0; ii < tDetails.size(); ii++) {
								if (oldTtds.get(i).getId().equals(tDetails.get(ii).getId())) {
									break;
								}
								if (ii == tDetails.size() - 1) {
									delectIds.append(oldTtds.get(i).getId() + ",");
								}
							}
						}
						if (delectIds.length() > 0) {
							delectIds.deleteCharAt(delectIds.length() - 1);
							String[] idsarry = delectIds.toString().split(",");
							taskDetailService.delete(idsarry);
						}
						// 新增、更新任务明细
						for (TbTaskDetail tdm : tDetails) {
                            tdm.setTaskId(task.getId());
                            tdm.setDeleteFlag((short) 0);
                            tdm.setReceiveStatus((short) 0);
                            tdm.setSampleNumber(0);
							if (null == tdm.getId()) {
								// 新增任务明细
								taskDetailService.insertSelective(tdm);
							} else {
								// 更新任务明细
								taskDetailService.updateById(tdm);
							}
						}
					}
				} else {
					// 新增任务
					if (task.getTaskStatus() == 1) {
						task.setTaskAnnouncer(tsUser.getId());// 发布人ID
						task.setTaskCdate(new Date());// 编制日期
					}
					task.setTaskDepartid(org.getId());// 发布机构ID
					task.setSampleNumber(0);
					task.setDeleteFlag((short) 0);
					task.setViewFlag((short) 0);

					// 保存附件
					if (null != file && file.getSize() > 0) {
						String fileName = uploadFile(request, "taskFile/", file, null);
						task.setFilePath("/resources/taskFile/" + fileName);
					}

					PublicUtil.setCommonForTable(task, true);
					taskService.insertSelective(task);
					Integer taskId = task.getId();
					// 新增任务明细
					if (null != tDetails) {
						for (TbTaskDetail detail : tDetails) {
							detail.setTaskId(taskId);
							detail.setDeleteFlag((short) 0);
							detail.setReceiveStatus((short) 0);
							detail.setSampleNumber(0);
							taskDetailService.insertSelective(detail);
						}
					}
				}
				aj.setObj(task);
			} else {
				aj.setSuccess(false);
				aj.setMsg("保存失败");
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			e.printStackTrace();
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
	}

	/**
	 * 下发任务
	 */
	@RequestMapping("/releaseTask")
	@ResponseBody
	public AjaxJson releaseTask(HttpServletRequest request, HttpServletResponse response, String id) {
		AjaxJson aj = new AjaxJson();
		try {
			TbTask task = taskService.queryById(id);
			if (null == task) {
				aj.setSuccess(false);
				aj.setMsg("下发任务失败");
			} else {
				if (0 == task.getTaskStatus()) {
					TSUser user = PublicUtil.getSessionUser();
					// 下发暂存任务
					task.setTaskStatus((short) 1);
					task.setTaskAnnouncer(user.getId());
					task.setTaskCdate(new Date());
					PublicUtil.setCommonForTable(task, false);
					taskService.updateBySelective(task);
				} else {
					// 任务已下发
					aj.setSuccess(false);
					aj.setMsg("任务已下发");
				}
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
			aj.setMsg("下发任务失败");
		}
		return aj;
	}

	/**
	 * 终止任务
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/stopTask")
	@ResponseBody
	public AjaxJson stopTask(HttpServletRequest request, HttpServletResponse response, String id) {
		AjaxJson aj = new AjaxJson();
		try {
			if (StringUtil.isNotEmpty(id)) {
				// 终止任务
				taskService.stopTask(id);
			} else {
				aj.setSuccess(false);
				aj.setMsg("终止任务失败");
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
			aj.setMsg("终止任务失败");
		}
		return aj;
	}

	/**
	 * 任务消息
	 */
	@RequestMapping("/queryNewTasks")
	@ResponseBody
	public AjaxJson queryNewTasks(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson aj = new AjaxJson();
		try {
			// 获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			List<TbTaskDetail> tasks = null;
			if (null != tsUser) {
				if (StringUtil.isNotEmpty(tsUser.getPointId())) {
					tasks = taskDetailService.queryTasksByRStatus(0, null, tsUser.getPointId());
				} else if (StringUtil.isNotEmpty(tsUser.getDepartId())) {
					tasks = taskDetailService.queryTasksByRStatus(0, tsUser.getDepartId(), null);
				}
			}
			aj.setObj(JSONArray.toJSONString(tasks));
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
		}
		return aj;
	}

	/**
	 * 进入下发任务统计页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author xyl
	 */
	@RequestMapping("/missionStatistics")
	public ModelAndView missionStatistics(HttpServletRequest request, HttpServletResponse response) {
		
		return new ModelAndView("/task/missionStatistics");
	}

	/**
	 * 进入接收任务统计页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author xyl
	 */
	@RequestMapping("/receivedStatistics")
	public ModelAndView receivedStatistics(HttpServletRequest request, HttpServletResponse response) {
		
		return new ModelAndView("/task/receivedStatistics");
	}

	/**
	 * 进入任务统计页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author xyl
	 */
	@RequestMapping("/statisticsDetail")
	public ModelAndView statisticsDetail(HttpServletRequest request, HttpServletResponse response, String taskDate) {
		
		request.setAttribute("taskDate", taskDate);
		return new ModelAndView("/task/statisticsDetail");
	}

	/**
	 * 任务统计数据列表
	 * 
	 * @param request
	 * @param response
	 * @param page
	 * @author xyl
	 * @return
	 */
	@RequestMapping(value = "/statisticsDatagrid")
	@ResponseBody
	public AjaxJson statisticsDatagrid(HttpServletRequest request, HttpServletResponse response, Page page, String type,
			String year, String startTime, String endTime, int missionOrRecevied) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			// 获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			Map<String, Object> map = new HashMap<>();
			if (null != tsUser) {
				if (StringUtil.isNotEmpty(tsUser.getPointId())) {// 检测点用户查询
					map.put("pointId", tsUser.getPointId());
				} else if (StringUtil.isNotEmpty(tsUser.getDepartId())) {// 机构用户查询
					map.put("departId", tsUser.getDepartId());
				}
			}
			List<String> dateList = new ArrayList<>();
//			String years = "";
			int month = 0;
			if (type.equals("diy")) {// 自定义选择年月
				year = null;
				int startYear = Integer.parseInt(startTime.substring(0, startTime.indexOf('-')));// 开始时间年份
				int endYear = Integer.parseInt(endTime.substring(0, endTime.indexOf('-')));// 结束时间年份
				int startMonth = Integer.parseInt(startTime.substring(startTime.indexOf('-') + 1));// 开始时间月份
				int endMonth = Integer.parseInt(endTime.substring(endTime.indexOf('-') + 1));// 结束时间月份
				if (startYear == endYear) {// 选择年份在同一年
					for (int i = endMonth; i >= startMonth; i--) {
						String date = startYear + "-" + String.format("%0" + 2 + "d", i);
						dateList.add(date);
					}
				} else {// 跨年份时间段
					for (int i = endMonth; i > 0; i--) {// 结束时间年份，从1月到结束时间月份
						String date = endYear + "-" + String.format("%0" + 2 + "d", i);
						dateList.add(date);
					}
					for (int i = 12; i >= startMonth; i--) {// 开始时间年份，开始月份到12月
						String date = startYear + "-" + String.format("%0" + 2 + "d", i);
						dateList.add(date);
					}
				}
				startTime = startTime + "-01 00:00:00";
				int lastDay = DateUtil.lastDayOfMonth(Integer.parseInt(endTime.substring(endTime.indexOf('-'))));
				endTime = endTime + "-" + lastDay + " 23:59:59";

			} else {
				startTime = null;
				endTime = null;
				Calendar cal = Calendar.getInstance();
				month = cal.get(Calendar.MONTH) + 1;
				int paramYear = Integer.parseInt(year);
				int nowYear = cal.get(Calendar.YEAR);
				if (paramYear < nowYear || paramYear > nowYear) {// 选择年份不是当前年份，默认显示12个月的数据
					month = 12;
				}
				for (int i = month; i > 0; i--) {
					String date = year + "-" + String.format("%0" + 2 + "d", i);// 月份不足两位数前面补0
					dateList.add(date);
				}
			}
			map.put("userId", tsUser.getId());
			map.put("startTime", startTime);
			map.put("endTime", endTime);
			map.put("month", month<10?"0"+month:month);
			map.put("year", year);
			List<TaskStatistics> missionList = null;
			if (missionOrRecevied == 0) {
				missionList = taskService.queryMission(map);// 下发任务统计列表
			} else {
				missionList = taskService.queryReceived(map);// 接收任务统计列表
			}
			List<TaskStatistics> dataList = new ArrayList<>();
			for (String date : dateList) {
				TaskStatistics taskStatistic = new TaskStatistics();
				taskStatistic.setTaskDate(date);
				if ((missionList != null && missionList.size() > 0)) {
					for (TaskStatistics taskStatistics : missionList) {
						if (date.equals(taskStatistics.getTaskDate())) {
							taskStatistic.setMissionNum(taskStatistics.getMissionNum());
							taskStatistic.setMissionFinish(taskStatistics.getMissionFinish());
							taskStatistic.setMissionUnqualified(taskStatistics.getMissionUnqualified());
							taskStatistic.setmCompletionRate(taskStatistics.getmCompletionRate());

							taskStatistic.setReceivedNum(taskStatistics.getReceivedNum());
							taskStatistic.setReceivedFinish(taskStatistics.getReceivedFinish());
							taskStatistic.setReceivedUnqualified(taskStatistics.getReceivedUnqualified());
							taskStatistic.setrCompletionRate(taskStatistics.getrCompletionRate());
						}
					}
				}
				dataList.add(taskStatistic);
			}
			Page pages = new Page();
			pages.setResults(dataList);
			jsonObj.setObj(pages);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

}
