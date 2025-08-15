package com.dayuan3.terminal.model;

import com.dayuan.model.BaseModel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 余额管理model
 *
 * @author Dz
 * @date 2019年10月23日
 */
@Data
public class BalanceModel extends BaseModel {

    /**
     * ID
     */
    private Integer id;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 实际充值金额
     */
    private Integer actualMoney;

    /**
     * 赠送金额
     */
    private Integer giftMoney;
    /**
     * 总金额
     */
    private Integer totalMoney;

    /**
     * 充值次数
     */
    private Integer rechargeCount;

    /**
     * 最后交易时间
     */
    private Date lastRechargeDate;

    /**
     * 更新时间
     */
    private Date updateDate;

    /**
     * 账户状态 0:正常 1：冻结
     */
    private Short status;

    /**
     * 用户名称
     */
    private String realName;

    /**
     * 用户账号
     */
    private String userName;

    /**
     * 联系方式
     */
    private String phone;
    /**
     * 用户编号
     */
    private String account;
    /**
     * 用户Id
     */
    private Integer accountId;

    private Short ishave =0;//查询条件 0：查询存不在交易记录的数据 1：查询存在交易记录的数据

    private Integer flowCount;//交易次数（只记录成功的记录）

}