package com.dayuan.controller.system;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.system.RoleFunctionModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.system.TSFunctionService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.ArithUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;

/**
 * 系统菜单
 * @author Dz
 *
 */
@Controller
@RequestMapping("/system")
public class SystemController  extends BaseController {
	private final Logger log = Logger.getLogger(SystemController.class);
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSFunctionService tSFunctionService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;
	@Autowired
	private DataUnqualifiedTreatmentService dataUnqualifiedTreatmentService;
	@Autowired
	private TSDepartService departService;
	
	/*@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>();
		List<TSFunction> menus = tSFunctionService.getMenus();
		map.put("menus", menus);
		map.put("menusStr", JSON.toJSON(menus).toString());
		return new ModelAndView("/common/home",map);
	}*/

	/**
	 * APP二维码页面
	 */
	@RequestMapping("/appQrcode")
	public ModelAndView appQrcode(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/common/appQrcode");
	}
	
	/**
	 * 根据角色id获取菜单
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/goHome")
	public ModelAndView goHome(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		Map<String,Object> map = new HashMap<String, Object>();	
		TSUser user = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		List<RoleFunctionModel> menus = tSFunctionService.getRoleMenus(user.getRoleId());
		map.put("user", user);
		map.put("menus", menus);
		map.put("menusStr", JSON.toJSON(menus).toString());
		map.put("systemConfig", SystemConfigUtil.SYSTEM_NAME_CONFIG);
		// add by xiaoyl 2020/10/30 武陵系统标识,进入主页面的时候写入session中
		int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
		JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
		if (systemFlagConfig != null &&  systemFlagConfig.getInteger("systemFlag") != null) {
			systemFlag = systemFlagConfig.getInteger("systemFlag");
		}
		session.setAttribute("systemFlag",systemFlag);
//		session.setAttribute("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));

		try {
			TSDepart userDepart = PublicUtil.getSessionUserDepart();
			TSDepart sysDepart = departService.selectSystemName(userDepart.getDepartCode());
			if (sysDepart != null) {
				session.setAttribute("systemLogo", sysDepart.getSystemLogo());
				session.setAttribute("systemName", sysDepart.getSystemName());
				session.setAttribute("homeSystemName", sysDepart.getSystemName());
				session.setAttribute("systemCopyright", sysDepart.getSystemCopyright());
			} else {
				session.setAttribute("systemLogo", null);
				session.setAttribute("systemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("systemName"));
				session.setAttribute("homeSystemName", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("homeSystemName"));
				session.setAttribute("systemCopyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright1"));
			}

		} catch (MissSessionExceprtion e) {
			e.printStackTrace();
		}
		return new ModelAndView("/common/home",map);
	}
	
	/**
	 * 进入首页界面
	 */
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		Map<String,Object> map = new HashMap<String, Object>();	
		TSUser user = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		List<RoleFunctionModel> menus = tSFunctionService.getRoleMenus(user.getRoleId());
		map.put("menusStrs", JSON.toJSON(menus).toString());
		map.put("copyright", SystemConfigUtil.SYSTEM_NAME_CONFIG.getString("copyright1"));
		return new ModelAndView("/common/index",map);
	}
	
	/**
	 * 获取汇总统计数据
	 * @return
	 */
	@RequestMapping("/getProjectMsg")
	@ResponseBody
	public AjaxJson getProjectMsg(Integer departId, Integer pointId) {
		AjaxJson aj = new AjaxJson();
		
		try {
			//获取当前用户信息
			if (departId == null && pointId == null) {
				TSUser tsUser = PublicUtil.getSessionUser();
				if (tsUser != null) {
					departId = tsUser.getDepartId();
					pointId = tsUser.getPointId();
				}
			}
			
			Map<String,Object> map = new HashMap<String,Object>();
			int samplingTotal = 0;
			int jczs = 0;
			int jchg = 0;
			int jcbhg = 0;
			
			StringBuffer sbuffer = new StringBuffer();
			if(pointId != null) {
				//检测点用户
				//抽样总数
				sbuffer.append("SELECT COUNT(1) samplingTotal " +
						"	FROM tb_sampling  " +
						"WHERE delete_flag = 0 AND depart_id = ? AND point_id = ? ");
				Map map1 = jdbcTemplate.queryForMap(sbuffer.toString(), departId, pointId);
				samplingTotal = Integer.parseInt(map1.get("samplingTotal").toString());

				//检测点-检测总数、不合格数量
				sbuffer.setLength(0);
				sbuffer.append("SELECT COUNT(1) jczs, SUM(IF(conclusion = '不合格', 1, 0)) jcbhg " +
						"	FROM data_check_recording  " +
						"WHERE delete_flag = 0 AND param7 = 1 AND depart_id = ? AND point_id = ? ");
				Map map2 = jdbcTemplate.queryForMap(sbuffer.toString(), departId, pointId);
				jczs = Integer.parseInt(map2.get("jczs").toString());
				jcbhg = StringUtil.isNotEmpty(map2.get("jcbhg")) ? Integer.parseInt(map2.get("jcbhg").toString()) : 0;
				jchg = jczs - jcbhg;

			} else if (departId != null) {
				//机构用户
				//历史数据汇总
				sbuffer.append("SELECT SUM(sampling_number) samplingTotal, SUM(check_number) jczs, SUM(unqualified_number) jcbhg " +
						"	FROM data_monthly_statistics " +
						"WHERE delete_flag = 0  " +
						"	AND depart_id = ? ");
				Map map1 = jdbcTemplate.queryForMap(sbuffer.toString(), departId);
				samplingTotal = StringUtil.isNotEmpty(map1.get("samplingTotal")) ? Integer.parseInt(map1.get("samplingTotal").toString()) : 0;
				jczs = StringUtil.isNotEmpty(map1.get("jczs")) ? Integer.parseInt(map1.get("jczs").toString()) : 0;
				jcbhg = StringUtil.isNotEmpty(map1.get("jcbhg")) ? Integer.parseInt(map1.get("jcbhg").toString()) : 0;

				//机构-当月抽样数量
				sbuffer.setLength(0);
				sbuffer.append("SELECT COUNT(1) samplingTotal " +
						"	FROM tb_sampling  " +
						"WHERE delete_flag = 0  " +
						"	AND sampling_date >= CONCAT(DATE_FORMAT(NOW(),'%Y-%m'), '-01 00:00:00') " +
						"	AND depart_id IN ( " +
						"		SELECT id " +
						"			FROM t_s_depart  " +
						"		WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?), '%') " +
						"	)");
				Map map2 = jdbcTemplate.queryForMap(sbuffer.toString(), departId);
				samplingTotal += Integer.parseInt(map2.get("samplingTotal").toString());

				//机构-当月检测总数、不合格数量
				sbuffer.setLength(0);
				sbuffer.append("SELECT COUNT(1) jczs, SUM(IF(conclusion = '不合格', 1, 0)) jcbhg " +
						"	FROM data_check_recording  " +
						"WHERE delete_flag = 0 AND param7 = 1  " +
						"	AND check_date >= CONCAT(DATE_FORMAT(NOW(),'%Y-%m'), '-01 00:00:00') " +
						"	AND depart_id IN ( " +
						"		SELECT id 	 " +
						"			FROM t_s_depart  " +
						"		WHERE depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = ?), '%') " +
						"	)");
				Map map3 = jdbcTemplate.queryForMap(sbuffer.toString(), departId);
				jczs += StringUtil.isNotEmpty(map3.get("jczs")) ? Integer.parseInt(map3.get("jczs").toString()) : 0;
				jcbhg += StringUtil.isNotEmpty(map3.get("jcbhg")) ? Integer.parseInt(map3.get("jcbhg").toString()) : 0;
				jchg = jczs - jcbhg;
			}
			
			map.put("samplingTotal", samplingTotal);	//抽样数量
			map.put("jczs", jczs);	//检测总数
			map.put("jchg", jchg);	//合格数
			map.put("jcbhg", jcbhg);	//不合格
			if(jczs == 0 || jczs == 0){
				map.put("hgl", "0.0");	//合格率
			}else{
				map.put("hgl", ArithUtil.percentage(jchg, jczs));	//合格率
			}
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}
	
	/**
	 * 获取任务数量
	 * @return
	 */
	@RequestMapping("/getTasksNum")
	@ResponseBody
	public AjaxJson getTasksNum() {
		AjaxJson aj = new AjaxJson();
		
		try {
			//获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			Map<String,Object> map = taskService.queryTaskNum(tsUser);
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}
	
	/**
	 * 获取当月检测数据数量
	 * @return
	 */
	@RequestMapping("/getCheckRecording")
	@ResponseBody
	public AjaxJson getCheckRecording() {
		AjaxJson aj = new AjaxJson();
		
		try {
			//获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			Map<String,Object> map = dataCheckRecordingService.queryCheckNumM(tsUser);
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}
	
	/**
	 * 获取当月不合格处理数量
	 * @return
	 */
	@RequestMapping("/getProcessing")
	@ResponseBody
	public AjaxJson getProcessing() {
		AjaxJson aj = new AjaxJson();
		
		try {
			//获取当前用户信息
			TSUser tsUser = PublicUtil.getSessionUser();
			Map<String,Object> map = dataUnqualifiedTreatmentService.queryProcessingNum(tsUser);
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}
	
	/**
	 * 获取最近X天合格/不合格检测量
	 * @return
	 */
	@RequestMapping("/getRecordingNum")
	@ResponseBody
	public AjaxJson getRecordingNum(Integer departId, Integer pointId, Date start, Date end) {
		AjaxJson aj = new AjaxJson();
		
		try {
			//获取当前用户信息
			if (departId == null && pointId == null) {
				TSUser tsUser = PublicUtil.getSessionUser();
				if (tsUser != null) {
					departId = tsUser.getDepartId();
					pointId = tsUser.getPointId();
				}
			}

			if (DateUtil.getBetweenDays(start, end) > 90) {
				aj.setMsg("检测量统计最大不能超过90天");
				aj.setSuccess(false);
				return aj;
			}

			Map<String,Object> map = dataCheckRecordingService.queryCheckNumW(pointId, departId, start, end);
			
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}

	/**
	 * 获取当天每小时检测数据数量
	 * @return
	 */
	@RequestMapping("/queryCheckNumD")
	@ResponseBody
	public AjaxJson queryCheckNumD(Integer departId, Integer pointId) {
		AjaxJson aj = new AjaxJson();

		try {
			//获取当前用户信息
			if (departId == null && pointId == null) {
				TSUser tsUser = PublicUtil.getSessionUser();
				if (tsUser != null) {
					departId = tsUser.getDepartId();
					pointId = tsUser.getPointId();
				}
			}
			Map<String,Object> map = dataCheckRecordingService.queryCheckNumD(pointId, departId, new Date());

			aj.setObj(map);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			aj.setSuccess(false);
		}
		return aj;
	}

}
