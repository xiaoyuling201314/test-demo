package com.dayuan3.terminal.util;

import java.util.ResourceBundle;
/**
 * 支付项目参数
 * @author xiaoyl
 * @date   2019年7月5日
 */
public class PayConfig {
	public static final ResourceBundle payInfo = ResourceBundle.getBundle("payinfo");
	// 支付宝网关名、partnerId和appId
	public static final String SERVERURL = PayConfig.payInfo.getString("open_api_domain");
	//商户ID
	public static final String P_ID = PayConfig.payInfo.getString("pid");

	// APP支付宝支付业务：app_id
	public static final String APP_ID = PayConfig.payInfo.getString("appid");

	// 商户的私钥,使用支付宝自带的openssl工具生成。
	public static final String PRIVATE_KEY = PayConfig.payInfo.getString("private_key");

	// 应用的公钥，无需修改该值
	public static final String PUBLIC_KEY = PayConfig.payInfo.getString("public_key");

	// SHA256withRsa对应支付宝公钥
	public static final String ALIPY_PUBLIC_KEY = PayConfig.payInfo.getString("alipay_public_key");

	// 签名类型: RSA->SHA1withRsa,RSA2->SHA256withRsa
	public static final String SIGN_TYPE = PayConfig.payInfo.getString("sign_type");

	// 当面付最大查询次数和查询间隔（毫秒）
	public static final int MAX_QUERY_RETRY = Integer.parseInt(PayConfig.payInfo.getString("max_query_retry"));

	public static final int QUERY_DURATION = Integer.parseInt(PayConfig.payInfo.getString("query_duration"));

	// 当面付最大撤销次数和撤销间隔（毫秒）
	public static final int MAX_CANCEL_RETRY = Integer.parseInt(PayConfig.payInfo.getString("max_cancel_retry"));

	public static final int CANCEL_DURATION = Integer.parseInt(PayConfig.payInfo.getString("cancel_duration"));
	// 交易保障线程第一次调度延迟和调度间隔（秒）
	public static final int HEARTBEAT_DELAY = Integer.parseInt(PayConfig.payInfo.getString("heartbeat_delay"));

	public static final int HEARTBEAT_DURATION = Integer.parseInt(PayConfig.payInfo.getString("heartbeat_duration"));

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static final String INPUT_CHARSET = "UTF-8";

	/************************ 微信支付相关参数 ******************************************/
	// 公众账号appid
	public static final String W_APPID = PayConfig.payInfo.getString("w_appid");
	// 商户号
	public static final String W_MCH_ID = PayConfig.payInfo.getString("w_mch_id");
	// 私钥
	public static final String W_WEIPRIKRY = PayConfig.payInfo.getString("w_weiPriKry");
	// 秘钥
	public static String W_SECRET = PayConfig.payInfo.getString("w_secret");
	// 微信预下单地址
	public static final String W_UNIFIED_ORDER_URL = PayConfig.payInfo.getString("w_unified_order_url");
	// 微信支付通知地址
	public static final String W_NOTIFY_URL = PayConfig.payInfo.getString("w_notify_url");
	// 微信订单查询地址
	public static final String W_ORDER_QUERY_URL = PayConfig.payInfo.getString("w_order_query_url");
	//微信订单取消地址
	public static final String W_ORDER_CANCEL_URL = PayConfig.payInfo.getString("w_order_cancel_url");
	
}
