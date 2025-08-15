package com.dayuan3.api.vo;

import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.RoundingMode;
import java.util.List;

@ApiModel("费用统计数据")
@Data
@AllArgsConstructor
public class CostStatisticsRespVo {

    @ApiModelProperty(value = "本月 支出|充值 费用（元）", example = "142.6")
    private String cost;
    /**
     * 获取格式化后的金额（保留两位小数并带千分位）
     */
    public String getCost() {
        if (StrUtil.isNotBlank(cost)) {
            try {
                double fee = NumberUtil.div(Float.parseFloat(cost), 100, 2, RoundingMode.HALF_UP);
                return String.valueOf(fee);
            } catch (Exception e) {
                return "";
            }
        } else {
            return "";
        }
    }

    @ApiModelProperty(value = "本月 支出|充值 次数", example = "8")
    private long times;

    @ApiModelProperty(value = "每月费用统计")
    private List<monthly> monthly;

    @Data
    @AllArgsConstructor
    public static class monthly {

        @ApiModelProperty(value = "统计月份", example = "2025-07")
        private String ym;

        @ApiModelProperty(value = "统计月份 支出|充值 费用（元）", example = "92.4")
        private String cost;
        /**
         * 获取格式化后的金额（保留两位小数并带千分位）
         */
        public String getCost() {
            if (StrUtil.isNotBlank(cost)) {
                try {
                    double fee = NumberUtil.div(Float.parseFloat(cost), 100, 2, RoundingMode.HALF_UP);
                    return String.valueOf(fee);
                } catch (Exception e) {
                    return "";
                }
            } else {
                return "";
            }
        }
    }

}
