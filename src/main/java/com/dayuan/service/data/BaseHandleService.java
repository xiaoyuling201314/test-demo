package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseHandle;
import com.dayuan.mapper.data.BaseHandleMapper;
import com.dayuan.service.BaseService;

/**
 * 不合格的处理方式
 * @author Bill
 *
 */
@Service
public class BaseHandleService extends BaseService<BaseHandle, String> {
	
	@Autowired
	private BaseHandleMapper mapper;
	
	public BaseHandleMapper getMapper() {
		return mapper;
	}


	/**
	 * 搜索全部不合格处理方式
	 * @return
	 */
	public List<BaseHandle> selectList(){
		return mapper.selectList();
	}

}
