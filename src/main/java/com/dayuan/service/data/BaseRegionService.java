package com.dayuan.service.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.data.BaseRegion;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.data.BaseRegionMapper;
import com.dayuan.service.BaseService;
@Service
public class BaseRegionService extends BaseService<BaseRegion, Integer>{
	@Autowired
	private BaseRegionMapper mapper;
	@Override
	public BaseMapper<BaseRegion, Integer> getMapper() {
		return mapper;
	}
	/**
	 * 查询下级行政机构
	 * @param regionId 父级行政机构ID
	 * @return
	 * @author LuoYX
	 * @date 2018年4月23日
	 */
	public List<BaseRegion> querySubRegionById(Integer regionId) {
		return mapper.querySubRegionById(regionId);
	}
	/**
	 * 根据行政机构名称查询 行政机构
	 * @param regionName
	 * @return
	 * @author LuoYX
	 * @date 2018年4月25日
	 */
	public BaseRegion queryByRegionName(String regionName) {
		return mapper.queryByRegionName(regionName);
	}

}
