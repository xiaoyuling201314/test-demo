package com.dayuan.mapper.dataCheck;

import java.util.List;

import com.dayuan.bean.Page;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.mapper.BaseMapper;

public interface DataUnqualifiedConfigMapper extends BaseMapper<DataUnqualifiedConfig, Integer> {
    /**
     * 处置方法
     * @param page	分页参数
     * @return	处置方法列表
     */
    List<DataUnqualifiedConfig> loadDatagrid1(Page page);
    
    /**
     * 处置方法查询记录总数量
     * @param page
     * @return
     */
    int getRowTotal(Page page);
    
    /**
     * 获取所有处置信息
     * @return
     */
	List<DataUnqualifiedConfig> getList();
}