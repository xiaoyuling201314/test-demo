package com.dayuan3.terminal.mapper;

import com.dayuan.bean.Page;
import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.OrderStatisticDaily;
import com.dayuan3.terminal.bean.RequesterUnit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderStatisticDailyMapper extends BaseMapper<OrderStatisticDaily, Integer> {

    OrderStatisticDaily selectByDate(@Param("date")String date);

    List<OrderStatisticDaily> selectByDate2(@Param("start") String start, @Param("end") String end);

    List<RequesterUnit> getRequesterList(@Param("orderNo") String orderNo, @Param("requestIds") Integer[] requestIds);
    
    List<RequesterUnit> getRequesterLists(Page page);
}