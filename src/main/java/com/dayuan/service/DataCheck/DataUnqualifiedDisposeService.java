package com.dayuan.service.DataCheck;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.bean.dataCheck.DataUnqualifiedDispose;
import com.dayuan.mapper.dataCheck.DataUnqualifiedConfigMapper;
import com.dayuan.mapper.dataCheck.DataUnqualifiedDisposeMapper;
import com.dayuan.service.BaseService;



/**
 * 不合格处置记录
 * @author Bill
 *
 */
@Service
public class DataUnqualifiedDisposeService extends BaseService<DataUnqualifiedDispose, Integer> {
	
	@Autowired
	private DataUnqualifiedDisposeMapper mapper;
	public DataUnqualifiedDisposeMapper getMapper() {
		return mapper;
	}
	
	/**
	 * 根据抽检结果id获取不合格处置记录
	 * @param unid
	 * @return
	 */
	public int selectByUnid(Integer unid){
		return mapper.selectByUnid(unid);
	}

	/**
	 * 删除不合格处理明细
	 * @param unid
	 * @return
	 */
	public int deleteByUnid(Integer unid){
		return mapper.deleteByUnid(unid);
	}
	
}
