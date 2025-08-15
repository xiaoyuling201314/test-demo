package com.dayuan3.api.vo.check;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author Dz
 */
@ApiModel(description = "拒绝检测任务入参")
@Data
public class RejectTaskReqVO {

    @ApiModelProperty(value = "订单明细ID", required = true, example = "3725")
    @NotNull(message = "订单明细ID不能为空")
    private Integer id;

    @ApiModelProperty(value = "仪器唯一标识", example = "DY-3500(I)_202506241311520219")
    @NotBlank(message = "仪器唯一标识不能为空")
    private String serialNumber;

}
