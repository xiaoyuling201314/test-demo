package com.dayuan3.admin.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan3.admin.bean.SplitAmount;
import com.dayuan3.admin.service.SplitAmountService;
import com.dayuan3.common.mapper.SplitAmountMapper;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * <p>
 * 分账记录表 服务实现类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-18
 */
@Service
public class SplitAmountServiceImpl extends ServiceImpl<SplitAmountMapper, SplitAmount>
        implements SplitAmountService {


    @Override
    public SplitAmount queryByNumber(String merOrderId) {
        LambdaQueryWrapper<SplitAmount> queryWrapper= Wrappers.lambdaQuery(SplitAmount.class)
                .eq(SplitAmount::getNumber,merOrderId);
        return getOne(queryWrapper);
    }

    @Override
    public List<SplitAmount> query2ReceivedOrder(Date time) {
        LambdaQueryWrapper<SplitAmount> queryWrapper= Wrappers.lambdaQuery(SplitAmount.class)
                .eq(SplitAmount::getStatus,1)
                .eq(SplitAmount::getReceiveStatus,0)
                .gt(SplitAmount::getCreateDate,time);
        return getBaseMapper().selectList(queryWrapper);
    }
}
