package com.dayuan.bean.sampling;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.dayuan.bean.sampling.TbSamplingDetail;
import lombok.Data;

/**
 * 抽检单表
 * @TableName tb_sampling
 */
@TableName(value ="tb_sampling")
@Data
public class TbSampling implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 机构ID（可删除?）
     */
    private Integer departId;

    /**
     * 检测点ID（可删除?）
     */
    private Integer pointId;

    /**
     * 电子单号
     */
    private String orderNumber;

    /**
     * 订单类型：1_自助下单，2_电子抽样
     */
    private Integer orderType;

    /**
     * 订单创建时间
     */
    private Date orderTime;

    /**
     * 订单状态:1_待支付,2_已支付,3_已完成,4_取消,5_检测中,6_复检中
     */
    private Integer orderStatus;

    /**
     * 订单费用(检测费+复检费；单位：分)
     */
    private Integer orderFees;

    /**
     * 下单用户ID
     */
    private Integer orderUserid;

    /**
     * 下单用户名称
     */
    private String orderUsername;

    /**
     * 下单用户手机号码
     */
    private String orderUserPhone;

    /**
     * 车牌号码
     */
    private String carNumber;

    /**
     * 司机姓名
     */
    private String driverName;

    /**
     * 司机手机号码
     */
    private String driverPhone;

    /**
     * 冷库ID
     */
    private Integer ccuId;

    /**
     * 冷库名称
     */
    private String ccuName;

    /**
     * 仓号ID
     */
    private Integer iuId;

    /**
     * 仓号名称
     */
    private String iuName;

    /**
     * 是否取样：0_待接收(停用，不用接收)，1_待取样，2_已取样
     */
    private Integer isSampling;

    /**
     * 取样人ID
     */
    private Integer samplingUserid;

    /**
     * 取样人姓名
     */
    private String samplingUsername;

    /**
     * 取样时间
     */
    private Date samplingTime;

    /**
     * 取样拍照（多个以,隔开）
     */
    private String samplingPhotos;

    /**
     * 报告时间
     */
    private Date reportTime;

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

    /**
     * 删除状态：0_未删除，1_已删除
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
     * 更新人ID
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateDate;

    /************** 非数据库字段 ****************************/
    @TableField(exist = false)
    private String pointName; // 检测点名称

    @TableField(exist = false)
    private String total; // 抽样总数

    @TableField(exist = false)
    private String completionNum; // 已完成数

    @TableField(exist = false)
    private String inspectionName; // 送检单位

    @TableField(exist = false)
    private Double totalFee; // 小计费用

    @TableField(exist = false)
    private Integer collectNum; //待收样样品数量

    @TableField(exist = false)
    private Integer incomeId; // 交易流水ID

    @TableField(exist = false)
    private String incomeNumber;    // 交易订单号

    @TableField(exist = false)
    private String payNumber; // 交易流水号

    @TableField(exist = false)
    private String requesterNameStr; // 订单对应的多个委托单位,存储格式:黄埔二中食堂,黄埔一中食堂

    @TableField(exist = false)
    private Integer unitsCount;//委托单位数量 add by xiaoyl 2020/1/15

    //一个抽检单对应多个抽检样品
    @TableField(exist = false)
    private List<TbSamplingDetail> samplingDetails = new ArrayList<TbSamplingDetail>();

    @TableField(exist = false)
    private Integer detailsCount;    //明细数量

    @TableField(exist = false)
    private Integer checkedCount;   //已检测数量

    @TableField(exist = false)
    private Date collectTime;   //最新收样时间

    @TableField(exist = false)
    private Short payStatus;//income表的支付状态 add by xiaoyl 2020-03-20

    @TableField(exist = false)
    private String conclusion; // 检测结果

    @TableField(exist = false)
    private String samplingDateStr;//抽样时间字符串

    @TableField(exist = false)
    private String regAddress;//被检单位地址

}