package com.dayuan3.api.vo;

import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.RoundingMode;
import java.util.Date;

@ApiModel("待取样订单数据")
@Data
public class ToSampleOrderRespVo {

    @ApiModelProperty(value = "订单ID", example = "1")
    private Integer id;

    @ApiModelProperty(value = "电子单号", example = "A5200000001")
    private String orderNumber;

    @ApiModelProperty(value = "订单类型：1_自助下单，2_电子抽样", example = "1")
    private Integer orderType;

    @ApiModelProperty(value = "下单时间", example = "")
    private Date orderTime;

    @ApiModelProperty(value = "订单状态:1_待支付,2_已支付,3_已完成,4_取消,5_检测中,6_复检中", example = "")
    private Integer orderStatus;

    @ApiModelProperty(value = "订单费用(检测费+复检费；单位：元)", example = "")
    private String orderFees;
    /**
     * 获取格式化后的订单费用（保留两位小数并带千分位）
     */
    public String getOrderFees() {
        if (StrUtil.isNotBlank(orderFees)) {
            try {
                double fee = NumberUtil.div(Float.parseFloat(orderFees), 100, 2, RoundingMode.HALF_UP);
                return String.valueOf(fee);
            } catch (Exception e) {
                return "";
            }
        } else {
            return "";
        }
    }

//    @ApiModelProperty(value = "下单用户ID", example = "")
//    private Integer orderUserid;

    @ApiModelProperty(value = "下单用户名称", example = "")
    private String orderUsername;

    @ApiModelProperty(value = "下单用户手机号码", example = "")
    private String orderUserPhone;

    @ApiModelProperty(value = "车牌号码", example = "")
    private String carNumber;

    @ApiModelProperty(value = "司机姓名", example = "")
    private String driverName;

    @ApiModelProperty(value = "司机手机号码", example = "")
    private String driverPhone;

//    @ApiModelProperty(value = "冷库ID", example = "")
//    private Integer ccuId;

    @ApiModelProperty(value = "冷库名称", example = "")
    private String ccuName;

//    @ApiModelProperty(value = "仓号ID", example = "")
//    private Integer iuId;

    @ApiModelProperty(value = "仓号名称", example = "")
    private String iuName;

    @ApiModelProperty(value = "备注", example = "")
    private String remark;

}
