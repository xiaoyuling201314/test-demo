package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("冷链单位信息")
@Data
public class ColdChainUnitRespVo {
    @ApiModelProperty(value = "ID", example = "1")
    private Integer id;

    @ApiModelProperty(value = "单位名称", example = "")
    private String regName;

    @ApiModelProperty(value = "所属组织机构ID", example = "")
    private Integer departId;

    @ApiModelProperty(value = "单位类型", example = "0 企业，1 个人")
    private Integer regType;

    @ApiModelProperty(value = "统一社会信用代码", example = "")
    private String creditCode;

    @ApiModelProperty(value = "企业名称", example = "")
    private String companyName;

    @ApiModelProperty(value = "法人名称", example = "")
    private String legalPerson;

    @ApiModelProperty(value = "法人联系方式", example = "")
    private String legalPhone;

    @ApiModelProperty(value = "联系人", example = "")
    private String linkUser;

    @ApiModelProperty(value = "联系方式", example = "")
    private String linkPhone;

    @ApiModelProperty(value = "联系人身份证", example = "")
    private String linkIdCard;

    @ApiModelProperty(value = "所属区域id", example = "")
    private Double regionId;

    @ApiModelProperty(value = "详细地址", example = "")
    private String regAddress;

    @ApiModelProperty(value = "坐标x，经度", example = "")
    private String placeX;

    @ApiModelProperty(value = "坐标y，纬度", example = "")
    private String placeY;
}
