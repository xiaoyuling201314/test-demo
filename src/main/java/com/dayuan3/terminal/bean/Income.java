package com.dayuan3.terminal.bean;

import com.baomidou.mybatisplus.annotation.*;
import com.dayuan.bean.BaseBean2;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @TableName income
 */
@TableName(value ="income")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Income implements Serializable {
	/**
	 * ID
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * 订单号
	 */
	private String number;

	/**
	 * 抽样单ID
	 */
	private Integer samplingId;

	/**
	 * 下单方式（0 自助终端，1 公众号, 2后台操作）
	 */
	private Short orderPlatform;

	/**
	 * 付款方式:0微信，1支付宝，2余额
	 */
	private Short payType;

	/**
	 * 付款来源
	 */
	private String paySource;

	/**
	 * 交易流水号/官方商户订单号
	 */
	private String payNumber;

	/**
	 * 费用类型(0_检测费用, 1_复检费用, 2_充值费用, 3_订单退款, 4_充值退款, 5_增加余额, 6_减少余额)
	 */
	private Short transactionType;

	/**
	 * 付款账号
	 */
	private String payAccount;

	/**
	 * 收款金额：分
	 */
	private Integer money;

	/**
	 * 交易时间
	 */
	private Date payDate;

	/**
	 * 交易状态(0_待支付,1_成功,2_失败,3_关闭)
	 */
	private Short status;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 发票流水ID
	 */
	private Integer invoiceId;

	/**
	 * 是否删除
	 */
	@TableLogic
	private Integer deleteFlag;

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
	 * 官方订单号
	 */
	private String param1;

	/**
	 * 渠道订单号
	 */
	private String param2;

	/**
	 * 预留参数3
	 */
	private String param3;

	/**
	 * 后台操作创建人ID（t_s_user.id）
	 */
	private String createUser;

	/**
	 * 报告费用(元)
	 */
	private int reportMoney;

	/**
	 * 上门服务费
	 */
	private Double takeSamplingMoney;

	/**
	 * 检测费用
	 */
	private Double checkMoney;

	public Income(String number, Integer samplingId, Short orderPlatform, Short payType, String payNumber, Short transactionType, Integer money, Short status) {
		this.number = number;
		this.samplingId = samplingId;
		this.orderPlatform = orderPlatform;
		this.payType = payType;
		this.payNumber = payNumber;
		this.transactionType = transactionType;
		this.money = money;
		this.status = status;
	}

	public Income(String number, Integer samplingId, Short orderPlatform, Short transactionType, Integer money,
				  String createBy, Date createDate, String updateBy, Date updateDate) {
		super();
		this.number = number;
		this.samplingId = samplingId;
		this.orderPlatform = orderPlatform;
		this.transactionType = transactionType;
		this.money = money;
		this.createBy = createBy;
		this.createDate = createDate;
		this.updateBy = updateBy;
		this.updateDate = updateDate;
	}

	public Income(String number, Integer samplingId, Short orderPlatform, Short transactionType, Integer money,
				  int reportMoney,Double checkMoney,String createBy, Date createDate, String updateBy, Date updateDate,String remark) {
		super();
		this.number = number;
		this.samplingId = samplingId;
		this.orderPlatform = orderPlatform;
		this.transactionType = transactionType;
		this.money = money;
		this.createBy = createBy;
		this.createDate = createDate;
		this.updateBy = updateBy;
		this.updateDate = updateDate;
		this.reportMoney = reportMoney;
		this.checkMoney=checkMoney;
		this.remark=remark;
	}

	/***************** 非表字段 ************/
	/**
	 * 付款人姓名
	 */
	@TableField(exist = false)
	private String realName;

	/**
	 * 	订单金额
	 */
	@TableField(exist = false)
	private BigDecimal totalMoney;


	public BigDecimal getTotalMoney() {
		int total=0;
		if(this.money!= 0){
			total+=this.money;
		}
		if(this.reportMoney!= 0){
			total+=this.reportMoney;
		}
		return new BigDecimal(""+total).setScale(2, BigDecimal.ROUND_HALF_UP);
	}

}