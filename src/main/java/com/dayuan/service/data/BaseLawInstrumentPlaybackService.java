package com.dayuan.service.data;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseLawInstrumentPlayback;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.BaseLawInstrumentPlaybackMapper;
import com.dayuan.service.BaseService;
/**
 * 
 * @author LuoYX
 * @date 2018年8月20日
 */
@Service
public class BaseLawInstrumentPlaybackService extends BaseService<BaseLawInstrumentPlayback, Integer> {

	@Autowired
	private BaseLawInstrumentPlaybackMapper mapper;
	@Override
	public BaseMapper<BaseLawInstrumentPlayback, Integer> getMapper() {
		return mapper;
	}
	/**
	 * 保存 抽样单下载视频任务，
	 * @param bean
	 * @author LuoYX
	 * @date 2018年8月21日
	 */
	public void saveTask(TbSampling bean) {
		mapper.saveTask(bean);
	}
	/**
	 * 手动添加 抽样单下载视频任务
	 * huht
	 * 2019-5-29
	 * @param bean
	 */
	public void saveTask2(TbSampling bean) {
		mapper.saveTask2(bean);
	}
	/**
	 * 查询抽样单下载视频任务
	 * @return
	 * @author LuoYX
	 * @date 2018年8月21日
	 */
	public List<Map<String, Object>> queryDownloadPlan() {
		return mapper.queryDownloadPlan();
	}
	public void deletePlan(Integer id) {
		mapper.deletePlan(id);
	}
	
	/**
	 * 修改视频任务下载状态 0未下载1正在下载中
	 * @param id
	 * @param state
	 */
	public void updateState(Integer id,Integer state) {
		mapper.deletePlan(id);
	}
	/**
	 * 查询抽样单对应下载任务
	 * @return
	 */
	public List<Map<String, Object>> queryPlanBySamId( Integer samNo) {
		return mapper.queryPlanBySamId(samNo);
	}
	/**
	 * 查询文件是否已下载
	 * @param fileName
	 * @return
	 */
	public List<BaseLawInstrumentPlayback> selectByFileName( String fileName) {
		return mapper.selectByFileName(fileName);
	}

}
