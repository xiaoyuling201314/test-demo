package com.dayuan.mapper.task;

import java.util.List;

import com.dayuan.model.task.TaskProgressModel;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.Page;
import com.dayuan.bean.task.TbTaskDetail;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.task.RecTaskModel;
/**
 * 
 * Description: 任务明细Mapper
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public interface TbTaskDetailMapper extends BaseMapper<TbTaskDetail, String> {
    
    /**
     * 通过主任务ID获取任务明细
     * @param pid
     * @return
     */
    List<TbTaskDetail> getDetailsByPid(String pid);
    
    /**
     * 通过主任务ID和接收检测点ID获取任务明细
     * @param taskId	主任务ID
     * @param pointId 接收检测点ID
     * @return
     */
    List<TbTaskDetail> getDetailsByTP(@Param("taskId")int taskId, @Param("pointId")int pointId);
    
    /**
     * 通过检测点ID,获取接收任务分页数据
     * @param pid
     * @return
     */
    List<RecTaskModel> getRecTaskByPid(Page page);
    
    /**
     * 查询接收任务记录总数量
     * @param page
     * @return
     */
    int getRecTaskTotal(Page page);
    
    /**
     * 获取接收任务信息
     * @param id
     * @return
     */
    RecTaskModel getRecTask(String id);
    
    /**
     * 获取检测点或检测机构任务
     * @param status 接收任务状态
     * @param receivePointid 接收检测机构ID
     * @param receiveNodeid 接收检测点ID
     * @return
     */
    List<TbTaskDetail> queryTasksByRStatus(@Param("status")int status,@Param("receivePointid")Integer receivePointid, @Param("receiveNodeid")Integer receiveNodeid);

	void updateSampleNumberById(String id);
	/**
	 * 查询报警的任务
	 * @return
	 * @author LuoYX
	 * @param date 报警时间
	 * @date 2018年8月3日
	 */
	List<TbTaskDetail> queryAlarmTask(String date);

    /**
     * 查询抽检任务
     * @param checkTime 检测时间
     * @param pointId	检测点ID
     * @param foodId	样品ID
     * @param itemId	检测项目ID（非必填）
     * @return
     */
	List<TaskProgressModel> queryCheckTask(@Param("checkTime")String checkTime, @Param("pointId") Integer pointId, @Param("foodId") Integer foodId, @Param("itemId") String itemId);

}