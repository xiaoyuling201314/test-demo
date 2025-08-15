package com.dayuan.mapper.dataCheck;

import com.dayuan.bean.dataCheck.DataCheckRecordingAddendum;
import com.dayuan.mapper.BaseMapper;

public interface DataCheckRecordingAddendumMapper extends BaseMapper<DataCheckRecordingAddendum, Integer> {

    int updateByRid(DataCheckRecordingAddendum addendum);

}