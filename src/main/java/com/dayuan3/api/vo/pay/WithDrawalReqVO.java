package com.dayuan3.api.vo.pay;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * WithDrawalReqVO 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/7/19 11:14
 * @description 类的功能描述
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WithDrawalReqVO {
    /**
     * 结算订单号
     */
    private String merOrderId;
    /**
     * 子商户编号
     */
    private String userId;
    /**
     * 结算金额
     */
    private String amount;

}
