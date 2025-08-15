package com.dayuan.controller.ledger;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.ledger.BaseLedgerUser;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.ledger.BaseLedgerUserModel;
import com.dayuan.service.ledger.BaseLedgerUserService;
import com.dayuan.util.StringUtil;

/** 监管对象管理
 * @Description:
 * @Company:食安科技
 * @author Dz
 * @date 2017年8月15日 */
@Controller
@RequestMapping("/ledger/regulatoryUser")
public class BaseLedgerUserController extends BaseController {

	private final Logger log = Logger.getLogger(BaseLedgerUserController.class);

	@Autowired
	private BaseLedgerUserService ledgerUserService;
	
	/** 市场或者经营户生成创建账号密码 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request, HttpServletResponse response, BaseLedgerUser regUser) {
		AjaxJson aj = new AjaxJson();
		Short type = regUser.getType();
		try {
			TSUser user = PublicUtil.getSessionUser();
			Date now = new Date();
			BaseLedgerUser LedgerUser=ledgerUserService.selectByUsername(regUser.getUsername());//通过账号查找
			if (regUser.getUsername() == null ||regUser.getPwd()==null) {
				aj.setSuccess(false);
				aj.setMsg("账号密码不能为空!");
				return aj;
			}
		if (type == 1) {// 市场方账号
			if (regUser.getRegId() == null || StringUtil.isEmpty(regUser.getRegName())) {
				aj.setSuccess(false);
				aj.setMsg("获取市场信息失败!请重试");
				return aj;
			}
		} else if (type == 0) {// 经营户账号
				if (regUser.getOpeId() == null || StringUtil.isEmpty(regUser.getOpeShopCode())) {
					aj.setSuccess(false);
					aj.setMsg("获取经营户信息失败!请重试");
					return aj;
				}
		}
		BaseLedgerUser LedUser=ledgerUserService.queryById(regUser.getId());
		if(LedUser!=null){//用户存在则更新
			if(LedgerUser!=null&& LedgerUser.getId()!=LedUser.getId()){
				aj.setSuccess(false);
				aj.setMsg("该账号已存在!请重新输入");
				return aj;
			}
			regUser.setUpdateBy(user.getId());
			regUser.setUpdateDate(now);
			ledgerUserService.updateBySelective(regUser);
		}else{
			BaseLedgerUser bean=new BaseLedgerUser();
			if (type == 1) {// 市场方账号
				 bean=	ledgerUserService.selectByRegOrBusiId(regUser.getRegId(), null);//通过市场id 查询 特殊情况下使用
			}else{
				 bean=	ledgerUserService.selectByRegOrBusiId(null, regUser.getOpeId());//通过经营户id 查询 特殊情况下使用
			}
			if(bean!=null){//账号已存在
				regUser.setId(bean.getId());
				regUser.setUpdateBy(user.getId());
				regUser.setUpdateDate(now);
				ledgerUserService.updateBySelective(regUser);
			}else{//账号不存在 
				if(LedgerUser!=null){
					aj.setSuccess(false);
					aj.setMsg("该账号已存在!请重新输入");
					return aj;
				}
				regUser.setCreateBy(user.getId());
				regUser.setCreateDate(now);
				regUser.setUpdateBy(user.getId());
				regUser.setUpdateDate(now);
				ledgerUserService.insertSelective(regUser);
			}
		}
		
			aj.setObj(regUser);
		} catch (Exception e) {
			aj.setSuccess(false);
			aj.setMsg("操作异常!");
			return aj;
		}
		return aj;
	}

	
	/**
	 * 获取经营户账号密码
	 * @param request
	 * @param opeId
	 * @param regId
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getLedgerUser")
	@ResponseBody
	public AjaxJson getLedgerUser(HttpServletRequest request, Integer opeId, Integer regId,  HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			BaseLedgerUser ledgerUser=		ledgerUserService.selectByRegOrBusiId(regId, opeId);	
			jsonObj.setObj(ledgerUser);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("获取信息失败");
		}
		return jsonObj;
	}
	
	/**
	 * 解除微信账号绑定
	 * @param request
	 * @param id
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/deleteOpenid")
	@ResponseBody
	public AjaxJson getLedgerUser(HttpServletRequest request, Integer id, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			ledgerUserService.deleteOpenid(id);
			jsonObj.setSuccess(true);
			jsonObj.setMsg("解除成功!");
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("解除失败!");
		}
		return jsonObj;
	}
}
