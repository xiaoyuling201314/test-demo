package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.data.BaseStandard;

import java.util.List;


/**
 * @author Dz
 * @description 针对表【base_standard(检测标准)】的数据库操作Mapper
 * @createDate 2025-06-24 00:46:54
 * @Entity BaseStandard
 */
public interface BaseStandardMapper extends BaseMapper<BaseStandard> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseFoodType> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	/**
	 * 查询最大的系统编号
	 * @return
	 */
	String queryLastCode();
	/**
	 * 根据检测标准名称查询数据
	 * @param standardName
	 * @return
	 */
	BaseStandard queryByStandardName(String standardName);
	
	/**
	 * 查询所有的检测标准
	 * @return
	 */
	List<BaseStandard> queryAll();    
    
}