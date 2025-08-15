package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.mapper.data.BaseDetectItemMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @author Dz
* @description 针对表【base_detect_item(检测项目表)】的数据库操作Service实现
* @createDate 2025-06-13 16:12:14
*/
@Service
public class BaseDetectItemServiceImpl extends ServiceImpl<BaseDetectItemMapper, BaseDetectItem>
    implements BaseDetectItemService {

    @Autowired
    private BaseFoodTypeService baseFoodTypeService;


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
     * 查询最后一个系统编号
     * @author xyl
     * @return
     */
    public String queryLastCode() {
        return getBaseMapper().queryLastCode();
    }
    /**
     * 根据检测项目名称和检测标准查询数据
     * @author xyl
     * @param bean
     * @return
     */
    public BaseDetectItem queryByDetectNameAndStandard(BaseDetectItem bean) {
        return getBaseMapper().queryByDetectNameAndStandard(bean);
    }

    /**
     * 根据检测项目类型查询数据
     * @author Dz
     * @param typeid
     * @return
     */
    public List<BaseDetectItem> queryByTypeid(String typeid) {
        return getBaseMapper().queryByTypeid(typeid);
    }
    /**
     * 根据样品ID递归向上查询所有关联的检测项目列表
     * （查询当前样品及所有父类样品的检测项目并去重）
     * @param foodId 样品ID
     * @return
     * @author xyl 2017-09-13
     */
    public List<BaseDetectItem> queryByFoodId(String[] foodId)throws Exception {
        return getBaseMapper().queryByFoodId(foodId);
    }

    /**
     * 根据样品ID向下递归查询所有关联的检测项目列表
     * （查询当前样品及所有子类样品的检测项目并去重）
     * @param foodId 样品ID
     * @return
     */
    public List<BaseDetectItem> queryByFoodId2(Integer foodId)throws Exception {
        BaseFoodType f = baseFoodTypeService.getById(foodId);
        if (f != null) {
            //食品种类
            if (f.getIsfood() == 0) {
                return getBaseMapper().queryByFoodId2(null, f.getFoodCode());

                //食品名称
            } else if (f.getIsfood() == 1) {
                return getBaseMapper().queryByFoodId2(foodId, null);
            }
        }
        return new ArrayList();
    }

    /**
     * 根据检测模块ID、样品ID递归向下查询所有关联的检测项目列表
     * @param childFoodIds 父级/子级样品ID字符串
     * @param itemTypeId 检测模块ID
     */
    public List<BaseDetectItem> queryByItemType(String childFoodIds, String itemTypeId)throws Exception {
		/*String childFoodIds = baseFoodTypeService.queryChildFoodById(foodId);
		if(StringUtil.isEmpty(childFoodIds)){
			return null;
		}*/
        String[] childFoodIdArray = null;
        if(StringUtil.isNotEmpty(childFoodIds)) {
            childFoodIdArray = childFoodIds.split(",");
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("childFoodIdArray", childFoodIdArray);
        map.put("itemTypeId", itemTypeId);
        return getBaseMapper().queryByItemType(map);
    }
    /**
     * 根据检测项目名称查询检测项目
     */
    public List<BaseDetectItem> queryByItemName(String itemName) {
        return getBaseMapper().queryByItemName(itemName);
    }

    /**
     * 根据检测项目名称查询检测项目
     */
    public BaseDetectItem queryOneByItemName(String itemName) {
        return getBaseMapper().queryOneByItemName(itemName);
    }

    /**
     * 查询所有检测项目
     * @return
     * @author LuoYX
     * @date 2018年5月30日
     */
    public List<Map<String, Object>> queryItemMap() {
        return getBaseMapper().queryItemMap();
    }

    /**
     * 查询所有检测项目
     * @return
     */
    public List<BaseDetectItem> queryAll() {
        return getBaseMapper().queryAll();
    }

    /**
     * huht 2019-8-28
     * 查询全部可用检测项目 id为空查询全部 不为空则查活动的检测项目
     * @return
     */
    public	List<BaseDetectItem> queryAllByChecked(String[] offerId){
        return getBaseMapper().queryAllByChecked(offerId);

    }
    /**
     * 查询所有可用检测项目的ID，用于新增优惠活动应用所有项目时使用
     * @description
     * @return
     * @author xiaoyl
     * @date   2020年4月9日
     */
    public	String queryAllIDs(){
        return getBaseMapper().queryAllIds();

    }
    /**
     * 根据检测项目名称查询检测项目
     */
    public BaseDetectItem queryByItemNames(String[] itemName) {
        return getBaseMapper().queryByItemNames(itemName);
    }

    @Override
    public BaseDetectItem queryItemById(String itemId) {
        return getBaseMapper().queryItemById(itemId);
    }

}




