package com.dayuan.controller.statistics;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.statistics.DataRegStatistics;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.statistics.DataRegStatisticsModel;
import com.dayuan.service.statistics.DataRegStatisticsService;
import com.dayuan.util.DateUtil;
//import com.dayuan2.bean.project.PProject;
//import com.dayuan2.service.project.PProjectService;


/**
 * 市场统计
 */
@Controller
@RequestMapping("/regStatistics")
public class DataRegStatisticsController extends BaseController {
	
	private final Logger log = Logger.getLogger(DataRegStatisticsController.class);

	@Autowired
	private DataRegStatisticsService dataRegStatisticsService;
//	@Autowired
//	private PProjectService projectService;
	
	@Value("${db1}")
	private String db1;
	
	/**
	 * 统计上个月到2017-11的市场覆盖率
	 */
	@RequestMapping(value="/initData",produces="text/html; charset=UTF-8")
	@ResponseBody
	public String initData(HttpServletRequest request,HttpServletResponse response, HttpSession session, String yyyyMM){
		try {
			SimpleDateFormat yyyy_MM = new SimpleDateFormat("yyyy-MM");
			Date date1 = yyyy_MM.parse(yyyyMM);
			Date date2 = yyyy_MM.parse(DateUtil.firstDayOfMonth());
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date2);
			while (calendar.getTime().getTime() > date1.getTime()) {
				calendar.add(Calendar.MONTH, -1);
//				List<DataRegStatistics> regStatistics = dataRegStatisticsService.queryRegStatstics(calendar.getTime(), 1);
//				if(regStatistics==null || regStatistics.size()==0) {
//					dataRegStatisticsService.saveRegStatstics(calendar.getTime(), null);
//				}
				int regStatisticsNum = dataRegStatisticsService.queryNumByYm(calendar.getTime());
				if(regStatisticsNum==0) {
					dataRegStatisticsService.saveRegStatstics(calendar.getTime(), null, null);
				}
			}
			return "success!!";
			
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			return "failure!!";
		}
		
	}
	
	/**
	 * 打开覆盖率界面
	 * @param request
	 * @return
	 */
	@RequestMapping("/coverage")
	public ModelAndView coverage(HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String, Object>();
		TSUser tsUser;
		try {
			tsUser = PublicUtil.getSessionUser();
//			List<PProject> pProjects=projectService.selectProjects(db1, tsUser.getDepartId(), tsUser.getId(),null);
//			map.put("pProjects", pProjects);
		} catch (MissSessionExceprtion e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/statistics/coverage",map);
	}
	
	/**
	 * 覆盖率表格数据
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(DataRegStatisticsModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser user = PublicUtil.getSessionUser();
			int departId = user.getDepartId();	//默认以用户机构查询市场覆盖率
			
//			if(model.getProjectId()!=0){	//通过项目机构查询市场覆盖率
//				PProject project = projectService.queryById(model.getProjectId());
//				departId = project.getDepartId();
//			}
			model.setDepartId(departId);
			
			page = dataRegStatisticsService.loadDatagridByDepart(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 覆盖率图表数据
	 * @param request
	 * @return
	 */
	@RequestMapping("/coverageData")
	@ResponseBody
	public AjaxJson coverageData(HttpServletRequest request, int projectId, Date yyyyMM) {
		AjaxJson aj = new AjaxJson();
		try {
			Map<String,Object> map = new HashMap<String, Object>();
			TSUser user = PublicUtil.getSessionUser();
			int departId = user.getDepartId();	//默认以用户机构查询市场覆盖率
			
//			if(projectId!=0){	//通过项目机构查询市场覆盖率
//				PProject project = projectService.queryById(projectId);
//				departId = project.getDepartId();
//			}
			
			List<DataRegStatistics> regStatistics = dataRegStatisticsService.queryRegStatstics(yyyyMM, departId, null);
			map.put("regStatistics", regStatistics);
			aj.setObj(map);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
			aj.setMsg("操作失败");
		}
		return aj;
	}

	/**
	 * 覆盖率表格数据
	 */
	@RequestMapping(value="/foodDatagrid")
	@ResponseBody
	public AjaxJson foodDatagrid(DataRegStatisticsModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			//获取当前月统计
			page = dataRegStatisticsService.loadDatagridByDepart(page, model);
			if (page.getResults().size() > 0) {
				JSONObject json = (JSONObject) JSONObject.toJSON(page.getResults().get(0));
				String foodsStr = json.getString("foodStatistics");
				//当月统计样品覆盖率
				List<JSONObject> foods1 = JSONArray.parseArray(foodsStr, JSONObject.class);

				if (foods1 != null && foods1.size() > 0) {
					Collections.sort(foods1, new Comparator<JSONObject>(){
						@Override
						public int compare(JSONObject o1, JSONObject o2) {
							int diff = o1.getInteger("f_check_num") - o2.getInteger("f_check_num");
							if (diff > 0) {
								return -1;
							} else if (diff < 0) {
								return 1;
							}
							return 0;
						}
					});
				}

				page.setResults(foods1);
			}

			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
