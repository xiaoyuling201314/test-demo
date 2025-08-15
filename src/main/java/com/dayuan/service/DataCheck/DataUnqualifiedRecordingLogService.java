package com.dayuan.service.DataCheck;

import com.dayuan.bean.dataCheck.DataUnqualifiedRecordingLog;
import com.dayuan.mapper.dataCheck.DataUnqualifiedRecordingLogMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * 不合格数据
 *
 * @author Dz
 */
@Service
public class DataUnqualifiedRecordingLogService extends BaseService<DataUnqualifiedRecordingLog, Integer> {


    @Autowired
    private DataUnqualifiedRecordingLogMapper mapper;

    public DataUnqualifiedRecordingLogMapper getMapper() {
        return mapper;
    }

    public void deleteLog(Integer[] ids, String userId) {
        mapper.deleteLog(ids,userId);
    }

}
