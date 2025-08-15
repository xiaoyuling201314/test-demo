package com.dayuan.mapper;

import java.util.List;

import com.dayuan.bean.Page;
import org.apache.ibatis.annotations.Param;

public interface BaseMapper<T, ID extends java.io.Serializable> {
	int deleteByPrimaryKey(ID... ids);

	int deleteByPrimaryKeys(@Param("ids")List<ID> ids, @Param("updateUserId")String updateUserId);

	int insert(T record);

	int insertSelective(T record);

	T selectByPrimaryKey(ID id);

	List<T> queryByIds(@Param("ids")ID[] ids);

	int updateByPrimaryKeySelective(T record);

	int updateByPrimaryKey(T record);

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<T> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	List<T> queryByUpdateDate(String lastUpdateTime);
}
