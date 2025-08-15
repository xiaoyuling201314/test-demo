package com.dayuan.mapper.data;

import java.util.List;

import com.dayuan.bean.data.BaseHandle;
import com.dayuan.mapper.BaseMapper;

/**
 * 不合格处理选择
 * @author Bill
 *
 * 2017年7月31日
 */
public interface BaseHandleMapper extends BaseMapper<BaseHandle, String> {
 
    List<BaseHandle> selectList();
}