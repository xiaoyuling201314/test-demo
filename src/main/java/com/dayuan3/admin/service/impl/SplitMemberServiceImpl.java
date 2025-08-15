package com.dayuan3.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import com.dayuan3.admin.bean.SplitMember;
import com.dayuan3.admin.mapper.SplitMemberMapper;
import com.dayuan3.admin.service.SplitMemberService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 分账子商户编号管理 服务实现类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-21
 */
@Service
public class SplitMemberServiceImpl extends ServiceImpl<SplitMemberMapper, SplitMember> implements SplitMemberService {

    @Override
    public List<SplitMember> querySplitMember() {
        LambdaQueryWrapper<SplitMember> queryWrapper = Wrappers.lambdaQuery(SplitMember.class)
                .eq(SplitMember::getDeleteFlag, 0);
        return getBaseMapper().selectList(queryWrapper);
    }

    @Override
    public int mySaveOrUpdate(SplitMember bean) {
        bean.setMbUserId(bean.getMbUserId().trim());
        SplitMember school0 = getByMbUserId(bean.getMbUserId());
        if (school0 != null) {
            if (bean.getId() == null || school0.getId().intValue() != bean.getId().intValue()) {
                //学校名称重复
                return -2;
            }
        }
        saveOrUpdate(bean);
        return 1;
    }

    @Override
    public SplitMember getByMbUserId(String mbUserId) {
        LambdaQueryWrapper<SplitMember> queryWrapper = Wrappers.lambdaQuery(SplitMember.class)
                .eq(SplitMember::getMbUserId, mbUserId)
                .eq(SplitMember::getDeleteFlag, 0);
        return getOne(queryWrapper);
    }

    @Override
    public Page loadDatagrid(Page page, BaseModel t) {
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
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }
        List<SplitMember> dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    @Override
    public boolean deleteData(String userId, Integer[] idas) {
        LambdaUpdateWrapper<SplitMember> updateWrapper = Wrappers.lambdaUpdate(SplitMember.class)
                .in(SplitMember::getId, idas)
                .set(SplitMember::getUpdateBy, userId)
                .set(SplitMember::getDeleteFlag, 1);
       return update(updateWrapper);
    }
}
