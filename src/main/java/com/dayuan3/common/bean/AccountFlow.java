package com.dayuan3.common.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * <p>
 * 余额交易流水表
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-03
 */
@Data
@TableName("account_flow")
@NoArgsConstructor
@AllArgsConstructor
public class AccountFlow implements Serializable {

    public AccountFlow(Integer topupId, Integer topupDetailId, Integer money, Date payDate, Short flowState,Integer giftMoney) {
        super();
        this.topupId = topupId;
        this.topupDetailId = topupDetailId;
        this.money = money;
        this.payDate = payDate;
        this.flowState = flowState;
        this.giftMoney=giftMoney;
    }

    public AccountFlow(Integer incomeId,Integer money, Short flowState, Short status, String createBy, Date createDate) {
        super();
        this.incomeId=incomeId;
        this.money = money;
        this.flowState = flowState;
        this.status = status;
        this.createBy = createBy;
        this.createDate = createDate;
    }
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 支付流水ID
     */
    private Integer incomeId;

    /**
     * 充值活动ID
     */
    private Integer topupId;

    /**
     * 充值活动明细ID
     */
    private Integer topupDetailId;

    /**
     * 交易金额：分
     */
    private Integer money;

    /**
     * 赠送金额
     */
    private Integer giftMoney=0;

    /**
     * 余额：分
     */
    private Integer balance;

    /**
     * 交易时间
     */
    private Date payDate;

    /**
     * 流水状态：0 支出，1 收入--充值
     */
    private Short flowState;

    /**
     * 交易状态（0 待支付、1 成功、2 失败、3 关闭）
     */
    private Short status;

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
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改时间
     */
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
