package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("仪器检测项目压缩数据")
@Data
public class DeviceItemZipRespVo {

    @ApiModelProperty(value = "仪器项目检测配置ID", example = "cfbb4a8d0e584c9db28bd26ac500d8761")
    private String id;

//    @ApiModelProperty(value = "仪器类别ID", example = "5")
//    private String deviceTypeId;

    @ApiModelProperty(value = "检测项目ID", example = "ba044f5919714f8c99364f3d9d307357")
    private String itemId;

    @ApiModelProperty(value = "检测模块", example = "分光光度")
    private String projectType;

    @ApiModelProperty(value = "检测方法", example = "标准曲线法")
    private String detectMethod;

    @ApiModelProperty(value = "检测值单位", example = "g/100mL")
    private String detectUnit;

    @ApiModelProperty(value = "仪器操作密码", example = "")
    private String operationPassword;

    @ApiModelProperty(value = "样品编号", example = "")
    private String foodCode;

    @ApiModelProperty(value = "检测无效值", example = "")
    private Double invalidValue;

    @ApiModelProperty(value = "检查孔1", example = "")
    private Integer checkHole1;

    @ApiModelProperty(value = "检查孔2", example = "")
    private Integer checkHole2;

    @ApiModelProperty(value = "选择波长", example = "")
    private Integer wavelength;

    @ApiModelProperty(value = "预热时间(s)", example = "3")
    private Integer preTime;

    @ApiModelProperty(value = "检测时间(s)", example = "180")
    private Integer decTime;

    @ApiModelProperty(value = "标准曲线1A0", example = "")
    private Double stda0;

    @ApiModelProperty(value = "标准曲线1A1", example = "")
    private Double stda1;

    @ApiModelProperty(value = "标准曲线1A2", example = "")
    private Double stda2;

    @ApiModelProperty(value = "标准曲线1A3", example = "")
    private Double stda3;

    @ApiModelProperty(value = "标准曲线2B0", example = "")
    private Double stdb0;

    @ApiModelProperty(value = "标准曲线2B1", example = "")
    private Double stdb1;

    @ApiModelProperty(value = "标准曲线2B2", example = "")
    private Double stdb2;

    @ApiModelProperty(value = "标准曲线2B3", example = "")
    private Double stdb3;

    @ApiModelProperty(value = "矫正曲线A", example = "")
    private Double stda;

    @ApiModelProperty(value = "矫正曲线B", example = "")
    private Double stdb;

    @ApiModelProperty(value = "国标值下限", example = "")
    private Double nationalStdmin;

    @ApiModelProperty(value = "国标值上限", example = "")
    private Double nationalStdmax;

    @ApiModelProperty(value = "阴性范围下限", example = "")
    private Double yinMin;

    @ApiModelProperty(value = "阴性范围上限", example = "")
    private Double yinMax;

    @ApiModelProperty(value = "阳性范围下限", example = "")
    private Double yangMin;

    @ApiModelProperty(value = "阳性范围上限", example = "")
    private Double yangMax;

    @ApiModelProperty(value = "阴性T>", example = "")
    private Double yint;

    @ApiModelProperty(value = "阳性T<=", example = "")
    private Double yangt;

    @ApiModelProperty(value = "AbsX", example = "")
    private Double absx;

    @ApiModelProperty(value = "|C-T|>AbsX;0：阴性，1：阳性", example = "")
    private Integer ctabsx;

    @ApiModelProperty(value = "分界值", example = "")
    private Double division;

    @ApiModelProperty(value = "带入参数0:A ,1:B,2:C ,3D", example = "")
    private Integer parameter;

    @ApiModelProperty(value = "连续下降沿点数C", example = "")
    private Double trailingedgec;

    @ApiModelProperty(value = "连续下降沿点数T", example = "")
    private Double trailingedget;

    @ApiModelProperty(value = "数据可疑Min", example = "")
    private Double suspiciousmin;

    @ApiModelProperty(value = "数据可疑Max", example = "")
    private Double suspiciousmax;

    @ApiModelProperty(value = "预留字段1", example = "")
    private String reserved1;

    @ApiModelProperty(value = "预留字段2", example = "")
    private String reserved2;

    @ApiModelProperty(value = "预留字段3", example = "")
    private String reserved3;

    @ApiModelProperty(value = "预留字段4", example = "")
    private String reserved4;

    @ApiModelProperty(value = "预留字段5", example = "")
    private String reserved5;

    @ApiModelProperty(value = "备注", example = "")
    private String remark;

}
