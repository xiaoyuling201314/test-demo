package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseDetectModular;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * Description:检测模块
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月17日
 */
public interface BaseDetectModularMapper extends BaseMapper<BaseDetectModular, String> {

    List<BaseDetectModular> queryDetectModular();

    List<BaseDetectModular> queryAll();

    /**
     * 根据检测模块名称去查询校验唯一性
     *
     * @param detectModular
     * @return
     */
    BaseDetectModular selectByModular(@Param("detectModular") String detectModular, @Param("id") String id);
}