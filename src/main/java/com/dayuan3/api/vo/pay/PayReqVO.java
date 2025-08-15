package com.dayuan3.api.vo.pay;

import lombok.Data;

/**
 * PayReqVO 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/24 15:05
 * @description 类的功能描述
 */
@Data
public class PayReqVO {
    public PayReqVO() {
    }

    public PayReqVO(String merOrderId, String payType, String terminalIp, short transactionType, String openId, Integer orderFees) {
        this.merOrderId = merOrderId;
        this.payType = payType;
        this.terminalIp = terminalIp;
        this.transactionType = transactionType;
        this.openId = openId;
        this.orderFees = orderFees;
    }

    public PayReqVO(Integer orderId, String payType, String terminalIp, Short transactionType) {
        this.orderId = orderId;
        this.payType = payType;
        this.terminalIp = terminalIp;
        this.transactionType = transactionType;
    }
    /**
     * 交易流水ID
     */
    private String merOrderId;
    /**
     * 抽样单ID
     */
    private Integer orderId;
    /**
     * 支付类型 PaymentType枚举类
     */
    private String payType;
    /**
     * IP
     */
    private String terminalIp;
    /**
     * 费用类型：0 检测费，1复检费，2 充值费用
     */
    private short transactionType;
    /**
     * 微信用户openId
     */
    private String openId;
    /**
     * 订单费用(检测费+复检费；单位：分)
     */
    private Integer orderFees;
    /**
     * 电子单号
     */
    private String orderNumber;
}
