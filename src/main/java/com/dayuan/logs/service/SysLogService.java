package com.dayuan.logs.service;

import com.dayuan.logs.bean.SysLog;
import com.dayuan.logs.mapper.SysLogMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Description 系统通用操作日志
* @Date 2021/05/25 17:06
* @Author xiaoyl
* @Param
* @return
*/
@Service
public class SysLogService extends BaseService<SysLog, Integer> {
	
	@Autowired
	private SysLogMapper mapper;
	
	public SysLogMapper getMapper() {
		return mapper;
	}

    public List<String> queryAllModule() {
		return mapper.queryAllModule();
    }
	/**
	* @Description 查询近三天没有物理地址的IP信息
	* @Date 2022/03/03 15:39
	* @Author xiaoyl
	* @Param
	* @return
	*/
    public List<String> queryIpForNotAddress(){
		return mapper.queryIpForNotAddress();
	}

	/**
	* @Description 根据IP地址更新日志表没有物理地址的日志信息
	* @Date 2022/03/03 15:54
	* @Author xiaoyl
	* @Param
	* @return
	*/
	public int updateLogsByIp(String ip,String address) {
		return mapper.updateLogsByIp(ip,address);
	}
}
