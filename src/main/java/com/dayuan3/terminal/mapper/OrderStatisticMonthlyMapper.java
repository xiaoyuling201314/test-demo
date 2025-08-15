package com.dayuan3.terminal.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.OrderStatisticMonthly;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderStatisticMonthlyMapper extends BaseMapper<OrderStatisticMonthly, Integer> {

    OrderStatisticMonthly selectByDate(@Param("date")String date);

    List<OrderStatisticMonthly> selectByDate2(@Param("start") String start, @Param("end") String end);

}