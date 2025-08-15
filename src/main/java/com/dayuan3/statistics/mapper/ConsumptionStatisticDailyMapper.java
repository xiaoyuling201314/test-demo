package com.dayuan3.statistics.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.statistics.bean.ConsumptionStatisticDaily;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConsumptionStatisticDailyMapper extends BaseMapper<ConsumptionStatisticDaily, Integer> {

    List<ConsumptionStatisticDaily> selectByDate(@Param("date")String date, @Param("userId")Integer userId);

    List<ConsumptionStatisticDaily> selectByDate2(@Param("start") String start, @Param("end") String end, @Param("userId")Integer userId);

}