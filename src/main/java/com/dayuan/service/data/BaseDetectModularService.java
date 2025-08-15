package com.dayuan.service.data;

import com.dayuan.bean.data.BaseDetectModular;
import com.dayuan.mapper.data.BaseDetectModularMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 检测模块
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月17日
 */
@Service
public class BaseDetectModularService extends BaseService<BaseDetectModular, String>{
	
	@Autowired
	private BaseDetectModularMapper mapper;
	
	public BaseDetectModularMapper getMapper() {
		return mapper;
	}
	/**
	 * 查询检测模块与检测方法列表
	 * @return
	 */
	public List<BaseDetectModular> queryDetectModular() {
		return mapper.queryDetectModular();
	}
	/**
	 * 查询所有的检测模块
	 * @return
	 */
	public List<BaseDetectModular> queryAll() {
		return mapper.queryAll();
	}

	/**
	 * 根据检测模块名称去查询校验唯一性
	 * @param detectModular
	 * @return
	 * @throws Exception
	 */
	public BaseDetectModular selectByModular(String detectModular,String id)throws Exception {
		return mapper.selectByModular(detectModular, id);
	}
}
