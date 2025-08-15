package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("食品压缩数据")
@Data
public class FoodZipRespVo {

    @ApiModelProperty(value = "食品ID",  required = true,  example = "1")
    private Integer id;

    @ApiModelProperty(value = "食品名称",  required = true,  example = "皮皮虾")
    private String foodName;

    @ApiModelProperty(value = "食品别名",  required = true,  example = "虾姑、琵琶虾")
    private String foodNameOther;

}
