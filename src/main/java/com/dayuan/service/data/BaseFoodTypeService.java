package com.dayuan.service.data;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.data.BaseFoodTypeController;
import com.dayuan.controller.dataCheck.ImportDataCheckController;
import com.dayuan.mapper.data.BaseFoodItemMapper;
import com.dayuan.mapper.data.BaseFoodTypeMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.BaseService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.GlobalConfig;
import com.dayuan.util.ReflectHelper;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @author Dz
 * @description 针对表【base_food_type(食品种类表)】的数据库操作Service
 * @createDate 2025-06-13 11:01:18
 */
public interface BaseFoodTypeService extends IService<BaseFoodType> {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception;

    /**
     * 根据食品种类ID查询二级食品信息
     *
     * @param id            样品ID
     * @param isShowFood    是否显示样品信息
     * @param isContainSelf 是否包括当前节点
     * @param attributes    自定义属性 add by xiaoyuling 2017-09-18
     * @return
     */
    public List<TreeNode> queryFoodTree(Integer id, Boolean isContainSelf, Boolean isShowFood, List<String> attributes);

    public List<TreeNode> queryFoodTrees(Integer id, Boolean isContainSelf, Boolean isShowFood, List<String> attributes);

    public List<Integer> queryFoodId(Integer foodId, List<Integer> foodArr);

    /**
     * 根据食品类别ID加载食品分类列表信息（包括当前类别）
     *
     * @param id
     * @return
     */
    public List<BaseFoodType> queryFoodType(Integer id);

    /**
     * 查询类型ID为parentId下是否已存在相同的样品类别或样品信息
     *
     * @param foodName 样品名称
     * @param parentId 父类别ID
     * @return
     */
    public BaseFoodType queryByFoodName(String foodName, Integer parentId);

    /**
     * 根据食品类别父ID统计子类信息
     *
     * @return
     */
    public int queryCount(String parentId);

    /**
     * 删除食品信息和关联检测项目信息
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public BaseFoodType delete(Integer id) throws Exception;

    public int updateByFoodPid(String[] ids, String parentId);

    /**
     * 根据foodId向上查找父类样品ID
     *
     * @param foodId
     * @return
     * @author xyl
     */
    public String queryParentFoodById(String foodId);

    /**
     * 查询所有样品种类
     *
     * @return
     */
    public List<BaseFoodType> queryAll();

    /**
     * 查询所有子种类IDS
     *
     * @param id
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public String querySubTypes(Integer id);

    /**
     * 根据名称模糊查询食品
     *
     * @param fName
     * @param isFood 0是食品种类，1是食品名称
     * @return
     * @author LuoYX
     * @date 2018年5月14日
     */
    public List<BaseFoodType> queryByFName(String fName, Integer isFood);

    /**
     * 查询所有的样品
     *
     * @return
     * @author LuoYX
     * @date 2018年5月30日
     */
    public List<Map<String, Object>> queryFoodTypeMap();

    /**
     * '
     * 微信端获取全部样品为食品的数据
     *
     * @return
     */
    public List<BaseFoodType> queryAllFood();

    /**
     * 根据父类ID查询数据
     *
     * @param parentId  父类ID
     * @param isFood    0是食品种类，1是食品名称
     * @return
     * @author wtt
     * @date 2018年8月22日
     */
    public List<BaseFoodType> selectByParentId(Integer parentId, Integer isFood);

    /**
     * 查询所选的食品类别是否还有下一级食品类别
     * @param id
     * @return
     * @author wtt
     * @date 2018年11月23日
     */
    public List<BaseFoodType> queryFoodTypeMap(Integer id);

    /**
     * 查询所选的食品类别是否还有下一级食品名称
     * @param id
     * @return
     */
    public List<BaseFoodType> queryFoodMap(Integer id);

    /**
     * 查询子样品
     *
     * @param id 样品ID
     * @return
     */
    public List<BaseFoodType> getAllSonFoodsByID(Integer id);

    /**
     * 查询该样品种类下最大编码
     *
     * @param foodCode 样品种类编码
     * @return
     */
    public String getLastFoodCode(String foodCode);

    /**
     * 查询子样品ID
     *
     * @param id 样品ID
     * @return
     */
    public List<Integer> querySonFoods(Integer id);

    /**
     * 根据上次更新时间查询需要从新生成首拼的样品
     *
     * @param lastUpdateTime
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月25日
     */
    public List<BaseFoodType> queryFoodByLastUpdateTime(String lastUpdateTime);

    /**
     * 通过检测项目ID获取样品信息(食品类型)
     *
     * @param itemId 检测项目ID
     * @return
     */
    public List<BaseFoodType> queryFoodByItemId(String itemId);

    /**
     * 查询二级样品种类，用于数据统计中默认加载二级样品数据
     *
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年12月13日
     */
    public BaseFoodType querySecondFoodType();

    /**
     * @return
     * @Description 开启新的线程处理生成样品编号
     * @Date 2020/11/03 14:10
     * @Author xiaoyl
     * @Param
     */
    public void resetFoodTypeCode(String[] ids, boolean cleanCode);

    /**
     * 重置所有样品编码
     *
     * @param foodId
     * @param cleanCode
     * @throws Exception
     */
    public void recursionResetFoodType(Integer foodId, boolean cleanCode) throws Exception;

    /**
     * 查询所有子样品ID，包括删除的样品
     *
     * @param id 样品ID
     * @return
     */
    public List<Integer> queryAllSonFoods(Integer id);

    /**
     * 获取最大排序
     * @param parentId 父样品ID
     * @return
     */
    public Integer queryMaxSorting(@Param("parentId")Integer parentId);

    /**
     * 新增修改食品
     * @param bean
     * @param isExtends 1继承上级检测项目
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public AjaxJson saveOrUpdateFood(BaseFoodType bean, String isExtends,TSUser user ) throws Exception;

    /**
    * @Description 根据样品ID查询该类下是否有样品种类，用于仪器端控制是否启用新增样品按钮
    * @Date 2022/07/28 11:19
    * @Author xiaoyl
    * @Param 
    * @return 
    */
    public int queryFoodTypeByID(Integer id);

    BaseFoodType queryFoodById(Integer id);
}
