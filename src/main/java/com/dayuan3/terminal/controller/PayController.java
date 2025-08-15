package com.dayuan3.terminal.controller;

import com.alibaba.fastjson.JSON;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeCloseRequest;
import com.alipay.api.request.AlipayTradePrecreateRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradeCloseResponse;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.DateUtil;
import com.dayuan.util.QrcodeUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.service.TbSamplingRequesterService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.AlipayNotifyParam;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.terminal.util.WXPayConstants.SignType;
import com.dayuan3.terminal.util.WXPayUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;

/**
 * 订单结算
 * 
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/pay")
public class PayController extends BaseController {
	private Logger log = Logger.getLogger(PayController.class);

	@Autowired
	private IncomeService incomeService;

	@Autowired
	private TbSamplingService tbSamplingService;

	@Autowired
	private CommonLogUtilService logUtil;

	@Autowired
	private InspectionUserAccountService accountService;

	@Autowired
	private AccountFlowService flowService;

	@Autowired
	private TbSamplingRequesterService samplingRequesterService;
	
	@Autowired
	private TbSamplingDetailService samplingDetailService;
	
	/**
	 * 进入支付页面
	 * 
	 * @description
	 * @param incomeId
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date 2019年9月26日
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Integer incomeId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			request.getSession().removeAttribute("incomeId");
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			if (null == user) {
				return new ModelAndView("/terminal/index");
			}
			Income bean = incomeService.getById(incomeId);
//			TbSampling sampleBean = tbSamplingService.getByIdAndInspection(bean.getSamplingId(),
//				user.getInspectionId());
//			if(user.getUserType()==0) {
//				sampleBean.setInspectionName(user.getPhone());
//			}
//			List<TbSamplingRequester> unitList=samplingRequesterService.queryBySamplingId(sampleBean.getId());
			// 查询当前用户余额
			InspectionUserAccount account = accountService.queryAccountByUserId(user.getId());
			if (account != null) {
				AccountFlow flowBean=flowService.queryByIncomeId(bean.getId());
				if(flowBean==null) {
					int b1 =account.getTotalMoney()==0 ? 0 : account.getTotalMoney();
//					BigDecimal b2 = new BigDecimal(bean.getMoney()+bean.getReportMoney()).setScale(2, BigDecimal.ROUND_HALF_UP);
					int b2 = bean.getMoney();
					if (b1>b2) {// 余额足够支付，生成余额交易记录
						AccountFlow flow = new AccountFlow(bean.getId(), bean.getMoney(), (short) 0,
								(short) 0, user.getId().toString(), new Date());
						flowService.saveOrUpdate(flow);
						logUtil.savePayLog(bean.getNumber(), (short) 0, (short) 2, (short) 1, bean.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
								PayController.class.toString(), "list", "生成余额交易预支付信息", true, null, request);
					}
				}
				map.put("account", account);
			}
			map.put("bean", bean);
//			map.put("sampleBean", sampleBean);
//			map.put("unitList", unitList);
			map.put("balance", SystemConfigUtil.PAYTYPE_CONFIG.getString("balance"));
			map.put("weiPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("weiPay"));
			map.put("aliPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("aliPay"));
		} catch (Exception e) {
			e.getStackTrace();
			System.out.println("*********************" + e.getMessage());
		}
		return new ModelAndView("/terminal/income/list", map);
	}

	@RequestMapping(value = "/paySuccess")
	public ModelAndView paySuccess(Integer incomeId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Income bean = incomeService.getById(incomeId);
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
//			TbSampling tbSampling = tbSamplingService.getByIdAndInspection(bean.getSamplingId(),
//					user.getInspectionId());
			map.put("bean", bean);
//			map.put("tbSampling", tbSampling);
			//add by xiaoyl 2020-02-21 增加下单成功通知
			if(StringUtil.isNotEmpty(user.getOpenId())) {
				//查询该订单有多少个样品，样品名称相同但检测项目不同视为同一个样品
//				int count=samplingDetailService.queryFoodCountBySamplingId(tbSampling.getId());
//				wxPayService.sendOrderMsg(user.getOpenId(), "",tbSampling.getSamplingNo(), count, tbSampling.getInspectionFee(), tbSampling.getCreateDate(), tbSampling.getOrderPlatform(),bean.getId());
			}
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
		return new ModelAndView("/terminal/income/paySuccess", map);
	}

	/**
	 * 微信支付
	 * 
	 * @description
	 * @param responses
	 * @param orderid   订单号
	 * @param money     收款金额
	 * @throws AlipayApiException
	 * @author xiaoyl
	 * @date 2019年7月6日
	 */
	@RequestMapping(value = "/weipay.do")
	@ResponseBody
	public void weipay(@Param("orderid") String orderid, @Param("money") double money,
			@Param("samplingNo") String samplingNo, @Param("title") String title, HttpServletResponse response,
			HttpServletRequest request) throws AlipayApiException {
		boolean success = true;
		String exception = "";
		Map<String, String> maps = new HashMap<>();
		String nonce_str = WXPayUtil.genNonceStr();
		// 设置回调地址
		maps.put("notify_url", SystemConfigUtil.WEIPAY_CONFIG.getString("w_order_callBack_url"));// 通知回调
		maps.put("out_trade_no", orderid);
		maps.put("spbill_create_ip", "192.168.123.20");
		maps.put("nonce_str", nonce_str);// 随机字符串 32位以内
		maps.put("appid", SystemConfigUtil.WEIPAY_CONFIG.getString("w_appid"));
		if (StringUtil.isNotEmpty(title)) {
			maps.put("body", title);
		} else {
			maps.put("body", samplingNo);// 收款时显示给用户看的商品名称
		}
		maps.put("mch_id", SystemConfigUtil.WEIPAY_CONFIG.getString("w_mch_id"));// 商户id
		// 订单失效时间，格式为yyyyMMddHHmmss，如2009年12月27日9点10分10秒表示为20091227091010。订单失效时间是针对订单号而言的;建议;最短失效时间间隔大于1分钟
		// maps.put("time_expire", "20190705104010");
		// 订单总金额，单位为分
//		int moneyFee = (int) (money * 100);
		BigDecimal big1 = new BigDecimal(Double.valueOf(money)).setScale(2, BigDecimal.ROUND_HALF_UP);
		BigDecimal big2 = new BigDecimal(Double.valueOf(100));
		int moneyFee=big1.multiply(big2).intValue();
		maps.put("total_fee", String.valueOf(moneyFee));
		maps.put("trade_type", "NATIVE");// 扫码支付时为 NATIVE 公众号为 JSAPI NATIVE
		ServletOutputStream sos = null;
		String str = "";
		try {
			str = WXPayUtil.generateSignedXml(maps, SystemConfigUtil.WEIPAY_CONFIG.getString("w_weiPriKry"),
					SignType.MD5);

			InputStream is = WXPayUtil
					.sendXMLDataByPost(SystemConfigUtil.WEIPAY_CONFIG.getString("w_unified_order_url"), str).getEntity()
					.getContent();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int len;
			while ((len = is.read(buf)) != -1) {
				out.write(buf, 0, len);
			}
			String string = out.toString("UTF-8");
			Map<String, String> xmlToMap = WXPayUtil.xmlToMap(string);
			if ("SUCCESS".equals(xmlToMap.get("result_code"))) {
				System.out.println(xmlToMap.toString());
				String codeUrl = xmlToMap.get("code_url");
				// 生成二维码
				sos = response.getOutputStream();
				BufferedImage image = QrcodeUtil.generateQrcode(codeUrl, 150, 150);
				ImageIO.write(image, "png", sos);
				sos.close();
				out.close();
				is.close();
			} else {
				System.out.println("生成微信收款二维码失败");
				System.out.println(xmlToMap.toString());
				success = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*********************" + e.getMessage());
			success = false;
			exception = e.getMessage();
		}
		logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 1, money, ModularConstant.OPERATION_MODULE_PAY,
				PayController.class.toString(), "weipay", "生成微信收款二维码", success, exception, request);
	}

	@RequestMapping(value = "/weipayCallback")
	public void weipayCallback(HttpServletResponse response, HttpServletRequest request) {
		try {
			String orderid = "";
			InputStream is = request.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int len;
			while ((len = is.read(buf)) != -1) {
				out.write(buf, 0, len);
			}
			String string = out.toString("UTF-8");
			Map<String, String> xmlToMap = WXPayUtil.xmlToMap(string);
			if (WXPayUtil.isSignatureValid(xmlToMap, SystemConfigUtil.WEIPAY_CONFIG.getString("w_weiPriKry"),
					SignType.MD5)) {// 校验签名是否正确
				// 更新订单状态信息，财务信息
				orderid = xmlToMap.get("out_trade_no");
				List<Income> list = incomeService.queryListByNumber(null, orderid);
				Income bean = null;
				if (list != null) {
					bean = list.get(0);
					if (list.size() == 1 && bean.getStatus() != 1) {// 首次支付成功更新,只要支付状态不是成功就修改订单和支付流水状态
						bean.setPayType((short) 0);
						bean.setPayDate(DateUtil.yyyymmddhhmmss.parse(xmlToMap.get("time_end")));
						bean.setPayNumber(xmlToMap.get("transaction_id"));
						bean.setStatus((short) 1);
						// 1.更新后台系统订单信息和交易状态
						incomeService.payMentForOrder(bean, null, (short) 2, (short) 0);
						// 2.写入交易日志
						logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 4, bean.getMoney(),
								ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(), "weipayCallback",
								"微信支付成功", true, null, request);
						// 3.取消支付宝预下单信息
						cancelPreparaOrder(orderid, false, true, request);
						// 4.返回接收成功信息
						response.setContentType("text/xml; charset=UTF-8");
						Map<String, String> data = new HashMap<String, String>();
						data.put("return_code", "SUCCESS");
						data.put("return_msg", "OK");
						String str = WXPayUtil.mapToXml(data);
						response.getWriter().write(str);
					} else if (list.size() >= 1 && bean.getStatus() == 1) {// 重复支付，新增交易记录
						int count=incomeService.queryUniqueByNumber(bean.getNumber(), (short)0);
						if(count==0) {
							// 1.更新后台系统订单信息和交易状态
							bean.setId(null);
							bean.setStatus((short) 1);
							bean.setPayType((short) 0);
							bean.setPayDate(DateUtil.yyyymmddhhmmss.parse(xmlToMap.get("time_end")));
							bean.setPayNumber(xmlToMap.get("transaction_id"));
							
							incomeService.saveIncomeAndFlow(bean, null, null);
						}
						// 2.写入交易日志
						logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 4, bean.getMoney(),
								ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(), "weipayCallback",
								"微信支付成功", true, null, request);
						// 3.取消支付宝预下单信息
						cancelPreparaOrder(orderid, false, true, request);
						// 4.返回接收成功信息
						response.setContentType("text/xml; charset=UTF-8");
						Map<String, String> data = new HashMap<String, String>();
						data.put("return_code", "SUCCESS");
						data.put("return_msg", "OK");
						String str = WXPayUtil.mapToXml(data);
						response.getWriter().write(str);
					}
				}
			}
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
	}

	/**
	 * 微信： 支付状态trade_state：
	 * SUCCESS—支付成功,REFUND—转入退款,NOTPAY—未支付,CLOSED—已关闭,REVOKED—已撤销（付款码支付）
	 * USERPAYING--用户支付中（付款码支付）,PAYERROR--支付失败(其他原因，如银行返回失败)
	 * 
	 * 阿里交易查询接口 out_trade_no 支付时传入的商户订单号，与trade_no必填一个 trade_no
	 * 支付时返回的支付宝交易号，与out_trade_no必填一个 请求返回值示例：
	 * {"alipay_trade_query_response":{"code":"10000","msg":"Success","buyer_logon_id":"159****4027","buyer_pay_amount":"0.01","buyer_user_id":"2088012351746164",
	 * "fund_bill_list":[{"amount":"0.01","fund_channel":"PCREDIT"}],"invoice_amount":"0.01","out_trade_no":"020910312752381","point_amount":"0.00","receipt_amount":"0.01",
	 * "send_pay_date":"2018-02-09
	 * 10:31:45","total_amount":"0.01","trade_no":"2018020921001004160275738069","trade_status":"TRADE_SUCCESS"},
	 * "sign":""}
	 * 交易状态：WAIT_BUYER_PAY（交易创建，等待买家付款）、TRADE_CLOSED（未付款交易超时关闭，或支付完成后全额退款）、
	 * TRADE_SUCCESS（交易支付成功）、TRADE_FINISHED（交易结束，不可退款）
	 * 
	 * @description
	 * @param id      抽样单ID
	 * @param orderid 商户订单号
	 * @param weixinPay 是否前去微信后台查询
	 * @param aliPay 是否前去支付宝后台查询
	 * @param request
	 * @return
	 * @author xiaoyl
	 * @date 2019年11月12日
	 */
	@RequestMapping(value = "/payQuery")
	@ResponseBody
	public AjaxJson payQuery(@RequestParam(value = "id", required = false) Integer id, @RequestParam(value = "orderid", required = false) String orderid,
			@RequestParam(value = "weixinPay", required = false)boolean weixinPay,@RequestParam(value = "aliPay", required = false)boolean aliPay, HttpServletRequest request) {
		AjaxJson ajax = new AjaxJson();
		JSONObject returnJsonObject=null;
		try {
			List<Income> list = incomeService.queryListByNumber(id, orderid);
			Income bean = null;
			if (list != null && list.size()>0) {
				bean = list.get(0);
				orderid=bean.getNumber();
				if (bean.getStatus() == 1) {// 1. 订单已支付完成，不再进行查询
					if (bean.getPayType() == 0) {// 微信支付
						cancelPreparaOrder(orderid, false, true, request);// 取消支付宝订单
					} else if (bean.getPayType() == 1) {// 支付宝支付
						cancelPreparaOrder(orderid, true, false, request);// 取消微信订单
					} else if (bean.getPayType() == 2) {// 余额支付
						cancelPreparaOrder(orderid, true, true, request);// 取消微信、支付宝订单
					}
					//update by xiaoyl 2020-03-18 支付成功但未更新订单状态时特殊处理，用于激活订单使用
					if(bean.getSamplingId()!=null) {
						TbSampling samplingBean = tbSamplingService.getById(bean.getSamplingId());
						if(samplingBean.getOrderStatus()!=2) {
//							samplingBean.setOrderStatus((short) 2);
//							samplingBean.setUpdateBy(bean.getCreateBy());
//							samplingBean.setUpdateDate(new Date());
//							samplingBean.setPayDate(bean.getPayDate());
//							samplingBean.setPayMethod(bean.getPayType());
							tbSamplingService.updateById(samplingBean);
						}
					}
					ajax.setObj(bean);
					return ajax;
				} else {// 2. 前往微信、支付宝后台获取支付状态
						// ① 微信后台查询状态
					HashMap<String, String> map = new HashMap<String, String>();
					returnJsonObject=new JSONObject();
					if(weixinPay) {
						String nonce_str = WXPayUtil.genNonceStr();
						map.put("appid", SystemConfigUtil.WEIPAY_CONFIG.getString("w_appid"));
						map.put("mch_id", SystemConfigUtil.WEIPAY_CONFIG.getString("w_mch_id"));// 商户id
						map.put("out_trade_no", orderid);
						map.put("nonce_str", nonce_str);// 随机字符串 32位以内
						String str = WXPayUtil.generateSignedXml(map,
								SystemConfigUtil.WEIPAY_CONFIG.getString("w_weiPriKry"), SignType.MD5);
						InputStream is = WXPayUtil
								.sendXMLDataByPost(SystemConfigUtil.WEIPAY_CONFIG.getString("w_order_query_url"), str)
								.getEntity().getContent();
						ByteArrayOutputStream out = new ByteArrayOutputStream();
						byte[] buf = new byte[1024];
						int len;
						while ((len = is.read(buf)) != -1) {
							out.write(buf, 0, len);
						}
						String string = out.toString("UTF-8");
						Map<String, String> xmlToMap = WXPayUtil.xmlToMap(string);
						if (xmlToMap.get("return_code").equals("SUCCESS")) {
							if (xmlToMap.get("result_code").equals("SUCCESS")){
								if (xmlToMap.get("trade_state").equals("SUCCESS")){// 微信后台返回支付结果成功
									if (bean.getStatus() == 0) {// 订单为未支付状态时修改状态
//										HttpSession session = ContextHolderUtils.getSession();
//										InspectionUnitUser user = (InspectionUnitUser) session
//												.getAttribute(WebConstant.SESSION_USER1);
										bean.setPayType((short) 0);
										bean.setStatus((short) 1);
										bean.setPayDate(DateUtil.yyyymmddhhmmss.parse(xmlToMap.get("time_end")));
										bean.setPayNumber(xmlToMap.get("transaction_id"));
										incomeService.payMentForOrder(bean, null, (short) 2, (short) 0);
										// 2.写入交易日志
										logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 4, bean.getMoney(),
												ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(), "weipayCallback",
												"微信支付成功", true, null, request);
										cancelPreparaOrder(orderid, false, true, request);// 取消支付宝订单
									}
								}
								returnJsonObject.put("weixin_trade_state", xmlToMap.get("trade_state"));
								returnJsonObject.put("weixin_trade_state_desc", xmlToMap.get("trade_state_desc"));
							}else {
								returnJsonObject.put("weixin_trade_state", xmlToMap.get("result_code"));
								returnJsonObject.put("weixin_trade_state_desc", xmlToMap.get("err_code_des"));
							}
						}else {
							returnJsonObject.put("weixin_trade_state", xmlToMap.get("result_code"));
							returnJsonObject.put("weixin_trade_state_desc", xmlToMap.get("err_code_des"));
						} 
					}
					if (aliPay) {//查询支付宝支付
						// ② 支付宝后台查询
						AlipayClient alipayClient = new DefaultAlipayClient(
								SystemConfigUtil.ALIPAY_CONFIG.getString("open_api_domain"),
								SystemConfigUtil.ALIPAY_CONFIG.getString("appid"),
								SystemConfigUtil.ALIPAY_CONFIG.getString("private_key"), "json",
								SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
								SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
								SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type"));
						AlipayTradeQueryRequest requests = new AlipayTradeQueryRequest();// 创建API对应的request类
						map = new HashMap<>();
						map.put("out_trade_no", orderid);
						String returndata = JSONObject.fromObject(map).toString();
						requests.setBizContent(returndata); // 设置业务参数
						AlipayTradeQueryResponse response = alipayClient.execute(requests);// 通过alipayClient调用API，获得对应的response类
						JSONObject jsonObject = JSONObject.fromObject(response.getBody())
								.getJSONObject("alipay_trade_query_response");
						String code = jsonObject.getString("code");
						String msg = jsonObject.getString("msg");
						Map<String, Object> returnmap = new HashMap<>();
						if (code.equals("10000") && msg.equals("Success")) {
							String trade_status = jsonObject.getString("trade_status");
							if (trade_status.equals("TRADE_SUCCESS")) {
								returnmap.put("trade_state", trade_status);
								// TODO支付成功，修改订单状态
								if (bean.getStatus() == 0) {// 订单为未支付状态时修改状态
//									InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
									bean.setPayType((short) 1);
									bean.setStatus((short) 1);
									bean.setPayDate(
											DateUtil.datetimeFormat.parse(jsonObject.getString("send_pay_date")));
									bean.setPayNumber(jsonObject.getString("trade_no"));
									bean.setPayAccount(jsonObject.getString("buyer_logon_id"));
									incomeService.payMentForOrder(bean, null, (short) 2, (short) 1);
									// 2.写入交易日志
									logUtil.savePayLog(jsonObject.getString("trade_no"), (short) 0, (short) 1, (short) 4,
											bean.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
											PayController.class.toString(), "alipayCallback", "支付宝支付成功", true, null, request);
									cancelPreparaOrder(orderid, true, false, request);// 取消微信订单

								}
							}
							returnJsonObject.put("alipay_trade_state", jsonObject.getString("trade_status"));
							returnJsonObject.put("alipay_trade_state_desc", jsonObject.getString("msg"));
						}else {//交易不存在
							returnJsonObject.put("alipay_trade_state", "TRADE_NOT_EXIST");
							returnJsonObject.put("alipay_trade_state_desc", jsonObject.getString("sub_msg"));
						}
					}
				}
				ajax.setObj(returnJsonObject.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*********************" + e.getMessage());
			ajax.setSuccess(false);
			ajax.setMsg("查询失败，请联系工作人员。");
		}
		return ajax;
	}

	/**
	 * @name 预下单请求，阿里获取二维码接口
	 * @throws AlipayApiException
	 * @Param out_trade_no 商户订单号,64个字符以内、只能包含字母、数字、下划线；需保证在商户端不重复
	 * @Param total_amount 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
	 *        如果同时传入了【打折金额】，【不可打折金额】， 【订单总金额】三者，则必须满足如下条件：【订单总金额】=【打折金额】+【不可打折金额】
	 * @Param subject 订单标题
	 * @Param store_id 商户门店编号
	 * @Param timeout_express 该笔订单允许的最晚付款时间，逾期将关闭交易。
	 *        取值范围：1m～15d。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。
	 *        该参数数值不接受小数点， 如 1.5h，可转换为 90m。
	 */
	@RequestMapping(value = "/alipay.do")
	@ResponseBody
	public void alipay(@Param("orderid") String orderid, @Param("money") double money,
			@Param("samplingNo") String samplingNo, @Param("title") String title, HttpServletResponse response,
			HttpServletRequest requests) {
		AlipayClient alipayClient = new DefaultAlipayClient(SystemConfigUtil.ALIPAY_CONFIG.getString("open_api_domain"),
				SystemConfigUtil.ALIPAY_CONFIG.getString("appid"),
				SystemConfigUtil.ALIPAY_CONFIG.getString("private_key"), "json",
				SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
				SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
				SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type"));
		AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();// 创建API对应的request类
		// 设置回调地址
		// request.setNotifyUrl("http://www.andata.com.cn/aliPayCallBack.do");
		boolean success = true;
		String exception = "";
		Map<String, Object> maps = new HashMap<>();
		maps.put("out_trade_no", orderid);
		maps.put("total_amount", money);
		if (StringUtil.isNotEmpty(title)) {
			maps.put("subject", title);
		} else {
			maps.put("subject", samplingNo);
		}
		maps.put("timeout_express", "24h");// 该笔订单允许的最晚付款时间，逾期将关闭交易。取值范围：1m～15d。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）
		// 把订单信息转换为json对象的字符串
		String postdata = JSONObject.fromObject(maps).toString();
		request.setBizContent(postdata);
		request.setNotifyUrl(SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_order_callBack_url"));// 支付宝回调地址
//		request.setReturnUrl(PayConfig.payInfo.getString("alipay_order_returnBack_url"));//设置支付成功回跳地址
		try {
			AlipayTradePrecreateResponse responses = alipayClient.execute(request);
			if (responses.isSuccess()) {
				String body = responses.getBody();
				JSONObject jsonObject = JSONObject.fromObject(body);
				String qr_code = jsonObject.getJSONObject("alipay_trade_precreate_response").getString("qr_code");
				response.setHeader("Pragma", "no-cache");
				response.setHeader("Cache-Control", "no-cache");
				response.setDateHeader("Expires", 0);
				response.setContentType("image/jpeg");
				// 流输出
				ServletOutputStream sos = null;

				sos = response.getOutputStream();
				log.info("************************************" + qr_code + sos);
				// 生成二维码
				BufferedImage image = QrcodeUtil.generateQrcode(qr_code, 150, 150);
				ImageIO.write(image, "png", sos);
				sos.close();
			} else {
				log.info("生成支付宝收款二维码失败");
				success = false;
				exception = "生成支付宝收款二维码失败";
			}
		} catch (IOException e) {
			e.printStackTrace();
			log.error("*********************" + e.getMessage());
			success = false;
			exception = e.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*********************" + e.getMessage());
			success = false;
			exception = e.getMessage();
		}
		logUtil.savePayLog(orderid, (short) 0, (short) 1, (short) 1, money, ModularConstant.OPERATION_MODULE_PAY,
				PayController.class.toString(), "alipay", "生成支付宝收款二维码", success, exception, requests);
	}

	/**
	 * 阿里交易查询接口 out_trade_no 支付时传入的商户订单号，与trade_no必填一个 trade_no
	 * 支付时返回的支付宝交易号，与out_trade_no必填一个 请求返回值示例：
	 * {"alipay_trade_query_response":{"code":"10000","msg":"Success","buyer_logon_id":"159****4027","buyer_pay_amount":"0.01","buyer_user_id":"2088012351746164",
	 * "fund_bill_list":[{"amount":"0.01","fund_channel":"PCREDIT"}],"invoice_amount":"0.01","out_trade_no":"020910312752381","point_amount":"0.00","receipt_amount":"0.01",
	 * "send_pay_date":"2018-02-09
	 * 10:31:45","total_amount":"0.01","trade_no":"2018020921001004160275738069","trade_status":"TRADE_SUCCESS"},
	 * "sign":""}
	 * 交易状态：WAIT_BUYER_PAY（交易创建，等待买家付款）、TRADE_CLOSED（未付款交易超时关闭，或支付完成后全额退款）、
	 * TRADE_SUCCESS（交易支付成功）、TRADE_FINISHED（交易结束，不可退款）
	 * 
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value = "/alipayQuery")
	@ResponseBody
	public AjaxJson alipayQuery(@Param("id") Integer id, @Param("orderid") String orderid, HttpServletRequest requests)
			throws AlipayApiException {
		AjaxJson ajax = new AjaxJson();
		try {
			Income bean = incomeService.getById(id);
			if (bean.getStatus() == 1) {// 订单已支付完成，不再进行查询
				if (bean.getPayType() == 0) {// 微信支付
					cancelPreparaOrder(orderid, false, true, requests);// 取消支付宝订单
				} else if (bean.getPayType() == 1) {// 支付宝支付
					cancelPreparaOrder(orderid, true, false, requests);// 取消微信宝订单
				} else if (bean.getPayType() == 2) {// 余额支付
					cancelPreparaOrder(orderid, true, true, requests);// 取消微信、支付宝订单
				}
				ajax.setObj(bean);
				return ajax;
			}
			AlipayClient alipayClient = new DefaultAlipayClient(
					SystemConfigUtil.ALIPAY_CONFIG.getString("open_api_domain"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("appid"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("private_key"), "json",
					SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type"));
			AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();// 创建API对应的request类
			Map<String, Object> map = new HashMap<>();
			map.put("out_trade_no", orderid);
			String returndata = JSONObject.fromObject(map).toString();
			request.setBizContent(returndata); // 设置业务参数
			AlipayTradeQueryResponse response = alipayClient.execute(request);// 通过alipayClient调用API，获得对应的response类
			JSONObject jsonObject = JSONObject.fromObject(response.getBody())
					.getJSONObject("alipay_trade_query_response");
			String code = jsonObject.getString("code");
			String msg = jsonObject.getString("msg");
			Map<String, Object> returnmap = new HashMap<>();
//			double money = Double.valueOf(jsonObject.getString("buyer_pay_amount"));
//			logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 1, money, ModularConstant.OPERATION_MODULE_PAY,
//					PayController.class.toString(), "alipayQuery", "支付宝支付状态查询", ajax.isSuccess(), null, requests);
			if (code.equals("10000") && msg.equals("Success")) {
				String trade_status = jsonObject.getString("trade_status");
				if (trade_status.equals("TRADE_SUCCESS")) {
					returnmap.put("trade_state", trade_status);
					// TODO支付成功，修改订单状态
					if (bean.getStatus() == 0) {// 订单为未支付状态时修改状态
//						logUtil.savePayLog(orderid, (short) 0, (short) 1, (short) 4, money,
//								ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(), "alipayQuery",
//								"支付宝支付成功", ajax.isSuccess(), null, requests);
						InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
						bean.setPayType((short) 1);
						bean.setStatus((short) 1);
						bean.setPayDate(DateUtil.datetimeFormat.parse(jsonObject.getString("send_pay_date")));
//						bean.getPaySource();
						bean.setPayNumber(jsonObject.getString("trade_no"));
						bean.setPayAccount(jsonObject.getString("buyer_logon_id"));
						incomeService.payMentForOrder(bean, user, (short) 2, (short) 1);
						cancelPreparaOrder(orderid, true, false, requests);// 取消微信订单

					}
				} else {
					returnmap.put("trade_state", trade_status);
				}
			} else {
				returnmap.put("trade_state", "QUERYFAILD");
				returnmap.put("data", jsonObject.getString("sub_msg"));
			}
			ajax.setAttributes(returnmap);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*********************" + e.getMessage());
//			logUtil.savePayLog(orderid, (short) 0, (short) 1, (short) 2, 0, ModularConstant.OPERATION_MODULE_PAY,
//					PayController.class.toString(), "alipayQuery", "支付宝支付状态查询异常", ajax.isSuccess(), e.getMessage(),
//					requests);
		}
		return ajax;
	}

	@RequestMapping(value = "/alipayCallback")
	public void alipayCallback(HttpServletResponse response, HttpServletRequest request) {
		String returnData = "success";
		try {
			Map<String, String> params = showParams(request); // 将异步通知中收到的待验证所有参数都存放到map中
			String paramsJson = JSON.toJSONString(params);
			log.info("支付宝回调，{" + paramsJson + "}");
			// 调用SDK验证签名
			log.error("返回签名:" + params.get("sign"));
			boolean signVerified = AlipaySignature.rsaCheckV1(params,
					SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
					SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type"));
			if (signVerified) {
				log.info("支付宝回调签名认证成功");
				AlipayNotifyParam param = JSON.parseObject(paramsJson, AlipayNotifyParam.class);
				if (param.getTrade_status().equals("TRADE_SUCCESS")) {
					List<Income> list = incomeService.queryListByNumber(null, param.getOut_trade_no());
					Income bean = null;
					if (list != null) {
						bean = list.get(0);
						if (list.size() == 1 && bean.getStatus() != 1) {// 首次支付成功更新,只要支付状态不是成功就修改订单和支付流水状态
							// 1.更新后台系统订单信息和交易状态
							int count=incomeService.queryUniqueByNumber(bean.getNumber(), (short)1);
							if(count==0) {
								bean.setPayType((short) 1);
								bean.setStatus((short) 1);
								bean.setPayDate(param.getGmt_payment());
								bean.setPayNumber(param.getTrade_no());
								bean.setPayAccount(param.getBuyer_logon_id());
								incomeService.payMentForOrder(bean, null, (short) 2, (short) 1);
							}
							// 2.写入交易日志
							logUtil.savePayLog(param.getOut_trade_no(), (short) 0, (short) 1, (short) 4,
									bean.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
									PayController.class.toString(), "alipayCallback", "支付宝支付成功", true, null, request);
							// 3.取消微信预下单信息
							cancelPreparaOrder(param.getOut_trade_no(), true, false, request);// 取消微信订单
							// 4.返回接收成功信息
							PrintWriter out = response.getWriter();
							out.print(returnData);
							out.flush();
							out.close();
						} else if (list.size() >= 1 && bean.getStatus() == 1) {// 重复支付，新增交易记录
							int count=incomeService.queryUniqueByNumber(bean.getNumber(), (short)1);
							if(count==0) {
								// 1.更新后台系统订单信息和交易状态
								bean.setId(null);
								bean.setPayType((short) 1);
								bean.setStatus((short) 1);
								bean.setPayDate(param.getGmt_payment());
								bean.setPayNumber(param.getTrade_no());
								bean.setPayAccount(param.getBuyer_logon_id());
								incomeService.saveIncomeAndFlow(bean, null, null);
							}
							// 2.写入交易日志
							logUtil.savePayLog(param.getOut_trade_no(), (short) 0, (short) 1, (short) 4,
									bean.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
									PayController.class.toString(), "alipayCallback", "支付宝支付成功", true, null, request);
							// 3.取消微信预下单信息
							cancelPreparaOrder(param.getOut_trade_no(), true, false, request);// 取消微信订单
							// 4.返回接收成功信息
							PrintWriter out = response.getWriter();
							out.print(returnData);
							out.flush();
							out.close();
						}
					}
				}
			}
		} catch (Exception e) {
			e.getStackTrace();
			log.error("*********************" + e.getMessage());
		}
	}

	/**
	 * 根据抽样单号生成报告打印条形码
	 * 
	 * @description
	 * @param qrCode
	 * @param reportNumber 重打取报告码：可选
	 * @param collectCode  收样取报告码
	 * @param unitId 委托单位ID
	 * @param responses
	 * @param requests
	 * @throws AlipayApiException
	 * @author xiaoyl
	 * @date 2019年7月8日
	 */
	@RequestMapping(value = "/generatorQrCode")
	@ResponseBody
	public void generatorQrCode(@Param("qrCode") String qrCode,
			@RequestParam(required = false, name = "reportNumber") String reportNumber,
			@RequestParam(required = false, name = "collectCode") String collectCode,
			@RequestParam(required = false, name = "scan") String scan,
			@RequestParam(required = false, name = "unitId") Integer unitId,
			HttpServletResponse responses,
			HttpServletRequest requests) throws AlipayApiException {
		responses.setHeader("Pragma", "no-cache");
		responses.setHeader("Cache-Control", "no-cache");
		responses.setDateHeader("Expires", 0);
		responses.setContentType("image/jpeg");
		try {
			// 流输出
			ServletOutputStream sos = responses.getOutputStream();
//			log.info("************************************" + qrCode + sos);
			// 生成二维码
			if (StringUtil.isNotEmpty(reportNumber)) {
				qrCode += "&rN=" + reportNumber;
			}
			if (StringUtil.isNotEmpty(collectCode)) {
				qrCode += "&collectCode=" + collectCode;
			}
			if (StringUtil.isNotEmpty(scan)) {
				qrCode += "&scan=" + scan;
			}
			if (StringUtil.isNotEmpty(unitId)) {
				qrCode += "&requestId=" + unitId;
			}
			BufferedImage image = QrcodeUtil.generateQrcode(qrCode, 150, 150);
			ImageIO.write(image, "png", sos);
			sos.close();
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
	}

	/**
	 * 根据抽样单号生成收样一维码
	 * 
	 * @description
	 * @param qrCode
	 * @param reportNumber 取报告码：可选
	 * @param responses
	 * @param requests
	 * @throws AlipayApiException
	 * @author xiaoyl
	 * @date 2019年7月8日
	 */
	@RequestMapping(value = "/generatorBarCode")
	@ResponseBody
	public void generatorBarCode(@Param("qrCode") String qrCode, Integer width, Integer height,
			HttpServletResponse responses, HttpServletRequest requests) throws AlipayApiException {
		responses.setHeader("Pragma", "no-cache");
		responses.setHeader("Cache-Control", "no-cache");
		responses.setDateHeader("Expires", 0);
		responses.setContentType("image/jpeg");
		try {
			if (width == null) {
				width = 150;
			}
			if (height == null) {
				height = 50;
			}
			// 流输出
			ServletOutputStream sos = responses.getOutputStream();
			BufferedImage image = QrcodeUtil.generateQrcode2(qrCode, width, height);
			ImageIO.write(image, "png", sos);
			sos.close();
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
	}

	// 取消订单
	@RequestMapping(value = "/cancelOrder")
	@ResponseBody
	public AjaxJson cancelOrder(Integer incomeId, Integer samplingId, String orderid, HttpServletRequest request,
			HttpServletResponse response) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Income bean = incomeService.getById(incomeId);
			HttpSession session = ContextHolderUtils.getSession();
			InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
			// 1.取消支付后台订单
			int count = cancelPreparaOrder(orderid, true, true, request);
			if (count == 1 || bean.getStatus()==1) {// 订单已支付成功，不予取消
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("订单已支付成功，无法取消订单！");
				ajaxJson.setObj(bean);
				return ajaxJson;
			}else {
				// 2.取消系统后台订单、支付记录
				incomeService.cancelPayOrder(bean, user, request);
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("订单取消失败，请联系管理员！");
			log.error("*********************" + e.getMessage());
		}
		logUtil.saveOperatorLog((short) 0, ModularConstant.OPERATION_MODULE_ORDER, PayController.class.toString(),
				"cancelOrder", "取消订单", ajaxJson.isSuccess(), ajaxJson.getMsg(), request);
		return ajaxJson;
	}

	/**
	 * 
	 * @description
	 * @param orderid   订单号
	 * @param weixinPay 取消微信订单
	 * @param alipy     取消支付宝订单
	 * @return
	 * @author xiaoyl
	 * @date 2019年7月8日
	 */
	/*
	 * public int cancelPreparaOrder(String orderid, Boolean weixinPay, Boolean
	 * alipy, HttpServletRequest requests) { int count = 0; boolean success = true;
	 * String message = ""; try { if (alipy) {// 取消支付宝订单信息 Map<String, String> map =
	 * new HashMap<String, String>(); AlipayClient alipayClient = new
	 * DefaultAlipayClient(SystemConfigUtil.ALIPAY_CONFIG.getString(
	 * "open_api_domain"), SystemConfigUtil.ALIPAY_CONFIG.getString("appid"),
	 * SystemConfigUtil.ALIPAY_CONFIG.getString("private_key"),
	 * "json",SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
	 * SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
	 * SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type")); // 获得初始化的AlipayClient
	 * AlipayTradeCancelRequest request = new AlipayTradeCancelRequest();
	 * map.put("out_trade_no", orderid); String returndata =
	 * JSONObject.fromObject(map).toString(); request.setBizContent(returndata); //
	 * 设置业务参数 AlipayTradeCancelResponse response = alipayClient.execute(request);//
	 * 通过alipayClient调用API，获得对应的response类 JSONObject query_response =
	 * JSONObject.fromObject(response.getBody())
	 * .getJSONObject("alipay_trade_cancel_response"); String code =
	 * query_response.getString("code"); String msg =
	 * query_response.getString("msg"); if (code.equals("10000") &&
	 * msg.equals("Success")) { log.info("支付宝订单取消成功"); } else { success = false;
	 * message = "支付宝订单取消失败"; log.info(message); count=1; }
	 * logUtil.savePayLog(orderid, (short) 0, (short) 1, (short) 3, 0,
	 * ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(),
	 * "cancelPreparaOrder", "取消支付宝预支付订单", success, message, requests); } if
	 * (weixinPay) {// 取消微信订单信息 // 取消微信订单 success = true; message = "";
	 * HashMap<String, String> mapWeixin = new HashMap<String, String>(); String
	 * nonce_str = WXPayUtil.genNonceStr(); mapWeixin.put("appid",
	 * SystemConfigUtil.WEIPAY_CONFIG.getString("w_appid")); mapWeixin.put("mch_id",
	 * SystemConfigUtil.WEIPAY_CONFIG.getString("w_mch_id"));// 商户id
	 * mapWeixin.put("out_trade_no", orderid); mapWeixin.put("nonce_str",
	 * nonce_str);// 随机字符串 32位以内 String str = WXPayUtil.generateSignedXml(mapWeixin,
	 * SystemConfigUtil.WEIPAY_CONFIG.getString("w_weiPriKry"), SignType.MD5);
	 * InputStream is =
	 * WXPayUtil.sendXMLDataByPost(SystemConfigUtil.WEIPAY_CONFIG.getString(
	 * "w_order_cancel_url"), str).getEntity() .getContent(); ByteArrayOutputStream
	 * out = new ByteArrayOutputStream(); byte[] buf = new byte[1024]; int len;
	 * while ((len = is.read(buf)) != -1) { out.write(buf, 0, len); } String string
	 * = out.toString("UTF-8"); Map<String, String> xmlToMap2 =
	 * WXPayUtil.xmlToMap(string); if (xmlToMap2.get("result_code").equals("FAIL"))
	 * { success = false; message = "微信订单关闭失败"; log.error(message); count=1; }
	 * logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 3, 0,
	 * ModularConstant.OPERATION_MODULE_PAY, PayController.class.toString(),
	 * "cancelPreparaOrder", "取消微信预支付订单", success, message, requests); } } catch
	 * (Exception e) { log.error("*********************" + e.getMessage()); } return
	 * count; }
	 */
	public int cancelPreparaOrder(String orderid, Boolean weixinPay, Boolean alipy, HttpServletRequest requests) {
		int count = 0;
		boolean success = true;
		String message = "";
		try {
			if (alipy) {// 取消支付宝订单信息
				Map<String, String> map = new HashMap<String, String>();
				AlipayClient alipayClient = new DefaultAlipayClient(
						SystemConfigUtil.ALIPAY_CONFIG.getString("open_api_domain"),
						SystemConfigUtil.ALIPAY_CONFIG.getString("appid"),
						SystemConfigUtil.ALIPAY_CONFIG.getString("private_key"), "json",
						SystemConfigUtil.ALIPAY_CONFIG.getString("charset"),
						SystemConfigUtil.ALIPAY_CONFIG.getString("alipay_public_key"),
						SystemConfigUtil.ALIPAY_CONFIG.getString("sign_type")); // 获得初始化的AlipayClient
				AlipayTradeCloseRequest request = new AlipayTradeCloseRequest();
				map.put("out_trade_no", orderid);
				String returndata = JSONObject.fromObject(map).toString();
				request.setBizContent(returndata); // 设置业务参数
				AlipayTradeCloseResponse response = alipayClient.execute(request);// 通过alipayClient调用API，获得对应的response类
				JSONObject query_response = JSONObject.fromObject(response.getBody())
						.getJSONObject("alipay_trade_close_response");
				String code = query_response.getString("code");
				String msg = query_response.getString("msg");
				if (code.equals("10000") && msg.equals("Success")) {
					log.info("支付宝订单关闭成功");
				} else if (code.equals("40004")) {// 未扫描二维码暂未生成后台订单，直接返回即可
					log.info("未扫描二维码暂未生成后台订单");
				} else {
					success = false;
					message = "支付宝订单关闭失败";
					log.info(message);
					count = 1;
				}
				logUtil.savePayLog(orderid, (short) 0, (short) 1, (short) 3, 0, ModularConstant.OPERATION_MODULE_PAY,
						PayController.class.toString(), "cancelPreparaOrder", "取消支付宝预支付订单", success, message, requests);
			}
			if (weixinPay) {// 取消微信订单信息
				// 取消微信订单
				success = true;
				message = "";
				HashMap<String, String> mapWeixin = new HashMap<String, String>();
				String nonce_str = WXPayUtil.genNonceStr();
				mapWeixin.put("appid", SystemConfigUtil.WEIPAY_CONFIG.getString("w_appid"));
				mapWeixin.put("mch_id", SystemConfigUtil.WEIPAY_CONFIG.getString("w_mch_id"));// 商户id
				mapWeixin.put("out_trade_no", orderid);
				mapWeixin.put("nonce_str", nonce_str);// 随机字符串 32位以内
				String str = WXPayUtil.generateSignedXml(mapWeixin,
						SystemConfigUtil.WEIPAY_CONFIG.getString("w_weiPriKry"), SignType.MD5);
				InputStream is = WXPayUtil
						.sendXMLDataByPost(SystemConfigUtil.WEIPAY_CONFIG.getString("w_order_cancel_url"), str)
						.getEntity().getContent();
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				byte[] buf = new byte[1024];
				int len;
				while ((len = is.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				String string = out.toString("UTF-8");
				Map<String, String> xmlToMap2 = WXPayUtil.xmlToMap(string);
				if (xmlToMap2.get("result_code").equals("FAIL")) {
					success = false;
					message = "微信订单关闭失败";
					log.error(message);
					count = 1;
				}
				logUtil.savePayLog(orderid, (short) 0, (short) 0, (short) 3, 0, ModularConstant.OPERATION_MODULE_PAY,
						PayController.class.toString(), "cancelPreparaOrder", "取消微信预支付订单", success, message, requests);
			}
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
		return count;
	}

	/**
	 * 获取request的参数集合，返回map格式 {orderid=1000120190909154156679, id=396}
	 * 
	 * @description
	 * @param request
	 * @return
	 * @author xiaoyl
	 * @date 2019年9月9日
	 */
	public Map<String, String> showParams(HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		Enumeration paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();
			String[] paramValues = request.getParameterValues(paramName);
			if (paramValues.length > 0) {
				String paramValue = paramValues[0];
				if (paramValue.length() != 0) {
					map.put(paramName, paramValue);
				}
			}
		}
		return map;
	}
}
