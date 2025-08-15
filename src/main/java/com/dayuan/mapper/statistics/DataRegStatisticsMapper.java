package com.dayuan.mapper.statistics;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dayuan.bean.statistics.DataRegStatistics;
import com.dayuan.mapper.BaseMapper;

public interface DataRegStatisticsMapper extends BaseMapper<DataRegStatistics, Integer> {
	
	/**
	 * 批量新增
	 * @return
	 */
    int insertList(List<DataRegStatistics> list);
    
    /**
     * 根据机构和月份获取市场统计
     * @param departId 机构ID
     * @param regId 监管对象ID
     * @param yyyyMM 年月
     * @return
     */
    List<DataRegStatistics> queryByDepart(@Param("departId")Integer departId, @Param("regId")Integer regId, @Param("yyyyMM")String yyyyMM);
    
    /**
     * 获取当月统计记录数量
     * @author Dz
     * 2019年3月14日 上午10:59:49
     * @param yyyyMM
     * @return
     */
    int queryNumByYm(@Param("yyyyMM")String yyyyMM);
}