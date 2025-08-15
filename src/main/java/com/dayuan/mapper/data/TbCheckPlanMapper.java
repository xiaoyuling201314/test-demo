package com.dayuan.mapper.data;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TbCheckPlan;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* @author Dz
* @description 针对表【tb_check_plan(检测计划)】的数据库操作Mapper
* @createDate 2025-06-17 20:29:55
* @Entity com.dayuan.bean.data.TbCheckPlan
*/
public interface TbCheckPlanMapper extends BaseMapper<TbCheckPlan> {

    /**
     * 获取每日检测计划
     * @param dayOfWeek  星期几，1 表示周日，2 表示周一，以此类推
     * @param foodIds   食品ID列表
     * @return
     */
    List<Map<String, Object>> getPlans(@Param("dayOfWeek") int dayOfWeek, @Param("foodIds")List<Integer> foodIds);

    int getRowTotal(Page page);

    List<TbCheckPlan> loadDatagrid(Page page);

    TbCheckPlan queryById(Integer id);
}




