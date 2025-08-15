package com.dayuan.controller.interfaces2;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.log.TSErrorLog;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.log.TSErrorLogService;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * APP配置接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iAppConfig")
public class IAppConfigController extends BaseInterfaceController {
	
	/**
	 * 读取APP配置
	 */
	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public InterfaceJson get(HttpServletRequest request, HttpServletResponse response, String userToken) {
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//token校验
			TSUser user = tokenExpired(userToken);

			Map map = new HashMap(3);
			//打卡范围
			map.put("clockInRange", SystemConfigUtil.APP_PROGRAM_CONFIG.getString("clockInRange"));
			aj.setObj(map);

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	

}
