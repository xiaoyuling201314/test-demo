package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseLawInstrument;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.BaseLawInstrumentMapper;
import com.dayuan.service.BaseService;
/**
 * 执法仪Service
 * @author LuoYX
 * @date 2018年8月13日
 */
@Service
public class BaseLawInstrumentService extends BaseService<BaseLawInstrument, Integer> {
	@Autowired
	private BaseLawInstrumentMapper mapper;
	@Override
	public BaseMapper<BaseLawInstrument, Integer> getMapper() {
		return mapper;
	}
		
	
	/**
	 * 查询全部执法仪器
	 * @return
	 */
	public  List<BaseLawInstrument>  queryAll() {
		
		return mapper.queryAll();
	}

    /**
	 * 查询设备号是否已存在
	 * @param devIdno
	 * @return
	 */
	public  List<BaseLawInstrument> selectByDevIdno(String devIdno){
		
		return mapper.selectByDevIdno(devIdno);
	}
}
