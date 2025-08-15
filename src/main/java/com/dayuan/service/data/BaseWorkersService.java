package com.dayuan.service.data;

import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.mapper.data.BaseWorkersMapper;
import com.dayuan.model.data.BaseWorkersModel;
import com.dayuan.service.BaseService;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月18日
 */
@Service
public class BaseWorkersService extends BaseService<BaseWorkers, String>{
	@Autowired
	private BaseWorkersMapper mapper;
	
	public BaseWorkersMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据用户名和身份证号码查询用户名称是否重复
	 * @param workerName
	 * @param MobilePhone
	 * @return
	 */
	public BaseWorkers queryByWorkerName(String workerName, String MobilePhone) {
		return mapper.queryByWorkerName(workerName,MobilePhone);
	}
	
	/**
	 * 根据机构ID获取用户组(含下级检测点、机构用户)
	 * @param departId 机构ID
	 * @param userName 用户名(模糊查询指定名称用户)
	 * @return
	 */
	public List<BaseWorkers> queryByDepartId(String departId, String userName) {
		return mapper.queryByDepartId(departId, userName);
	}
	
	/**
	 * 根据检测点ID获取用户组
	 * @param pointid
	 * @return
	 */
//	public List<PPersonnelBaseWorkers> queryByPointId(String pointid) {
//		return mapper.queryByPointId(pointid);
//	}
	
	/**
	 * 获取所有用户
	 * @return
	 */
	public List<BaseWorkers> queryAll(){
		return mapper.queryAll();
	}
	
	/**
	 * 获取未分配到检测点或机构人员
	 * @param userName 用户名(模糊查询指定名称用户)
	 */
	public List<BaseWorkers> queryIdleWorkers(String userName) throws Exception{
		return mapper.queryIdleWorkers(userName);
	}
	
	public List<BaseWorkers> selectByPointId(Integer pointId){
		
		return mapper.selectByPointId(pointId);
	}
	
	public List<BaseWorkers> queryByList(@Param("model")BaseWorkersModel model){
		return mapper.queryByList(model);
	}
}