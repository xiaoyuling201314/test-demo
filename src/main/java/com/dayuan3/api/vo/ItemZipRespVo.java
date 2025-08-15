package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("检测项目压缩数据")
@Data
public class ItemZipRespVo {

    @ApiModelProperty(value = "检测项目ID", example = "cfbb4a8d0e584c9db28bd26ac500d8761")
    private String id;

    @ApiModelProperty(value = "检测项目名称", example = "有机磷和氨基甲酸酯类农药残留")
    private String itemName;

    @ApiModelProperty(value = "检测标准判定符号", example = "≤")
    private String detectSign;

    @ApiModelProperty(value = "检测标准值", example = "50")
    private String detectValue;

    @ApiModelProperty(value = "检测标准值单位", example = "%")
    private String detectValueUnit;

    @ApiModelProperty(value = "检测标准ID", example = "5432")
    private Integer standardId;

    @ApiModelProperty(value = "检测标准编号", example = "GB 5009.12-2017")
    private String standardCode;

    @ApiModelProperty(value = "检测标准名称", example = "GB 5009.12-2017 食品安全国家标准 食品中铅的测定")
    private String standardName;

}
