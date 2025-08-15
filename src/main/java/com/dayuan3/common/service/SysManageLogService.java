package com.dayuan3.common.service;

import com.dayuan.bean.Page;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.SysPayLog;
import com.dayuan3.common.mapper.SysManageLogMapper;
import com.dayuan3.common.model.SysOperationLogModel;
import com.dayuan3.common.model.SysPayLogModel;
import com.dayuan3.common.model.SysPrintLogModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysManageLogService extends BaseService<SysPayLog, Integer> {
    @Autowired
    private SysManageLogMapper mapper;

    @Override
    public BaseMapper<SysPayLog, Integer> getMapper() {
        return mapper;
    }


    /**
     * 用户操作日志数据查询
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadOperationLogDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(mapper.getOperationRowTotal(page));
        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }
        List<SysOperationLogModel> dataList = mapper.loadOperationDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 报告打印日志数据查询
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadPrintLogDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(mapper.getPrintRowTotal(page));
        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }
        List<SysPrintLogModel> dataList = mapper.loadPrintDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 付款日志数据查询
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadPayLogDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);
        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(mapper.getPayRowTotal(page));
        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));
        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            page.setRowOffset(page.getRowOffset());
            page.setRowTail(page.getRowTail());
        }
        List<SysPayLogModel> dataList = mapper.loadPayDatagrid(page);
        page.setResults(dataList);
        return page;
    }
}
