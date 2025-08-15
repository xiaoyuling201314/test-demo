package com.dayuan.controller.statistics;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.detect.TSDepartService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;


/**
* @Description 甘肃项目相关统计
* @Date 2022/05/23 15:02
* @Author xiaoyl
* @Param
* @return
*/
@Controller
@RequestMapping("/statisticsForGS")
public class StatisticsForGSController extends BaseController {
	
	private Logger log = Logger.getLogger(StatisticsForGSController.class);
	@Autowired
	private DataCheckRecordingService checkRecordingService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 有效数据统计
	 */
	@RequestMapping("/effectiveStatistics")
	@SystemLog(module = "有效统计",methods = "查看有效统计",type = 0)
	public ModelAndView effectiveStatistics(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/gs/effectiveStatistics");
	}

	/**
	 * 各个辖区内检测室和快检车的有效数据和无效数据统计
	 * @return
	 */
	@RequestMapping(value="loadEffective")
	@ResponseBody
	public AjaxJson loadEffective(Integer departId,String type, String year, String month, String season, String start, String end){
		AjaxJson jsonObj = new AjaxJson();
		List<Map<String, Object>> list = null;
		try {
			timeModel time=formatTime(type,month,season,year,start,end);
			list = checkRecordingService.selectEffectiveDataForGS(departId, time.getStart(), time.getEnd());
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>(3);
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}
	/**
	* @Description 有效数据统计-查看详细的检测数据
	* @Date 2022/05/25 10:46
	* @Author xiaoyl
	* @Param showType 查看类型：0 有效数据统计，1 季度考核统计
    * @Param pointType检测点类型： 0 政府检测室，1企业检测室，2 快检车
	* @return
	*/
	@RequestMapping("/queryCheckData")
	public ModelAndView queryCheckData(HttpServletRequest request,HttpServletResponse response,HttpSession session,
									   Integer departId,String departName,String pointType,String queryType,
									   String type,String month,String season,String year,String start,String end,Integer seasonNumber,
									   @RequestParam(required = false,defaultValue = "0") Integer faking,
									   @RequestParam(required = false,defaultValue = "0")Integer dealFlag,
									   @RequestParam(required = false,defaultValue = "0")Integer showType){
		Map<String,Object> map=new HashMap<>();
		map.put("departName",departName);
		map.put("departId", departId);
		map.put("pointType", "undefined".equals(pointType) ? "" : pointType);
		map.put("queryType", "undefined".equals(queryType) ? "" : queryType);
		map.put("type", type);
		map.put("month", month);
		map.put("season", season);
		map.put("year", year);
		map.put("start", start);
		map.put("end", end);
		map.put("seasonNumber", seasonNumber);
		map.put("showType", showType);
		map.put("faking", faking);//是否造假：0 否，1 是
		map.put("dealFlag", dealFlag);//不合格处理状态：0不查询，1合规处理，2 未处理，3处置不当(包括超时未处理+已处理不合格)
		return new ModelAndView("/statistics/gs/checkData",map);
	}
	/**
	* @Description 检测数据列表，根据机构ID、检测点类型、时间、查询状态（有效或无效）等条件查看检测数据
	* @Date 2022/05/25 11:46
	* @Author xiaoyl
	* @Param model.queryType查看类型：-1 总数，0 有效数，1 无效数量
	* @Param model.pointType检测点类型：0 政府检测室，1企业检测室，2 快检车
	* @Param showType 查看类型：0 有效数据统计时根据查询的月份进行查询，1季度统计和年度统计，查看详情时都是一个一个季度查看，重新设置数据查询开始和结束时间
	* @return
	*/
	@RequestMapping(value="/loadDatadatagrid")
	@ResponseBody
	public AjaxJson loadDatadatagrid(DataCheckRecordingModel model,Integer showType,Page page,HttpServletResponse response,HttpServletRequest request, HttpSession session){
		AjaxJson jsonObj = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		Integer departId=model.getDepartId();
		page.setOrder("desc");
		try {
			/*if (StringUtil.isNotEmpty(departId)) {
				List<Integer> subIds = null;
				if(tsUser.getDepartId().equals(departId)){//查询当前机构的直属检测点数据
					subIds=new ArrayList<>();
					subIds.add(departId);
				}else{
					subIds = departService.querySonDeparts(departId);
				}
				model.setChildDepartList(subIds);
			}*/
			TSDepart depart=departService.getById(departId);
			model.setDepartCode(depart.getDepartCode());
			//有效数据统计时根据查询的月份进行查询，季度统计和年度统计，查看详情时都是一个一个季度查看，重新设置数据查询开始和结束时间
			if(showType==1){//质量统计数据查询
				model.setType("season");
				model.setSeason(model.getSeasonNumber().toString());
			}
			timeModel time=formatTime(model.getType(),model.getMonth(),model.getSeason(),model.getYear(),model.getStart(),model.getEnd());
			model.setStart(time.getStart());
			model.setEnd(time.getEnd());
//			page =checkRecordingService.loadDatagrid(page, model, DataCheckRecordingMapper.class, "loadDatagridForGS", "getRowTotalForGS");
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.getStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		};
		return jsonObj;
	}
	/**
	 * @Description 有效数据统计-查看检测点信息
	 * @Date 2022/05/25 10:46
	 * @Author xiaoyl
	 * @Param showType 查看类型：0 有效数据统计，1 季度考核统计
	 * @return
	 */
	@RequestMapping("/queryPoint")
	public ModelAndView queryPoint(Integer departId,String departName,String pointType,
									   String type,String month,String season,String year,String start,String end,Integer seasonNumber,
								   @RequestParam(required = false,defaultValue = "0")Integer showType){
		Map<String,Object> map=new HashMap<>();
		map.put("departName",departName);
		map.put("departId", departId);
		map.put("pointType", pointType.equals("undefined") ? "" : pointType);
		map.put("type", type);
		map.put("month", month);
		map.put("season", season);
		map.put("year", year);
		map.put("start", start);
		map.put("end", end);
		map.put("seasonNumber", seasonNumber);
		map.put("showType", showType);
		return new ModelAndView("/statistics/gs/showPoint",map);
	}
	/**
	 * @Description 根据所属机构和类型查看检测点信息
	 * @Date 2022/05/25 11:46
	 * @Author xiaoyl
	 * @Param model.pointType检测点类型：0 政府检测室，1企业检测室，2 快检车
	 * @return
	 */
	@RequestMapping(value="/loadPointdatagrid")
	@ResponseBody
	public AjaxJson loadPointdatagrid(DataCheckRecordingModel model,Integer showType,Page page,HttpServletResponse response,HttpServletRequest request, HttpSession session){
		AjaxJson jsonObj = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);

		page.setOrder("desc");
		try {
			TSDepart depart=departService.getById(model.getDepartId());
			model.setDepartCode(depart.getDepartCode());
			//有效数据统计时根据查询的月份进行查询，季度统计和年度统计，查看详情时都是一个一个季度查看，重新设置数据查询开始和结束时间
			if(showType==1){//质量统计数据查询
				model.setType("season");
				model.setSeason(model.getSeasonNumber().toString());
			}
			timeModel time=formatTime(model.getType(),model.getMonth(),model.getSeason(),model.getYear(),model.getStart(),model.getEnd());
			model.setStart(time.getStart());
			model.setEnd(time.getEnd());
//			page =checkRecordingService.loadDatagrid(page, model, BasePointMapper.class, "loadPointForGS", "getRowTotalForGS");
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.getStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		};
		return jsonObj;
	}

	/**
	 * 数据质量统计
	 */
	@RequestMapping("/quality")
	@SystemLog(module = "质量统计",methods = "查看质量统计",type = 0)
	public ModelAndView quality(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/gs/qualityStatistics");
	}

	/**
	 * 数据质量统计数据查询
	 * @return
	 */
	@RequestMapping(value="loadQualityData")
	@ResponseBody
	public AjaxJson loadQualityData(Integer departId,String type, String year, String month, String season, String start, String end){
		AjaxJson jsonObj = new AjaxJson();
		List<Map<String, Object>> list = null;
		try {
			timeModel time=formatTime(type,month,season,year,start,end);
			list = checkRecordingService.selectQualityData(departId, time.getStart(), time.getEnd());
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>(3);
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}
	/**
	 * 拼接时间
	 * @param type
	 * @param month
	 * @param season
	 * @param year
	 * @param start
	 * @param end
	 * @return
	 */
	public timeModel formatTime(String type, String month, String season, String year, String start, String end){
		timeModel model=new timeModel();
		Calendar cal = Calendar.getInstance();
		if(type.equals("month")){
			if(month.length()<2){
				month="0"+month;
			}
			start=year+"-"+month+"-01";
			end=year+"-"+month+"-31 23:59:59";
		}else if (type.equals("season")) {
			if(season.equals("1")){
				start=year+"-01-01";
				end=year+"-03-31 23:59:59";
			}else if (season.equals("2")) {
				start=year+"-04-01";
				end=year+"-06-30 23:59:59";
			}else if (season.equals("3")) {
				start=year+"-07-01";
				end=year+"-09-30 23:59:59";
			}else if (season.equals("4")) {
				start=year+"-10-01";
				end=year+"-12-31 23:59:59";
			}
		}else if (type.equals("year")) {
			start=year+"-01-01";
			end=year+"-12-31 23:59:59";
		}else if (type.equals("diy")) {
			end=end+" 23:59:59";
		}

		model.setStart(start);
		model.setEnd(end);
		return model;
	}

	public static class timeModel{

		private String start;

		private String end;

		public String getStart() {
			return start;
		}

		public void setStart(String start) {
			this.start = start;
		}

		public String getEnd() {
			return end;
		}

		public void setEnd(String end) {
			this.end = end;
		}

	}
}
