package com.dayuan.model.task;

import java.util.List;

import com.dayuan.bean.task.TbTask;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.model.BaseModel;

public class TaskModel extends BaseModel {

	//任务
	private TbTask task;
    //任务明细列表
	private List<TbTaskDetail> taskDetails;
	
	public TbTask getTask() {
		return task;
	}
	public void setTask(TbTask task) {
		this.task = task;
	}
	public List<TbTaskDetail> getTaskDetails() {
		return taskDetails;
	}
	public void setTaskDetails(List<TbTaskDetail> taskDetails) {
		this.taskDetails = taskDetails;
	}
	
}
