package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author xiaoyl
 */
@ApiModel("经营单位信息")
@Data
public class InspectionUnitRespVo {
    @ApiModelProperty(value = "ID", example = "1")
    private Integer id;

    @ApiModelProperty(value = "冷链单位ID", example = "")
    private Integer coldUnitId;

    @ApiModelProperty(value = "冷链单位名称", example = "")
    private String coldUnitName;

    @ApiModelProperty(value = "单位名称", example = "")
    private String companyName;

    @ApiModelProperty(value = "仓口编号", example = "001")
    private String companyCode;

    @ApiModelProperty(value = "单位类型：0企业，1个人", example = "0")
    private Short companyType;

    @ApiModelProperty(value = "社会信用代码/身份证号码/经营户身份证号")
    private String creditCode;


    @ApiModelProperty(value = "法定代表人")
    private String legalPerson;

    @ApiModelProperty(value = "法人联系方式")
    private String legalPhone;


    @ApiModelProperty(value = "详细地址")
    private String companyAddress;

    @ApiModelProperty(value = "联系人")
    private String linkUser;

    @ApiModelProperty(value = "联系方式")
    private String linkPhone;

    @ApiModelProperty(value = "附件地址")
    private String filePath;

}
