package com.dayuan.controller.interfaces2;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONArray;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.util.*;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.web.bind.annotation.*;

import com.dayuan.bean.Cache;
import com.dayuan.bean.InterfaceJson;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSOperation;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.system.TSOperationService;
import com.dayuan.service.system.TSUserService;

/**
 * 用户验证接口
 * @author Dz
 *
 */
@RestController
@RequestMapping("/iUserLogin")
public class IUserLoginController extends BaseInterfaceController {

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
	 * 登录
	 * @param userName	用户名
	 * @param password		密码
	 * @param deviceCode	机器码
	 * @param type 登录类型(0:云平台;1:APP;2:工作站)
	 * @param deviceVersion	硬件版本相关信息
	 * @param softWareVersion	软件名称和版本
	 * @param place	GPS坐标
	 * @param ip	IP地址
	 * @param outside	内外部接口标识（默认为0；0：外部接口，1：内部接口）
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@SystemLog(module = "用户管理",methods = "登录",type = 0, serviceClass = "tSUserService")
	public InterfaceJson login(HttpServletRequest request, String userName, String password, String deviceCode,  String type,
			String deviceVersion, String softWareVersion, String place, String ip, @RequestParam(required = true, defaultValue = "0") int outside) {
		
		InterfaceJson aj = new InterfaceJson();
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

			if(outside == 1) {
				//内部接口
				
				//用户信息
				sbuffer.append("SELECT " + 
						"	u.id, u.user_name, u.realname,	 " + 
						"	u.depart_id, u.point_id,	u.reg_id, " + 
						"	d.depart_name AS depart_name, " + 
						"	d.depart_code AS depart_code, " + 
						"	d.depart_type AS depart_type, " + 
						"	(SELECT GROUP_CONCAT(id) FROM t_s_depart " + 
						"		WHERE depart_code LIKE CONCAT(d.depart_code, '%') ) AS departs_id, " + 
						"	p.point_name AS point_name, p.point_type AS point_type, " + 
						"	p.place_x, p.place_y, " +
						"	NULL AS param1, NULL AS param2, NULL AS param3 " +
						"FROM " +
						"	t_s_user u " + 
						"LEFT JOIN t_s_depart d ON u.depart_id = d.id " + 
						"LEFT JOIN base_point p ON u.point_id = p.id " + 
						"WHERE " + 
						"	u.delete_flag = 0 AND u.status = 0 " + 
						"AND u.user_name = ? AND u.password = ?");
				
				List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, password);
				Map<String, Object> map2 = null;
				if(mapList2!=null && mapList2.size()>0) {
					map2 = mapList2.get(0);
				}
				map.put("user", map2);
				
				//权限
				sbuffer.delete(0, sbuffer.length());
				if(StringUtil.isNotEmpty(type)) {
					//云平台、APP、工作站单一类型权限	(0:云平台;1:APP;2:工作站)
					if("1".equals(type) || "2".equals(type) || "0".equals(type)) {
						sbuffer.append("SELECT " + 
								"IF ( " + 
								"	tb1.mark = 0, " + 
								"	( SELECT tb2.id " + 
								"		FROM t_s_function tb2 " + 
								"		WHERE tb2.id = tb1.function_id AND tb2.delete_flag = 0 AND tb2.function_type = '" + type + "' " + 
								"	), " + 
								"	( " + 
								"		SELECT tb3.operation_code " + 
								"		FROM t_s_operation tb3 INNER JOIN t_s_function tb4 ON tb3.function_id = tb4.id " + 
								"		WHERE tb3.id = tb1.function_id AND tb3.delete_flag = 0 AND tb4.function_type = '" + type + "' " + 
								"	) " + 
								") AS rightList " + 
								"FROM t_s_role_function tb1 " + 
								"WHERE role_id = ? ");
					}else {
						throw new MyException("参数type不正确", "参数type不正确", WebConstant.INTERFACE_CODE2);
					}
				}else {
					//全部权限
					sbuffer.append("SELECT " + 
							"IF ( " + 
							"	tb1.mark = 0, " + 
							"	( SELECT tb2.id " + 
							"		FROM t_s_function tb2 " + 
							"		WHERE tb2.id = tb1.function_id AND tb2.delete_flag = 0 " + 
							"	), " + 
							"	( " + 
							"		SELECT tb3.operation_code " + 
							"		FROM t_s_operation tb3 " + 
							"		WHERE tb3.id = tb1.function_id AND tb3.delete_flag = 0 " + 
							"	) " + 
							") AS rightList " + 
							"FROM t_s_role_function tb1 " + 
							"WHERE role_id = ? ");
				}
				
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
				
			}else {
				//外部接口
				
				//用户信息
				sbuffer.append("SELECT " + 
						"	u.id, u.user_name, u.realname,	 " + 
						"	u.depart_id, u.point_id, " + 
						"	d.depart_name AS depart_name, " + 
						"	d.depart_code AS depart_code, " + 
						"	p.point_name AS point_name,  " + 
						"	NULL AS param1, NULL AS param2, NULL AS param3 " + 
						"FROM " + 
						"	t_s_user u " + 
						"LEFT JOIN t_s_depart d ON u.depart_id = d.id " + 
						"LEFT JOIN base_point p ON u.point_id = p.id " + 
						"WHERE " + 
						"	u.delete_flag = 0 AND u.status = 0 " + 
						"AND u.user_name = ? AND u.password = ?");
				
				List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, password);
				Map<String, Object> map2 = null;
				if(mapList2!=null && mapList2.size()>0) {
					map2 = mapList2.get(0);
				}
				map.put("user", map2);
			}
			
			aj.setObj(map);
			
		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;
		
	}
	

	/**
	 * 对外接口-登录
	 * @param userName	用户名
	 * @param password		密码 明文
	 * @return
	 */
	@RequestMapping(value = "/loginEx", method = RequestMethod.POST)
	@SystemLog(module = "用户管理",methods = "登录",type = 0,serviceClass = "tSUserService", source = "3")
	public InterfaceJson loginEx(HttpServletRequest request, String userName, String password) {

		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			required(userName, WebConstant.INTERFACE_CODE1, "参数userName不能为空");
			required(password, WebConstant.INTERFACE_CODE1, "参数password不能为空");

			//加密密码
			String pwd = CipherUtil.generatePassword(password);

			TSUser user = tSUserService.getUserByUserName(userName);
			if (user == null || 1 == user.getDeleteFlag()) {
				throw new MyException("账号不存在", "账号不存在", WebConstant.INTERFACE_CODE7);
			} else if (!user.getPassword().equals(pwd)) {
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
                TSDepart depart =departService.getById(user.getDepartId());
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
			//暂时允许一个账号同时登录多台设备
//			Object oldToken=CacheManager.getCacheUser(user.getUserName());
//			if(oldToken!=null){//移除之前的token
//				CacheManager.clearOnly(oldToken.toString());
//			}
			Cache cache = new Cache(token, user, System.currentTimeMillis() + Integer.parseInt(WebConstant.res.getString("cache.timeOut")), false);
			CacheManager.putCache(cache.getKey(), cache,user.getUserName());
			map.put("token", token);

			StringBuffer sbuffer = new StringBuffer();
			//用户信息
			sbuffer.append("SELECT u.user_name, u.realname, d.depart_name, " +
					"	p.point_name, NULL AS param1, NULL AS param2, NULL AS param3 " +
					"FROM " +
					"	t_s_user u " +
					"LEFT JOIN t_s_depart d ON u.depart_id = d.id " +
					"LEFT JOIN base_point p ON u.point_id = p.id " +
					"WHERE " +
					"	u.delete_flag = 0 AND u.status = 0 " +
					"AND u.user_name = ? AND u.password = ?");

			List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, pwd);
			Map<String, Object> map2 = null;
			if(mapList2!=null && mapList2.size()>0) {
				map2 = mapList2.get(0);
			}
			map.put("user", map2);
			aj.setObj(map);

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;

	}


	/**
	 * 对外接口-登录
	 * @param userName	用户名
	 * @param password		密码 MD5加密一次
	 * @return
	 */
	@RequestMapping(value = "/Ulogin", method = RequestMethod.POST)
	@SystemLog(module = "用户管理",methods = "登录",type = 0,serviceClass = "tSUserService", source = "3")
	public InterfaceJson Ulogin(HttpServletRequest request, String userName, String password) {

		InterfaceJson aj = new InterfaceJson();
		try {
			//必填验证
			required(userName, WebConstant.INTERFACE_CODE1, "参数userName不能为空");
			required(password, WebConstant.INTERFACE_CODE1, "参数password不能为空");

			//加密密码
			String pwd = CipherUtil.encodeByMD5(password);

			TSUser user = tSUserService.getUserByUserName(userName);
			if (user == null || 1 == user.getDeleteFlag()) {
				throw new MyException("账号不存在", "账号不存在", WebConstant.INTERFACE_CODE7);
			} else if (!user.getPassword().equals(pwd)) {
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
			//暂时允许一个账号同时登录多台设备
//			Object oldToken=CacheManager.getCacheUser(user.getUserName());
//			if(oldToken!=null){//移除之前的token
//				CacheManager.clearOnly(oldToken.toString());
//			}
			Cache cache = new Cache(token, user, System.currentTimeMillis() + Integer.parseInt(WebConstant.res.getString("cache.timeOut")), false);
			CacheManager.putCache(cache.getKey(), cache,user.getUserName());
			map.put("token", token);

			StringBuffer sbuffer = new StringBuffer();
			//用户信息
			sbuffer.append("SELECT u.user_name, u.realname, d.depart_name, " +
					"	p.point_name, NULL AS param1, NULL AS param2, NULL AS param3 " +
					"FROM " +
					"	t_s_user u " +
					"LEFT JOIN t_s_depart d ON u.depart_id = d.id " +
					"LEFT JOIN base_point p ON u.point_id = p.id " +
					"WHERE " +
					"	u.delete_flag = 0 AND u.status = 0 " +
					"AND u.user_name = ? AND u.password = ?");

			List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {userName, pwd});
			Map<String, Object> map2 = null;
			if(mapList2!=null && mapList2.size()>0) {
				map2 = mapList2.get(0);
			}
			map.put("user", map2);
			aj.setObj(map);

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
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public InterfaceJson logout(HttpServletRequest request, String userToken) {
		
		InterfaceJson aj = new InterfaceJson();
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

	/**
	 * 登录
	 * @param userName	用户名
	 * @param password		密码
	 * @param deviceCode	机器码
	 * @param type 登录类型(0:云平台;1:APP;2:工作站)
	 * @param deviceVersion	硬件版本相关信息
	 * @param softWareVersion	软件名称和版本
	 * @param place	GPS坐标
	 * @param ip	IP地址
	 * @param outside	内外部接口标识（默认为0；0：外部接口，1：内部接口）
	 * @return
	 */
	@RequestMapping(value = "/xcxlogin", method = RequestMethod.POST)
	public InterfaceJson xcxlogin(HttpServletRequest request, String userName, String password, String deviceCode,  String type,
								  String deviceVersion, String softWareVersion, String place, String ip, @RequestParam(required = true, defaultValue = "0") int outside) {

		InterfaceJson aj = new InterfaceJson();
//		String miniOpenId="";
		try {
			//必填验证
			/*
			 * 接收小程序传递参数
			 * yxp
			 * 2021/03/18
			 * */

			if("1".equals(type)){
				// update by xiaoyl 2022-02-24 修改密码的加密方式，由小程序端进行一次md5加密后再进行登录
				//password= MD5Utils.generatePassword(password);
				if (password.length() == 32) {
					password=CipherUtil.encodeByMD5(password);
				} else {
					password=CipherUtil.generatePassword(password);
				}
//				String openid=request.getParameter("code");
//				miniOpenId = MiniProgramUtil.getUserOpenId(openid);

			}



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

			if(outside == 1) {
				//内部接口

				//用户信息
				sbuffer.append("SELECT " +
						"	u.id, u.user_name, u.realname,	 " +
						"	u.depart_id, u.point_id,	u.reg_id, " +
						"	d.depart_name AS depart_name, " +
						"	d.depart_code AS depart_code, " +
						"	d.depart_type AS depart_type, " +
						"	(SELECT GROUP_CONCAT(id) FROM t_s_depart " +
						"		WHERE depart_code LIKE CONCAT(d.depart_code, '%') ) AS departs_id, " +
						"	p.point_name AS point_name, p.point_type AS point_type, " +
						"	p.place_x, p.place_y, " +
						"	NULL AS param1, NULL AS param2, NULL AS param3 " +
						"FROM " +
						"	t_s_user u " +
						"LEFT JOIN t_s_depart d ON u.depart_id = d.id " +
						"LEFT JOIN base_point p ON u.point_id = p.id " +
						"WHERE " +
						"	u.delete_flag = 0 AND u.status = 0 " +
						"AND u.user_name = ? AND u.password = ?");

				List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, password);
				Map<String, Object> map2 = null;
				if(mapList2!=null && mapList2.size()>0) {
					map2 = mapList2.get(0);
				}
				map.put("user", map2);

				//权限
				sbuffer.delete(0, sbuffer.length());
				if(StringUtil.isNotEmpty(type)) {
					//云平台、APP、工作站单一类型权限	(0:云平台;1:APP;2:工作站)
					if("1".equals(type) || "2".equals(type) || "0".equals(type)) {
						sbuffer.append("SELECT " +
								"IF ( " +
								"	tb1.mark = 0, " +
								"	( SELECT tb2.id " +
								"		FROM t_s_function tb2 " +
								"		WHERE tb2.id = tb1.function_id AND tb2.delete_flag = 0 AND tb2.function_type = '" + type + "' " +
								"	), " +
								"	( " +
								"		SELECT tb3.operation_code " +
								"		FROM t_s_operation tb3 INNER JOIN t_s_function tb4 ON tb3.function_id = tb4.id " +
								"		WHERE tb3.id = tb1.function_id AND tb3.delete_flag = 0 AND tb4.function_type = '" + type + "' " +
								"	) " +
								") AS rightList " +
								"FROM t_s_role_function tb1 " +
								"WHERE role_id = ? ");
					}else {
						throw new MyException("参数type不正确", "参数type不正确", WebConstant.INTERFACE_CODE2);
					}
				}else {
					//全部权限
					sbuffer.append("SELECT " +
							"IF ( " +
							"	tb1.mark = 0, " +
							"	( SELECT tb2.id " +
							"		FROM t_s_function tb2 " +
							"		WHERE tb2.id = tb1.function_id AND tb2.delete_flag = 0 " +
							"	), " +
							"	( " +
							"		SELECT tb3.operation_code " +
							"		FROM t_s_operation tb3 " +
							"		WHERE tb3.id = tb1.function_id AND tb3.delete_flag = 0 " +
							"	) " +
							") AS rightList " +
							"FROM t_s_role_function tb1 " +
							"WHERE role_id = ? ");
				}

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

			}else {
				//外部接口

				//用户信息
				sbuffer.append("SELECT " +
						"	u.id, u.user_name, u.realname,	 " +
						"	u.depart_id, u.point_id, " +
						"	d.depart_name AS depart_name, " +
						"	d.depart_code AS depart_code, " +
						"	p.point_name AS point_name,  " +
						"	NULL AS param1, NULL AS param2, NULL AS param3 " +
						"FROM " +
						"	t_s_user u " +
						"LEFT JOIN t_s_depart d ON u.depart_id = d.id " +
						"LEFT JOIN base_point p ON u.point_id = p.id " +
						"WHERE " +
						"	u.delete_flag = 0 AND u.status = 0 " +
						"AND u.user_name = ? AND u.password = ?");

				List<Map<String, Object>> mapList2 = jdbcTemplate.queryForList(sbuffer.toString(), userName, password);
				Map<String, Object> map2 = null;
				if(mapList2!=null && mapList2.size()>0) {
					map2 = mapList2.get(0);
				}
				map.put("user", map2);
			}

			aj.setObj(map);

		} catch (MyException e) {
			setAjaxJson(aj, e.getCode(), e.getText());
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}

		return aj;

	}


    //甘肃系统特殊接口加密salt
    String salt = "#dayUan_GS";

    /**
     * 甘肃系统-获取用户信息
     * @author Dz
     * @param sign 加密签名
     * @param username 账号
     * @return
     */
    @CrossOrigin
    @RequestMapping(value = "/getUserInfo", method = RequestMethod.POST)
    public InterfaceJson getUserInfo(String sign, String username) {
        InterfaceJson aj = new InterfaceJson();
        try {
            String sign0 = CipherUtil.encodeByMD5(username+salt);
            if (sign0.equals(sign)) {
                TSUser user = tSUserService.getUserByUserName(username);
                if (user == null) {
                    setAjaxJson(aj, WebConstant.INTERFACE_CODE7, "账号["+username+"]不存在！");

                } else if (user.getStatus() == 1){
                    setAjaxJson(aj, WebConstant.INTERFACE_CODE9, "账号["+username+"]已停用！");

                } else {
                    Map<String, String> userInfo = new HashMap<String, String>();
                    userInfo.put("realname",user.getRealname());
                    userInfo.put("departName",user.getDepartName());
                    userInfo.put("pointName",user.getPointName());

                    String defaultPassword = "Dy123456#";
                    JSONArray defaultPasswordArr = null;
                    if (SystemConfigUtil.OTHER_CONFIG != null && SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config") != null) {
                        defaultPasswordArr = SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config").getJSONArray("default_password");
                    }
                    //密码正则表达式
                    Pattern pattern = Pattern.compile(WebConstant.pwRegEx);
                    Matcher matcher = pattern.matcher(defaultPasswordArr.getString(0));
                    if (defaultPasswordArr != null && defaultPasswordArr.size() > 0 && matcher.matches()) {
                        //使用配置中密码
                        defaultPassword = defaultPasswordArr.getString(0);
                    }
                    userInfo.put("pw", defaultPassword);
                    aj.setObj(userInfo);
                }

            } else {
                setAjaxJson(aj, WebConstant.INTERFACE_CODE2, "参数sign错误！");
            }
        } catch (Exception e) {
            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }
        return aj;
    }

	/**
	 * 甘肃系统-重置用户密码
	 * @author Dz
	 * @param sign 加密签名
	 * @param username 账号
	 * @param password 密码(非必填；为空时使用默认密码)
	 * @param type 类型：1_重置密码，2_解锁账号
	 * @return
	 */
	@CrossOrigin
	@RequestMapping(value = "/setPw", method = RequestMethod.POST)
	public InterfaceJson setPw(String sign, String username, String password, @RequestParam(required = false, defaultValue = "1") Integer type) {
		InterfaceJson aj = new InterfaceJson();
		try {
			String sign0 = CipherUtil.encodeByMD5(username+salt);
			if (sign0.equals(sign)) {
				TSUser user = tSUserService.getUserByUserName(username);
				if (user == null) {
					setAjaxJson(aj, WebConstant.INTERFACE_CODE7, "账号["+username+"]不存在！");

				} else if (user.getStatus() == 1){
					setAjaxJson(aj, WebConstant.INTERFACE_CODE9, "账号["+username+"]已停用！");

				} else {
					switch (type){
						case 1:

                            //密码正则表达式
                            Pattern pattern = Pattern.compile(WebConstant.pwRegEx);

						    if (StringUtil.isEmpty(password)) {
                                JSONArray defaultPasswordArr = null;
                                if (SystemConfigUtil.OTHER_CONFIG != null && SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config") != null) {
                                    defaultPasswordArr = SystemConfigUtil.OTHER_CONFIG.getJSONObject("system_config").getJSONArray("default_password");
                                }

                                password = "Dy123456#";
                                Matcher matcher = pattern.matcher(defaultPasswordArr.getString(0));
                                if (defaultPasswordArr != null && defaultPasswordArr.size() > 0 && matcher.matches()) {
                                    //使用配置中密码
                                    password = defaultPasswordArr.getString(0);
                                }

                            } else {
                                Matcher matcher = pattern.matcher(password);
                                if (!matcher.matches()) {
                                    setAjaxJson(aj, WebConstant.INTERFACE_CODE3, "重置失败，密码不符合要求。密码规则：数字、大写字母、小写字母和特殊字符中至少2种组合成的8~16位字符串！");
                                    break;
                                }
                            }

							//重置密码
							user.setPassword(CipherUtil.generatePassword(password));
							tSUserService.updateById(user);
							aj.setMsg(password);
							break;

						case 2:
							//解锁账号
							LockAccount.waUnlock(username);
							break;

						default:
							setAjaxJson(aj, WebConstant.INTERFACE_CODE2, "参数type错误！");
							break;
					}
				}

			} else {
				setAjaxJson(aj, WebConstant.INTERFACE_CODE2, "参数sign错误！");
			}
		} catch (Exception e) {
			setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
		}
		return aj;
	}
}
