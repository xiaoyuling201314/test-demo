package com.dayuan.mapper.sampling;

import java.util.List;

import com.dayuan.bean.sampling.TbSamplingDetailRecevie;
import com.dayuan.mapper.BaseMapper;
/**
 * 抽检明细任务接收状态
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月14日
 */
public interface TbSamplingDetailRecevieMapper extends BaseMapper<TbSamplingDetailRecevie, Integer> {
	/**
	 * 根据抽样明细ID进行删除
	 * @param sdId 抽样明细ID
	 */
	void deleteBySdId(Integer sdId);
	
	/**
	 * 根据仪器唯一标识删除检测任务临时表数据
	 * @param serialNumber 仪器唯一标识
	 */
	void deleteBySerialNumber(String serialNumber);

	/**
	 * 更新检测任务状态
	 * @param recevie
	 */
	void updateByRejectStatus(TbSamplingDetailRecevie recevie);
	
	/**
	 * 根据抽样明细ID获取下一条仪器任务
	 * @param sdId 抽样明细ID
	 */
	TbSamplingDetailRecevie queryNextDeviceBySdid(Integer sdId);
	
	/**
	 * 根据抽样明细ID重置所有仪器的接收状态
	 * @param sdId 抽样明细ID
	 */
	void updateResetRecevieStatusBySdId(Integer sdId);
	
	/**
	 * 根据抽样明细ID，获取已分配检测任务
	 * @param sdId 抽样明细ID
	 * @return
	 */
	List<TbSamplingDetailRecevie> queryBySdId(Integer sdId);

	
   
}