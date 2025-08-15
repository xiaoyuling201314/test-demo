package com.dayuan3.api.vo;

import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.Date;
import java.util.List;

@ApiModel("订单详细数据")
@Data
public class OrderInfoRespVo {

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

    @ApiModelProperty(value = "交易流水号", example = "")
    private String payNumber;
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

    @ApiModelProperty(value = "是否取样：0_待接收，1_待取样，2_已取样", example = "")
    private Integer isSampling;

//    @ApiModelProperty(value = "取样人ID", example = "")
//    private Integer samplingUserid;

    @ApiModelProperty(value = "取样人姓名", example = "")
    private String samplingUsername;

    @ApiModelProperty(value = "取样时间", example = "")
    private Date samplingTime;

    @ApiModelProperty(value = "取样拍照（多个以,隔开）", example = "")
    private String samplingPhotos;

    @ApiModelProperty(value = "备注", example = "")
    private String remark;

    @ApiModelProperty(value = "订单检测项")
    private List<OrderDetail> orderDetails;

    @Data
    public class OrderDetail {
        @ApiModelProperty(value = "订单检测项ID", example = "1")
        private Integer id;

        @ApiModelProperty(value = "样品条码", example = "A5200000001-1")
        private String sampleCode;

        @ApiModelProperty(value = "检测结果（合格/不合格）", example = "合格")
        private String conclusion;

//        @ApiModelProperty(value = "检测项目ID")
//        private String itemId;

        @ApiModelProperty(value = "检测项目名称", example = "克百威")
        private String itemName;

//        @ApiModelProperty(value = "食品种类ID")
//        private Integer foodId;

        @ApiModelProperty(value = "食品种类名称", example = "白菜")
        private String foodName;

//        @ApiModelProperty(value = "抽样数量（克）")
//        private Integer sampleNumber;

        @ApiModelProperty(value = "进货数量（KG）", example = "10.5")
        private String purchaseAmount;
        /**
         * 获取格式化后的进货数量（保留两位小数并带千分位）
         */
        public String getPurchaseAmount() {
            if (StrUtil.isNotBlank(purchaseAmount)) {
                try {
                    double pa = NumberUtil.div(Float.parseFloat(purchaseAmount), 1000, 2, RoundingMode.HALF_UP);
                    return String.valueOf(pa);
                } catch (Exception e) {
                    return "";
                }
            } else {
                return "";
            }
        }


//        @ApiModelProperty(value = "进货日期")
//        private Date purchaseDate;
//
//        @ApiModelProperty(value = "产地")
//        private String origin;
//
//        @ApiModelProperty(value = "规格")
//        private String specs;
//
//        @ApiModelProperty(value = "批号")
//        private String batchNumber;
//
//        @ApiModelProperty(value = "供货商")
//        private String supplier;
//
//        @ApiModelProperty(value = "供货商地址")
//        private String supplierAddress;
//
//        @ApiModelProperty(value = "供货商联系人")
//        private String supplierPerson;
//
//        @ApiModelProperty(value = "供货商联系电话")
//        private String supplierPhone;
//
//        @ApiModelProperty(value = "收样人ID")
//        private String collectUserid;

        @ApiModelProperty(value = "收样人名称")
        private String collectUsername;

        @ApiModelProperty(value = "收样时间")
        private Date collectTime;

//        @ApiModelProperty(value = "试管编码（可删除？）")
//        private String sampleTubeCode;

        @ApiModelProperty(value = "预处理时间")
        private Date pretreatmentTime;

//        @ApiModelProperty(value = "是否复检：0首次检测，1已复检（报告隐藏状态1数据）")
//        private Integer isRecheck;

//        @ApiModelProperty(value = "复检原样品ID")
//        private Integer recheckDetailId;

        @ApiModelProperty(value = "检测费用（单位：元）")
        private String inspectionFee;
        /**
         * 获取格式化后的订单费用（保留两位小数并带千分位）
         */
        public String getInspectionFee() {
            if (StrUtil.isNotBlank(inspectionFee)) {
                try {
                    double fee = NumberUtil.div(Float.parseFloat(inspectionFee), 100, 2, RoundingMode.HALF_UP);
                    return String.valueOf(fee);
                } catch (Exception e) {
                    return "";
                }
            } else {
                return "";
            }
        }

        @ApiModelProperty(value = "检测任务状态：0未接收，1已接收，2已检测")
        private Integer recevieStatus;

        @ApiModelProperty(value = "检测任务接收设备")
        private String recevieDevice;

        @ApiModelProperty(value = "上机时间")
        private Date operatingTime;

        @ApiModelProperty(value = "备注")
        private String remark;
    }

}
