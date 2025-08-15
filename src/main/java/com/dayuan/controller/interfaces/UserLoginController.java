package com.dayuan.controller.interfaces;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dayuan.logs.aop.SystemLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.Cache;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSUserService;
import com.dayuan.util.CacheManager;
import com.dayuan.util.StringUtil;
import com.dayuan.util.Tools;

/**
 * 对外接口 Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月25日
 */
@Controller
@RequestMapping("/interfaces/userLogin")
public class UserLoginController extends BaseInterfaceController {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSUserService tSUserService;
	@Autowired
	private TSFunctionService functionService;
	@Autowired
	private TSOperationService operationService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private BasePointService basePointService;
	
	/**
	 * 
	 * @param userName 用户名
	 * @param password 密码
	 * @param deviceCode 机器码
	 * @param softWareVersion 软件名称和版本
	 * @param place GPS坐标
	 * @param ip IP地址
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@SystemLog(module = "用户管理",methods = "登录",type = 0,serviceClass = "tSUserService")
	public AjaxJson login(HttpServletRequest request, String userName, String password, String deviceCode, String softWareVersion, String place, String ip) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			required(userName, WebConstant.INTERFACE_CODE1, "参数userName不能为空");
			required(password, WebConstant.INTERFACE_CODE1, "参数password不能为空");
			
			TSUser user = tSUserService.getUserByUserName(userName);
			if (user == null || 1 == user.getDeleteFlag()) {
				throw new MyException("账号不存在", "账号不存在", WebConstant.INTERFACE_CODE7);
			} else if (!user.getPassword().equals(password)) {
				throw new MyException("密码错误", "密码错误", WebConstant.INTERFACE_CODE8);
			} else if (user.getStatus() == 1) {
				throw new MyException("账户被停用", "账户被停用", WebConstant.INTERFACE_CODE9);
			}
			
			//session保存登录用户
			user.setLoginCount((user.getLoginCount() + 1));
			user.setLoginTime(new Date());
			tSUserService.updateById(user);
            request.getSession().setAttribute(WebConstant.SESSION_USER, user);
            //session保存登录用户机构
            if (null != user.getDepartId()) {
                TSDepart depart = departService.getById(user.getDepartId());
                request.getSession().setAttribute(WebConstant.ORG, depart);
            }
            //session保存登录用户检测点
            if (null != user.getPointId()) {
                BasePoint point = basePointService.queryById(user.getPointId());
                request.getSession().setAttribute(WebConstant.POINT, point);
            }
			
			//用户菜单
			List<TSFunction>functions = functionService.queryByRoleId(user.getRoleId());
			Integer[] functionIds = new Integer[functions.size()];
			for(int i=0;i<functions.size();i++) {
				functionIds[i] = Integer.parseInt(functions.get(i).getId());
			}
			user.setFunctionId(functionIds);
			//用户权限
			List<TSOperation>operations = operationService.queryAllPrivilegs(user.getRoleId());
			String[] operationCodes = new String[operations.size()];
			for(int i=0;i<operations.size();i++) {
				operationCodes[i] = operations.get(i).getOperationCode();
			}
			user.setOperationCode(operationCodes);
			
			Map<String, Object> map = new HashMap<>();
			// 登录成功,生成token
			String token = Tools.randomNum(32);
			//暂存允许一个账号同时登录多台设备
//			Object oldToken=CacheManager.getCacheUser(user.getUserName());
//			if(oldToken!=null){//移除之前的token
//				CacheManager.clearOnly(oldToken.toString());
//			}
			Cache cache = new Cache(token, user, System.currentTimeMillis() + Integer.parseInt(WebConstant.res.getString("cache.timeOut")), false);
			CacheManager.putCache(cache.getKey(), cache,user.getUserName());
			map.put("token", token);
			
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("select ");
			sbuffer.append("u.*,d.id as d_id , d.depart_name as d_depart_name,");
			sbuffer.append(" d.description as d_description, d.depart_pid as d_depart_pid, d.project_id as d_project_id,");
			sbuffer.append(" d.principal_id as d_principal_id, d.region_id as d_region_id, d.depart_code as d_depart_code,");
			sbuffer.append(" d.depart_type as d_depart_type, d.mobile_phone as d_mobile_phone, ");
			sbuffer.append(" d.fax as d_fax, d.address as d_address, d.sorting as d_sorting, d.delete_flag as d_delete_flag,");
			sbuffer.append(" d.is_outsourcing as d_is_outsourcing, d.create_by as d_create_by, ");
			sbuffer.append(" d.create_date as d_create_date, d.update_by as d_update_by, d.update_date as d_update_date,");
			sbuffer.append(" p.id as p_id, p.point_name as p_point_name, p.point_code as p_point_code, p.point_type as p_point_type,");
			sbuffer.append(" p.depart_id as p_depart_id, p.region_id as p_region_id, p.manager_id as p_manager_id, p.license_plate as p_license_plate, ");
			sbuffer.append(" p.phone as p_phone, p.address as p_address, p.place_x as p_place_x,");
			sbuffer.append(" p.place_y as p_place_y, p.remark as p_remark, p.IMEI as p_IMEI, p.sorting as p_sorting, p.delete_flag as p_delete_flag, ");
			sbuffer.append(" p.create_by as p_create_by, p.create_date as p_create_date, p.update_by as p_update_by, p.update_date as p_update_date,");
			sbuffer.append(" (SELECT GROUP_CONCAT(tb1.id) FROM t_s_depart tb1 WHERE tb1.delete_flag = 0 AND tb1.depart_code LIKE CONCAT( " +
					" (SELECT tb2.depart_code FROM t_s_depart tb2 WHERE tb2.delete_flag = 0 AND id = u.depart_id), '%' " +
					")) as d_departs_id");
			sbuffer.append(" from t_s_user u");
			sbuffer.append(" LEFT JOIN t_s_depart d on u.depart_id=d.id");
			sbuffer.append(" LEFT JOIN base_point p on u.point_id=p.id");
			sbuffer.append(" where u.delete_flag=0 and u.status=0 and u.user_name=? and u.password=?");
			List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, password);
			Map<String, Object> map2 = null;
			if(mapList2!=null && mapList2.size()>0) {
				map2 = mapList2.get(0);
			}
			map.put("user", map2);
			
			sbuffer.delete(0, sbuffer.length());
			sbuffer.append(" select ");
			sbuffer.append(" IF(tb1.mark=0,(select function_id from t_s_role_function tb2 where tb2.id=tb1.id),");
			sbuffer.append(" (select tb3.operation_code from t_s_operation tb3 where tb3.delete_flag = 0 AND tb3.id=tb1.function_id)) as rightList");
			sbuffer.append(" from t_s_role_function tb1 where role_id=?");
			final List<String> rights=new ArrayList<>();
			jdbcTemplate.query(sbuffer.toString(), new Object[] { user.getRoleId() }, new RowCallbackHandler(){
				@Override
				public void processRow(ResultSet rest) throws SQLException {
					rights.add(rest.getString("rightList"));
				}
			});
			String rightStr="";
			for (String ids : rights) {
				if(StringUtil.isEmpty(ids)) {
					continue;
				}
				if(StringUtil.isEmpty(rightStr)){
					rightStr+=ids;
				}else{
					rightStr+=","+ids;
				}
			}
			map.put("rights",rightStr);
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 修改密码
	 * @author Dz
	 * @param userToken 用户token
	 * @param oldPassword 旧密码
	 * @param newPassword 新密码
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public AjaxJson resetPassword(HttpServletRequest request, String userToken, String oldPassword, String newPassword) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			required(newPassword, WebConstant.INTERFACE_CODE1, "参数newPassword不能为空");
			required(oldPassword, WebConstant.INTERFACE_CODE1, "参数oldPassword不能为空");
			
			if (!user.getPassword().equals(oldPassword)) {
				throw new MyException("原密码错误", "原密码错误", WebConstant.INTERFACE_CODE8);
			} else if (user.getStatus() == 1) {
				throw new MyException("账户被停用", "账户被停用", WebConstant.INTERFACE_CODE9);
			}
			
			user.setPassword(newPassword);
			PublicUtil.setCommonForTable(user, false, user);
			tSUserService.updateById(user);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	
	/**
	 * 注销
	 * @author Dz
	 * @param userToken
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/writeOff", method = RequestMethod.POST)
	public AjaxJson writeOff(HttpServletRequest request, String userToken) {
		
		AjaxJson aj = new AjaxJson();
		try {
			//必填验证
			TSUser user = tokenExpired(userToken);	//token验证
			
			//清空缓存
			Cache cache = CacheManager.getCacheInfo(userToken);
			CacheManager.clearOnly(cache.getKey());
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}

}
