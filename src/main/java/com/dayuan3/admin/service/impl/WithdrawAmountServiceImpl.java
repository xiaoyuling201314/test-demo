package com.dayuan3.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.dayuan3.admin.bean.WithdrawAmount;
import com.dayuan3.admin.mapper.WithdrawAmountMapper;
import com.dayuan3.admin.service.WithdrawAmountService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 提现记录表 服务实现类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-19
 */
@Service
public class WithdrawAmountServiceImpl extends ServiceImpl<WithdrawAmountMapper, WithdrawAmount> implements WithdrawAmountService {

    @Override
    public WithdrawAmount queryByNumber(String number) {
        LambdaQueryWrapper<WithdrawAmount> queryWrapper= Wrappers.lambdaQuery(WithdrawAmount.class)
                .eq(WithdrawAmount::getNumber,number);
        return getOne(queryWrapper);
    }
}
