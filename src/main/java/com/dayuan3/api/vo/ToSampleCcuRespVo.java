package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("待取样冷库汇总数据")
@Data
public class ToSampleCcuRespVo {

    @ApiModelProperty(value = "冷库ID", example = "1")
    private Integer ccuId;

    @ApiModelProperty(value = "冷库名称", example = "壹号冷库")
    private String ccuName;

    @ApiModelProperty(value = "冷库地址", example = "广州市黄埔区")
    private String address;

    @ApiModelProperty(value = "冷库经纬度", example = "23.432623,54.423623")
    private String locationXY;

    @ApiModelProperty(value = "待取样订单数量", example = "5")
    private int orderQuantity;

    @ApiModelProperty(value = "待取样品数量", example = "16")
    private int sampleQuantity;;

}
