package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @author Dz
 * @description 针对表【base_food_type(食品种类表)】的数据库操作Mapper
 * @createDate 2025-06-13 11:01:18
 * @Entity BaseFoodType
 */
public interface BaseFoodTypeMapper extends BaseMapper<BaseFoodType> {

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
     * 通过食品种类父ID,获取下级食品种类列表
     * @param id 食品种类父ID
     * @param isContainSelf 是否包含当前节点
     * @param isShowFood 是否显示样品信息
     * @return
     */
    List<BaseFoodType> queryFoodByPid(@Param("id")Integer id,@Param("isContainSelf")Boolean isContainSelf,@Param("isShowFood")Boolean isShowFood);

	BaseFoodType queryByFoodName(@Param("foodName")String foodName,@Param("parentId")Integer parentId);

	/**
	 * 根据食品类别父ID统计子类信息
	 * @param parentId 食品种类父ID
	 * @return
	 */
	int queryCountByPid(String parentId);

	int updateByFoodPid(@Param("ids")String[] ids, @Param("parentId")String parentId);

	String queryParentFoodById(String foodId);

	List<BaseFoodType> queryAll();
	
	List<Integer> queryFoodId(@Param("foodId")Integer foodId,@Param("foodArr")List<Integer> foodArr);

	/**
	 * 查询所有子种类IDS
	 * @param id
	 * @return
	 * @author LuoYX
	 * @date 2018年4月19日
	 */
	String querySubTypes(Integer id);
	/**
	 * 根据名称模糊查询食品
	 * @param fName
	 * @param isFood 0是食品种类，1是食品名称
	 * @return
	 * @author LuoYX
	 * @date 2018年5月14日
	 */
	List<BaseFoodType> queryByFName(@Param("fName")String fName, @Param("isFood")Integer isFood);
	/**
	 * 查询所有的样品 
	 * @return
	 * @author LuoYX
	 * @date 2018年5月30日
	 */
	List<Map<String, Object>> queryAllMap();
	/**
	 * 微信端查询全部食品 类型为食品
	 * @return
	 */
	List<BaseFoodType>  queryAllFood();
	
	/**
	 * 根据父类ID查询数据
	 * @param parentId  父类ID
	 * @param isFood    0是食品种类，1是食品名称
	 * @return
	 * @author wtt
	 * @date 2018年8月22日
	 */
	List<BaseFoodType> selectByParentId(@Param("parentId") Integer parentId, @Param("isFood") Integer isFood);
	
	List<BaseFoodType> queryByFoodCode(String foodCode);
	
	String getLastFoodCode(String foodCode);
	
	List<Integer> querySonFoods(Integer id);
	
	/**
	 * 查询所选的食品类别是否还有下一级食品类别
	 * @param id
	 * @return
	 * @author wtt
	 * @date 2018年11月23日
	 */
	List<BaseFoodType> queryFoodTypeMap(Integer id);
	
	List<BaseFoodType> queryFoodMap(Integer id);
	
	List<BaseFoodType> queryFoodByLastUpdateTime(@Param("lastUpdateTime")String lastUpdateTime);

    List<BaseFoodType> queryFoodByItemId(String itemId);
    
	BaseFoodType querySecondFoodType();
	/**
	* @Description 查询所有样品ID，包括已删除的样品
	* @Date 2020/11/30 8:51
	* @Author xiaoyl
	* @Param
	* @return
	*/
	List<Integer> queryAllSonFoods(Integer id);

	/**
	 * 获取最大排序
	 * @param parentId 父样品ID
	 * @return
	 */
	Integer queryMaxSorting(@Param("parentId")Integer parentId);
	/**
	* @Description 根据样品ID查询该类下是否有样品种类，用于仪器端控制是否启用新增样品按钮
	* @Date 2022/07/28 11:21
	* @Author xiaoyl
	* @Param
	* @return
	*/
	int queryFoodTypeByID(Integer id);

	BaseFoodType queryFoodById(Integer id);
}