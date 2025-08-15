package com.dayuan.service.task;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dayuan.model.task.TaskProgressModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.task.TaskStatistics;
import com.dayuan.bean.task.TbTask;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.common.PublicUtil;
import com.dayuan.mapper.task.TbTaskMapper;
import com.dayuan.model.task.RecTaskModel;
import com.dayuan.model.task.TaskModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.StringUtil;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TaskService extends BaseService<TbTask, String> {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TaskDetailService taskDetailService;
	@Autowired
	private TbTaskMapper mapper;
	
	public TbTaskMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 接收任务列表分页
	 * @param page	分页参数
	 * @return	任务列表
	 */
	public Page loadDatagrid(Page page, RecTaskModel recTask){
		//初始化分页参数
		if(null==page){
			page = new Page();
		}
		
		//设置查询条件
		page.setObj(recTask);
		
		//每次查询记录总数量,防止新增或删除记录后总数量错误
		page.setRowTotal(taskDetailService.getRecTaskTotal(page));
		
		//每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
		page.setPageCount((int) Math.ceil(page.getRowTotal()/(page.getPageSize()*1.0)));
		
		List<RecTaskModel> recTaskList = taskDetailService.getRecTaskByPid(page);
		page.setResults(recTaskList);
		return page;
	}
	
	/**
	 * 下达任务
	 * @throws Exception 
	 */
	public void addTask(TaskModel taskModel) throws Exception{
		if(null != taskModel && null != taskModel.getTask()){
			TbTask task = taskModel.getTask();
			List<TbTaskDetail> tDetails = taskModel.getTaskDetails();
			if(StringUtil.isNotEmpty(task.getId())){
				//更新任务
				mapper.updateByPrimaryKeySelective(task);
				//处理任务明细
				List<TbTaskDetail> oldTtds = taskDetailService.getDetailsByPid(task.getId().toString());	//旧任务明细
				if(null == tDetails || tDetails.size()==0){
					//删除所有任务明细
					for(TbTaskDetail oldTtd : oldTtds){
						taskDetailService.delete(oldTtd.getId().toString());
					}
				}else{
					//删除部分任务明细
					for(int i=0;i<oldTtds.size();i++){
						for(int ii=0;ii<tDetails.size();ii++){
							if(StringUtil.isEmpty(tDetails.get(ii).getId().toString()) || 
								oldTtds.get(i).getId().equals(tDetails.get(ii).getId())){
								break;
							}
							if(ii==tDetails.size()-1){
								taskDetailService.delete(oldTtds.get(i).getId().toString());
								oldTtds.remove(i);
							}
						}
					}
					//新增、更新任务明细
					for(TbTaskDetail tdm : tDetails){
						if(StringUtil.isEmpty(tdm.getId().toString())){
							//新增任务明细
							tdm.setTaskId(task.getId());
							tdm.setDeleteFlag((short) 0);
							tdm.setReceiveStatus((short) 0);
							taskDetailService.insertSelective(tdm);
						}else{
							//更新任务明细
							taskDetailService.updateBySelective(tdm);
						}
					}
				}
			}else{
				//新增任务
				task.setTaskCdate(new Date());//编制日期
				task.setDeleteFlag((short) 0);
				task.setViewFlag((short) 0);
				mapper.insertSelective(task);
				Integer taskId=task.getId();
				//新增任务明细
				if(null != tDetails){
					for(TbTaskDetail detail : tDetails){
						detail.setTaskId(taskId);
						detail.setDeleteFlag((short) 0);
						detail.setReceiveStatus((short) 0);
						taskDetailService.insertSelective(detail);
					}
				}
			}
		}
	}
	

	public TbTask getSecTask(String id) {
		return mapper.getSecTask(id);
	}
	/**
	 * 根据用户机构或ID查询任务列表
	 * @param taskDetail
	 * @return
	 * @author xyl 2017-09-13
	 */
	public List<TbTask> queryByReceiveId(RecTaskModel taskDetail) {
		return mapper.queryByReceiveId(taskDetail);
	}
	
    /**
     * 终止任务
     * @param id 下发任务ID
     */
	public void stopTask(String id) throws Exception {
		List<TbTask> tasks = mapper.queryChildTaskById(id);
		for(TbTask task : tasks){
			task.setTaskStatus((short) -1);
			PublicUtil.setCommonForTable(task, false);
			mapper.updateByPrimaryKeySelective(task);
		}
	}
	/**
	 * 根据任务ID更新抽样数量
	 * @param taskId 任务ID
	 * @param user	修改人
	 * @throws Exception
	 */
	public void updateSampleNumberById(String taskId, TSUser user) throws Exception{
		if(user != null){
			mapper.updateSampleNumberById(taskId,user.getId(),new Date());
		}else{
			mapper.updateSampleNumberById(taskId,null,new Date());
		}
	}
	/**
	 * 查询用户下发任务
	 * @param map
	 * @return
	 * @author xyl
	 */
	public List<TaskStatistics> queryMission(Map<String, Object> map) {
		return mapper.queryMission(map);
	}
	/**
	 * 查询用户的接收任务情况
	 * @param map
	 * @return
	 * @author xyl
	 */
	public List<TaskStatistics> queryReceived(Map<String, Object> map) {
		return mapper.queryReceived(map);
	}
	/**
	 * 根据任务ID查询关联机构和发布人信息
	 * @param id
	 * @return
	 * @author xyl
	 */
	public TbTask queryJoinById(String id) {
		return mapper.queryJoinById(id);
	}
	
	
	/**
	 * 获取我的任务数量（首页统计）
	 * @param tsUser
	 * @return
	 */
	public Map<String,Object> queryTaskNum(TSUser tsUser){
		
		Map<String,Object> map = new HashMap<String,Object>();
		StringBuffer sbuffer = new StringBuffer();
		if(null != tsUser){
			if(StringUtil.isNotEmpty(tsUser.getPointId())){
				
				//任务数量
				sbuffer.setLength(0);
				sbuffer.append("SELECT IFNULL(a.atn,0) aTasksNum, IFNULL(a.ftn,0) fTasksNum, (IFNULL(a.atn,0) - IFNULL(a.ftn,0)) eTasksNum  " + 
						"FROM ( " + 
						"SELECT " + 
						"	SUM(CASE WHEN tt.task_status != -1 THEN 1 ELSE 0 END ) atn, " + 
						"	SUM(CASE WHEN ttd.sample_number >= ttd.task_total and tt.task_status != -1 THEN 1 ELSE 0 END ) ftn " + 
						"FROM " + 
						"	tb_task_detail ttd " + 
						"LEFT JOIN tb_task tt ON ttd.task_id = tt.id " + 
						"WHERE " + 
						"	tt.delete_flag = 0 AND ttd.receive_nodeid = ? " + 
						")a");
				Map map1 = jdbcTemplate.queryForMap(sbuffer.toString(), tsUser.getPointId());
				map.put("aTasksNum", map1.get("aTasksNum"));	//总任务数量
				map.put("fTasksNum", map1.get("fTasksNum"));	//已完成任务数量
				map.put("eTasksNum", map1.get("eTasksNum"));	//执行中任务数量
				
			}else if(StringUtil.isNotEmpty(tsUser.getDepartId())){
				
				//任务数量
				sbuffer.setLength(0);
				sbuffer.append("SELECT IFNULL(a.atn,0) aTasksNum, IFNULL(a.ftn,0) fTasksNum, (IFNULL(a.atn,0) - IFNULL(a.ftn,0)) eTasksNum  " + 
						"FROM ( " + 
						"SELECT " + 
						"	SUM(CASE WHEN tt.task_status != -1 THEN 1 ELSE 0 END ) atn, " + 
						"	SUM(CASE WHEN ttd.sample_number >= ttd.task_total and tt.task_status != -1 THEN 1 ELSE 0 END ) ftn " + 
						"FROM " + 
						"	tb_task_detail ttd " + 
						"LEFT JOIN tb_task tt ON ttd.task_id = tt.id " + 
						"WHERE " + 
						"	tt.delete_flag = 0 AND ttd.receive_pointid = ? " + 
						")a");
				Map map1 = jdbcTemplate.queryForMap(sbuffer.toString(), tsUser.getDepartId());
				map.put("aTasksNum", map1.get("aTasksNum"));	//总任务数量
				map.put("fTasksNum", map1.get("fTasksNum"));	//已完成任务数量
				map.put("eTasksNum", map1.get("eTasksNum"));	//执行中任务数量
				
			}
		}
		
		return map;
	}

	/**
	 * 更新抽检任务进度，每次调用检测数量+1
	 * @param checkTime 检测时间
	 * @param pointId	检测点ID
	 * @param foodId	样品ID
	 * @param itemId	检测项目ID
	 * @param isDel		0_新增，1_删除
	 */
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
	public void updateTaskProgress(Date checkTime, Integer pointId, Integer foodId, String itemId, Integer isDel) throws Exception {

		List<TaskProgressModel> taskProgressModels = taskDetailService.queryCheckTask(checkTime, pointId, foodId, itemId);
		for (TaskProgressModel taskProgressModel : taskProgressModels) {
			TbTask task = queryById(taskProgressModel.getId().toString());
			TbTaskDetail taskDetail = taskDetailService.queryById(taskProgressModel.getTdId().toString());

			if (task != null && taskDetail != null) {
				Date now = new Date();
				//更新主任务进度
				if (null == task.getSampleNumber()) {
					if (isDel == 0) {
						task.setSampleNumber(1);

					} else if (isDel == 1) {
						task.setSampleNumber(0);
					}

				} else {
					if (isDel == 0) {
						task.setSampleNumber(task.getSampleNumber() + 1);

					} else if (isDel == 1) {
						task.setSampleNumber(Math.max((task.getSampleNumber() - 1), 0));
					}
				}

				//更改已完成任务状态
				if (task.getSampleNumber() >= task.getTaskTotal()) {
					task.setTaskStatus((short) 2);
				} else {
					task.setTaskStatus((short) 1);
				}

				task.setUpdateDate(now);
				updateById(task);

				//更新任务明细进度
				if (null == taskDetail.getSampleNumber()) {
					if (isDel == 0) {
						taskDetail.setSampleNumber(1);

					} else if (isDel == 1) {
						taskDetail.setSampleNumber(0);
					}

				} else {
					if (isDel == 0) {
						taskDetail.setSampleNumber(taskDetail.getSampleNumber() + 1);

					} else if (isDel == 1) {
						taskDetail.setSampleNumber(Math.max((taskDetail.getSampleNumber() - 1), 0));
					}
				}
				taskDetailService.updateById(taskDetail);

				//更新上级任务进度
				if (task.getTaskDetailPid() != null && !"".equals(task.getTaskDetailPid().trim())) {
					updatePtaskProgress(Integer.parseInt(task.getTaskDetailPid()), isDel);
				}
			}
		}
	}

	/**
	 * 更新抽检任务的上级任务进度，每次调用检测数量+1
	 * @param taskDetailPid	转发任务ID
	 * @param isDel		0_新增，1_删除
	 */
	private void updatePtaskProgress(Integer taskDetailPid, Integer isDel) throws Exception {
		if (taskDetailPid != null) {
			TbTaskDetail taskDetail = taskDetailService.queryById(taskDetailPid.toString());
			if (taskDetail != null) {
				TbTask task = queryById(taskDetail.getTaskId().toString());
				if (task != null) {
					Date now = new Date();
					//更新主任务进度
					if (null == task.getSampleNumber()) {
						if (isDel == 0) {
							task.setSampleNumber(1);

						} else if (isDel == 1) {
							task.setSampleNumber(0);
						}

					} else {
						if (isDel == 0) {
							task.setSampleNumber(task.getSampleNumber() + 1);

						} else if (isDel == 1) {
							task.setSampleNumber(Math.max((task.getSampleNumber() - 1), 0));
						}
					}

					//更改已完成任务状态
					if (task.getSampleNumber() >= task.getTaskTotal()) {
						task.setTaskStatus((short) 2);
					} else {
						task.setTaskStatus((short) 1);
					}

					task.setUpdateDate(now);
					updateById(task);

					//更新任务明细进度
					if (null == taskDetail.getSampleNumber()) {
						if (isDel == 0) {
							taskDetail.setSampleNumber(1);

						} else if (isDel == 1) {
							taskDetail.setSampleNumber(0);
						}

					} else {
						if (isDel == 0) {
							taskDetail.setSampleNumber(taskDetail.getSampleNumber() + 1);

						} else if (isDel == 1) {
							taskDetail.setSampleNumber(Math.max((taskDetail.getSampleNumber() - 1), 0));
						}
					}
					taskDetailService.updateById(taskDetail);

					//更新上级任务进度
					if (task.getTaskDetailPid() != null && !"".equals(task.getTaskDetailPid().trim())) {
						updatePtaskProgress(Integer.parseInt(task.getTaskDetailPid()), isDel);
					}
				}
			}

		}
	}
	
}
