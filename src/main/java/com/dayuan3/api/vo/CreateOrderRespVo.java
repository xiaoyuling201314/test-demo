package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@ApiModel("新增订单返回数据")
@Data
@AllArgsConstructor
public class CreateOrderRespVo {

    @ApiModelProperty(value = "订单ID",  required = true,  example = "10981")
    private Integer id;

}
