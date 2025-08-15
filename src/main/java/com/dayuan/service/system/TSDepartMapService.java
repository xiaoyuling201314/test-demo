package com.dayuan.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSDepartMap;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.system.TSDepartMapMapper;
import com.dayuan.model.system.TSDepartMapModel;
import com.dayuan.service.BaseService;

@Service
public class TSDepartMapService extends BaseService<TSDepartMap, Integer> {
	
	@Autowired 
	private  TSDepartMapMapper mapper;
	@Override
	public BaseMapper<TSDepartMap, Integer> getMapper() {
		return mapper;
	}

	/**
	 * 根据departId查询经纬度信息
	 * @param departId
	 * @return
	 */
	public	TSDepartMap selectByDepartid(Integer departId){
		TSDepartMap tSDepartMap=	mapper.selectByDepartid(departId);
		return tSDepartMap;
	}
	
	/**
	 * 根据机构id修改
	 * @param record
	 */
	public void updateByDepartId(TSDepartMap record) {
		mapper.updateByDepartId(record);
	}
	
	/**
	 * 根据机构id查询下级各个机构数量
	 * @param departId
	 * @return
	 */
	public  TSDepartMapModel selectReportByDepartid(Integer departId) {
		
		return mapper.selectReportByDepartid(departId);
	}
	
	/**
	 * 查询机构列表定位信息
	 * @param model
	 * @return
	 */
	public List<TSDepartMap>	selectDepartByDepartid(TSDepartMapModel model) {
		return mapper.selectDepartByDepartid(model);
	}
}
