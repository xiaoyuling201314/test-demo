package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodItem;
import com.dayuan.mapper.data.BaseFoodItemMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.data.BaseFoodItemService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Dz
* @description 针对表【base_food_item(食品种类检测项目表)】的数据库操作Service实现
* @createDate 2025-06-23 14:12:08
*/
@Service
public class BaseFoodItemServiceImpl extends ServiceImpl<BaseFoodItemMapper, BaseFoodItem>
    implements BaseFoodItemService {



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
     * 根据样品ID查询检测项目
     * @param ids
     * @return
     * @throws Exception
     */
    public List<BaseFoodItem> queryByList(String[] ids) throws Exception {
        return getBaseMapper().queryByList(ids);
    }

    public List<BaseFoodItem> queryList(BaseFoodItem baseFoodItem,String[] ids){
        return getBaseMapper().queryList(baseFoodItem,ids);
    }

    public int insertBean(List<BaseFoodItem> list){
        return getBaseMapper().insertBean(list);
    }

    public int selectByFoodId(Integer foodId,String itemId){
        return getBaseMapper().selectByFoodId(foodId, itemId);
    }

    public BaseFoodItem queryByFoodItem(Integer foodId,String itemId){
        return getBaseMapper().queryByFoodItem(foodId, itemId);
    }

    /**
     * 根据食品id查询检测项目集合
     * @param foodId
     * @return
     */
    public List<BaseFoodItem> queryListByFoodId(Integer foodId){
        return getBaseMapper().queryListByFoodId(foodId);
    }
    /**
     * 删除样品种类的检测项目时同时删除子类的配置
     * @description
     * @param itemId
     * @param foodIds
     * @return
     * @author xiaoyl
     * @date   2020年7月20日
     */
    public int deleteBatch(String itemId, List<Integer> foodIds) {
        return  getBaseMapper().deleteBatch(itemId,foodIds);
    }

}




