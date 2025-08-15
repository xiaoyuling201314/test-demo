package com.dayuan3.admin.bean;

import com.baomidou.mybatisplus.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 分账记录表
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-18
 */
@Data
@TableName("tb_split_amount")
@NoArgsConstructor
@AllArgsConstructor
public class SplitAmount implements Serializable {

    private static final long serialVersionUID = 1L;

    public SplitAmount(String number, String incomeNumber, Integer splitMoney, Short status, Date splitDate, Short deleteFlag,Date createDate) {
        this.number = number;
        this.incomeNumber = incomeNumber;
        this.splitMoney = splitMoney;
        this.status = status;
        this.splitDate = splitDate;
        this.deleteFlag = deleteFlag;
        this.createDate=createDate;
    }

    /**
     * ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 分账订单号
     */
    private String number;

    /**
     * 交易订单号
     */
    private String incomeNumber;

    /**
     * 分账金额：单位：分
     */
    private Integer splitMoney;

    /**
     * 分账方列表和金额，json格式存储
     */
    private String splitJson;

    /**
     * 异步分账状态：0：待处理 1：成功 2：失败
     */
    private Short status;

    /**
     * 分账时间
     */
    private Date splitDate;

    /**
     * 确认收货订单号
     */
    private String receiveNumber;

    /**
     * 确认收货状态：0：待收货 1：已收货
     */
    private Short receiveStatus;

    /**
     * 确认收货时间
     */
    private Date receiveDate;

    /**
     * 备注
     */
    private String remark;

    /**
     * 是否删除
     */
    @TableLogic
    private Short deleteFlag;

    /**
     * 创建人id
     */
    private String createBy;

    /**
     * 创建时间
     */
    @TableField(value = "create_date", fill = FieldFill.INSERT)
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改时间
     */
    @TableField(value = "update_date", fill = FieldFill.INSERT_UPDATE)
    private Date updateDate;

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
}
