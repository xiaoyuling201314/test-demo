package com.dayuan.service.data;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.model.BaseModel;

import java.util.List;


/**
 * @author Dz
 * @description 针对表【base_food_item(食品种类检测项目表)】的数据库操作Service
 * @createDate 2025-06-23 14:12:08
 */
public interface BaseFoodItemService extends IService<BaseFoodItem> {

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;

	/**
	 * 根据样品ID查询检测项目
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	public List<BaseFoodItem> queryByList(String[] ids) throws Exception;
	
	public List<BaseFoodItem> queryList(BaseFoodItem baseFoodItem,String[] ids);
	
	public int insertBean(List<BaseFoodItem> list);
	
	public int selectByFoodId(Integer foodId,String itemId);

	public BaseFoodItem queryByFoodItem(Integer foodId,String itemId);
	
	/**
	 * 根据食品id查询检测项目集合
	 * @param foodId
	 * @return
	 */
	public List<BaseFoodItem> queryListByFoodId(Integer foodId);

	/**
	 * 删除样品种类的检测项目时同时删除子类的配置
	 * @description
	 * @param itemId
	 * @param foodIds
	 * @return
	 * @author xiaoyl
	 * @date   2020年7月20日
	 */
	public int deleteBatch(String itemId, List<Integer> foodIds);

}
