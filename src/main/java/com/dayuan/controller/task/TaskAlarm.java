package com.dayuan.controller.task;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.service.message.TbTaskMessgaeService;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.util.DateUtil;

@Component
public class TaskAlarm {

	@Autowired
	private TaskDetailService detailService;
	@Autowired
	private TbTaskMessgaeService messgaeService;
	
	//@Scheduled(cron = "0 0/1 * * * *")
	public void taskAlarm() {
		Date now = new Date();
		String date = DateUtil.time_sdf.format(now);
		List<TbTaskDetail> list = detailService.queryAlarmTask(date);
		for (TbTaskDetail task : list) {
			TbTaskMessgae mp = new TbTaskMessgae();
			String title = "【任务报警】"+task.getTaskTitle();
			String startDate = DateUtil.date_sdf.format(task.getTaskSdate());
			String endDate = DateUtil.date_sdf.format(task.getTaskEdate());
			String content = String.format("您的任务【%s】即将过期，请及时处理。<br/>任务开始时间：%s<br/>任务结束时间：%s",task.getTaskTitle(),startDate,endDate);
			mp.setFromUserId("1");
			mp.setTitle(title);
			mp.setContent(content);
			mp.setSendtime(now);
			if (null != task.getReceivePointid()) {// 发送给机构的任务
				mp.setGroupId(task.getReceivePointid());
				mp.setToUserType("1");
			} else { // 发送给检测点的任务
				mp.setGroupPointId(task.getReceiveNodeid());
				mp.setToUserType("2");
			}
			messgaeService.sendMessage(mp);
		}
	}
}
