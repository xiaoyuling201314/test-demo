package com.dayuan.mapper.system;

import com.dayuan.bean.system.Scheduled;
import com.dayuan.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

public interface ScheduledMapper extends BaseMapper<Scheduled, Integer>{

    Scheduled selectById(Integer id);

    List<Map<String,Object>> selectDepart();

    List<Scheduled> queryAllEnableSchedule();

}