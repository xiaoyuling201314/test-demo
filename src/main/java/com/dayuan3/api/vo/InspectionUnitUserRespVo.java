package com.dayuan3.api.vo;

import com.dayuan3.admin.bean.InspectionUnitUser;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * Description 用户登录返回信息
 *
 * @Author xiaoyl
 * @Date 2025/6/18 8:34
 */
@ApiModel("用户注册")
@Data
public class InspectionUnitUserRespVo {
    @ApiModelProperty(value = "用户token", example = "")
    private String token;

    @ApiModelProperty(value = "用户相关信息", example = "")
    private InspectionUnitUser user;

    @ApiModelProperty(value = "经营单位", example = "")
    private InspectionUnitRespVo respUnit;

    @ApiModelProperty(value = "菜单权限", example = "")
    private List<TSFunctionRespVo> menuList;
}