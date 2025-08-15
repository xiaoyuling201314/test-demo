package com.dayuan3.api.vo.pay;

import com.dayuan3.admin.bean.SplitMember;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * PayReqVO 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/24 15:05
 * @description 类的功能描述
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SplitAmountReqVO {
    /**
     * 原支付请求单号，income表的number
     */
    private String originalMerOrderId;

    /**
     * 分账订单号
     */
    private String merOrderId;

    /**
     * 待分账金额
     */
    private Integer splitMoney;
    /**
     * 子商户管理
     */
    private List<SplitMember> splitMembers;
}
