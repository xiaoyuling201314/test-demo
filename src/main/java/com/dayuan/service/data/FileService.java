package com.dayuan.service.data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.TbFile;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.TbFileMapper;
import com.dayuan.service.BaseService;

@Service
public class FileService extends BaseService<TbFile, Integer>{
	@Autowired
	private TbFileMapper mapper;

	@Override
	public BaseMapper<TbFile, Integer> getMapper() {
		return mapper;
	}
}