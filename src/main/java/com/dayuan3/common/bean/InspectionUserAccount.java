package com.dayuan3.common.bean;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.*;

/**
 * <p>
 * 送检用户余额表
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-04
 */
@Data
@TableName("inspection_user_account")
@NoArgsConstructor
@AllArgsConstructor
public class InspectionUserAccount implements Serializable {

    public InspectionUserAccount(Integer userId, Integer actualMoney, Integer giftMoney, Integer rechargeCount,
                                 Date lastRechargeDate, String createBy, Date createDate, Date updateDate) {
        super();
        this.userId = userId;
        this.actualMoney = actualMoney;
        this.giftMoney = giftMoney;
        this.rechargeCount = rechargeCount;
        this.lastRechargeDate = lastRechargeDate;
        this.createBy = createBy;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    private static final long serialVersionUID = 1L;
    /**
     * ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 实际充值金额：单位：分
     */
    private Integer actualMoney;
    /**
     * 赠送金额：单位：分
     */
    private Integer giftMoney;
    /**
     * 充值次数
     */
    private Integer rechargeCount;
    /**
     * 最后交易时间
     */
    private Date lastRechargeDate;
    /**
     * 支付密码
     */
    private String payPassword;
    /**
     * 账户状态 0:正常 1：冻结
     */
    private Short status;
    /**
     * 删除状态 1是已删除 0是未删除
     */
    @TableLogic
    private Short deleteFlag;
    /**
     * 创建时间
     */
    private Date createDate;
    /**
     * 创建人id
     */
    private String createBy;
    /**
     * 修改时间
     */
    private Date updateDate;
    /**
     * 修改人id
     */
    private String updateBy;
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
     * 总金额：单位：分
     */
    private Integer totalMoney=0;
    /**
     * 版本号
     */
    private Integer version;


}
