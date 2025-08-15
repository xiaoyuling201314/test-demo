package com.dayuan.service.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.log.TSErrorLog;
import com.dayuan.mapper.log.TSErrorLogMapper;
import com.dayuan.service.BaseService;

import java.util.List;

/**
 * 仪器错误日志
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年5月4日
 */
@Service
public class TSErrorLogService extends BaseService<TSErrorLog, String>{
	@Autowired
	private TSErrorLogMapper mapper;
	
	public TSErrorLogMapper getMapper() {
		
		return mapper;
	}

	/**
	 * 查询错误日志中存在的所有仪器类型
	 * @return
	 */
	public List<String> selectAlldeviceType() {
		return mapper.selectAlldeviceType();
	}
}
