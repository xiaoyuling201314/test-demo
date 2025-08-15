package com.dayuan.controller.detect;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.detect.DetectCarLocation;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.controller.BaseController;
import com.dayuan.model.detect.DetectCarLocationModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.BaseWorkersService;
import com.dayuan.service.detect.DetectCarLocationService;

/**
 * 快检车设备管理Action
 * @author xyl
 *
 */
@Controller
@RequestMapping("/detect/location")
public class DetectCarLocationAction extends BaseController {
	
	private final Logger log = Logger.getLogger(DetectCarLocationAction.class);
	
	@Autowired
	private DetectCarLocationService detectCarLocationService;
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private BaseWorkersService baseWorkersService;
	
	/**
	 * 进入轨迹回放 页面
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/replay")
	public ModelAndView replay(Integer id, @RequestParam(required = false,defaultValue = "Y") String showDudao, @RequestParam(required = false,defaultValue = "N") String openIframe, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> map=new HashMap<>();
		BasePoint point=basePointService.queryById(id);
		//负责人
		BaseWorkers manager = baseWorkersService.queryById(point.getManagerId());
		map.put("point", point);
		map.put("manager", manager);
		map.put("showDudao", showDudao);
		map.put("openIframe", openIframe);//是否以子窗口形式打开页面
		return new ModelAndView("/detect/carLocation/replay",map);
	}
	/**
	 * 根据定位设备ID查看某一辆车的位置
	 * @param id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(Integer id,HttpServletResponse response,HttpServletRequest request){
		AjaxJson jsonObject=new AjaxJson();
		try {
			//1.根据检测车Id查询车辆最后位置
			DetectCarLocation bean  = detectCarLocationService.queryLastLocationByPointId(id);
			//2.没有定位数据则显示快检点、快检车的经纬度坐标
			if(bean  == null){
				bean=new DetectCarLocation();
				BasePoint point=basePointService.queryById(id);
				bean.setLongitude(point.getPlaceX());
				bean.setLatitude(point.getPlaceY());
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询异常"+e.getMessage());
		}
		return jsonObject;
	}
	/**
	 * 根据ID查找定位记录数据，轨迹回放页面
	 * 默认查询一天的记录进行回放
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/replayDataList")
	@ResponseBody
	public AjaxJson replayDataList(DetectCarLocationModel model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		AjaxJson jsonObject=new AjaxJson();
		Map<String, Object> map=new HashMap<>();
		List<DetectCarLocation> list  = detectCarLocationService.queryByList(model);
		List<BaseRegulatoryObject> listRegula =null ;//baseRegulaService.selectCheckOrgByCode(org.getOrganizationCode());
		//查询停车点信息列表
		model.setShowStop(true);
		List<DetectCarLocation> stopArrayList  = detectCarLocationService.queryByList(model);
		if(list  == null){
			jsonObject.setSuccess(false);
			jsonObject.setMsg("没有找到相关的记录");
			return jsonObject;
		}
		jsonObject.setObj(list);
		map.put("stopList", stopArrayList);
		map.put("listRegula", listRegula);
		jsonObject.setAttributes(map);
		return jsonObject;
	}
	/**
	 * 根据定位设备IMEI号码查询有数据的日期，筛选前10条
	 * @param request
	 * @param response
	 * @param carImei
	 * @return
	 */
	@RequestMapping("/queryGroupDateByCarImei")
	@ResponseBody
	public List<DetectCarLocation> queryGroupDateByCarImei(HttpServletRequest request,HttpServletResponse response,String carImei){
		List<DetectCarLocation> list=null;
		try {
			list=detectCarLocationService.queryGroupDateByCarImei(carImei);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return list;
	}
}
