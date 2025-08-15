package com.dayuan.mapper.data;

import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.data.BaseWorkersModel;

import org.apache.ibatis.annotations.Param;

import java.util.List;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月18日
 */
public interface BaseWorkersMapper extends BaseMapper<BaseWorkers, String> {

	BaseWorkers queryByWorkerName(@Param("workerName")String workerName, @Param("MobilePhone")String MobilePhone);
  
	List<BaseWorkers> queryByDepartId(@Param("departId")String departId, @Param("userName")String userName);
	
//	List<PPersonnelBaseWorkers> queryByPointId(String pointid);
	
	List<BaseWorkers> queryAll();
	
	List<BaseWorkers> queryIdleWorkers(@Param("userName")String userName);
	
	List<BaseWorkers> selectByPointId(Integer pointId);
	
	List<BaseWorkers> queryByList(BaseWorkersModel model);
}