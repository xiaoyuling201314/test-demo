package com.dayuan3.api.vo.check;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@ApiModel("获取检测任务出参")
@Data
@AllArgsConstructor
public class CheckTaskRespVO {

    @ApiModelProperty(value = "订单明细ID", example = "3725")
    private Integer id;

    @ApiModelProperty(value = "样品条码", example = "A5200000001-1")
    private String sampleCode;

    @ApiModelProperty(value = "样品ID", example = "3214")
    private Integer foodId;

    @ApiModelProperty(value = "样品名称", example = "白菜")
    private String foodName;

    @ApiModelProperty(value = "检测项目ID", example = "cfbb4a8d0e584c9db28bd26ac500d876")
    private String itemId;

    @ApiModelProperty(value = "检测项目名称", example = "有机磷和氨基甲酸酯类农药残留")
    private String itemName;

    @ApiModelProperty(value = "检测依据",  example = "GB/T 5009.199-2003")
    private String checkAccord;

    @ApiModelProperty(value = "限定值",  example = "≤50")
    private String limitValue;

    @ApiModelProperty(value = "检测结果单位",  example = "%")
    private String checkUnit;

}
