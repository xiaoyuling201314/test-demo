package com.dayuan.bean.sampling;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 抽检单明细表
 * @TableName tb_sampling_detail
 */
@TableName(value ="tb_sampling_detail")
@Data
public class TbSamplingDetail implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 订单ID
     */
    private Integer samplingId;

    /**
     * 样品条码
     */
    private String sampleCode;

    /**
     * 检测项目ID
     */
    private String itemId;

    /**
     * 检测项目名称
     */
    private String itemName;

    /**
     * 食品种类ID
     */
    private Integer foodId;

    /**
     * 食品种类名称
     */
    private String foodName;

    /**
     * 抽样数量（克）
     */
    private Integer sampleNumber;

    /**
     * 进货数量（克）
     */
    private Integer purchaseAmount;

    /**
     * 进货日期
     */
    private Date purchaseDate;

    /**
     * 产地
     */
    private String origin;

    /**
     * 规格
     */
    private String specs;

    /**
     * 批号
     */
    private String batchNumber;

    /**
     * 供货商
     */
    private String supplier;

    /**
     * 供货商地址
     */
    private String supplierAddress;

    /**
     * 供货商联系人
     */
    private String supplierPerson;

    /**
     * 供货商联系电话
     */
    private String supplierPhone;

    /**
     * 收样人ID
     */
    private String collectUserid;

    /**
     * 收样人名称
     */
    private String collectUsername;

    /**
     * 收样时间
     */
    private Date collectTime;

    /**
     * 试管编码（可删除？）
     */
    private String sampleTubeCode;

    /**
     * 打印样品码时间
     */
    private Date printCodeTime;
    /**
     * 打印样品码次数
     */
    private Short printCodeNum=0;

    /**
     * 是否复检：0首次检测，1已复检（报告隐藏状态1数据）
     */
    private Integer isRecheck;

    /**
     * 复检原样品ID
     */
    private Integer recheckDetailId;

    /**
     * 检测费用（单位：分）
     */
    private Integer inspectionFee;

    /**
     * 检测任务状态：0未接收，1已接收，2已检测
     */
    private Integer recevieStatus;

    /**
     * 检测任务接收设备
     */
    private String recevieDevice;

    /**
     * 上机时间
     */
    private Date operatingTime;

    /**
     * 备注
     */
    private String remark;

    /**
     * 预留参数1
     */
    private String param1;

    /**
     * 预留参数2
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;

    /**************非数据库字段****************************/

    @TableField(exist = false)
    private String opeShopCode;     //档口编号

    @TableField(exist = false)
    private String conclusion;	    //检测结果

    @TableField(exist = false)
    private Integer supplierId;//来源id 可为空, 仅当为订单详情时使用 huht 2019-7-23

    @TableField(exist = false)
    private String tubeCode1;	    //试管码1

    @TableField(exist = false)
    private Date tubeCodeTime1;	    //试管码1扫码时间

    @TableField(exist = false)
    private String tubeCode2;	    //试管码2

    @TableField(exist = false)
    private Date tubeCodeTime2;	    //试管码2扫码时间

    @TableField(exist = false)
    private Integer sno;    //序号

}