package com.dayuan3.admin.bean;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.*;

/**
 * <p>
 * 提现记录表
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-19
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("tb_withdraw_amount")
public class WithdrawAmount implements Serializable {

    private static final long serialVersionUID = 1L;

    public WithdrawAmount(String userId, String number, Integer withdrawMoney, Short status, Date createDate) {
        this.userId = userId;
        this.number = number;
        this.withdrawMoney = withdrawMoney;
        this.status = status;
        this.createDate = createDate;
    }

    /**
     * ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 子商户编号
     */
    private String userId;

    /**
     * 提现订单号
     */
    private String number;

    /**
     * 提现金额：单位：分
     */
    private Integer withdrawMoney;

    /**
     * 提现状态：0：待处理 1：成功 2：失败
     */
    private Short status;

    /**
     * 是否退票：0：否 1：是
     */
    private Short withdrawBackFlag;

    /**
     * 结算发起时间
     */
    private Date startDate;

    /**
     * 结算完成时间
     */
    private Date endDate;

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
