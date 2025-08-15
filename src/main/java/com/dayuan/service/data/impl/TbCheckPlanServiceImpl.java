package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TbCheckPlan;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.mapper.data.TbCheckPlanMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.system.TSOperationModel;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.data.TbCheckPlanService;
import com.dayuan3.admin.bean.SplitMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
* @author Dz
* @description 针对表【tb_check_plan(检测计划)】的数据库操作Service实现
* @createDate 2025-06-17 20:29:55
*/
@Service
public class TbCheckPlanServiceImpl extends ServiceImpl<TbCheckPlanMapper, TbCheckPlan>
    implements TbCheckPlanService{

    @Autowired
    BaseFoodTypeService foodTypeService;

    @Override
    public List<Map<String, Object>> getPlans(int dayOfWeek, List<Integer> foodIds) {
        return getBaseMapper().getPlans(dayOfWeek, foodIds);
    }

    @Override
    public Page loadDatagrid(Page page, BaseModel model) {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(model);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));
        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }
        List<TbCheckPlan> dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    @Override
    public int mySaveOrUpdate(TbCheckPlan bean) {
        LambdaQueryWrapper<TbCheckPlan> queryWrapper = Wrappers.lambdaQuery(TbCheckPlan.class)
                .eq(TbCheckPlan::getFoodId, bean.getFoodId());
        TbCheckPlan checkBean=getOne(queryWrapper);
        //样品配置重复，进行提醒
        if(null!=bean.getId() &&  !checkBean.getId().equals(bean.getId())){
            return -1;
        }
        saveOrUpdate(bean);
        return 1;
    }

    @Override
    public boolean deleteData(String userId, Integer[] idas) {
        LambdaUpdateWrapper<TbCheckPlan> updateWrapper = Wrappers.lambdaUpdate(TbCheckPlan.class)
                .in(TbCheckPlan::getId, idas)
                .set(TbCheckPlan::getUpdateBy, userId)
                .set(TbCheckPlan::getDeleteFlag, 1);
        return update(updateWrapper);
    }

    @Override
    public TbCheckPlan queryById(Integer id) {
        return getBaseMapper().queryById(id);
    }
}




