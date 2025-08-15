package com.dayuan3.api.vo;

import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.RoundingMode;
import java.util.Date;

@ApiModel("分页交易记录数据")
@Data
public class IncomePageRespVo {

    @ApiModelProperty(value = "ID", example = "1")
    private Integer id;

    @ApiModelProperty(value = "付款方式:0微信，1支付宝，2余额", example = "0")
    private String payType;

    @ApiModelProperty(value = "费用类型:0_检测费用, 1_复检费用, 2_充值费用, 3_订单退款, 4_充值退款", example = "0")
    private String transactionType;

    @ApiModelProperty(value = "金额（元）", example = "10.5")
    private String money;
    /**
     * 获取格式化后的金额（保留两位小数并带千分位）
     */
    public String getMoney() {
        if (StrUtil.isNotBlank(money)) {
            try {
                double fee = NumberUtil.div(Float.parseFloat(money), 100, 2, RoundingMode.HALF_UP);
                return String.valueOf(fee);
            } catch (Exception e) {
                return "";
            }
        } else {
            return "";
        }
    }

    @ApiModelProperty(value = "交易时间", example = "2025-07-02 12:11:32")
    private Date payDate;

    @ApiModelProperty(value = "交易状态(0_待支付,1_成功,2_失败,3_关闭)", example = "1")
    private String status;

}
