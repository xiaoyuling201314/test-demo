package com.dayuan3.api.vo;

import com.dayuan.bean.BaseBean2;
import com.dayuan.util.StringUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * Description  用户注册
 * @Author xiaoyl
 * @Date 2025/6/17 15:11
 */
@ApiModel("用户注册")
@Data
public class InspectionUnitUserReqVo {
    @ApiModelProperty(value = "用户ID，编辑的时候传递", example = "",required = false)
    private Integer id;

    @ApiModelProperty(value = "类型：0企业，1个人", example = "",required = true)
    private Short companyType;

    @ApiModelProperty(value = "用户姓名", example = "",required = false)
    private String realName;

    @ApiModelProperty(value = "手机号码", example = "",required = true)
    @NotNull(message = "请输入手机号码")
    private String phone;

    @ApiModelProperty(value = "密码，MD5加密一次", example = "",required = true)
    @NotNull(message = "请输入密码")
    private String password;

    @ApiModelProperty(value = "冷链单位ID，个人注册的时候传：-1", example = "")
    private Integer coldUnitId;

    //经营单位信息
    @ApiModelProperty(value = "经营单位ID，修改的时候传递", example = "",required = false)
    private Integer inspectionId;

    @ApiModelProperty(value = "仓口编号", example = "")
    @NotNull(message = "请输入仓口编号或用户姓名")
    private String companyCode;

    @ApiModelProperty(value = "单位名称", example = "",required = false)
    private String companyName;

    @ApiModelProperty(value = "社会信用代码/身份证号码/经营户身份证号", example = "",required = false)
    private String creditCode;

    @ApiModelProperty(value = "法定代表人", example = "",required = false)
    private String legalPerson;

    @ApiModelProperty(value = "法人联系方式", example = "",required = false)
    private String legalPhone;

}