package com.dayuan.controller.monitor;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.model.monitor.DataCheckQueryModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BaseRegion;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSDepartMap;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.app.TbSignInModel;
import com.dayuan.model.data.DepartModel;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.model.system.TSDepartMapModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.app.TbSignInService;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.BaseRegionService;
import com.dayuan.service.data.BaseWorkersService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.system.TSDepartMapService;
import com.dayuan.util.DateUtil;

@Controller
@RequestMapping("syMonitor")
public class syMonitorController extends BaseController {
	private final Logger log = Logger.getLogger(syMonitorController.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private TbSignInService tbSignInService;
	@Autowired
	private BaseRegionService regionService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private TSDepartMapService departMapService;
	@Autowired
	private BaseWorkersService baseWorkersService;
	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;
	public static String foodListPath = WebConstant.res.getString("resources") + "/json/";
	
	/**
	 * 获取实时监控数据
	 * @author Dz
	 * @param response
	 * @param signDate	签到时间
	 * @return
	 */
	@RequestMapping(value="/getLocations")
	@ResponseBody
	public AjaxJson getLocations(HttpServletResponse response, Date signDate,String realname){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			TSDepart depart = PublicUtil.getSessionUserDepart();
			depart=departService.getById(depart.getId());
			String[] departIds = null;
			if(depart != null){
				String sql = "SELECT GROUP_CONCAT(id) FROM t_s_depart WHERE delete_flag = 0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag = 0 AND id = ?), '%')";
				departIds = jdbcTemplate.queryForObject(sql, new Object[] {depart.getId()}, String.class).split(",");
			}
			TSDepartMap departMap=departMapService.selectByDepartid(depart.getId());
			
			List<BasePoint> points = basePointService.queryByPointType("0", departIds);	//检测点
			List<BasePoint> cars = basePointService.queryByPointType("1", departIds);	//检测车
			
			List<BaseRegulatoryObject> jydws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7e898a015e7e89a9490001", departIds);//经营单位
			List<BaseRegulatoryObject> scdws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7e898a015e7e898adb0000", departIds);//生产单位
			List<BaseRegulatoryObject> cydws = baseRegulatoryObjectService.queryRegByDepartIds("4028935f5e7edbe2015e7eeca4b60009", departIds);//餐饮单位
			
			if(signDate == null){
				signDate = new Date();
			}
			List<TbSignInModel> signs = tbSignInService.queryByDepartIds(departIds, signDate,realname);
			
			map.put("points", points);
			map.put("cars", cars);
			map.put("jydws", jydws);
			map.put("scdws", scdws);
			map.put("cydws", cydws);
			map.put("signs", signs);
			map.put("depart", depart);
			map.put("departMap", departMap);
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
	 * 实时监控-机构
	 * 获取机构检测数据
	 * @author Dz
	 * @param departId
	 * @date 2021/08/25
	 * @return
	 */
	@RequestMapping(value="/getPositionByDepartId")
	@ResponseBody
	public AjaxJson getPositionByDepartId(Integer departId){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//机构
			TSDepart depart =departService.getById(departId);

//			//最近15天的检测数据
			Calendar checkDate = Calendar.getInstance();
			checkDate.add(Calendar.DATE, -14);
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(departId, null, null,  DateUtil.formatDate(checkDate.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			//获取30天前日期
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -30);

			//最近30天检测数据
//			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(departId, null, null,  DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
			
			//最近30天合格/不合格检测量
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
					"		WHERE dcr.depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE ? ) and dcr.delete_flag  = 0" + 
					"		AND dcr.check_date BETWEEN ? AND ? " +
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " + 
					"	) a " + 
					"GROUP BY a.md ORDER BY a.md DESC");
			
			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), depart.getDepartCode()+"%", DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
			
			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-29;i<=0;i++){
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
			map.put("depart", depart);
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
	 * 实时监控-检测点
	 * 获取检测点检测数据
	 * @author Dz
	 * @param pointId
	 * @return
	 */
	@RequestMapping(value="/getPositionByPointId")
	@ResponseBody
	public AjaxJson getPositionByPointId(Integer pointId){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//检测点
			BasePoint point = basePointService.queryById(pointId);

//			//当天检测数据
			Calendar checkDate = Calendar.getInstance();
			checkDate.add(Calendar.DATE, -14);
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(null, pointId, null, DateUtil.formatDate(checkDate.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			//获取30天前日期
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -30);

			//最近30天检测数据
//			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(null, pointId, null,  DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			//修改为获取最近30天的合格/不合格检测量 update by xiaoyl 2020/11/17
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
					"		WHERE dcr.point_id = ?   and dcr.delete_flag  = 0" +
					"		AND dcr.check_date BETWEEN ? AND ? " +
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " +
					"	) a " +
					"GROUP BY a.md ORDER BY a.md DESC");

			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), pointId, DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-29;i<=0;i++){
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
	* @Description 进入机构定位页面
	* @Date 2022/07/28 10:41
	* @Author xiaoyl
	* @Param queryType：查询类型：0 普通入口，1 新的项目预览页面访问
	* @return
	*/
	@RequestMapping("/departManagementList")
	public ModelAndView departManagementList(HttpServletRequest request, HttpServletResponse response,Integer queryType) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		TSDepart depart = PublicUtil.getSessionUserDepart();
		// 按钮操作权限
		
		// 所有人员
		// List<BaseWorkers> workers = baseWorkersService.queryAll();

		map.put("depart", depart);
		// map.put("workers", workers);
		BaseRegion country = regionService.queryById(1);
		List<BaseRegion> provinces = regionService.querySubRegionById(country.getRegionId());
		request.setAttribute("country", country);
		request.setAttribute("provinces", provinces);
		request.setAttribute("queryType", queryType);
		return new ModelAndView("/monitor/departManagementList", map);
	}
	
	/**
	 * 保存机构定位经纬度坐标信息
	 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,TSDepartMap bean,String maplat){
		AjaxJson aj = new AjaxJson();
		try {
					if(maplat==null){
						aj.setSuccess(false);
						aj.setMsg("获取经纬度信息失败,请重试");
						return aj;
					}
					String[] map=maplat.split(",");
					if(map.length<2){
						aj.setSuccess(false);
						aj.setMsg("获取经纬度信息失败,请重试");
						return aj;
					}
					bean.setLongitude(map[0]);
					bean.setLatitude(map[1]);
					if(bean.getDepartId()==null){
						aj.setSuccess(false);
						aj.setMsg("获取机构信息失败,请重试");
						return aj;
					}
            if(bean.getLatitude()==null||bean.getLongitude()==null){
						aj.setSuccess(false);
						aj.setMsg("获取经纬度信息失败,请重试!");
						return aj;
					}
            //机构定位信息
					TSUser tsUser = PublicUtil.getSessionUser();
					TSDepartMap tsDepartMap=departMapService.selectByDepartid(bean.getDepartId());
					//如果这里修改了地址 则更新机构列表 地址
					String address=bean.getAddress();
					if(address!=null){
						TSDepart depart=new TSDepart();
						depart.setId(bean.getDepartId());
						depart.setAddress(address); 
						depart.setSorting(bean.getSorting()); 
						departService.saveOrUpdate(depart);
					}
					Date  now=new Date();
					bean.setUpdateDate(now);
					bean.setUpdateBy(tsUser.getId());
					if(tsDepartMap==null){//不存在
						bean.setCreateBy(tsUser.getId());
						bean.setCreateDate(now);
						departMapService.insertSelective(bean);
					}else{
						departMapService.updateByDepartId(bean);
					}
					aj.setSuccess(true);
					aj.setMsg("保存成功");
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
	}
	/**
	 * 实时监控-监管对象
	 * 获取监管对象检测数据
	 * @author 
	 * @param regId
	 * @return
	 */
	@RequestMapping(value="/getPositionByRegId")
	@ResponseBody
	public AjaxJson getPositionByRegId(Integer regId){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//监管对象
			BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(regId);
		 
//			//当天检测数据
			Calendar checkDate = Calendar.getInstance();
			checkDate.add(Calendar.DATE, -14);
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(null, null, regId, DateUtil.formatDate(checkDate.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			//获取30天前日期
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -30);

			//最近30天检测数据
//			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryCheckData(null, null, regId,  DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));

			//修改为获取最近30天的合格/不合格检测量 update by xiaoyl 2020/11/17
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
					"		WHERE dcr.reg_id = ?   and dcr.delete_flag  = 0" + 
					"		AND dcr.check_date BETWEEN ? AND ? " +
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " + 
					"	) a " + 
					"GROUP BY a.md ORDER BY a.md DESC");
			
			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), regId, DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
			
			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-29;i<=0;i++){
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
	private String getDatafromFile1(String fileName) throws IOException {
		String Path = foodListPath + fileName + ".json";
		/*File file = new File(Path);
		if (!file.exists()) {
			if (saveDataToFile("foodList")) {
				getDatafromFile(fileName);
			}
			;
		}*/
		BufferedReader reader = null;
		String laststr = "";
		try {
			FileInputStream fileInputStream = new FileInputStream(Path);
			InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, StandardCharsets.UTF_8);
			reader = new BufferedReader(inputStreamReader);
			String tempString = null;
			while ((tempString = reader.readLine()) != null) {
				laststr += tempString;
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
					return null;
				}
			}
		}
		return laststr;
	}
	
	/**
	 * 查找数据，进入编辑页面
	 * @param id 检测机构id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(Integer id, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			TSDepart depart =departService.getById(id);
			
			if (depart == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			} else {
				DepartModel departModel = new DepartModel();
				TSDepart superior =departService.getById(depart.getDepartPid());
				BaseWorkers worker = baseWorkersService.queryById(depart.getPrincipalId());
				departModel.setRegionIds(depart.getRegionId().split(","));
				departModel.setDepart(depart);
				departModel.setSuperior(superior);
				departModel.setPrincipal(worker);
				TSDepartMap  tsDepartMap= departMapService.selectByDepartid(id);
				if(tsDepartMap!=null){//获取机构经纬度坐标
					
				}
				map.put("depar", departModel);
				map.put("deparMap", tsDepartMap);
				jsonObject.setObj(map);
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作失败");
		}
		return jsonObject;
	}
	
	/**
	 * 查询机构下 机构 检测点 监管对象 信息
	 * @param response
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/getData")
	@ResponseBody
	public AjaxJson getData(HttpServletResponse response,  Page page,TSDepartMapModel model, String  type){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			if(model.getDepartId()!=null){
				TSDepartMapModel report=departMapService.selectReportByDepartid(model.getDepartId());
				map.put("report", report);
				if("1".equals(type)){//查询机构信息
				//查询当前机构下子机构定位信息
					page = departMapService.loadDatagrid(page,model);
				}
			}
			jsonObj.setAttributes(map);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/*******************************************************項目预览新页面 add by xiaoyl 2022-07-28***********************************************************************/
	/**
	 * 项目预览页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/monitorMap_new")
	public ModelAndView monitorMapNew(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			TSDepart depart = PublicUtil.getSessionUserDepart();
			TSDepartMapModel report=departMapService.selectReportByDepartid(depart.getId());
			map.put("report", report);
			map.put("departId", depart.getId());
			map.put("departCode", depart.getDepartCode());
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		return new ModelAndView("/monitor/syMonitorMap_new",map);
	}
	/**
	 * @Description 项目预览-获取测数据
	 * @Date 2022/07/26 16:12
	 * @Author xiaoyl
	 * @Param
	 * @return
	 */
	@RequestMapping(value="/loadCheckData")
	@ResponseBody
	public AjaxJson loadCheckData(DataCheckQueryModel model){
		AjaxJson jsonObj = new AjaxJson();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_YEAR, -30);////获取30天前日期
			model.setStartDate(DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"));
			model.setEndDate(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
			//1.查询30天检测数据
			int rowTotal=dataCheckRecordingService.queryMonitorRowTotal(model);
			List<DataCheckRecordingModel> recordings = dataCheckRecordingService.queryMonitorCheckData(model);
			String sqlCondition="";
			String objectName="";
			if(model.getDepartId()!=null){
				//机构
				TSDepart depart = departService.getById(model.getDepartId());
				objectName=depart.getDepartName();
				sqlCondition=" and dcr.depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE '"+depart.getDepartCode()+"%' ) ";
			}else if(model.getPointId()!=null){
				BasePoint point = basePointService.queryById(model.getPointId());
				objectName=point.getPointName();
				sqlCondition=" and dcr.point_id = "+model.getPointId();
			}else if(model.getRegId()!=null){
				BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(model.getRegId());
				objectName=regObj.getRegName();
				sqlCondition=" and dcr.reg_id = "+model.getRegId();
			}

			//最近30天合格/不合格检测量
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
					"		WHERE  dcr.delete_flag  = 0 and dcr.param7 = 1 " +sqlCondition+
					"		AND dcr.check_date BETWEEN ? AND ? " +
					"		GROUP BY date_format(dcr.check_date, '%Y-%m-%d'), dcr.conclusion " +
					"	) a " +
					"GROUP BY a.md ORDER BY a.md DESC");

			List<Map<String, Object>> list8 = jdbcTemplate.queryForList(sbuffer.toString(), new Object[] {DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"), DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss")});

			List<Map<String, Object>> list9 = new ArrayList<Map<String, Object>>();
			for(int i=-29;i<=0;i++){
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
				map1.put("days", daysStr.substring(5,daysStr.length()));
			}
			map.put("objectName", objectName);
			map.put("quantity", JSONObject.toJSONString(list9));
			map.put("rowTotal", rowTotal);
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
