package com.dayuan.controller.interfaces;

import java.util.List;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Cache;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MyException;
import com.dayuan.util.CacheManager;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;

public class BaseInterfaceController extends BaseController {

	private Logger iErrLog = Logger.getLogger("iERR");

	/**
	 * 分页
	 * @param sql
	 * @param pageNumber	页码 0：不分页；>=1：分页
	 * @param recordNumber	每页数量
	 */
	public void limit(StringBuffer sql, String pageNumber, String recordNumber) {

		//页码
		int pNum = 1;
		if(StringUtil.isNumeric(pageNumber)){
			pNum = Integer.parseInt(pageNumber);
		}

		//每页数量
		int rNum = 50;
		if(StringUtil.isNumeric(recordNumber)){
			rNum = Integer.parseInt(recordNumber);
		}

		if(pNum > 0 && rNum > 0){
			sql.append(" LIMIT "+ ((pNum-1)*rNum < 0 ? 0 : (pNum-1)*rNum) +", "+rNum);
		}

	}
	
	/**
	 * 设置接口请求异常错误代码
	 * @param aj
	 * @param resultCode 错误码
	 * @param msg 提示信息
	 * @return
	 */
	public static final AjaxJson setAjaxJson(AjaxJson aj, String resultCode, String msg){
		aj.setResultCode(resultCode);
		aj.setMsg(msg);
		aj.setSuccess(false);
		return aj;
	}

	/**
	 * 设置接口请求异常错误代码
	 * @param aj
	 * @param resultCode 错误码
	 * @param msg 提示信息
	 * @return
	 */
	public AjaxJson setAjaxJson(AjaxJson aj, String resultCode, String msg, Exception e){
		iErrLog.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		aj.setResultCode(resultCode);
		aj.setMsg(msg);
		aj.setSuccess(false);
		return aj;
	}
	
	
	/**
	 * 接口参数必填验证
	 * @param obj 验证参数
	 * @param tipsCode 错误码
	 * @param tipsMsg 提示信息
	 * @throws MyException 
	 */
	public static final void required(Object obj, String tipsCode, String tipsMsg) throws MyException{
		if(!StringUtil.isNotEmpty(obj)){
			throw new MyException("接口参数错误", tipsMsg, tipsCode);
		}
	}
	
	/**
	 * 接口多参数必填验证
	 * @param objs 验证参数集合
	 * @param tipsCode 错误码
	 * @param tipsMsg 提示信息
	 * @throws MyException 
	 */
	public static final void required(List<Object> objs, String tipsCode, String tipsMsg) throws MyException{
		if (objs == null) {
			throw new MyException("接口参数错误", tipsMsg, tipsCode);
		}
		for(Object obj : objs){
			if(!StringUtil.isNotEmpty(obj)){
				throw new MyException("接口参数错误", tipsMsg, tipsCode);
			}
		}
	}
	
	/**
	 * 接口时间参数验证（时间参数格式，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss
	 * @param time 验证参数
	 * @param tipsCode 错误码
	 * @param tipsMsg 提示信息
	 * @throws MyException 
	 */
	public static final void checkTime(String time, String tipsCode, String tipsMsg) throws MyException{
		if (!DateUtil.checkDate(time)) {
			throw new MyException("接口参数错误", tipsMsg, tipsCode);
		}
	}
	
	public TSUser tokenExpired(String userToken) throws MyException{
		//更新、清除token
		Cache cache = CacheManager.getCacheInfo(userToken);
		TSUser user = null;
		if(cache != null){
			user = (TSUser) cache.getValue();
			if (null != user && System.currentTimeMillis() < cache.getTimeOut()) {
				//更新token有效期
				Long dt = System.currentTimeMillis() + Integer.parseInt(WebConstant.res.getString("cache.timeOut"));
				CacheManager.resetCacheInfo(cache.getKey(), cache, dt);
			} else {
				//user不存在或用户token已失效,进行缓存清除
				CacheManager.clearOnly(cache.getKey());
				throw new MyException("接口参数错误", "token已失效，请重新登录！", WebConstant.INTERFACE_CODE6);
			}
		}else{
			//无效token
			throw new MyException("接口参数错误", "token已失效，请重新登录！", WebConstant.INTERFACE_CODE6);
		}
		
		return user;
	}
	
}
