package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@ApiModel("仪器登录认证出参")
@Data
@AllArgsConstructor
public class DeviceLoginRespVo {

    @ApiModelProperty(value = "sa-token", example = "bb22bbe9-8aa9-4e24-a4f4-52a26c219b07")
    private String token;

    @ApiModelProperty(value = "昵称", example = "陈**")
    private String realname;

    @ApiModelProperty(value = "机构", example = "A区市场监管局")
    private String departName;

    @ApiModelProperty(value = "检测点", example = "A-1检测室")
    private String pointName;

}
