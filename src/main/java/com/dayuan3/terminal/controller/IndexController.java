package com.dayuan3.terminal.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.InspectionUnitUserService;

/**
 *  送检账号
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/terminal")
public class IndexController extends BaseController {
	private Logger log = Logger.getLogger(IndexController.class);
	@Autowired
	private InspectionUnitUserService insUnitUserService;
	
	@Autowired
	private InspectionUnitService inspectionUnitService;
	
	@Autowired
	private InspectionUserAccountService accountService;
	
	@Autowired
	private CommonLogUtilService logUtil;
	
	@RequestMapping({ "/index" })
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("weChatImg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("weChatImg"));
		return new ModelAndView("/terminal/index");
	}
	
	@RequestMapping({ "/toLogin" })
	public ModelAndView toLogin(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("/terminal/login");
	}
	/**
	 * 进入注册页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/register")
	public ModelAndView register(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		map.put("inspectionUnitPath", WebConstant.res.getString("inspectionUnitPath"));
		return new ModelAndView("/terminal/register", map);
	}

	@RequestMapping(value="/registerUser")
	@ResponseBody
	public  AjaxJson registerUser(InspectionUnitUser bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		//TODO
		try {
			//查询送检单位社会信用代码是否重复
//			InspectionUnit model=inspectionUnitService.queryByCreditCode(bean.getCreditCode());
			//检验手机号码是否重复
			InspectionUnitUser model=insUnitUserService.queryByPhone(bean.getPhone());
			if(model!=null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("该手机号码已被注册，请更换手机号码进行注册！");
			}else{
				//查询该送检单位是否有送检人员
				int count=insUnitUserService.queryCountByInspectId(bean.getInspectionId());
				 if(count>0) {
					 bean.setType(0);
				 }else {//第一个注册用户，默认管理员
					 bean.setType(1);
				 }
				 bean.setAccount(insUnitUserService.getNextAccount());
				 bean.setPassword(CipherUtil.generatePassword(bean.getPassword()));
				 bean.setCreateDate(new Date());
				insUnitUserService.insertSelective(bean);
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 校验手机号码是否可用
	 * @description
	 * @param phone
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月19日
	 */
	@RequestMapping(value="/checkPhone")
	@ResponseBody
	public  AjaxJson checkPhone(String  phone,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//检验手机号码是否重复
			InspectionUnitUser model=insUnitUserService.queryByPhone(phone);
			if(model!=null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("该手机号码已被注册，请更换手机号码进行注册！");
			}
			jsonObject.setObj(model);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 校验原密码是否正确
	 * @description
	 * @param id
	 * @param password
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月19日
	 */
	@RequestMapping(value="/checkPassword")
	@ResponseBody
	public  AjaxJson checkPassword(Integer id,String  password,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//检验手机号码是否重复
			InspectionUnitUser model=insUnitUserService.queryById(id);
			if(!model.getPassword().equals(CipherUtil.generatePassword(password))) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("原密码错误，请重新输入！");
			}
			jsonObject.setObj(model);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 修改登录密码
	 * @description
	 * @param id
	 * @param password
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月19日
	 */
	@RequestMapping(value="/updatePassword")
	@ResponseBody
	public  AjaxJson updatePassword(Integer id,String  password,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			InspectionUnitUser bean=insUnitUserService.queryById(id);
			bean.setPassword(CipherUtil.generatePassword(password));
			bean.setUpdateDate(new Date());
			 bean.setUpdateBy(user.getId().toString());
			insUnitUserService.updateBySelective(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 根据手机号码快捷注册用户，用户类型默认为个人
	 * @description
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月14日
	 */
	@RequestMapping(value="/registerUserByPhone")
	@ResponseBody
	public  AjaxJson registerUserByPhone(InspectionUnitUser bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		//TODO
		try {
			//检验手机号码是否重复
			InspectionUnitUser model=insUnitUserService.queryByPhone(bean.getPhone());
			Date d=new Date();
			if(bean.getId()==null) {//新增用户
					bean.setLoginCount((short) (bean.getLoginCount().shortValue() + 1));
					bean.setLoginTime(d);
					bean.setAccount(insUnitUserService.getNextAccount());
					bean.setPassword(CipherUtil.generatePassword(bean.getPassword()));
					bean.setCreateDate(d);
					if(bean.getUserType()==0) {//个人注册
						bean.setInspectionId(null);
					}else{//企业注册
						//查询该送检单位是否有送检人员
						/*int count=insUnitUserService.queryCountByInspectId(bean.getInspectionId());
						if(count>0) {
							bean.setType((short)0);
						}else {//第一个注册用户，默认管理员
							bean.setType((short)1);
						}*/
						//update by xiaoyl 2020-02-28 注册默认为送检用户
						bean.setIdentifiedNumber("");
					}
					bean.setType(0);
					insUnitUserService.insertSelective(bean);
					if(bean.getInspectionId()==null){//送检单位id 为空 新增
						if(!StringUtil.isEmpty(bean.getIdentifiedNumber())&&!StringUtil.isEmpty(bean.getInspectionName())){//公司信用代码、名称不为空
							InspectionUnit unit=inspectionUnitService.queryByCreditCode(bean.getIdentifiedNumber());
							if(unit==null){//公司不存在，新增记录
								unit=new InspectionUnit();
								unit.setCreateDate(d);
								unit.setCreateBy(bean.getId().toString());
								unit.setUpdateDate(d);
								inspectionUnitService.insertSelective(unit);
							}
							bean.setInspectionId(unit.getId());
							insUnitUserService.updateBySelective(bean);
						}
					}
					InspectionUnit unitList=inspectionUnitService.queryById(bean.getInspectionId());
					if(unitList!=null) {
//						bean.setTerminalUserType(unitList.getSupplier());
					}
					request.getSession().setAttribute("session_user_terminal", bean);
					//用户注册成功的同时开通余额账号 update by xiaoyl 2020/03/16
					 InspectionUserAccount account = new InspectionUserAccount(bean.getId(), 0,
							 0, 0, null, bean.getId().toString(), d,d);
					 account.setTotalMoney(0);
					 accountService.saveOrUpdate(account);
			}else {//修改用户信息
					model=insUnitUserService.queryById(bean.getId());
					 InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
					 bean.setUpdateBy(user.getId().toString());
					if(bean.getUserType()==1) {
						bean.setIdentifiedNumber(null);
					}
					insUnitUserService.updateBySelective(bean);
					if(bean.getInspectionId()==null){//送检单位id 为空 新增
						if(!StringUtil.isEmpty(bean.getIdentifiedNumber())&&!StringUtil.isEmpty(bean.getInspectionName())){//公司信用代码、名称不为空
							InspectionUnit unit=inspectionUnitService.queryByCreditCode(bean.getIdentifiedNumber());
							if(unit==null){//公司不存在，新增记录
								unit=new InspectionUnit();
								unit.setCreateDate(d);
								unit.setCreateBy(bean.getId().toString());
								unit.setUpdateDate(d);
								inspectionUnitService.insertSelective(unit);
							}
							bean.setInspectionId(unit.getId());
						}
					}
					insUnitUserService.updateBySelective(bean);
					if(bean.getUserType()==1) {//企业用户
						InspectionUnit unitList=inspectionUnitService.queryById(bean.getInspectionId());
						if(unitList!=null) {
//							bean.setTerminalUserType(unitList.getSupplier());
						}
					}
					request.getSession().setAttribute("session_user_terminal", bean);
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 用户登录
	 * @description
	 * @param userName
	 * @param password
	 * @param vcode
	 * @param request
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月2日
	 */
	@RequestMapping({ "/loginAjax" })
	@ResponseBody
	public AjaxJson loginAjax(String userName, String password, String vcode, HttpServletRequest request) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			String pwd = CipherUtil.generatePassword(password);
			InspectionUnitUser user = new InspectionUnitUser();
			user.setUserName(userName);
			user.setPassword(pwd);
			InspectionUnitUser loginUser = insUnitUserService.queryUser(user);
			if (loginUser != null ) {
				if(loginUser.getChecked()==1) {
					short count = (short) (loginUser.getLoginCount().shortValue() + 1);
					loginUser.setLoginCount(Short.valueOf(count));
					loginUser.setLoginTime(new Date());
					insUnitUserService.updateBySelective(loginUser);
					if(loginUser.getUserType()==1) {
						InspectionUnit unitList=inspectionUnitService.queryById(loginUser.getInspectionId());
						if(unitList!=null) {
//							loginUser.setTerminalUserType(unitList.getSupplier());
						}
					}
					request.getSession().setAttribute("session_user_terminal", loginUser);
				}else {
					ajaxJson.setMsg("checkPage");
					ajaxJson.setSuccess(false);
				}
				ajaxJson.setObj(loginUser);
			} else {
				ajaxJson.setMsg("用户名或密码不正确！");
				ajaxJson.setSuccess(false);
			}
		} catch (Exception e) {
			this.log.error("******************************" + e.getMessage() + e.getStackTrace());
			ajaxJson.setMsg("登录失败，请联系管理员！");
			ajaxJson.setSuccess(false);
		}
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_USER, IndexController.class.toString(), "login", "用户登录", ajaxJson.isSuccess(),ajaxJson.getMsg(), request);
		return ajaxJson;
	}
	/**
	  * 用户登录成功，进入自助下单页面
	 * @description
	 * @param type 用户类型： 0 个人，1 企业,2供应商
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @throws IOException 
	 * @date   2019年7月2日
	 */
	@RequestMapping({ "/goHome" })
	public ModelAndView goHome(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> map = new HashMap<String, Object>();
		InspectionUnitUser user=(InspectionUnitUser)request.getSession().getAttribute("session_user_terminal");
		if (null == user) {
			return new ModelAndView("/terminal/index");
		}
		map.put("balance", SystemConfigUtil.PAYTYPE_CONFIG.getString("balance"));
		map.put("userType", user.getTerminalUserType());
		request.getSession().removeAttribute("incomeId");
		return new ModelAndView("/terminal/home",map);
	}
	/**
	 * 送检用户退出，返回index主页面
	 * @description
	 * @param session
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月2日
	 */
	@RequestMapping({ "/logout" })
	public ModelAndView logout(HttpServletRequest request) {
		logUtil.saveOperatorLog((short)0, ModularConstant.OPERATION_MODULE_USER, IndexController.class.toString(), "logout", "用户退出", true, null, request);
		HttpSession session=request.getSession();
		session.removeAttribute("session_user_terminal");
		session.removeAttribute("incomeId");
		//session.invalidate();
		request.getSession().setAttribute("weChatImg", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("weChatImg"));
		return new ModelAndView("/terminal/index");
	}
	@RequestMapping({ "/checkPage" })
	public String checkPage(String userName,String pwd,HttpServletRequest request, HttpServletResponse response) {
		String returnUrl="";
		try {
			InspectionUnitUser user = new InspectionUnitUser();
			user.setUserName(userName);
			user.setPassword(pwd);
			InspectionUnitUser loginUser=insUnitUserService.queryUser(user);
			if(loginUser==null || loginUser.getChecked()==0) {
				returnUrl="/terminal/checkPage";
			}else {
				short count = (short) (1);
				loginUser.setLoginCount(Short.valueOf(count));
				loginUser.setLoginTime(new Date());
				insUnitUserService.updateBySelective(loginUser);
				request.getSession().setAttribute("session_user_terminal", loginUser);
				returnUrl="redirect:/terminal/goHome";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnUrl;
	}
}
