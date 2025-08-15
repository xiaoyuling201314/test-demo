package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("样品检测项目检测参数压缩数据")
@Data
public class FoodItemZipRespVo {

    @ApiModelProperty(value = "样品检测项目ID", example = "1")
    private Integer id;

    @ApiModelProperty(value = "样品ID", example = "2321")
    private Integer foodId;

//    @ApiModelProperty(value = "食品名称", example = "皮皮虾")
//    private String foodName;

    @ApiModelProperty(value = "检测项目ID", example = "2c922b9a6321056d01632ad6efb70e85")
    private String itemId;

//    @ApiModelProperty(value = "检测项目名称", example = "敌敌畏")
//    private String itemName;

    @ApiModelProperty(value = "检测标准判定符号", example = "<")
    private String detectSign;

    @ApiModelProperty(value = "检测标准值", example = "50")
    private String detectValue;

    @ApiModelProperty(value = "检测标准值单位", example = "%")
    private String detectValueUnit;

}
