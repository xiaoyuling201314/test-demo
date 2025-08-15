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
public class FlowModel extends BaseModel {

    /**
     * ID
     */
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
     * 充值金额：元
     */
    private Integer money;

    /**
     * 余额：元
     */
    private Integer balance;
    /**
     * 赠送金额
     */
    private Integer giftMoney;
    /**
     * 交易时间
     */
    private Date payDate;

    /**
     * 流水状态：0 支出，1 收入--充值
     */
    private Short flowState;

    /**
     * 交易状态（0待支付、1成功、2失败、3关闭）
     */
    private Short status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 用户id
     */
    private String userId;

    /**
     * 活动主题
     */
    private String activityTheme;

    /**
     * 满足活动条件的充值金额
     */
    private Integer activityMoney;

    /**
     * 满足活动条件的赠送金额
     */
    private Integer activityGiftMoney;

    /**
     * 交易流水号
     */
    private String payNumber;
    /**
     * 订单号
     */
    private String number;

    private Short orderPlatform;//操作服务端: 0 自助终端，1 公众号,2 后台
    private Short payType;//支付方式：0 微信，1支付宝，2余额
    private String payMode;//交易方式

    /************** 查询条件 *************/
    private String payDateStart;
    private String payDateEnd;
    private String keyWords;

    private Short isok = 0;//是否查询收入成功的

    public String getPayMode() {
        String payMode = "";
        if (this.orderPlatform != null) {
            if (this.orderPlatform == 2) {//如果是后台，且操作的是余额
                payMode = "平台操作";
            } else if (this.payType == 0) {//0 微信，1支付宝，2余额
                payMode = "微信";
            } else if (this.payType == 1) {//0 微信，1支付宝，2余额
                payMode = "支付宝";
            } else if (this.payType == 2) {//0 微信，1支付宝，2余额
                payMode = "余额";
            }
        } else {
            payMode = "";
        }
        return payMode;
    }

}