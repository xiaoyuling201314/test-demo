package com.dayuan.service.data;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TbCheckPlan;
import com.dayuan.model.BaseModel;

import java.util.List;
import java.util.Map;

/**
* @author Dz
* @description 针对表【tb_check_plan(检测计划)】的数据库操作Service
* @createDate 2025-06-17 20:29:55
*/
public interface TbCheckPlanService extends IService<TbCheckPlan> {

    /**
     * 获取每日检测计划
     * @param dayOfWeek  星期几，1 表示周日，2 表示周一，以此类推
     * @param foodIds   食品ID列表
     * @return
     */
    List<Map<String, Object>> getPlans(int dayOfWeek, List<Integer> foodIds);

    Page loadDatagrid(Page page, BaseModel model);

    boolean deleteData(String id, Integer[] idas);

    int mySaveOrUpdate(TbCheckPlan bean);

    TbCheckPlan queryById(Integer id);
}
