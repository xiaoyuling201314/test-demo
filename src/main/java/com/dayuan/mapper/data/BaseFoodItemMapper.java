package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Dz
 * @description 针对表【base_food_item(食品种类检测项目表)】的数据库操作Mapper
 * @createDate 2025-06-23 14:12:08
 * @Entity com.dayuan.bean.data.BaseFoodItem
 */
public interface BaseFoodItemMapper extends BaseMapper<BaseFoodItem> {

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
	 * 根据样品种类ID删除关联检测项目
	 * @author xyl
	 * @param id
	 * @return
	 */
	int deteteByFoodId(Integer id);
	/**
	 * 根据样品ID查询关联检测项目信息（进行去重处理）
	 * @param ids
	 * @return
	 */
	List<BaseFoodItem> queryByList(String[] ids);
	
	List<BaseFoodItem> queryList(@Param("baseFoodItem")BaseFoodItem baseFoodItem,@Param("ids")String[] ids);

	int insertBean(List<BaseFoodItem> list);
	
	int selectByFoodId(@Param("foodId")Integer foodId,@Param("itemId")String itemId);

	BaseFoodItem queryByFoodItem(@Param("foodId")Integer foodId, @Param("itemId")String itemId);
	
	/**
	 * 根据食品id查询检测项目集合
	 * @param foodId
	 * @return
	 */
	List<BaseFoodItem> queryListByFoodId(Integer foodId);
	
	int deleteBatch(@Param("itemId")String itemId, @Param("idList")List<Integer> foodIds);
}