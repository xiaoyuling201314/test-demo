package com.dayuan.service.task;

import java.util.Date;
import java.util.List;

import com.dayuan.model.task.TaskProgressModel;
import com.dayuan.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.mapper.task.TbTaskDetailMapper;
import com.dayuan.model.task.RecTaskModel;
import com.dayuan.service.BaseService;

@Service
public class TaskDetailService extends BaseService<TbTaskDetail, String> {

	@Autowired
	private TbTaskDetailMapper mapper;
	
	public TbTaskDetailMapper getMapper() {
		return mapper;
	}
	/**
	 * 通过主任务ID获取任务明细
	 * @param id
	 * @return
	 */
	public List<TbTaskDetail> getDetailsByPid(String id) {
		return mapper.getDetailsByPid(id);
	}
	
	
    /**
     * 通过主任务ID和接收检测点ID获取任务明细
     * @param taskId	主任务ID
     * @param pointId 接收检测点ID
     * @return
     */
	public List<TbTaskDetail> getDetailsByTP(int taskId, int pointId) {
		return mapper.getDetailsByTP(taskId, pointId);
	}
	
    
    /**
     * 通过检测点ID,获取接收任务分页数据
     * @param pid
     * @return
     */
	public List<RecTaskModel> getRecTaskByPid(Page page){
		return mapper.getRecTaskByPid(page);
	}
    
    /**
     * 查询接收任务记录总数量
     * @param page
     * @return
     */
	public int getRecTaskTotal(Page page){
		return mapper.getRecTaskTotal(page);
	}
    
    /**
     * 获取接收任务信息
     * @param id
     * @return
     */
    public RecTaskModel getRecTask(String id){
    	return mapper.getRecTask(id);
    }
    
    /**
     * 获取检测点或检测机构任务
     * @param status 接收任务状态
     * @param receivePointid 接收检测机构ID
     * @param receiveNodeid 接收检测点ID
     * @return
     */
	public List<TbTaskDetail> queryTasksByRStatus(Integer status,Integer receivePointid, Integer receiveNodeid) throws Exception {
		return mapper.queryTasksByRStatus(status,receivePointid,receiveNodeid);
	}
	
	/**
	 * 根据任务明细ID更新抽样数量
	 * @param id 任务明细ID
	 * @throws Exception
	 */
	public void updateSampleNumberById(String id) throws Exception{
		mapper.updateSampleNumberById(id);
	}
	
	/**
	 * 查询报警的任务
	 * @return
	 * @author LuoYX
	 * @param date 报警时间
	 * @date 2018年8月3日
	 */
	public List<TbTaskDetail> queryAlarmTask(String date) {
		return mapper.queryAlarmTask(date);
	}


	/**
	 * 查询抽检任务
	 * @param checkTime 检测时间
	 * @param pointId	检测点ID
	 * @param foodId	样品ID
	 * @param itemId	检测项目ID（非必填）
	 * @return
	 */
	public List<TaskProgressModel> queryCheckTask(Date checkTime, Integer pointId, Integer foodId, String itemId) {
		return mapper.queryCheckTask(DateUtil.formatDate(checkTime, "yyyy-MM-dd"), pointId, foodId, itemId);
	}

}
