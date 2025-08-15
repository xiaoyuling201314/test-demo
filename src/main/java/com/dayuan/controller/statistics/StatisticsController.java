package com.dayuan.controller.statistics;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dayuan.common.PublicUtil;
import com.dayuan.util.DateUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.data.foodTypeStatistics;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.dataCheck.DataCheckRecordingModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.StringUtil;

import net.sf.json.JSONArray;


/**
 * 统计
 * @Company: 食安科技
 * @author Dz  
 * @date 2017年11月8日
 */
@RestController
@RequestMapping("/statistics")
public class StatisticsController extends BaseController {
	
	private final Logger log = Logger.getLogger(StatisticsController.class);
	@Autowired
	private DataCheckRecordingService checkRecordingService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	

	@RequestMapping("/demo")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/demo");
	}
	
	/**
	 * 检测点统计
	 */
	@RequestMapping("/areaStatistics")
	public ModelAndView areaStatistics(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname,String typeObj){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}
		
		return new ModelAndView("/statistics/areaStatistics");
	}
	/**
	 * 区域月统计
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/areaStatisticsMon")
	public ModelAndView areaStatisticsMon(HttpServletRequest request,HttpServletResponse response,HttpSession session,Integer pointId,
			String type,String month,String season,String year,String typeObj,String start,String end,String did,String dname){
		session.setAttribute("pointId", pointId);
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		return new ModelAndView("/statistics/areaStatistics_mon");
	}
	
	@RequestMapping("/listStatistics")
	public ModelAndView listStatistics(HttpServletRequest request,HttpServletResponse response,HttpSession session,Integer pointId,Integer regId,String itemId,Integer foodId,Integer foodTypeId,Integer departId,
			String type,String month,String season,String year,String typeObj,String start,String end,String did,String dname,String conclusion,String pointType){
		session.setAttribute("pointId", pointId);
		session.setAttribute("regId", regId);
		session.setAttribute("itemId", itemId);
		session.setAttribute("foodId", foodId);
		session.setAttribute("foodTypeId", foodTypeId);
		session.setAttribute("departId", departId);
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did.equals("undefined") ? "" : did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		request.setAttribute("conclusion", conclusion);
        request.setAttribute("pointType", pointType);
		return new ModelAndView("/statistics/listStatistics");
	}
	
	/**
	 * 辖区统计
	 */
	@RequestMapping("/departStatistics")
	public ModelAndView departStatistics(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}
		return new ModelAndView("/statistics/departStatistics");
	}

	/**
	 * 自定义统计
	 */
	@RequestMapping("/customStatistics")
	public ModelAndView customStatistics(HttpSession session){
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("defaltDepartId", tsUser.getDepartId());
		map.put("defaltDepartName", tsUser.getDepartName());
		return new ModelAndView("/statistics/customStatistics",map);
	}

    /**
     * 根据条件统计检测点的数据情况
     * @param response
     * @param session
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
	 * @param pointId 检测点ID，武陵项目新增检测点筛选条件
     * @return
     */
    @RequestMapping(value="loadData")
	public AjaxJson  loadData(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String typeObj,String start,String end,Integer did,String flag
			,@RequestParam(required = false,defaultValue = "") String pointType,
			@RequestParam(required = false,defaultValue = "") Integer pointId,
			  @RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends =end+" 23:59:59";*/
		List<DataCheckRecordingModel> model = null;
		
		timeModel time=formatTime(type,month,season,year,start,end);
		
		try {
//			if(did!=null&&did!=0){
//				model=checkRecordingService.selectDataGroup(did,typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
//			}else {
//				model=checkRecordingService.selectDataGroup(tsUser.getDepartId(),typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
//			}

			if(did == null || did == 0){
				did = tsUser.getDepartId();
			}
			model=checkRecordingService.selectDataGroup(did, typeObj, time.getStart(), time.getEnd(), pointType, systemFlag, pointId,null);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		
		
		jsonObj.setObj(model);
		return jsonObj;
	}
    
    /**
     * 根据条件统计辖区的数据情况
     * @param response
     * @param session
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
     * @return
     */
    @RequestMapping(value="loadDepart")
	public AjaxJson  loadDepart(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String start,String end,Integer did,String flag,String typeObj
			,@RequestParam(required = false,defaultValue = "") String pointType
			,@RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends = end+" 23:59:59";*/
		
		List<DataCheckRecordingModel> list =new ArrayList<DataCheckRecordingModel>();
		
		timeModel time=formatTime(type,month,season,year,start,end);
		
		try {
			if(did!=null&&did!=0){
				//项目 的顶级机构的 下一级机构的检测数量
				List<TSDepart> subDeparts = departService.getDepartsByPids(did);
				List<Integer> child=departService.querySonDeparts(did);
				for (TSDepart depart : subDeparts) {
					List<Integer> subIds = new ArrayList<Integer>();
					//delete by xiaoyl 2020/11/19 影响统计结果的准确性
					if(depart.getId().equals(did)){
						subIds.add(did);
					}else {
//						subIds = departService.querySubDeparts(depart.getDepartCode());
						subIds = departService.querySonDeparts(depart.getId());
					}
					DataCheckRecordingModel map = checkRecordingService.selectDepartDataGroup(child,depart.getId(),depart.getDepartName(),typeObj,subIds,time.getStart(),time.getEnd(),pointType,systemFlag);
					if(map.getNum()!=0){
						list.add(map);
					}
				}
				
			}else {
				List<TSDepart> subDeparts = departService.getDepartsByPid(tsUser.getDepartId());
				List<Integer> child=departService.querySonDeparts(tsUser.getDepartId());
				for (TSDepart depart : subDeparts) {
					List<Integer> subIds = new ArrayList<Integer>();
					if(depart.getId().equals(did)){
						subIds.add(did);
					}else {
						subIds = departService.querySonDeparts(depart.getId());
//						subIds = departService.querySubDeparts(depart.getDepartCode());
					}
					DataCheckRecordingModel map = checkRecordingService.selectDepartDataGroup(child,depart.getId(),depart.getDepartName(),typeObj,subIds,time.getStart(),time.getEnd(),pointType,systemFlag);
					if (map.getNum()!=0) {
						list.add(map);
					}
				}
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}

    /**
     * 单位统计的数据情况
     * @return
     */
    @RequestMapping(value="loadDepart2")
	public AjaxJson loadDepart2(Integer departId, String year, String month, String season, String start, String end){
		AjaxJson jsonObj = new AjaxJson();
		List<DataCheckRecordingModel> list = null;
        try {
            if (StringUtil.isNotEmpty(start) && StringUtil.isNotEmpty(end)) {
                list = checkRecordingService.selectDepartDataGroup2(departId, start, end);

            } else if (StringUtil.isNotEmpty(year)) {
                if (StringUtil.isNotEmpty(month)) {
                    Calendar c = Calendar.getInstance();
                    c.clear();
                    c.set(Calendar.YEAR, Integer.parseInt(year));
                    c.set(Calendar.MONTH, Integer.parseInt(month)-1);
                    c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));

                    start = DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00");
                    end = DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 23:59:59");

                } else if (StringUtil.isNotEmpty(season)) {
                    switch (season) {
                        case "1":
                            start = year+"-01-01 00:00:00";
                            end = year+"-03-31 23:59:59";
                            break;
                        case "2":
                            start = year+"-04-01 00:00:00";
                            end = year+"-06-30 23:59:59";
                            break;
                        case "3":
                            start = year+"-07-01 00:00:00";
                            end = year+"-09-30 23:59:59";
                            break;
                        case "4":
                            start = year+"-10-01 00:00:00";
                            end = year+"-12-31 23:59:59";
                            break;
                        default:
                            start = year+"-01-01 00:00:00";
                            end = year+"-12-31 23:59:59";
                            break;
                    }

                } else {
                    start = year+"-01-01 00:00:00";
                    end = year+"-12-31 23:59:59";
                }
                list = checkRecordingService.selectDepartDataGroup2(departId, start, end);

            } else {
                list = new ArrayList<DataCheckRecordingModel>();
            }

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>(3);
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}
    
    
    /**
     * 检测单位数据列表
     * @param model
     * @param page
     * @param response
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value="/loadDatadatagrid")
	public AjaxJson loadDatadatagrid(DataCheckRecordingModel model,Integer did ,Page page,HttpServletResponse response,HttpServletRequest request, HttpSession session){
		AjaxJson jsonObj = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		Integer pointId=(Integer) session.getAttribute("pointId");
		Integer regId=(Integer) session.getAttribute("regId");
		String itemId=(String) session.getAttribute("itemId");
		Integer foodId=(Integer) session.getAttribute("foodId");
		Integer foodTypeId=(Integer) session.getAttribute("foodTypeId");
		Integer departId=(Integer) session.getAttribute("departId");
		page.setOrder("desc");
		try {
			 if (StringUtil.isNotEmpty(regId)) {
				model.setRegId(regId);
			}else if (StringUtil.isNotEmpty(itemId)) {
				model.setItemId(itemId);
				if(StringUtil.isNotEmpty(tsUser.getPointId())){
					model.setPointId(tsUser.getPointId());
				}else if(StringUtil.isNotEmpty(pointId)){
					model.setPointId(pointId);
				}else if(StringUtil.isNotEmpty(did)){//增加所选机构参数 add by xiaoyl 2020/11/17
					List<Integer> child=departService.querySonDeparts(did);
					model.setDepartListForStatist(child);
				}

			}else if (StringUtil.isNotEmpty(foodId)) {
				model.setFoodId(foodId);
				if(StringUtil.isNotEmpty(tsUser.getPointId())){
					model.setPointId(tsUser.getPointId());
				}else if(StringUtil.isNotEmpty(pointId)){
					model.setPointId(pointId);
				}else if(StringUtil.isNotEmpty(did)){//增加所选机构参数 add by xiaoyl 2020/11/17
					List<Integer> child = departService.querySonDeparts(did);
					model.setDepartListForStatist(child);
				}
			}else if (StringUtil.isNotEmpty(foodTypeId)) {
			 	//delete by xiaoyl 2020/11/20 该条件会过滤掉已删除的样品，但是检测数据还在的数据
//				List<Integer> subIds=baseFoodTypeService.querySonFoods(foodTypeId);
//				model.setFoodList(foodTypeId);
				model.setFoodTypeId(foodTypeId.toString());
				 if(StringUtil.isNotEmpty(tsUser.getPointId())){
					 model.setPointId(tsUser.getPointId());
				 }else if(StringUtil.isNotEmpty(pointId)){
					 model.setPointId(pointId);
				 }else if(StringUtil.isNotEmpty(did)){//增加所选机构参数 add by xiaoyl 2020/11/17
					List<Integer> child = departService.querySonDeparts(did);
					model.setDepartListForStatist(child);
				}
			 }else if(StringUtil.isNotEmpty(pointId)){
				 model.setPointId(pointId);
			 }else if (StringUtil.isNotEmpty(departId)) {
				 List<Integer> subIds = null;
				 List<Integer> child=null;
			 	if(tsUser.getDepartId().equals(departId)){//查询当前机构的直属检测点数据
					subIds=new ArrayList<>();
					subIds.add(departId);
//					child=new ArrayList<>();
//					child.add(departId);
				}else{
					subIds = departService.querySonDeparts(departId);
//					child=departService.querySonDeparts(tsUser.getDepartId());
				}
//				model.setDepartList(child);
				model.setChildDepartList(subIds);
			}
   			timeModel time=formatTime(model.getType(),model.getMonth(),model.getSeason(),model.getYear(),model.getStart(),model.getEnd());
   			model.setStart(time.getStart());
   			model.setEnd(time.getEnd());
   			if(StringUtil.isNotEmpty(model.getConclusion())){
   				if(model.getConclusion().equals("0")){
   					model.setConclusion("合格");
   				}else if (model.getConclusion().equals("1")) {
					model.setConclusion("不合格");
				}
   			}
			page =checkRecordingService.loadDatagrids(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			e.getStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
        return jsonObj;
	}
    
    /**
     * 检测单位折线图
     * @param response
     * @param request
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value="/selectDataForDate")
   	public AjaxJson selectDataForDate(HttpServletResponse response,HttpServletRequest request, HttpSession session,
   			String type,String month,String season,String year,String start,String end,String typeObj){
   		AjaxJson jsonObj = new AjaxJson();
   		/*String ends =end+" 23:59:59";*/
   		Integer pointId=(Integer) session.getAttribute("pointId");
   		List<DataCheckRecordingModel> model = null;
   		
   		timeModel time=formatTime(type,month,season,year,start,end);
   		try {
   			model =checkRecordingService.selectDataForDate(pointId,null,typeObj,time.getStart(),time.getEnd());
   			jsonObj.setObj(model);
   		} catch (Exception e) {
   			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
   		}
        return jsonObj;
   	}
    
    /**
     * 检测点饼图
     * @param response
     * @param request
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value="/selectDataForDates")
   	public AjaxJson selectDataForDates(HttpServletResponse response,HttpServletRequest request, HttpSession session,
   			String type,String month,String season,String year,String start,String end,String typeObj){
   		AjaxJson jsonObj = new AjaxJson();
   		/*String ends =end+" 23:59:59";*/
   		Integer pointId=(Integer) session.getAttribute("pointId");
   		List<DataCheckRecordingModel> model = null;
   		
   		timeModel time=formatTime(type,month,season,year,start,end);
   		try {
   			model =checkRecordingService.selectDataForDates(pointId,null,typeObj,time.getStart(),time.getEnd());
   			jsonObj.setObj(model);
   		} catch (Exception e) {
   			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
   		}
        return jsonObj;
   	}
    /**
     * 检测项目统计
     * @param request
     * @param response
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
	 * @param pointId 检测点ID
     * @return
     */
    @RequestMapping(value="loadItem")
	public AjaxJson  loadItem(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String start,String typeObj,String end,Integer did
			,@RequestParam(required = false,defaultValue = "") String pointType
			,@RequestParam(required = false,defaultValue = "") Integer pointId
			,@RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends = end+" 59:59:59";*/
		List<DataCheckRecordingModel> model = null;
		
		timeModel time=formatTime(type,month,season,year,start,end);
		try {
			if(did!=null&&did!=0){
				model=checkRecordingService.selectItemGroup(did,typeObj,time.getStart(),time.getEnd(),pointType,pointId,systemFlag);
			}else {
				model=checkRecordingService.selectItemGroup(tsUser.getDepartId(),typeObj,time.getStart(),time.getEnd(),pointType,pointId,systemFlag);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		
		jsonObj.setObj(model);
		return jsonObj;
	}
    /**
     * 食品种类统计
     * @param request
     * @param response
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
	 * @param  pointId 检测点ID
     * @return
     */
    @RequestMapping(value="loadFood")
	public AjaxJson  loadFood(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String start,String end,Integer did,String fid,String typeObj
	,@RequestParam(required = false,defaultValue = "") String pointType ,@RequestParam(required = false,defaultValue = "0") Integer systemFlag
	,@RequestParam(required = false,defaultValue = "") Integer pointId){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends =end+" 59:59:59";*/
		List<DataCheckRecordingModel> model = null;
		List<Integer> subIds = new ArrayList<Integer>();
		timeModel time=formatTime(type,month,season,year,start,end);
		Integer foodId=null;
		try {
			if(fid!=null&&fid!=""){
				//fid=checkRecordingService.selectArryByFid(fid);
//				subIds=baseFoodTypeService.querySonFoods(Integer.parseInt(fid)); delete by xiaoyl 2020/11/19
				/*if(fid.endsWith(",")){
					fid = fid.substring(0,fid.length() - 1);
				}*/
//				foodId=Integer.parseInt(fid);
				subIds=baseFoodTypeService.queryAllSonFoods(Integer.parseInt(fid));
			}
			if(did!=null&&did!=0){
				model=checkRecordingService.selectFoodGroup(did,subIds,typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
			}else {
				model=checkRecordingService.selectFoodGroup(tsUser.getDepartId(),subIds,typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		jsonObj.setObj(model);
		return jsonObj;
	}
    
    /**
     * 食品类别统计
     * @param request
     * @param response
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @param did
     * @param map
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
	 * @return
     */
    @RequestMapping(value="loadFoodType")
	public AjaxJson loadFoodType(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String typeObj,String start,String end,Integer did,String map
			,@RequestParam(required = false,defaultValue = "") String pointType
			,@RequestParam(required = false,defaultValue = "") Integer pointId
			,@RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends =end+" 59:59:59";*/
		foodTypeStatistics statistics = null;
		List<foodTypeStatistics> list=new ArrayList<foodTypeStatistics>();
		List<Integer> subIds = new ArrayList<Integer>();
		String fid;
		
		timeModel time=formatTime(type,month,season,year,start,end);
		try {
			if(map!=null){
				JSONArray json=JSONArray.fromObject(map);
				net.sf.json.JSONObject jsonOne;
//				Integer foodId=null;
				for(int i=0;i<json.length();i++){
				    jsonOne = json.getJSONObject(i);
				    if(!jsonOne.get("key").equals("")){
				    	/*fid=checkRecordingService.selectArryByFid(jsonOne.get("key").toString());
				    	if(fid.endsWith(",")){
							fid = fid.substring(0,fid.length() - 1);
						}*/
				    	subIds=baseFoodTypeService.queryAllSonFoods(Integer.parseInt(jsonOne.get("key").toString()));//querySonFoods
//						foodId=Integer.parseInt(jsonOne.get("key").toString());
				    	if(did!=null&&did!=0){
					    	statistics=checkRecordingService.selectFoodTypeGroup(did,subIds,typeObj,time.getStart(),time.getEnd(),(String) jsonOne.get("value"),Integer.parseInt(jsonOne.get("key").toString()),pointType,systemFlag,pointId);
						}else {
							statistics=checkRecordingService.selectFoodTypeGroup(tsUser.getDepartId(),subIds,typeObj,time.getStart(),time.getEnd(),(String) jsonOne.get("value"),Integer.parseInt(jsonOne.get("key").toString()),pointType,systemFlag,pointId);
						}
					    
					    list.add(statistics);
				    }
				}
				jsonObj.setObj(list);
			}else {
				List<DataCheckRecordingModel> model = null;
				if(did!=null&&did!=0){
					model=checkRecordingService.selectFoodGroup(did,null,null,time.getStart(),time.getEnd(),pointType,0,pointId);
				}else {
					model=checkRecordingService.selectFoodGroup(tsUser.getDepartId(),null,null,time.getStart(),time.getEnd(),pointType,0,pointId);
				}
				jsonObj.setObj(model);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return jsonObj;
	}
    
    /**
     * 食品安全预警
     * @param request
     * @param response
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
     * @return
     */
    @RequestMapping(value="loadFood2")
	public AjaxJson  loadFood2(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String start,String end,Integer did
			,@RequestParam(required = false,defaultValue = "") String pointType
			,@RequestParam(required = false,defaultValue = "") Integer pointId
			,@RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends =end+" 59:59:59";*/
		timeModel time=formatTime(type,month,season,year,start,end);
		List<DataCheckRecordingModel> model=null;
		if(did!=null&&did!=0){
			model=checkRecordingService.selectFoodGroup2(did,time.getStart(),time.getEnd(),pointType,systemFlag,pointId,null);
		}else{
			model=checkRecordingService.selectFoodGroup2(tsUser.getDepartId(),time.getStart(),time.getEnd(),pointType,systemFlag,pointId,null);
		}

		jsonObj.setObj(model);
		return jsonObj;
	}
    /**
     * 被检单位统计
     * @param request
     * @param response
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
	 * @param pointType 检测点类型 ： "" 全部，0 政府检测室，1 检测车，2 企业检测室
	 * @param systemFlag 系统标志，默认为0;0 为通用系统，1 武陵定制系统，当为1时需关联查询抽样基数、销毁数、阳性样品等信息
     * @return
     */
    @RequestMapping(value="loadReg")
	public AjaxJson  loadReg(HttpServletRequest request,HttpServletResponse response, HttpSession session,
			String type,String month,String season,String year,String start,String typeObj,String end,Integer did
			,@RequestParam(required = false,defaultValue = "") String pointType
			,@RequestParam(required = false,defaultValue = "") Integer pointId
			,@RequestParam(required = false,defaultValue = "") Integer taskType
			,@RequestParam(required = false,defaultValue = "0") Integer systemFlag){
    	TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		/*String ends = end+" 59:59:59";*/
		List<DataCheckRecordingModel> model = null;
		
		timeModel time=formatTime(type,month,season,year,start,end);
		try {
//			if(did!=null&&did!=0){
//				model=checkRecordingService.selectRegGroup(did,typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
//			}else {
//				model=checkRecordingService.selectRegGroup(tsUser.getDepartId(),typeObj,time.getStart(),time.getEnd(),pointType,systemFlag,pointId);
//			}

			if(did == null || did == 0){
				did = tsUser.getDepartId();
			}
			model = checkRecordingService.selectRegGroup(did, typeObj, time.getStart(), time.getEnd(), pointType, systemFlag, pointId,taskType,null);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		jsonObj.setObj(model);
		return jsonObj;
	}

	/**
	 * 六大批发市场统计的数据情况 - 甘肃系统
	 * @return
	 */
	@RequestMapping(value="loadReg2")
	public AjaxJson loadReg2(Integer departId, String start, String end, String foodTypeIds){
		AjaxJson jsonObj = new AjaxJson();
		List<Map<String, Object>> list = null;
		try {
			Calendar c = Calendar.getInstance();
			if (StringUtils.isBlank(end)) {
				end = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd HH:mm:ss");
			}
			if (StringUtils.isBlank(start)) {
				start = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd 00:00:00");
			}

			StringBuffer sql = new StringBuffer();
			//查询指定样品种类数据
			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append("SELECT tb1.point_id pointId, tb1.point_name pointName, tb2.food_name foodName,");
			} else {
				sql.append("SELECT tb1.point_id pointId, tb1.point_name pointName, '--' foodName, ");
			}
			sql.append(" tb1.conclusion conclusion, SUM(tb1.zs) zs, SUM(tb1.yx) yx " +
					"FROM " +
					"( " +
					" SELECT point_id, point_name, food_id, conclusion, COUNT(1) zs, " +
					"  SUM(IF(check_date <= upload_date AND upload_date <= DATE_ADD(check_date, INTERVAL 3 DAY) " +
					"   AND (data_source NOT IN (3,4) OR (data_source = 3 AND check_voucher IS NOT NULL AND check_voucher != '')), 1, 0)) yx " +
					" FROM data_check_recording " +
					" WHERE delete_flag=0 AND param7 = 1 ");
			if (departId != null) {
				sql.append("  AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ")
						.append(departId).append("),'%')) ");
			}
			sql.append("  AND check_date BETWEEN '").append(start).append("' AND '").append(end).append("' ");
			sql.append(" GROUP BY point_id, food_id, conclusion " +
					") tb1 ");

			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" INNER JOIN ( " +
						"	SELECT tb3.id, tb4.food_name, tb4.food_code " +
						"	FROM base_food_type tb3  " +
						"		INNER JOIN ( SELECT food_name, food_code FROM base_food_type WHERE delete_flag=0 AND id IN (" + foodTypeIds + ") ) tb4  " +
						"			ON tb3.food_code LIKE CONCAT(tb4.food_code, '%') " +
						"	WHERE tb3.delete_flag=0 " +
						" ) tb2 ON tb1.food_id = tb2.id " +
						" GROUP BY tb1.point_id, tb2.food_code, tb1.conclusion ");
			} else {
				sql.append(" GROUP BY tb1.point_id, tb1.conclusion ");
			}

			//查询其他样品种类数据
			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" UNION " +
						" SELECT tb6.point_id pointId, tb6.point_name pointName, '其他' foodName, tb6.conclusion, COUNT(1) zs, " +
						"  SUM(IF(tb6.check_date <= tb6.upload_date AND tb6.upload_date <= DATE_ADD(tb6.check_date, INTERVAL 3 DAY) " +
						"   AND (tb6.data_source NOT IN (3,4) OR (tb6.data_source = 3 AND tb6.check_voucher IS NOT NULL AND tb6.check_voucher != '')), 1, 0)) yx " +
						" FROM data_check_recording tb6" +
						" WHERE tb6.delete_flag=0   AND tb6.param7 = 1");

				if (departId != null) {
					sql.append("  AND tb6.depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ")
							.append(departId).append("),'%')) ");
				}
				sql.append("  AND tb6.check_date BETWEEN '").append(start).append("' AND '").append(end).append("' ");
				sql.append(" AND tb6.food_id NOT IN (SELECT tb7.id " +
						" FROM base_food_type tb7 " +
						"  INNER JOIN ( SELECT id, food_name, food_code FROM base_food_type WHERE delete_flag = 0 AND id IN (" + foodTypeIds + ") ) tb8 ON tb7.food_code LIKE CONCAT( tb8.food_code, '%' )  " +
						" WHERE tb7.delete_flag = 0 )");
				sql.append(" GROUP BY tb6.point_id, tb6.conclusion ");
			}

			sql.append(" ORDER BY pointName, pointId, foodName, conclusion ");

			list = jdbcTemplate.queryForList(sql.toString());

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>(3);
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}
    
    /**
     * 被检单位数据列表
     * @param model
     * @param page
     * @param response
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value="/loadRegdatagrid")
   	public AjaxJson loadRegdatagrid(DataCheckRecordingModel model,Page page,HttpServletResponse response,HttpServletRequest request, HttpSession session){
   		AjaxJson jsonObj = new AjaxJson();
   		Integer regId=(Integer) session.getAttribute("regId");
   		page.setOrder("desc");
   		try {
   			model.setRegId(regId);
   			timeModel time=formatTime(model.getType(),model.getMonth(),model.getSeason(),model.getYear(),model.getStart(),model.getEnd());
   			model.setStart(time.getStart());
   			model.setEnd(time.getEnd());
   			page =checkRecordingService.loadDatagrids(page, model);
   			jsonObj.setObj(page);
   		} catch (Exception e) {
   			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
   		}
        return jsonObj;
   	}

	/**
	 * 自定义统计数据
	 * @return
	 */
	@RequestMapping(value="/getCustomStatistics")
	public AjaxJson getCustomStatistics(Integer departId, String start, String end, String foodTypeIds, String itemIds, Integer regTaskTypeFlag){
		AjaxJson jsonObj = new AjaxJson();
		List<Map<String, Object>> list = null;
		try {
			Calendar c = Calendar.getInstance();
			if (StringUtils.isBlank(end)) {
				end = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd HH:mm:ss");
			}
			if (StringUtils.isBlank(start)) {
				start = DateUtil.formatDate(c.getTime(),"yyyy-MM-dd 00:00:00");
			}
			if (departId == null) {
				departId = PublicUtil.getSessionUser().getDepartId();
			}

			StringBuffer sql = new StringBuffer();
			sql.append("SELECT tb1.reg_id regId, tb1.reg_name regName, ");
			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" tb2.food_name foodName, ");
			}
			if (!StringUtils.isBlank(itemIds)) {
				sql.append(" tb4.detect_item_name itemName, ");
			}
			if (regTaskTypeFlag != null && regTaskTypeFlag == 1) {
				sql.append(" tb5.task_type regTaskType, ");
			}
			sql.append(" tb1.conclusion conclusion, SUM(tb1.zs) zs, SUM(tb1.yx) yx FROM ");

			sql.append("( " +
					" SELECT reg_id, reg_name, food_id, item_id, item_name, conclusion, COUNT(1) zs, " +
					"  SUM(IF(check_date <= upload_date AND upload_date <= DATE_ADD(check_date, INTERVAL 3 DAY) " +
					"   AND (data_source NOT IN (3,4) OR (data_source = 3 AND check_voucher IS NOT NULL AND check_voucher != '')), 1, 0)) yx " +
					" FROM data_check_recording " +
					" WHERE delete_flag=0 AND param7 = 1");
			if (departId != null) {
				sql.append("  AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ")
						.append(departId).append("),'%')) ");
			}
			if (!StringUtils.isBlank(itemIds)) {
				String[] itemIds0 = itemIds.split(",");
				if (itemIds0 != null && itemIds0.length > 0) {
					sql.append(" AND item_id IN ( ");
					for (String itemId0 : itemIds0) {
						sql.append("'").append(itemId0).append("',");
					}
					sql.deleteCharAt(sql.length()-1);
					sql.append(" ) ");
				}
			}
			sql.append("  AND check_date BETWEEN '").append(start).append("' AND '").append(end).append("' ");
			sql.append(" GROUP BY reg_id, food_id, item_id, conclusion " +
					") tb1 ");

			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" INNER JOIN ( " +
						"	SELECT tb3.id, tb4.food_name, tb4.food_code " +
						"	FROM base_food_type tb3  " +
						"		INNER JOIN ( SELECT food_name, food_code FROM base_food_type WHERE delete_flag=0 AND id IN (" + foodTypeIds + ") AND isFood=0 ) tb4  " +
						"			ON tb3.food_code LIKE CONCAT(tb4.food_code, '%') " +
						"	WHERE tb3.delete_flag=0 " +
						" ) tb2 ON tb1.food_id = tb2.id ");
			}

			if (!StringUtils.isBlank(itemIds)) {
				String[] itemIds0 = itemIds.split(",");
				if (itemIds0 != null && itemIds0.length > 0) {
					sql.append(" INNER JOIN (SELECT id, detect_item_name FROM base_detect_item WHERE delete_flag=0 AND id IN ( ");
					for (String itemId0 : itemIds0) {
						sql.append("'").append(itemId0).append("',");
					}
					sql.deleteCharAt(sql.length()-1);
					sql.append(" )) tb4 ON tb1.item_id = tb4.id ");
				}
			}

			if (regTaskTypeFlag != null && regTaskTypeFlag == 1) {
				sql.append(" LEFT JOIN ( SELECT id, task_type FROM base_regulatory_object WHERE delete_flag=0 ) tb5 ON tb1.reg_id = tb5.id ");
			}

			sql.append(" GROUP BY tb1.reg_id, ");
			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" tb2.food_code, ");
			}
			if (!StringUtils.isBlank(itemIds)) {
				sql.append(" tb4.id, ");
			}

			sql.append(" tb1.conclusion ORDER BY regName, regId, ");
			if (!StringUtils.isBlank(foodTypeIds)) {
				sql.append(" foodName, ");
			}
			if (!StringUtils.isBlank(itemIds)) {
				sql.append(" itemName, ");
			}
			sql.append(" conclusion ");

			list = jdbcTemplate.queryForList(sql.toString());

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		Map<String,Object> obj = new HashMap<String,Object>(3);
		obj.put("list", list);
		jsonObj.setObj(obj);
		return jsonObj;
	}
    
    /**
     * 被检单位折线图
     * @param response
     * @param request
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value="/selectRegForDate")
   	public AjaxJson selectRegForDate(HttpServletResponse response,HttpServletRequest request, HttpSession session,
   			String type,String month,String season,String year,String start,String end,String typeObj){
   		AjaxJson jsonObj = new AjaxJson();
   		/*String ends =end+" 23:59:59";*/
   		Integer regId=(Integer) session.getAttribute("regId");
   		List<DataCheckRecordingModel> model = null;
   		
   		timeModel time=formatTime(type,month,season,year,start,end);
   		try {
   			model =checkRecordingService.selectDataForDate(null,regId,typeObj,time.getStart(),time.getEnd());
   			jsonObj.setObj(model);
   		} catch (Exception e) {
   			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
   		}
        return jsonObj;
   	}
    
    /**
     * 被检单位饼图
     * @param response
     * @param request
     * @param session
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value="/selectRegForDates")
   	public AjaxJson selectRegForDates(HttpServletResponse response,HttpServletRequest request, HttpSession session,
   			String type,String month,String season,String year,String start,String end,String typeObj){
   		AjaxJson jsonObj = new AjaxJson();
   		/*String ends =end+" 23:59:59";*/
   		Integer regId=(Integer) session.getAttribute("regId");
   		List<DataCheckRecordingModel> model = null;
   		
   		timeModel time=formatTime(type,month,season,year,start,end);
   		try {
   			model =checkRecordingService.selectDataForDates(null,regId,typeObj,time.getStart(),time.getEnd());
   			jsonObj.setObj(model);
   		} catch (Exception e) {
   			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
   		}
        return jsonObj;
   	}
	/**
	 * 检测项目统计
	 */
	@RequestMapping("/projectStatistics")
	public ModelAndView projectStatistics(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/projectStatistics");
	}
	
	/**
	 * 食品种类统计
	 */
	@RequestMapping("/foodStatistics")
	public ModelAndView foodStatistics(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/foodStatistics");
	}
	
	/**
	 * 食品类别统计
	 */
	@RequestMapping("/foodTypeStatistics")
	public ModelAndView foodTypeStatistics(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/foodTypeStatistics");
	}
	
	/**
	 * 食品安全预警
	 */
	@RequestMapping("/foodStatistics2")
	public ModelAndView foodStatistics2(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/foodStatistics2");
	}
	
	/**
	 * 被检单位统计
	 */
	@RequestMapping("/orgStatistics")
	public ModelAndView orgStatistics(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname,String typeObj){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}
		return new ModelAndView("/statistics/orgStatistics");
	}

	@RequestMapping(value="querydepart")
	public AjaxJson querydepart(HttpServletRequest request,HttpServletResponse response, HttpSession session){
		AjaxJson jsonObj  = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		try {
			TSDepart depart=departService.getById(tsUser.getDepartId());
			jsonObj.setObj(depart);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
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
	public timeModel formatTime(String type,String month,String season,String year,String start,String end){
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
	/**********************数据统计-新版本**************/
	/**
	* @Description 武陵项目：检测点统计
	* @Date 2020/11/17 14:09
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/areaStatistics_wl")
	public ModelAndView areaStatistics_wl(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname,String typeObj){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}

		return new ModelAndView("/statistics/wl/areaStatistics_wl");
	}
	/**
	* @Description 武陵项目：被检单位统计
	* @Date 2020/11/17 14:09
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/orgStatistics_wl")
	public ModelAndView orgStatistics_wl(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname,String typeObj){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		request.setAttribute("typeObj", typeObj);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}
		return new ModelAndView("/statistics/wl/orgStatistics_wl");
	}
	/**
	 * 食品种类统计
	 */
	@RequestMapping("/foodStatistics_wl")
	public ModelAndView foodStatistics_wl(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/wl/foodStatistics_wl");
	}
	/**
	 * 检测项目统计
	 */
	@RequestMapping("/projectStatistics_wl")
	public ModelAndView projectStatistics_wl(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/wl/projectStatistics_wl");
	}
	/**
	 * 辖区统计
	 */
	@RequestMapping("/departStatistics_wl")
	public ModelAndView departStatistics_wl(HttpServletRequest request,HttpServletResponse response,String type,String month,String season,String year,String start,String end,String did,String flag,String dname){
		request.setAttribute("type", type);
		request.setAttribute("month", month);
		request.setAttribute("season", season);
		request.setAttribute("year", year);
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("did", did);
		request.setAttribute("dname", dname);
		if(flag!=null){
			request.setAttribute("flag", flag);
		}else {
			request.setAttribute("flag", 0);
		}

		return new ModelAndView("/statistics/wl/departStatistics_wl");
	}
	/**
	 * 食品类别统计
	 */
	@RequestMapping("/foodTypeStatistics_wl")
	public ModelAndView foodTypeStatistics_wl(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/statistics/wl/foodTypeStatistics_wl");
	}
	/**
	 * 食品安全预警
	 */
	@RequestMapping("/foodStatisticsSafe_wl")
	public ModelAndView foodStatisticsSafe_wl(HttpServletRequest request,HttpServletResponse response){
		TSUser tsUser = (TSUser)request.getSession().getAttribute(WebConstant.SESSION_USER);
		request.setAttribute("did", tsUser.getDepartId());
		request.setAttribute("dname", tsUser.getDepartName());
		return new ModelAndView("/statistics/wl/foodStatisticsSafe_wl");
	}
}
