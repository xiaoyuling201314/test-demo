package com.dayuan.service.message;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.Page;
import com.dayuan.bean.message.TbTaskMessgae;
import com.dayuan.mapper.message.TbTaskMessgaeMapper;
import com.dayuan.model.message.TbTaskMessgaeModel;
import com.dayuan.service.BaseService;

/**
 * @project 快速服务云平台
 * @author wtt
 * @date 2017年10月25日
 */
@Service
public class TbTaskMessgaeService extends BaseService<TbTaskMessgae, String>{
	@Autowired
	private TbTaskMessgaeMapper mapper;
	
	public TbTaskMessgaeMapper getMapper() {
		return mapper;
	}
	
	/**
	 * @param messgae 发送一条信息
	 * @return 0失败 1成功
	 */
	public int sendMessage(TbTaskMessgae messgae){
		
		int count=mapper.insertSelective(messgae);
		
		return count>0?1:0;
		
	}
	
	/**
	 * 根据id查询发送信息详情
	 * @param id
	 * @return
	 */
	public TbTaskMessgaeModel selectFromById(int id){
		
		return mapper.selectFromById(id);
		
	}
	/**
	 * 根据id查询接收信息详情
	 * @param id
	 * @return
	 */
	public TbTaskMessgaeModel selectToById(int id){
		
		return mapper.selectToById(id);
		
	}
	
	public int deleteByid(int id){
		
		int result=mapper.deleteByPrimaryKey(id);
		
		return result;
		
	}
	
	/**
	 *  查询首页列表信息
	 * @param id
	 * @return
	 */
	public List<TbTaskMessgaeModel> selectIndex(String id,Integer departId,Integer pointId){
		
		return mapper.selectIndex(id,departId,pointId);
	}
	/**
	 * @Description 根据发送类型ID查询接收人或接收机构的名称
	 * @Date 2022/07/21 16:56
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	public String queryReceiveObject(TbTaskMessgaeModel messgaeModel) {
		return mapper.queryReceiveObject(messgaeModel);
	}
}
