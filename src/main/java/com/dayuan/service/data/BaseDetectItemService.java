package com.dayuan.service.data;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.model.BaseModel;

import java.util.List;
import java.util.Map;

/**
 * @author Dz
 * @description 针对表【base_detect_item(检测项目表)】的数据库操作Service
 * @createDate 2025-06-13 16:12:14
 */
public interface BaseDetectItemService extends IService<BaseDetectItem> {

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;
	
	/**
	 * 查询最后一个系统编号
	 * @author xyl
	 * @return
	 */
	public String queryLastCode();
	/**
	 * 根据检测项目名称和检测标准查询数据
	 * @author xyl
	 * @param bean
	 * @return
	 */
	public BaseDetectItem queryByDetectNameAndStandard(BaseDetectItem bean);
	
	/**
	 * 根据检测项目类型查询数据
	 * @author Dz
	 * @param typeid
	 * @return
	 */
	public List<BaseDetectItem> queryByTypeid(String typeid);

	/**
	 * 根据样品ID递归向上查询所有关联的检测项目列表
	 * （查询当前样品及所有父类样品的检测项目并去重）
	 * @param foodId 样品ID
	 * @return
	 * @author xyl 2017-09-13
	 */
	public List<BaseDetectItem> queryByFoodId(String[] foodId)throws Exception;

	/**
	 * 根据样品ID向下递归查询所有关联的检测项目列表
	 * （查询当前样品及所有子类样品的检测项目并去重）
	 * @param foodId 样品ID
	 * @return
	 */
	public List<BaseDetectItem> queryByFoodId2(Integer foodId)throws Exception;
	
	/**
	 * 根据检测模块ID、样品ID递归向下查询所有关联的检测项目列表
	 * @param childFoodIds 父级/子级样品ID字符串
	 * @param itemTypeId 检测模块ID
	 */
	public List<BaseDetectItem> queryByItemType(String childFoodIds, String itemTypeId)throws Exception;

	/**
	 * 根据检测项目名称查询检测项目
	 */
	public List<BaseDetectItem> queryByItemName(String itemName);

	/**
	 * 根据检测项目名称查询检测项目
	 */
	public BaseDetectItem queryOneByItemName(String itemName);

	/**
	 * 查询所有检测项目
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	public List<Map<String, Object>> queryItemMap();
	
	/**
	 * 查询所有检测项目
	 * @return
	 */
	public List<BaseDetectItem> queryAll();
	
	/**
	 * huht 2019-8-28
	 * 查询全部可用检测项目 id为空查询全部 不为空则查活动的检测项目
	 * @return 
	 */
	public	List<BaseDetectItem> queryAllByChecked(String[] offerId);

	/**
	 * 查询所有可用检测项目的ID，用于新增优惠活动应用所有项目时使用
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date   2020年4月9日
	 */
	public	String queryAllIDs();

	/**
	 * 根据检测项目名称查询检测项目
	 */
	public BaseDetectItem queryByItemNames(String[] itemName);

    BaseDetectItem queryItemById(String itemId);
}
