package com.dayuan3.admin.service;

import com.dayuan3.admin.bean.WithdrawAmount;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 提现记录表 服务类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-19
 */
public interface WithdrawAmountService extends IService<WithdrawAmount> {

    WithdrawAmount queryByNumber(String merOrderId);
}
