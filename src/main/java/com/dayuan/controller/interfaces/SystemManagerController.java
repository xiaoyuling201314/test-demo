package com.dayuan.controller.interfaces;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;

/**
 * 系统软件版本管理接口
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年11月6日
 */
@Controller
@RequestMapping("/upload")
public class SystemManagerController extends BaseInterfaceController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 获取软件最新版本
	 * @param appName 软件类型
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/checkVersion")
	public AjaxJson checkVersion(HttpServletRequest request, String appName){
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			required(appName, WebConstant.INTERFACE_CODE1, "参数appName不能为空");
			
			StringBuffer subffer=new StringBuffer();
			subffer.append(" select id, app_type, app_name, version, url_path, description, imp_date, delete_flag, create_by, create_date, update_by, update_date, "
					+ "param1, param2, param3, file_size, upload_state, introduce, update_content "
					+ "from t_s_system_manager where app_type=? and imp_date <= now() and delete_flag=0 order by version desc LIMIT 0,1;");
			List<Map<String, Object>> map=jdbcTemplate.queryForList(subffer.toString(), appName);
			if(map.size()>0){
				Map<String, Object> mapBean=map.get(0);
				mapBean.put("url_path", WebConstant.res.getString("resourcesUrl") + "/" + mapBean.get("url_path") );	//下载地址改为绝对地址
				aj.setObj(mapBean);
			}
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
}
