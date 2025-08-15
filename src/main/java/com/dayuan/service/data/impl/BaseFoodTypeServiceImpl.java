package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.dataCheck.ImportDataCheckController;
import com.dayuan.mapper.data.BaseFoodItemMapper;
import com.dayuan.mapper.data.BaseFoodTypeMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.service.data.BaseFoodItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.GlobalConfig;
import com.dayuan.util.ReflectHelper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
* @author Dz
* @description 针对表【base_food_type(食品种类表)】的数据库操作Service实现
* @createDate 2025-06-13 11:01:18
*/
@Slf4j
@Service
public class BaseFoodTypeServiceImpl extends ServiceImpl<BaseFoodTypeMapper, BaseFoodType>
    implements BaseFoodTypeService {


    @Autowired
    private BaseFoodItemMapper foodItemMapper;
    @Autowired
    private BaseFoodItemService foodItemService;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final ExecutorService cacheThreadPool = Executors.newCachedThreadPool();



    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 根据食品种类ID查询二级食品信息
     *
     * @param id            样品ID
     * @param isShowFood    是否显示样品信息
     * @param isContainSelf 是否包括当前节点
     * @param attributes    自定义属性 add by xiaoyuling 2017-09-18
     * @return
     */
    public List<TreeNode> queryFoodTree(Integer id, Boolean isContainSelf, Boolean isShowFood, List<String> attributes) {
        List<TreeNode> trees = new ArrayList<TreeNode>();
        List<BaseFoodType> foodType = getBaseMapper().queryFoodByPid(id, isContainSelf, isShowFood);
        Map<String, Object> map = new HashMap<>();
        ReflectHelper reflectHelper = null;
        for (BaseFoodType food : foodType) {
            TreeNode tree = new TreeNode();
            tree.setId(food.getId() + "");
            tree.setText(food.getFoodName());
            tree.setParentId(food.getParentId() + "");
            if (attributes != null) {
                reflectHelper = new ReflectHelper(food);
                for (String attri : attributes) {
                    map.put(attri, reflectHelper.getMethodValue(attri));
                }
                tree.setAttributes(map);
            }

            if (food.getIsfood() == 0) {
                tree.setState("closed");
            }

            //食品类别，查询下级食品
//			if(food.getIsFood()==0){
//				List<BaseFoodType> childFood = getBaseMapper().queryFoodByPid(food.getId(),isContainSelf,isShowFood);
//				if(childFood!=null && childFood.size()>0){
//					tree.setState("closed");
//				}
//			}
            trees.add(tree);
        }
        return trees;
    }

    public List<TreeNode> queryFoodTrees(Integer id, Boolean isContainSelf, Boolean isShowFood, List<String> attributes) {
        List<TreeNode> trees = new ArrayList<TreeNode>();
        List<BaseFoodType> foodType = getBaseMapper().queryFoodByPid(id, isContainSelf, isShowFood);
        for (BaseFoodType food : foodType) {
            TreeNode tree = new TreeNode();
            tree.setId(food.getId() + "");
            tree.setText(food.getFoodName());
            tree.setParentId(food.getParentId() + "");
            List<BaseFoodType> childMenu = getBaseMapper().queryFoodByPid(food.getId(), null, isShowFood);
            if (childMenu != null && childMenu.size() > 0) {
                tree.setState("closed");
            }
            trees.add(tree);
        }
        return trees;
    }

    public List<Integer> queryFoodId(Integer foodId, List<Integer> foodArr) {

        return getBaseMapper().queryFoodId(foodId, foodArr);
    }

    /**
     * 根据食品类别ID加载食品分类列表信息（包括当前类别）
     *
     * @param id
     * @return
     */
    public List<BaseFoodType> queryFoodType(Integer id) {
        return getBaseMapper().queryFoodByPid(id, false, false);
    }

    /**
     * 查询类型ID为parentId下是否已存在相同的样品类别或样品信息
     *
     * @param foodName 样品名称
     * @param parentId 父类别ID
     * @return
     */
    public BaseFoodType queryByFoodName(String foodName, Integer parentId) {
        return getBaseMapper().queryByFoodName(foodName, parentId);
    }

    /**
     * 根据食品类别父ID统计子类信息
     *
     * @return
     */
    public int queryCount(String parentId) {
        return getBaseMapper().queryCountByPid(parentId);
    }

    /**
     * 删除食品信息和关联检测项目信息
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public BaseFoodType delete(Integer id) throws Exception {
        BaseFoodType food = getById(id);
        food.setDeleteFlag(1);
        PublicUtil.setCommonForTable(food, false);
        int count = 0;

        foodItemMapper.deteteByFoodId(id);
        count = getBaseMapper().deleteById(id);
        //刷新样品编码
//        resetFoodTypeCode(new String[]{String.valueOf(food.getParentId())}, true);
        return food;
    }

    public int updateByFoodPid(String[] ids, String parentId) {
        return getBaseMapper().updateByFoodPid(ids, parentId);

    }

    /**
     * 根据foodId向上查找父类样品ID
     *
     * @param foodId
     * @return
     * @author xyl
     */
    public String queryParentFoodById(String foodId) {
        return getBaseMapper().queryParentFoodById(foodId);
    }

    /**
     * 查询所有样品种类
     *
     * @return
     */
    public List<BaseFoodType> queryAll() {
        return getBaseMapper().queryAll();
    }

    /**
     * 查询所有子种类IDS
     *
     * @param id
     * @return
     * @author LuoYX
     * @date 2018年4月19日
     */
    public String querySubTypes(Integer id) {
        return getBaseMapper().querySubTypes(id);
    }

    /**
     * 根据名称模糊查询食品
     *
     * @param fName
     * @param isFood 0是食品种类，1是食品名称
     * @return
     * @author LuoYX
     * @date 2018年5月14日
     */
    public List<BaseFoodType> queryByFName(String fName, Integer isFood) {
        return getBaseMapper().queryByFName(fName, isFood);
    }

    /**
     * 查询所有的样品
     *
     * @return
     * @author LuoYX
     * @date 2018年5月30日
     */
    public List<Map<String, Object>> queryFoodTypeMap() {
        return getBaseMapper().queryAllMap();
    }

    /**
     * '
     * 微信端获取全部样品为食品的数据
     *
     * @return
     */
    public List<BaseFoodType> queryAllFood() {
        return getBaseMapper().queryAllFood();
    }

    /**
     * 根据父类ID查询数据
     *
     * @param parentId  父类ID
     * @param isFood    0是食品种类，1是食品名称
     * @return
     * @author wtt
     * @date 2018年8月22日
     */
    public List<BaseFoodType> selectByParentId(Integer parentId, Integer isFood) {
        return getBaseMapper().selectByParentId(parentId, isFood);

    }

    /**
     * 查询所选的食品类别是否还有下一级食品类别
     * @param id
     * @return
     * @author wtt
     * @date 2018年11月23日
     */
    public List<BaseFoodType> queryFoodTypeMap(Integer id) {
        return getBaseMapper().queryFoodTypeMap(id);
    }

    /**
     * 查询所选的食品类别是否还有下一级食品名称
     * @param id
     * @return
     */
    public List<BaseFoodType> queryFoodMap(Integer id) {
        return getBaseMapper().queryFoodMap(id);
    }

    /**
     * 查询子样品
     *
     * @param id 样品ID
     * @return
     */
    public List<BaseFoodType> getAllSonFoodsByID(Integer id) {
        BaseFoodType foodType = getById(id);
        if (foodType == null) {
            return null;
        }
        return getBaseMapper().queryByFoodCode(foodType.getFoodCode());
    }

    /**
     * 查询该样品种类下最大编码
     *
     * @param foodCode 样品种类编码
     * @return
     */
    public String getLastFoodCode(String foodCode) {
        return getBaseMapper().getLastFoodCode(foodCode);
    }

    /**
     * 查询子样品ID
     *
     * @param id 样品ID
     * @return
     */
    public List<Integer> querySonFoods(Integer id) {
        return getBaseMapper().querySonFoods(id);
    }

    /**
     * 根据上次更新时间查询需要从新生成首拼的样品
     *
     * @param lastUpdateTime
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月25日
     */
    public List<BaseFoodType> queryFoodByLastUpdateTime(String lastUpdateTime) {
        return getBaseMapper().queryFoodByLastUpdateTime(lastUpdateTime);
    }

    /**
     * 通过检测项目ID获取样品信息(食品类型)
     *
     * @param itemId 检测项目ID
     * @return
     */
    public List<BaseFoodType> queryFoodByItemId(String itemId) {
        return getBaseMapper().queryFoodByItemId(itemId);
    }

    /**
     * 查询二级样品种类，用于数据统计中默认加载二级样品数据
     *
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年12月13日
     */
    public BaseFoodType querySecondFoodType() {
        return getBaseMapper().querySecondFoodType();
    }

    /**
     * @return
     * @Description 开启新的线程处理生成样品编号
     * @Date 2020/11/03 14:10
     * @Author xiaoyl
     * @Param
     */
    public void resetFoodTypeCode(String[] ids, boolean cleanCode) {
        if (null != ids && ids.length > 0) {
            //开启新的线程执行样品编码生成操作
            cacheThreadPool.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        log.info("执行生成样品编号，开始时间：" + DateUtil.datetimeFormat.format(new Date()));
                        for (String foodId : ids) {
                            recursionResetFoodType(Integer.valueOf(foodId), cleanCode);
                        }
                    } catch (Exception e) {
                        log.error("执行生成样品编号异常，错误信息：" + e.getMessage());
                        log.error("执行生成样品编号异常，堆栈信息：" + e.getStackTrace());
                    } finally {
                        log.info("执行生成样品编号，结束时间：" + DateUtil.datetimeFormat.format(new Date()));
                    }
                }
            });
        }
    }

    /**
     * 重置所有样品编码
     *
     * @param foodId
     * @param cleanCode
     * @throws Exception
     */
    public synchronized void recursionResetFoodType(Integer foodId, boolean cleanCode) throws Exception {
        BaseFoodType foodType = getById(foodId);
        if (null == foodType) {
            return;
        }
        if (cleanCode) {
            //清空下级样品编码
            jdbcTemplate.update(" UPDATE base_food_type SET food_code=NULL WHERE food_code LIKE '" + foodType.getFoodCode() + "%' AND id != " + foodId);
        }
        List<BaseFoodType> subDeparts = this.selectByParentId(foodType.getId(), null);
        for (int i = 0; i < subDeparts.size(); i++) {
            //下级食品
            BaseFoodType d = subDeparts.get(i);

            String code = "";
            //0是食品种类,生成新编码
            if (0 == d.getIsfood()) {
                String lastCode = this.getLastFoodCode(foodType.getFoodCode());
                code = GlobalConfig.getInstance().getNextCode(4, lastCode, foodType.getFoodCode());

                //1是食品名称,使用上级编码
            } else if (1 == d.getIsfood()) {
                code = foodType.getFoodCode();
            }

            d.setFoodCode(code);
            this.updateById(d);
            recursionResetFoodType(d.getId(), false);
        }
    }
    /**
     * 查询所有子样品ID，包括删除的样品
     *
     * @param id 样品ID
     * @return
     */
    public List<Integer> queryAllSonFoods(Integer id) {
        return getBaseMapper().queryAllSonFoods(id);
    }

    /**
     * 获取最大排序
     * @param parentId 父样品ID
     * @return
     */
    public Integer queryMaxSorting(@Param("parentId")Integer parentId) {
        return getBaseMapper().queryMaxSorting(parentId);
    }

    /**
     * 新增修改食品
     * @param bean
     * @param isExtends 1继承上级检测项目
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public AjaxJson saveOrUpdateFood(BaseFoodType bean, String isExtends, TSUser user ) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        //已存在食品
        BaseFoodType food = queryByFoodName(bean.getFoodName(), bean.getParentId());
        //新增食品父类
        BaseFoodType pfood = getById(bean.getParentId());

        //新增数据
        if (null == bean.getId()) {
            //样品编码；食品种类生成新编码，食品名称使用上级编码；修改后，食品名称不再有数量限制 -Dz 20220228
            String code = "";
            switch (bean.getIsfood()) {
                //0是食品种类,生成新编码
                case 0:
                    String lastCode = getLastFoodCode(pfood.getFoodCode());
                    code = GlobalConfig.getInstance().getNextCode(4, lastCode, pfood.getFoodCode());
                    if(code.equals("0")){
                        jsonObject.setSuccess(false);
                        jsonObject.setMsg("该类别的下的食品种类已超过一万,无法继续添加,请联系管理员处理！");
//                        logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);
                        return jsonObject;
                    }
                    break;

                //1是食品名称,使用上级编码
                case 1:
                    code = pfood.getFoodCode();
                    break;

                default:
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("请选择样品种类类型！");
//                    logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);
                    return jsonObject;
            }

            List<BaseFoodType> list = queryFoodTypeMap(bean.getParentId());
            if(bean.getIsfood()==1&&list.size()>0){
                jsonObject.setSuccess(false);
                jsonObject.setMsg("该类别存在下级类别，不允许添加食品名称，请在它的下级类别添加！");
            }else{
                if (food == null) {
                    bean.setFoodCode(code);

                    //获取父类下最大序号
                    Integer nextSorting = queryMaxSorting(bean.getParentId());
                    //设置序号+1
                    bean.setSorting(++nextSorting);

                    PublicUtil.setCommonForTable(bean, true,user);
                    save(bean);

                    Integer FoodId= bean.getId();
                    if(isExtends!=null&&isExtends!=""&&bean.getParentId()!=null){
                        if(isExtends.equals("1")){
                            List<BaseFoodItem> lists=foodItemService.queryListByFoodId(bean.getParentId());
                            if (lists.size()>0) {
                                for (BaseFoodItem baseFoodItem : lists) {
                                    baseFoodItem.setFoodId(FoodId);
                                    PublicUtil.setCommonForTable(baseFoodItem, true,user);
                                }
                                foodItemService.insertBean(lists);
                            }
                        }
                    }
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该食品已存在，请重新输入");
                }
            }
//            logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品新增", jsonObject.isSuccess(), jsonObject.getMsg(),null,bean,request);

            // 修改数据
        } else {

            BaseFoodType oldFood = getById(bean.getId());

            if (oldFood == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("找不到样品数据！");
//                logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                return jsonObject;

                //食品移组
            } else if (oldFood.getParentId().intValue() != bean.getParentId().intValue()){
                if(bean.getIsfood()==1){
                    //获取新父类下的食品种类
                    List<BaseFoodType> list = queryFoodTypeMap(bean.getParentId());
                    if (list.size()>0) {
                        jsonObject.setSuccess(false);
                        jsonObject.setMsg("该食品类别存在下级类别，不允许添加食品名称，请在它的下级类别添加！");
//                        logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                        return jsonObject;
                    }

                }else if (bean.getIsfood()==0) {
                    //获取新父类下的食品名称
                    List<BaseFoodType> list2 = queryFoodMap(bean.getParentId());
                    if (list2.size()>0) {
                        jsonObject.setSuccess(false);
                        jsonObject.setMsg("该食品类别下面存在食品名称，不允许添加食品类别！");
//                        logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                        return jsonObject;
                    }
                }
            }

            // 获取当前食品类别和其下级食品类别ID
            List<BaseFoodType> sFoods = getAllSonFoodsByID(bean.getId());
            List<Integer> sfoodIds = new ArrayList<Integer>();
            if(sFoods !=null && sFoods.size()>0) {
                for(BaseFoodType sDepart : sFoods) {
                    sfoodIds.add(sDepart.getId());
                }
            }
            if (bean.getIsfood()==0 && sfoodIds.contains(bean.getParentId())) {
                // 所属食品类别为当前类别或其下级食品类别
                jsonObject.setSuccess(false);
                jsonObject.setMsg("所属食品类别不能为当前类别或其下级食品类别");
//                logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                return jsonObject;

            } else {
                if (food == null || bean.getId().intValue() == food.getId().intValue()) {

                    //样品编码；食品种类生成新编码，食品名称使用上级编码；修改后，食品名称不再有数量限制 -Dz 20220228
                    String code = oldFood.getFoodCode();
                    switch (bean.getIsfood()) {
                        //0是食品种类,生成新编码
                        case 0:
                            if (oldFood.getParentId().intValue() != bean.getParentId().intValue()) {
                                String lastCode = getLastFoodCode(pfood.getFoodCode());
                                code = GlobalConfig.getInstance().getNextCode(4, lastCode, pfood.getFoodCode());
                                if(code.equals("0")){
                                    jsonObject.setSuccess(false);
                                    jsonObject.setMsg("该类别的下的食品种类已超过一万,无法继续添加,请联系管理员处理！");
//                                    logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                                    return jsonObject;
                                }
                            }
                            break;

                        //1是食品名称,使用上级编码
                        case 1:
                            code = pfood.getFoodCode();
                            break;

                        default:
                            jsonObject.setSuccess(false);
                            jsonObject.setMsg("请选择样品种类类型！");
//                            logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
                            return jsonObject;
                    }

                    bean.setFoodCode(code);
                    PublicUtil.setCommonForTable(bean, false,user);
                    updateById(bean);

                    //刷新食品编码
                    if (oldFood.getParentId().intValue() != bean.getParentId().intValue()) {
                        resetFoodTypeCode(new String[]{bean.getParentId().toString()}, true);
                    }

                    //继承上级检测项目
                    if (isExtends!=null&&isExtends!=""&&bean.getParentId()!=null) {
                        if(isExtends.equals("1")){
                            List<BaseFoodItem> lists=foodItemService.queryListByFoodId(bean.getParentId());
                            if (lists.size()>0) {
                                for (BaseFoodItem baseFoodItem : lists) {
                                    int baseFoodItems=foodItemService.selectByFoodId(bean.getId(),baseFoodItem.getItemId());
                                    if(baseFoodItems==0){
                                        baseFoodItem.setFoodId(bean.getId());
                                        PublicUtil.setCommonForTable(baseFoodItem, true,user);
                                        foodItemService.save(baseFoodItem);
                                    }
                                }
                            }
                        }
                    }

                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该食品已存在，请重新输入");
                    return jsonObject;
                }
            }
//            logUtil.saveOperatorLog2(ModularConstant.OPERATION_FOOD, BaseFoodTypeController.class.toString(), "save", "样品修改", jsonObject.isSuccess(), jsonObject.getMsg(),oldFood,bean,request);
        }

        //更新样品库的时候，重置内存中的样品集合
        ImportDataCheckController.foodMap=null;

        //用于记录操作日志
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("id", bean.getId());
        jsonObject.setAttributes(map);

        return jsonObject;
    }
    /**
     * @Description 根据样品ID查询该类下是否有样品种类，用于仪器端控制是否启用新增样品按钮
     * @Date 2022/07/28 11:19
     * @Author xiaoyl
     * @Param
     * @return
     */
    public int queryFoodTypeByID(Integer id) {
        return getBaseMapper().queryFoodTypeByID(id);
    }

    @Override
    public BaseFoodType queryFoodById(Integer id) {
        return getBaseMapper().queryFoodById(id);
    }

}




