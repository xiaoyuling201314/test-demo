package com.dayuan.util;

import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * 模板工具类,shit创建
 * Created by dy on 2018/8/6.
 */
public class TemplateUtil {


    public static Page getPage(Page page,BaseModel t){
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);
        return page;
    }
    //查询分页的模板方法
    public static Page page(Page page, BaseModel t, Integer totalPage) {
        page.setRowTotal(totalPage);
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
        return page;
    }

    //查询分页的模板方法
    public static Page page2(Page page, List<T> dataList) {
        page.setResults(dataList);
        return page;
    }
}
