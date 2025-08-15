package com.dayuan3.common.model;

import java.math.BigDecimal;

import com.dayuan3.terminal.bean.Income;

/**
 * 	交易明细查询条件Model
 * @author xiaoyl
 * @date   2019年10月31日
 */
public class AccountFlowModel extends Income {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 余额：元
	 */
	private BigDecimal balance;
	/**
	 * 赠送金额
	 */
	private BigDecimal giftMoney;
	/**
	 * 流水状态：0 支出，1 收入--充值
	 */
	private Short flowState;
	public BigDecimal getBalance() {
		return balance==null? new BigDecimal(0) : balance;
	}
	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}
	public BigDecimal getGiftMoney() {
		return giftMoney;
	}
	public void setGiftMoney(BigDecimal giftMoney) {
		this.giftMoney = giftMoney;
	}
	public Short getFlowState() {
		return flowState;
	}
	public void setFlowState(Short flowState) {
		this.flowState = flowState;
	}
	
}