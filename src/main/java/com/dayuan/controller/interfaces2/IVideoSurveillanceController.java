package com.dayuan.controller.interfaces2;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;

/**
 * 视频监控接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iVideoSurveillance")
public class IVideoSurveillanceController extends BaseInterfaceController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 获取摄像头
	 * @param request
	 * @param response
	 * @param userToken
	 * @return
	 */
	@RequestMapping(value = "/queryPointVideo", method = RequestMethod.POST)
	public InterfaceJson queryPointVideo(HttpServletRequest request, HttpServletResponse response, String userToken) {
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			List<Map<String, Object>> list = null;
			StringBuffer sbuffer = new StringBuffer();
			
			sbuffer.append("SELECT " + 
					"	id, depart_id, point_id, point_name, surveillance_name,  " + 
					"	ip, user_name, pwd, dev, register_date, video_type, video_url, " + 
					"	autostart, delete_flag " + 
					"FROM " + 
					"	base_point_video_surveillance WHERE 1=1 ");
			
			if(user.getPointId() != null) {		//检测点用户
				sbuffer.append(" AND point_id = ? ");
				list = jdbcTemplate.queryForList(sbuffer.toString(), user.getPointId());
				
			}else if (user.getRegId() != null) {	//监管对象用户
				
			}else if (user.getDepartId() != null) {	//机构用户
				sbuffer.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?), '%')) ");
				
				list = jdbcTemplate.queryForList(sbuffer.toString(), user.getDepartId());
			}
			
			aj.setObj(list);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
	}
	

}
