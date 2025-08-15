package com.dayuan3.common.mapper;

import com.dayuan.bean.Page;
import com.dayuan.mapper.BaseMapper;
import com.dayuan3.common.bean.SysPayLog;
import com.dayuan3.common.model.SysOperationLogModel;
import com.dayuan3.common.model.SysPayLogModel;
import com.dayuan3.common.model.SysPrintLogModel;

import java.util.List;

/**
 * 系统日志管理
 *
 * @author shit
 * @date 2019年9月17日
 */
public interface SysManageLogMapper extends BaseMapper<SysPayLog, Integer> {

    int getOperationRowTotal(Page page);

    List<SysOperationLogModel> loadOperationDatagrid(Page page);

    int getPrintRowTotal(Page page);

    List<SysPrintLogModel> loadPrintDatagrid(Page page);

    int getPayRowTotal(Page page);

    List<SysPayLogModel> loadPayDatagrid(Page page);

}