package com.dayuan3.api.vo;

import com.dayuan.bean.BaseBean;
import com.dayuan.bean.system.TSOperation;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * Description 菜单返回对象
 * @Author xiaoyl
 * @Date 2025/6/18 8:54
 */
@ApiModel("菜单权限")
@Data
public class TSFunctionRespVo {

    @ApiModelProperty(value = "主键：id", example = "")
    private Integer id;

    @ApiModelProperty(value = "菜单名称", example = "")
    private String functionName;

    @ApiModelProperty(value = "菜单图标", example = "")
    private String functionIcon;

    @ApiModelProperty(value = "菜单访问URL", example = "")
    private String functionUrl;

    @ApiModelProperty(value = "排序", example = "")
    private Short sorting;
}