package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @author Dz
 * @description 针对表【base_detect_item(检测项目表)】的数据库操作Mapper
 * @createDate 2025-06-13 16:12:14
 */
public interface BaseDetectItemMapper extends BaseMapper<BaseDetectItem> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BaseDetectItem> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	String queryLastCode();

	BaseDetectItem queryByDetectNameAndStandard(BaseDetectItem bean);
	
	List<BaseDetectItem> queryByTypeid(String typeid);
	/**
	 * 根据样品ID递归向上查询所有关联的检测项目列表
	 * （查询当前样品及所有父类样品的检测项目并去重）
	 * @param foodId 样品ID
	 * @return
	 * @author xyl 2017-09-13
	 */
	List<BaseDetectItem> queryByFoodId(@Param("foodId")String[] foodId);

	/**
	 * 根据样品ID向下递归查询所有关联的检测项目列表
	 * （查询当前样品及所有子类样品的检测项目并去重）
	 * @param foodId 样品ID
	 * @param foodCode 种类CODE
	 * @return
	 */
	List<BaseDetectItem> queryByFoodId2(@Param("foodId")Integer foodId, @Param("foodCode")String foodCode);

	/**
	 * 根据检测模块ID、样品ID递归向下查询所有关联的检测项目列表
	 * @param childFoodIds 子样品数组ID
	 * @param itemTypeId 检测模块ID
	 */
	List<BaseDetectItem> queryByItemType(Map map);
	/**
	 * 根据检测项目名称查询检测项目
	 */
	List<BaseDetectItem> queryByItemName(String itemName);

	/**
	 * 根据检测项目名称查询检测项目
	 */
	BaseDetectItem queryOneByItemName(String itemName);

	/**
	 * 查询所有检测项目
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	List<Map<String, Object>> queryItemMap();
	
	/**
	 * 查询所有检测项目
	 * @return
	 */
	List<BaseDetectItem> queryAll();
	
	/**
	 * 活动id 为空则查询全部
	 * 查询全部可用检测项目
	 * @return
	 */
	List<BaseDetectItem> queryAllByChecked(@Param("offerId")String[] offerId);
	/**
	 *  查询所有可用检测项目的ID，用于新增优惠活动应用所有项目时使用
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2020年4月9日
	 */
	String queryAllIds();

	BaseDetectItem queryByItemNames(@Param("itemNames")String[] itemNames);

    BaseDetectItem queryItemById(String itemId);
}