package com.dayuan.util.pdf;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @Description: 生成电子报告pdf数据
 * @author Dz
 */
@Data
@AllArgsConstructor
public class ReportData {

    /**
     * 电子单号
     */
    private String orderNumber;

    /**
     * 送样时间（取样时间）
     */
    private Date samplingTime;

    /**
     * 冷库名称
     */
    private String ccuName;

    /**
     * 仓号名称
     */
    private String iuName;

    /**
     * 下单用户手机号码
     */
    private String orderUserPhone;

    /**
     * 车牌号码
     */
    private String carNumber;

    /**
     * 检测报告二维码
     */
    private String qrCode;

    /**
     * 检测报告详情
     */
    private List<Detail> details;

    /**
     * 报告日期
     */
    private Date reportTime;

    @Data
    @AllArgsConstructor
    public static class Detail {
        /**
         * 样品名称
         */
        private String foodName;

        /**
         * 检测项目名称
         */
        private String itemName;

        /**
         * 检测结论
         */
        private String conclusion;
    }

}
