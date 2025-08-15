package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @author Dz
 */
@ApiModel(description = "设备登录认证入参")
@Data
public class DeviceLoginReqVO {

    @ApiModelProperty(value = "账号", required = true, example = "cs001")
    @NotBlank(message = "请输入账号")
    private String username;

    @ApiModelProperty(value = "密码(明文密码MD5加密一次，32位大写)", required = true, example = "29AD0E3FD3DB681FB9F8091C756313F7")
    @NotBlank(message = "请输入密码")
    private String password;

}
