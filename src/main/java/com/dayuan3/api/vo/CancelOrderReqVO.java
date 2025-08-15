package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @author Dz
 */
@ApiModel(description = "取消订单参数")
@Data
public class CancelOrderReqVO {

    @ApiModelProperty(value = "订单ID", required = true, example = "1")
    @NotNull(message = "请输入订单ID")
    private Integer id;

}
