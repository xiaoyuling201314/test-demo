package com.dayuan3.terminal.bean;

import java.io.Serializable;
import java.util.Date;

public class AlipayNotifyParam implements Serializable {
	private String app_id;
	private String trade_no; // 支付宝交易凭证号
	private String out_trade_no; // 原支付请求的商户订单号
	private String out_biz_no; // 商户业务ID，主要是退款通知中返回退款申请的流水号
	private String buyer_id; // 买家支付宝账号对应的支付宝唯一用户号。以2088开头的纯16位数字
	private String buyer_logon_id; // 买家支付宝账号
	private String seller_id; // 卖家支付宝用户号
	private String seller_email; // 卖家支付宝账号
	private String trade_status; // 交易目前所处的状态，见交易状态说明
	private double totalAmount; // 本次交易支付的订单金额
	private double receipt_amount; // 商家在交易中实际收到的款项
	private double buyer_pay_amount; // 用户在交易中支付的金额
	private double refundFee; // 退款通知中，返回总退款金额，单位为元，支持两位小数
	private String subject; // 商品的标题/交易标题/订单标题/订单关键字等
	private String body; // 该订单的备注、描述、明细等。对应请求时的body参数，原样通知回来
	private Date gmt_create; // 该笔交易创建的时间。格式为yyyy-MM-dd HH:mm:ss
	private Date gmt_payment; // 该笔交易的买家付款时间。格式为yyyy-MM-dd HH:mm:ss
	private Date gmt_refund; // 该笔交易的退款时间。格式为yyyy-MM-dd HH:mm:ss.S
	private Date gmt_close; // 该笔交易结束时间。格式为yyyy-MM-dd HH:mm:ss
	private String fund_bill_list; // 支付成功的各个渠道金额信息,array
	private String passback_params; // 公共回传参数，如果请求时传递了该参数，则返回给商户时会在异步通知时将该参数原样返回。
	public String getApp_id() {
		return app_id;
	}
	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}
	public String getTrade_no() {
		return trade_no;
	}
	public void setTrade_no(String trade_no) {
		this.trade_no = trade_no;
	}
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}
	public String getOut_biz_no() {
		return out_biz_no;
	}
	public void setOut_biz_no(String out_biz_no) {
		this.out_biz_no = out_biz_no;
	}
	public String getBuyer_id() {
		return buyer_id;
	}
	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}
	public String getBuyer_logon_id() {
		return buyer_logon_id;
	}
	public void setBuyer_logon_id(String buyer_logon_id) {
		this.buyer_logon_id = buyer_logon_id;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public String getSeller_email() {
		return seller_email;
	}
	public void setSeller_email(String seller_email) {
		this.seller_email = seller_email;
	}
	public String getTrade_status() {
		return trade_status;
	}
	public void setTrade_status(String trade_status) {
		this.trade_status = trade_status;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public double getReceipt_amount() {
		return receipt_amount;
	}
	public void setReceipt_amount(double receipt_amount) {
		this.receipt_amount = receipt_amount;
	}
	public double getBuyer_pay_amount() {
		return buyer_pay_amount;
	}
	public void setBuyer_pay_amount(double buyer_pay_amount) {
		this.buyer_pay_amount = buyer_pay_amount;
	}
	public double getRefundFee() {
		return refundFee;
	}
	public void setRefundFee(double refundFee) {
		this.refundFee = refundFee;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public Date getGmt_create() {
		return gmt_create;
	}
	public void setGmt_create(Date gmt_create) {
		this.gmt_create = gmt_create;
	}
	public Date getGmt_payment() {
		return gmt_payment;
	}
	public void setGmt_payment(Date gmt_payment) {
		this.gmt_payment = gmt_payment;
	}
	public Date getGmt_refund() {
		return gmt_refund;
	}
	public void setGmt_refund(Date gmt_refund) {
		this.gmt_refund = gmt_refund;
	}
	public Date getGmt_close() {
		return gmt_close;
	}
	public void setGmt_close(Date gmt_close) {
		this.gmt_close = gmt_close;
	}
	public String getFund_bill_list() {
		return fund_bill_list;
	}
	public void setFund_bill_list(String fund_bill_list) {
		this.fund_bill_list = fund_bill_list;
	}
	public String getPassback_params() {
		return passback_params;
	}
	public void setPassback_params(String passback_params) {
		this.passback_params = passback_params;
	}


}
