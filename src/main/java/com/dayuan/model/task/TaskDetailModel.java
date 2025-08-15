package com.dayuan.model.task;

import com.dayuan.bean.task.TbTask;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.model.BaseModel;

/**
 * 接收任务
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年9月19日
 */
public class TaskDetailModel extends BaseModel{
	
	private TbTask task;	//下达任务
	
	private TbTaskDetail detail;	//接收任务

	public TbTask getTask() {
		return task;
	}

	public void setTask(TbTask task) {
		this.task = task;
	}

	public TbTaskDetail getDetail() {
		return detail;
	}

	public void setDetail(TbTaskDetail detail) {
		this.detail = detail;
	}

	
}
