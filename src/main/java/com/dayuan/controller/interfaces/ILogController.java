package com.dayuan.controller.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.log.TSErrorLog;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.log.TSErrorLogService;

/**
 * 日志接口
 * @Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2017年11月15日
 */
@Controller
@RequestMapping("/interfaces/log")
public class ILogController extends BaseInterfaceController {
	
	@Autowired
	private TSErrorLogService errorLogService;
	
	/**
	 * 上传仪器错误日志
	 */
	@ResponseBody
	@RequestMapping(value = "/deviceLog", method = RequestMethod.POST)
	public AjaxJson deviceLog(HttpServletRequest request, HttpServletResponse response, String userToken, TSErrorLog log) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(log.getDeviceType(), WebConstant.INTERFACE_CODE1, "参数deviceType不能为空");
			required(log.getDeviceVersion(), WebConstant.INTERFACE_CODE1, "参数deviceVersion不能为空");
			required(log.getTime(), WebConstant.INTERFACE_CODE1, "参数time不能为空");
			required(log.getErrorMessage(), WebConstant.INTERFACE_CODE1, "参数errorMessage不能为空");
			
			PublicUtil.setCommonForTable(log, true, user);
			errorLogService.insertSelective(log);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	

}
