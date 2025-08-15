package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseRegion;
import com.dayuan.mapper.BaseMapper;

/**
 * 
 * Description:  地域信息
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public interface BaseRegionMapper extends BaseMapper<BaseRegion, Integer> {

	/**
	 * 查询下级行政机构
	 * @param regionId 父级行政机构ID
	 * @return
	 * @author LuoYX
	 * @date 2018年4月23日
	 */
	List<BaseRegion> querySubRegionById(Integer regionId);

	/**
	 * 查询上级行政区域
	 * @param parentId
	 * @return
	 * @author LuoYX
	 * @date 2018年4月25日
	 */
	BaseRegion queryByParentRegion(Integer parentId);
	/**
	 * 根据行政机构名称查询 行政机构
	 * @param regionName
	 * @return
	 * @author LuoYX
	 * @date 2018年4月25日
	 */
	BaseRegion queryByRegionName(String regionName);

}