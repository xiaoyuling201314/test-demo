package com.dayuan.mapper.log;

import com.dayuan.bean.log.TSErrorLog;
import com.dayuan.mapper.BaseMapper;

import java.util.List;

/**
 * 仪器错误日志
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年5月4日
 */
public interface TSErrorLogMapper extends BaseMapper<TSErrorLog, String> {

    /**
     * 查询错误日志中存在的所有仪器类型
     * @return
     */
    List<String> selectAlldeviceType();
}