package com.dayuan.mapper.data;

import java.util.List;
import java.util.Map;

import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.data.BaseLawInstrumentPlayback;
import com.dayuan.bean.sampling.TbSampling;

public interface BaseLawInstrumentPlaybackMapper extends BaseMapper<BaseLawInstrumentPlayback, Integer> {
	/**
	 * 保存 抽样单下载视频任务
	 * @param bean
	 * @author LuoYX
	 * @date 2018年8月21日
	 */
	void saveTask(TbSampling bean);
	
	/**
	 * 下载视频添加任务
	 * @param bean
	 */
	void saveTask2(TbSampling bean);
	/**
	 * 查询抽样单下载视频任务
	 * @return
	 * @author LuoYX
	 * @date 2018年8月21日
	 */
	List<Map<String, Object>> queryDownloadPlan();
	/**
	 * 查询抽样单对应视频任务
	 * @author huht
	 * @return
	 * 2018-5-28
	 */
	List<Map<String, Object>> queryPlanBySamId( Integer samNo);
	/**
	 * 判断文件是否已下载
	 * @param fileName
	 * @return
	 */
	List<BaseLawInstrumentPlayback> selectByFileName( String fileName);
	
	void deletePlan(Integer id);
	
	void updateState(@Param("id")Integer id,@Param("state")Integer state);

}