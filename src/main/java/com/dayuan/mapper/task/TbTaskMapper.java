package com.dayuan.mapper.task;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.task.TaskStatistics;
import com.dayuan.bean.task.TbTask;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.task.RecTaskModel;

public interface TbTaskMapper extends BaseMapper<TbTask, String> {
    
    /**
     * 获取转发任务
     * @param id 二级任务id
     * @return
     */
    TbTask getSecTask(String id);

	List<TbTask> queryByReceiveId(RecTaskModel taskDetail);
    
	/**
	 * 查询下发任务和转发任务
	 * @param id 下发任务ID
	 */
	List<TbTask> queryChildTaskById(String id);

//	void updateSampleNumberById(String taskId);

	void updateSampleNumberById(@Param("taskId")String taskId, @Param("userId")String userId, @Param("date")Date date);

	List<TaskStatistics> queryMission(Map<String, Object> map);

	List<TaskStatistics> queryReceived(Map<String, Object> map);

	TbTask queryJoinById(String id);
    
}