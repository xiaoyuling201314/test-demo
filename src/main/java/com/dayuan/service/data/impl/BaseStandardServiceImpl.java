package com.dayuan.service.data.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseStandard;
import com.dayuan.mapper.data.BaseStandardMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.service.data.BaseStandardService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Dz
* @description 针对表【base_standard(检测标准)】的数据库操作Service实现
* @createDate 2025-06-24 00:46:54
*/
@Service
public class BaseStandardServiceImpl extends ServiceImpl<BaseStandardMapper, BaseStandard>
    implements BaseStandardService {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 查询最后一个标准编号
     * @author xyl
     * @return
     */
    public String queryLastCode() {
        return getBaseMapper().queryLastCode();
    }

    /**
     * 根据标准名称查询是否存在重复的数据
     * @param standardName 标准名称
     * @return
     */
    public BaseStandard queryByStandardName(String standardName) {
        return getBaseMapper().queryByStandardName(standardName);
    }

    /**
     * 查询所有的检测标准
     * @author xyl
     * @return
     */
    public List<BaseStandard> queryAll() {
        return getBaseMapper().queryAll();
    }

}




