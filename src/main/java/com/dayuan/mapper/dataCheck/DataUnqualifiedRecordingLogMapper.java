package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.dataCheck.DataUnqualifiedRecordingLog;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

public interface DataUnqualifiedRecordingLogMapper extends BaseMapper<DataUnqualifiedRecordingLog, Integer> {

    void deleteLog(@Param("ids") Integer[] ids, @Param("userId") String userId);

}