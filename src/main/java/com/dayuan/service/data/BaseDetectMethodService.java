package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseDetectMethod;
import com.dayuan.mapper.data.BaseDetectMethodMapper;
import com.dayuan.service.BaseService;

/**
 * 检测方法
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月17日
 */
@Service
public class BaseDetectMethodService extends BaseService<BaseDetectMethod, String>{
	
	@Autowired
	private BaseDetectMethodMapper mapper;
	
	public BaseDetectMethodMapper getMapper() {
		return mapper;
	}
	/**
	 * 根据检测模块ID查询对应的检测方法
	 * @param id 检测模块ID
	 * @return
	 */
	public List<BaseDetectMethod> queryByModularId(String id) throws Exception {
		return mapper.queryByModularId(id);
	}
	
	/**
	 * 根据检测模块id 关联删除检测方法数据  ：操作人 操作时间
	 * @param bean
	 * @throws Exception
	 */
	public void deleteByDetectModularId(BaseDetectMethod bean) throws Exception {
		mapper.deleteByDetectModularId(bean);
	}

	/**
	 *根据检测方法名称去查询校验唯一性
	 * @param detectMethod	检测方法名称
	 * @param modularId		检测模块ID
	 * @return
	 */
	public BaseDetectMethod selectByMethod(String detectMethod, String modularId) {
		return mapper.selectByMethod(detectMethod, modularId);
	}
}
