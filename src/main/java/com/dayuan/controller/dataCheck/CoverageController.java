package com.dayuan.controller.dataCheck;

import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.regulatory.RegulatoryCoverageModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/dataCheck/recording")
public class CoverageController extends BaseController {

	@Autowired
	private DataCheckRecordingService dataCheckRecordingService;
	@Autowired
	private BaseRegulatoryObjectService objectService;
	@Autowired
	private BaseRegulatoryBusinessService businessService;
	/**
	 * 覆盖率页面
	 * @return
	 * @author LuoYX
	 * @date 2018年8月27日
	 */
	@RequestMapping("/coverage")
	public ModelAndView coverage(HttpServletRequest request) {
		String start = DateUtil.firstDayOfMonth();
		String end = DateUtil.lastDayOfMonth();
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		return new ModelAndView("/dataCheck/coverage");
	}

	/**
	 * 市场覆盖率数据
	 * @return
	 * @author LuoYX
	 * @throws MissSessionExceprtion 
	 * @date 2018年8月27日
	 */
	@RequestMapping("/coverageData")
	public Map<String,Object> coverageData(RegulatoryCoverageModel model) throws MissSessionExceprtion {
		model.setDepartId(PublicUtil.getSessionUserDepart().getId());
		Map<String,Object> result = new HashMap<String, Object>();
		List<Map<String, Object>> map1 = dataCheckRecordingService.queryCoverage(model);//查询每个市场检测的样品数和档口数
		List<Map<String, Object>> map2 = dataCheckRecordingService.queryCheckFoodCountGroupByRegId(model);//查询每个市场的检测过的样品总数
		List<Map<String, Object>> map3 = businessService.queryBusCountByGroupByRegId(model);//查询每个市场的档口数
		List<Map<String, Object>> map4 = dataCheckRecordingService.queryCheckFoodCount(model);//查询所有市场检测样品的总数
		List<Map<String, Object>> map5 = dataCheckRecordingService.queryCheckFoodCount2(model);//查询所有市场时间段内检测样品的数量
		result.put("coverage", map1);
		result.put("foodCount", map2);
		result.put("busCount", map3);
		result.put("foodCount2", map4);
		result.put("foodCount3", map5);
		return result;
	}
	
	@RequestMapping("/coverageDetail")
	public Map<String,Object> coverageDetail(RegulatoryCoverageModel model){
		List<BaseRegulatoryBusiness> bus = businessService.queryUnCheckBusiness(model);
		List<String> foods = dataCheckRecordingService.queryUnCheckFoodName(model);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("bus", bus);
		maps.put("foods", foods);
		return maps;
	}
}
