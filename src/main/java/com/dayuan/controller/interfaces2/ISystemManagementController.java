package com.dayuan.controller.interfaces2;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dayuan.bean.InterfaceJson;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;

/**
 * 系统软件版本管理接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iSystem")
public class ISystemManagementController extends BaseInterfaceController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 获取软件最新版本
	 * @param appName 软件类型
	 * @param machineCode 机身码
	 * @return
	 */
	@RequestMapping(value = "/checkVersion")
	public InterfaceJson checkVersion(HttpServletRequest request, String appType, String machineCode){
		
		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			required(appType, WebConstant.INTERFACE_CODE1, "参数appType不能为空");
			
			StringBuffer subffer=new StringBuffer();
			subffer.append(" select app_type, app_name, version, url_path, description, imp_date, delete_flag, "
					+ " file_size, introduce, update_content, param1, param2, param3, null param4, null param5 "
					+ " from t_s_system_manager where app_type=? and imp_date <= now() and delete_flag=0 order by version desc LIMIT 0,1;");
			List<Map<String, Object>> map=jdbcTemplate.queryForList(subffer.toString(), appType);
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
