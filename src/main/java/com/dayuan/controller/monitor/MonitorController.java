package com.dayuan.controller.monitor;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.app.TbSignInModel;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.app.TbSignInService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;

/**
 * 实时监控
 */
@Controller
@RequestMapping("/monitor")
public class MonitorController extends BaseController {
	private final Logger log = Logger.getLogger(MonitorController.class);
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private TbSignInService tbSignInService;
	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;
	
	/**
	 * 打开实时监控界面
	 * @author Dz
	 * @param functionId 菜单ID
	 * @return
	 */
	@RequestMapping("/monitorMap")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, String functionId){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
//			TSDepart depart = PublicUtil.getSessionUserDepart();
//			
//			//半年有签到记录的日期
//			List<String> signDates = tbSignInService.querySignDate(depart.getId());
//			StringBuffer signDatesStr = new StringBuffer();
//			for (String signDate : signDates) {
//				signDatesStr.append("\""+signDate+"\",");
//			}
//			
//			if(signDatesStr.length()>0){
//				map.put("signDates", signDatesStr.substring(0, signDatesStr.length()-1));
//			}else{
//				map.put("signDates", null);
//			}
			map.put("functionId", functionId);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return new ModelAndView("/monitor/monitorMap",map);
	}
	
	/**
	 * 半年有签到记录的日期
	 */
	@RequestMapping(value="/getSignDate")
	@ResponseBody
	public String getSignDate(String userId){
		StringBuffer signDatesStr = new StringBuffer();
		try {
			TSDepart depart = PublicUtil.getSessionUserDepart();
			List<String> signDates = tbSignInService.querySignDate(depart.getId(),userId);
			for (String signDate : signDates) {
				signDatesStr.append("\""+signDate+"\",");
//				signDatesStr.append(signDate+",");
			}
			if(signDatesStr.length()>0){
				return signDatesStr.substring(0, signDatesStr.length()-1);
			}
		} catch (MissSessionExceprtion e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return signDatesStr.toString();
	}
	
	
	/**
	 * 获取实时监控数据
	 * @author Dz
	 * @param response
	 * @param signDate	签到时间
	 * @return
	 */
	@RequestMapping(value="/getLocations")
	@ResponseBody
	public AjaxJson getLocations(HttpServletResponse response, Date signDate,Integer departId,String realname){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			TSDepart depart = PublicUtil.getSessionUserDepart();
			
			String[] departIds = null;
			if(depart != null){
				List<Integer> departIdsList = departService.querySonDeparts(departId==null? depart.getId() : departId);
				if(departIdsList !=null && departIdsList.size()>0) {
					departIds = new String[departIdsList.size()];
					
					for (int i = 0; i < departIdsList.size(); i++) {
						departIds[i] = departIdsList.get(i) + "";
					}
				}
			}
			
			List<BasePoint> points = basePointService.queryByPointType("0", departIds);	//检测点
			List<BasePoint> cars = basePointService.queryByPointType("1", departIds);	//检测车
			
			List<BaseRegulatoryObject> jydws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7e898a015e7e89a9490001", departIds);//经营单位
			List<BaseRegulatoryObject> scdws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7e898a015e7e898adb0000", departIds);//生产单位
			List<BaseRegulatoryObject> cydws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7edbe2015e7eeca4b60009", departIds);//餐饮单位
			
//			if(signDate == null){
//				signDate = new Date();
//			}
//			List<TbSignInModel> signs = tbSignInService.queryByDepartIds(departIds, signDate,realname);
			List<TbSignInModel> signs = tbSignInService.querySignByDepartIds(departIds,realname);
			
			map.put("points", points);
			map.put("cars", cars);
			map.put("jydws", jydws);
			map.put("scdws", scdws);
			map.put("cydws", cydws);
			map.put("signs", signs);
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 实时监控-人员签到
	 * 获取人员当天签到信息
	 * @author Dz
	 * @param response
	 * @param signUserId
	 * @param signDate
	 * @return
	 */
	@RequestMapping(value="/getSignByUserId")
	@ResponseBody
	public AjaxJson getSignByUserId(HttpServletResponse response, String signUserId, Date signDate){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			List<TbSignInModel> signs = tbSignInService.queryByUserId(signUserId, signDate);
			
			map.put("signs", signs);
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 实时监控-检测点
	 * 获取检测点当天检测数据
	 * @author Dz
	 * @param response
	 * @param pointId
	 * @return
	 */
	@RequestMapping(value="/getPositionByPointId")
	@ResponseBody
	public AjaxJson getPositionByPointId(HttpServletResponse response, Integer pointId){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//检测点
			BasePoint point = basePointService.queryById(pointId);

			//当天检测数据
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryDailyData(null, pointId, null, new Date());
			
			//最近7天合格/不合格检测量
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	a.md 'days', " + 
					"	IFNULL(sum(a.hg), 0) 'qualified', " + 
					"	IFNULL(sum(a.bhg), 0) 'unqualified', " + 
					"	IFNULL(sum(a.zs), 0) 'total' " + 
					"FROM " + 
					"	( " + 
					"		SELECT " + 
					"			date_format(check_date, '%Y-%m-%d') AS md, " + 
					"			SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg', " + 
					"			SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg', " + 
					"			sum(1) AS 'zs' " + 
					"		FROM " + 
					"			data_check_recording dcr " + 
					"		WHERE dcr.point_id = ?  and dcr.delete_flag  = 0" + 
					"		AND dcr.check_date BETWEEN DATE_FORMAT((DATE_SUB(now(), INTERVAL 7 DAY)), '%Y-%m-%d') AND DATE_FORMAT(DATE_ADD(now(),INTERVAL 1 DAY), '%Y-%m-%d') " + 
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " + 
					"	) a " + 
					"GROUP BY a.md ORDER BY a.md DESC");
			
			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), pointId);
			
			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-6;i<=0;i++){
				String ymd = DateUtil.xDayAgo(i);
				if(list8.size()==0){	//近7天无检测记录
					Map m = new HashMap<String, Object>();
					m.put("days", ymd);
					m.put("qualified", 0);
					m.put("unqualified", 0);
					m.put("total", 0);
					list9.add(m);
				}else{
					Iterator iterator = list8.iterator();
					while (iterator.hasNext()) {	//当天无检测记录，合格/不合格数量为0
						Map m = (Map) iterator.next();
						if(m!=null && ymd.equals(m.get("days"))){
							list9.add(m);
							iterator.remove();
							break;
						}
						if(!iterator.hasNext()) {//最后一个元素
							m = new HashMap<String, Object>();
							m.put("days", ymd);
							m.put("qualified", 0);
							m.put("unqualified", 0);
							m.put("total", 0);
							list9.add(m);
						}
					}
				}
			}
			
			//图表日期显示短日期(月-日)
			for(Map<String, Object> map1 : list9){	
				String daysStr = (String) map1.get("days");
				map1.put("days", daysStr.substring(5));
			}
			
			map.put("quantity", JSONObject.toJSONString(list9));
			map.put("point", point);
			map.put("recordings", recordings);
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
	/**
	 * 实时监控-监管对象
	 * 获取监管对象当天检测数据
	 * @author Dz
	 * @param response
	 * @param regId
	 * @return
	 */
	@RequestMapping(value="/getPositionByRegId")
	@ResponseBody
	public AjaxJson getPositionByRegId(HttpServletResponse response, Integer regId){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//监管对象
			BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(regId);
			
			//当天检测数据
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryDailyData(null, null, regId, new Date());
			
			//最近7天合格/不合格检测量
			StringBuffer sbuffer = new StringBuffer();
			sbuffer.append("SELECT " + 
					"	a.md 'days', " + 
					"	IFNULL(sum(a.hg), 0) 'qualified', " + 
					"	IFNULL(sum(a.bhg), 0) 'unqualified', " + 
					"	IFNULL(sum(a.zs), 0) 'total' " + 
					"FROM " + 
					"	( " + 
					"		SELECT " + 
					"			date_format(check_date, '%Y-%m-%d') AS md, " + 
					"			SUM(CASE WHEN dcr.conclusion = '合格' THEN 1 ELSE 0 END ) AS 'hg', " + 
					"			SUM(CASE WHEN dcr.conclusion = '不合格' THEN 1 ELSE 0 END ) AS 'bhg', " + 
					"			sum(1) AS 'zs' " + 
					"		FROM " + 
					"			data_check_recording dcr " + 
					"		WHERE dcr.reg_id = ?  and dcr.delete_flag  = 0 " + 
					"		AND dcr.check_date BETWEEN DATE_FORMAT((DATE_SUB(now(), INTERVAL 7 DAY)), '%Y-%m-%d') AND DATE_FORMAT(DATE_ADD(now(),INTERVAL 1 DAY), '%Y-%m-%d') " + 
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " + 
					"	) a " + 
					"GROUP BY a.md ORDER BY a.md DESC");
			
			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), regId);
			
			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-6;i<=0;i++){
				String ymd = DateUtil.xDayAgo(i);
				if(list8.size()==0){	//近7天无检测记录
					Map m = new HashMap<String, Object>();
					m.put("days", ymd);
					m.put("qualified", 0);
					m.put("unqualified", 0);
					m.put("total", 0);
					list9.add(m);
				}else{
					Iterator iterator = list8.iterator();
					while (iterator.hasNext()) {	//当天无检测记录，合格/不合格数量为0
						Map m = (Map) iterator.next();
						if(m!=null && ymd.equals(m.get("days"))){
							list9.add(m);
							iterator.remove();
							break;
						}
						if(!iterator.hasNext()) {//最后一个元素
							m = new HashMap<String, Object>();
							m.put("days", ymd);
							m.put("qualified", 0);
							m.put("unqualified", 0);
							m.put("total", 0);
							list9.add(m);
						}
					}
				}
			}
			
			//图表日期显示短日期(月-日)
			for(Map<String, Object> map1 : list9){	
				String daysStr = (String) map1.get("days");
				map1.put("days", daysStr.substring(5));
			}
			
			map.put("quantity", JSONObject.toJSONString(list9));
			map.put("regObj", regObj);
			map.put("recordings", recordings);
			jsonObj.setObj(map);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
