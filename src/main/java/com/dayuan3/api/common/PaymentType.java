package com.dayuan3.api.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Description 汇付支付类型枚举类
 *
 * @Author xiaoyl
 * @Date 2025/6/23 16:24
 */
@Getter
@AllArgsConstructor
public enum PaymentType {
    WX_JSAPI("微信公众号支付", "WX_JSAPI"),
    WX_MINI("微信小程序支付", "WX_MINI"),
    WX_CB("微信C扫B", "WX_CB"),
    WX_PAYSCORE("微信支付分", "WX_PAYSCORE"),
    ALI_CB("支付宝C扫B", "ALI_CB"),
    ALI_JSAPI("支付宝生活号", "ALI_JSAPI"),
    ALI_MINI("支付宝小程序", "ALI_MINI"),
    ALI_APP("支付宝APP", "ALI_APP"),
    ALI_H5("支付宝H5支付", "ALI_H5"),
    SCAN("付款码支付", "SCAN"),
    B2C("个人网银支付", "B2C"),
    B2B("企业网银支付", "B2B"),
    FAST_PAY("快捷支付", "FAST_PAY"),
    BALANCE("余额支付", "BALANCE"),
    UNIONPAY_CB("银联云闪付C扫B", "UNIONPAY_CB"),
    UNIONPAY_SDK("银联云闪付SDK支付", "UNIONPAY_SDK"),
    BANK_TRANSFER("银行转账支付", "BANK_TRANSFER");

    /**
     * 支付方式名称
     */
    private final String name;

    /**
     * 支付方式代码
     */
    private final String code;


    /**
     * 根据支付代码查找支付类型
     */
    public static PaymentType fromCode(String code) {
        for (PaymentType type : PaymentType.values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("无效的支付类型代码: " + code);
    }
}
