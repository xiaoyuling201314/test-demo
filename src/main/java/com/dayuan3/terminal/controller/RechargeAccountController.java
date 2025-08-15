package com.dayuan3.terminal.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dayuan3.common.mapper.AccountFlowMapper;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.common.model.AccountFlowQueryModel;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.terminal.service.TopupActivitiesDetailService;

/**
 * 余额充值
 *
 * @author Dz
 * @date 2019年7月2日
 */
@Controller
@RequestMapping("/balance")
public class RechargeAccountController extends BaseController {

	private Logger log = Logger.getLogger(RechargeAccountController.class);

	@Autowired
	private IncomeService incomeService;

	@Autowired
	private InspectionUserAccountService accountService;

	@Autowired
	private CommonLogUtilService logUtil;

	@Autowired
	private PayController payController;
	
	@Autowired
	private TopupActivitiesDetailService activitiesDetailService;
	@Autowired
	private AccountFlowService flowService;
	

	/**
	 * 进入会员页面
	 *
	 * @return
	 */

	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			InspectionUserAccount userAccount = accountService.queryAccountByUserId(user.getId());
			if (userAccount != null) {
				map.put("totalMoney", userAccount.getTotalMoney());
			}
			map.put("userAccount", userAccount);
			System.out.println(SystemConfigUtil.RECHARGE_CONFIG.getString("detail")); //
			map.put("rechargeConfig", SystemConfigUtil.RECHARGE_CONFIG.getString("detail"));
		} catch (MissSessionExceprtion e) {
			log.error("**************************" + e.getMessage());
			return new ModelAndView("/terminal/index", map);
		}
		return new ModelAndView("/terminal/balance/list", map);
	}
	/**
	 * 数据列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(AccountFlowQueryModel model,Page page,HttpServletResponse response) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		try {
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			model.setUserId(user.getId());

			page = flowService.loadDatagrid(page, model,
					AccountFlowMapper.class, "loadDatagrid", "getRowTotal");;
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 进入充值页面
	 *@param incomeId 交易明细ID，用于充值成功后返回订单待支付页面
	 * @return
	 */

	@RequestMapping("/prepareList")
	public ModelAndView prepareList(HttpServletRequest request,Integer incomeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			//TODO
			if(CommonDataController.activitie!=null) {
				map.put("activitie", JSONObject.toJSONString(CommonDataController.activitie));
				map.put("activitieUuid", CommonDataController.activitie_uuid);
			}else {
				map.put("rechargeConfig", SystemConfigUtil.RECHARGE_CONFIG.getString("detail"));
			}
			request.getSession().setAttribute("incomeId", incomeId);
		} catch (MissSessionExceprtion e) {
			log.error("**************************" + e.getMessage());
			return new ModelAndView("/terminal/index", map);
		}
		return new ModelAndView("/terminal/balance/rechargeMoney", map);
	}

	/**
	 * 提交充值申请
	 * 
	 * @description
	 * @return
	 * @author xiaoyl
	 * @date 2019年10月28日
	 */

	@RequestMapping("/prepareRecharge")
	@ResponseBody
	public AjaxJson prepareRecharge(Integer rechargeMoney, @RequestParam(required = false) Integer topupId,
			@RequestParam(required = false) Integer topupDetailId,@RequestParam(required = false) String activitieUuid,
			@RequestParam(required = false)String topupRemark,HttpServletRequest request) {
		AjaxJson jsonObject = new AjaxJson();
		Income income = null;
		try {
			if(StringUtil.isNotEmpty(activitieUuid) && !activitieUuid.equals(CommonDataController.activitie_uuid)) {//充值活动已结束，提示用户重新选择
				jsonObject.setResultCode("10005");
				jsonObject.setSuccess(false);
				return jsonObject;
			}
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			if (null == user) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("请重新登录！");
				return jsonObject;
			}
			Date now = new Date();
			income = new Income(GeneratorOrder.generate(user.getId()), null, (short) 0, (short) 2, rechargeMoney,
					user.getId().toString(), now, user.getId().toString(), now);
			BigDecimal giftMoney=null;
			if(topupId!=0) {
				List<TopupActivitiesDetail> list=CommonDataController.activitie.getDetailList();
				for (TopupActivitiesDetail detail : list) {
					if(detail.getId()==topupDetailId) {
						giftMoney=detail.getGiftMoney();
						break;
					}
				}
			}
			AccountFlow flow = new AccountFlow(topupId, topupDetailId, rechargeMoney, now, (short) 1,0);
			flow.setRemark(topupRemark);
			incomeService.saveIncomeAndFlow(income, flow,user);
			jsonObject.setObj(income);
		} catch (Exception e) {
			log.error("**************************" + e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败，请联系工作人员！");
		}
		logUtil.savePayLog(income.getNumber(), (short) 0, (short) 2, (short) 1, rechargeMoney, ModularConstant.OPERATION_MODULE_PAY,
				RechargeAccountController.class.toString(), "prepareRecharge", "提交充值申请生成余额交易信息，状态为待支付", jsonObject.isSuccess(), jsonObject.getMsg(), request);
		return jsonObject;
	}

	/**
	 * 进入支付页面
	 *
	 * @return
	 */

	@RequestMapping("/rechargeList")
	public ModelAndView rechargeList(Integer incomeId,Integer topupDetailId,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Income bean = incomeService.getById(incomeId);
			BigDecimal giftMoney=new BigDecimal(0);
			if(topupDetailId!=0) {
				TopupActivitiesDetail detail=activitiesDetailService.queryById(topupDetailId);
				giftMoney=detail.getGiftMoney();
			}
			map.put("giftMoney",giftMoney);
			//TODO 查找优惠活动
			map.put("bean", bean);
			map.put("weiPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("weiPay"));
			map.put("aliPay", SystemConfigUtil.PAYTYPE_CONFIG.getString("aliPay"));
		} catch (Exception e) {
			log.error("**************************" + e.getMessage());
			return new ModelAndView("/terminal/index", map);
		}
		return new ModelAndView("/terminal/balance/payList", map);
	}

	/**
	 * 取消订单
	 * 
	 * @description
	 * @param incomeId
	 * @param samplingId
	 * @param orderid
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date 2019年10月29日
	 */

	@RequestMapping(value = "/cancelOrder")
	@ResponseBody
	public AjaxJson cancelOrder(Integer incomeId, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			HttpSession session = ContextHolderUtils.getSession();
			InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
			Income bean = incomeService.getById(incomeId);
			if(bean.getStatus()==1) {//支付成功
				ajaxJson.setResultCode("10004");
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("订单已支付成功，无法取消订单！");
				ajaxJson.setObj(bean);
				return ajaxJson;
			}else if(bean.getStatus()==0){//待支付
				int count=payController.cancelPreparaOrder(bean.getNumber(), true, true, request);
				if(count==1) {
					ajaxJson.setResultCode("10004");
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("订单已支付成功，无法取消订单！");
					ajaxJson.setObj(bean);
					return ajaxJson;
				}
				count = incomeService.cancelRechargeOrder(incomeId, user, request);
				if (count == 0) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("订单取消失败，请联系管理员！");
					return ajaxJson;
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("订单取消失败，请联系管理员！");
			log.error("*********************" + e.getMessage());
			return ajaxJson;
		}
		logUtil.saveOperatorLog((short) 0, ModularConstant.OPERATION_MODULE_ORDER, RechargeAccountController.class.toString(),
				"cancelOrder", "取消订单", ajaxJson.isSuccess(), ajaxJson.getMsg(), request);
		return ajaxJson;
	}

	/**
	 * 充值成功
	 * 
	 * @description
	 * @param incomeId
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date 2019年10月30日
	 */
	@RequestMapping(value = "/paySuccess")
	public ModelAndView paySuccess(Integer incomeId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			AccountFlow bean=flowService.queryByIncomeId(incomeId);
			Income icome=incomeService.getById(bean.getIncomeId());
			InspectionUserAccount userAccount = accountService.queryAccountByUserId(Integer.valueOf(bean.getCreateBy()));
			map.put("userAccount", userAccount);
			map.put("bean", bean);
			map.put("payNumber", icome.getPayNumber());
		} catch (Exception e) {
			log.error("*********************" + e.getMessage());
		}
		return new ModelAndView("/terminal/balance/paySuccess", map);
	}

	@RequestMapping(value = "/setPayPassword")
	@ResponseBody
	public AjaxJson setPayPassword(String payPassword,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			HttpSession session = ContextHolderUtils.getSession();
			InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
			InspectionUserAccount bean=accountService.queryAccountByUserId(user.getId());
			bean.setUpdateBy(user.getId().toString());
			bean.setUpdateDate(new Date());
			bean.setPayPassword(CipherUtil.generatePassword(payPassword));
			accountService.saveOrUpdate(bean);
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("密码设置失败，请联系管理员！");
			log.error("*********************" + e.getMessage());
			return ajaxJson;
		}
		return ajaxJson;
	}
	/**
	 * 余额支付
	 * @description
	 * @param incomeId
	 * @param payPassword
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	@RequestMapping(value = "/balancePay")
	@ResponseBody
	public AjaxJson balancePay(Integer incomeId,String payPassword,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson ajaxJson = new AjaxJson();
		Income income= null;
		try {
			HttpSession session = ContextHolderUtils.getSession();
			InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
			InspectionUserAccount bean=accountService.queryAccountByUserId(user.getId());
			income= incomeService.getById(incomeId);
			if(income.getStatus()==1) {//订单已支付完成，不再进行查询
//				if(income.getPayType()==0) {//微信支付
//					payController.cancelPreparaOrder(income.getNumber(), false, true, request);// 取消支付宝订单
//				}else if(income.getPayType()==1) {//支付宝支付
//					payController.cancelPreparaOrder(income.getNumber(), true, false, request);// 取消微信订单
//				}
				return ajaxJson;
			}else {
				//1.校验密码是否正确
				/*if(StringUtil.isEmpty(bean.getPayPassword())) {//为设置密码
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("请先前往余额管理设置支付密码！");
					return ajaxJson;
				}*/
				if(!CipherUtil.generatePassword(payPassword).equals(bean.getPayPassword())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("密码错误");
					return ajaxJson;
				}
				if(bean.getTotalMoney()>(income.getMoney()+income.getReportMoney())){//余额充足
					//2.更新订单状态、交易明细，以及扣款信息
					income.setPayType((short)2);
					income.setStatus((short) 1);
					income.setPayDate(new Date());
					income.setPayNumber(income.getNumber());
					incomeService.payMentForOrder(income, null, (short)2, (short)2);
					ajaxJson.setObj(income);
					// .写入交易日志
					logUtil.savePayLog(income.getNumber(), (short) 0, (short) 2, (short) 4,
							income.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
							RechargeAccountController.class.toString(), "balancePay", "余额支付成功", true, null, request);
					//3. 关闭微信、支付宝订单
//					payController.cancelPreparaOrder(income.getNumber(), true, true, request);
				}else {//余额不足
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("余额不足，请更换其他支付方式！");
					return ajaxJson;
				}
				
			}
			
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("余额支付失败，请联系管理员！");
			log.error("*********************" + e.getMessage());
			return ajaxJson;
		}
		logUtil.savePayLog(income.getNumber(), (short) 0, (short) 2, (short) 4, income.getMoney(), ModularConstant.OPERATION_MODULE_PAY,
				RechargeAccountController.class.toString(), "balancePay", "余额支付", ajaxJson.isSuccess(), ajaxJson.getMsg(), request);
		return ajaxJson;
	}
}
