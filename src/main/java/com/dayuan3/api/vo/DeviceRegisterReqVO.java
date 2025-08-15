package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @author Dz
 */
@ApiModel(description = "设备注册入参")
@Data
public class DeviceRegisterReqVO {

    @ApiModelProperty(value = "仪器系列", required = true, example = "LZ-7000")
    @NotBlank(message = "请输入仪器系列")
    private String series;

    @ApiModelProperty(value = "仪器mac地址", required = true, example = "E4:3A:6E:00:6E:4E")
    @NotBlank(message = "请输入仪器mac地址")
    private String mac;

    @ApiModelProperty(value = "出厂编码", example = "35000(I)_20190821001")
    private String deviceCode;

}
