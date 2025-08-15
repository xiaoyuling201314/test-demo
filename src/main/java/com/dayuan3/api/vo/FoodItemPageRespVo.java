package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("食品与检测项目数据")
@Data
public class FoodItemPageRespVo {

    @ApiModelProperty(value = "食品ID", example = "1")
    private Integer foodId;

    @ApiModelProperty(value = "食品名称", example = "黄瓜")
    private String foodName;

    @ApiModelProperty(value = "食品别名", example = "青瓜")
    private String foodAlias;

    @ApiModelProperty(value = "检测项目ID", example = "f686744c02094faf91e10600c99aa67f")
    private String itemId;

    @ApiModelProperty(value = "检测项目名称", example = "克百威")
    private String itemName;

    @ApiModelProperty(value = "检测项目费用(元)", example = "38.5")
    private String price;

}
