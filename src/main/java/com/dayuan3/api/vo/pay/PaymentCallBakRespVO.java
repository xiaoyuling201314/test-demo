package com.dayuan3.api.vo.pay;

import com.trhui.mallbook.domain.response.SplitList;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.List;

/**
 * PaymentCallBakRespVO 类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/24 10:47
 * @description 类的功能描述
 */
@ApiModel("支付成功回调通知")
@Data
public class PaymentCallBakRespVO {
    //渠道订单号
    private String channelOrderId;
    //请求订单号
    private String merOrderId;
    //交易金额
    private String amount;
    //官方订单号
    private String outTransId;

    //官方商户订单号
    private String partyOrderId;
    //付款时间
    private String payFinishTime;

    //交易状态:0：待处理；1：成功；2：失败
    private String status;

    //分账方列表
    private List<SplitList> splitList;
    //自定义参数1
    private  String parameter1;
    //自定义参数2
    private String parameter2;
}
