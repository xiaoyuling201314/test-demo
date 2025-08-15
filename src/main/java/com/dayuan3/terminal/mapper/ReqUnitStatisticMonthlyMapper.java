package com.dayuan3.terminal.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.ReqUnitStatisticMonthly;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReqUnitStatisticMonthlyMapper extends BaseMapper<ReqUnitStatisticMonthly, Integer> {

    ReqUnitStatisticMonthly selectByDate(@Param("date") String date, @Param("unitId") Integer unitId);

    List<ReqUnitStatisticMonthly> selectByDate2(@Param("start") String start, @Param("end") String end, @Param("unitId") Integer unitId);

}