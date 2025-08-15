package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 仪器检测项目表
 * @TableName base_device_parameter
 */
@TableName(value ="base_device_parameter")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BaseDeviceParameter implements Serializable {
    /**
     * 主键ID
     */
    @TableId
    private String id;

    /**
     * 仪器类别id
     */
    private String deviceTypeId;

    /**
     * 检测项目id
     */
    private String itemId;

    /**
     * 检测模块
     */
    private String projectType;

    /**
     * 检测方法名称
     */
    private String detectMethod;

    /**
     * 检测值单位
     */
    private String detectUnit;

    /**
     * 仪器操作密码
     */
    private String operationPassword;

    /**
     * 样品编号
     */
    private String foodCode;

    /**
     * 检测无效值
     */
    private Double invalidValue;

    /**
     * 检查孔1
     */
    private Integer checkHole1;

    /**
     * 检查孔2
     */
    private Integer checkHole2;

    /**
     * 选择波长
     */
    private Integer wavelength;

    /**
     * 预热时间
     */
    private Integer preTime;

    /**
     * 检测时间
     */
    private Integer decTime;

    /**
     * 矫正曲线A
     */
    private Double stda;

    /**
     * 标准曲线1A0
     */
    private Double stda0;

    /**
     * 标准曲线1A1
     */
    private Double stda1;

    /**
     * 标准曲线1A2
     */
    private Double stda2;

    /**
     * 标准曲线1A3
     */
    private Double stda3;

    /**
     * 矫正曲线B
     */
    private Double stdb;

    /**
     * 标准曲线2B0
     */
    private Double stdb0;

    /**
     * 标准曲线2B1
     */
    private Double stdb1;

    /**
     * 标准曲线2B2
     */
    private Double stdb2;

    /**
     * 标准曲线2B3
     */
    private Double stdb3;

    /**
     * 国标值下限
     */
    private Double nationalStdmin;

    /**
     * 国标值上限
     */
    private Double nationalStdmax;

    /**
     * 阴性范围下限
     */
    private Double yinMin;

    /**
     * 阴性范围上限
     */
    private Double yinMax;

    /**
     * 阳性范围下限
     */
    private Double yangMin;

    /**
     * 阳性范围上限
     */
    private Double yangMax;

    /**
     * 阴性T>
     */
    private Double yint;

    /**
     * 阳性T<=
     */
    private Double yangt;

    /**
     * AbsX
     */
    private Double absx;

    /**
     * |C-T|>AbsX;0：阴性，1：阳性
     */
    private Integer ctabsx;

    /**
     * 分界值
     */
    private Double division;

    /**
     * 带入参数0:A ,1:B,2:C ,3D
     */
    private Integer parameter;

    /**
     * 连续下降沿点数C
     */
    private Double trailingedgec;

    /**
     * 连续下降沿点数T
     */
    private Double trailingedget;

    /**
     * 数据可疑Min
     */
    private Double suspiciousmin;

    /**
     * 数据可疑Max
     */
    private Double suspiciousmax;

    /**
     * 预留字段1
     */
    private String reserved1;

    /**
     * 预留字段2
     */
    private String reserved2;

    /**
     * 预留字段3
     */
    private String reserved3;

    /**
     * 预留字段4
     */
    private String reserved4;

    /**
     * 预留字段5
     */
    private String reserved5;

    /**
     * 备注
     */
    private String remark;

    /**
     * 删除状态
     */
    @TableLogic
    private Integer deleteFlag;

    /**
     * 创建人ID
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改时间
     */
    private Date updateDate;
    
    /*****************非数据库字段************************/
    @TableField(exist = false)
    private String itemName;			//检测项目名称

    @TableField(exist = false)
    private String errMsg;              //导入错误原因

}