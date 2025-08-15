package com.dayuan3.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan3.admin.bean.SplitAmount;

import java.util.Date;
import java.util.List;

/**
 * <p>
 * 分账记录表 服务类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-18
 */
public interface SplitAmountService extends IService<SplitAmount> {

    SplitAmount queryByNumber(String merOrderId);
    /**
     * Description 查询近3天所有待确认收货的的分账订单
     * @Author xiaoyl
     * @Date 2025/7/19 16:55
     */
    List<SplitAmount> query2ReceivedOrder(Date time);
}
