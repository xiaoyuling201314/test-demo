package com.dayuan3.common.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.controller.BaseController;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.InspectionUnitUserLabel;
import com.dayuan3.common.bean.TerminalBaseFood;
import com.dayuan3.common.service.CommonDataService;
import com.dayuan3.common.service.InspectionUnitUserLabelService;
import com.dayuan3.common.util.PingYinUtil;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.service.RequesterUnitService;

@Controller
@RequestMapping("/tFoodType")
public class TBaseFoodTypeController extends BaseController {

	@Autowired
	private CommonDataService commonDataService;
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;

	@Autowired
	private RequesterUnitService requesterUnitService;

	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	
	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	
	@Autowired
	private InspectionUnitUserLabelService labelService;

	@RequestMapping("/queryAllFoodType")
	@ResponseBody
	public AjaxJson queryAllFoodType(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson ajaxJson = new AjaxJson();
		List<TerminalBaseFood> list = commonDataService.queryCommonFood();
		Object str = JSONArray.toJSON(list);
		JSONObject obj = new JSONObject();
		obj.put("obj", list);
		String path = request.getSession().getServletContext().getRealPath("/");
		try {
			File file = new File(path + "/WEB-INF/view/terminal/food.json");
			if (!file.exists()) {
				file.createNewFile();
			}
			FileWriter fw = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(obj.toJSONString());
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ajaxJson.setObj(list);
		return ajaxJson;
	}

	/**
	 * 提取样品库名称的首字母和全拼
	 * @description
	 * @param type 类型: 0 样品 1委托单位 2 样品来源,4委托单位标签
	 * @param lastUpdateTime
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月25日
	 */
	@RequestMapping("/changeAllLetter")
	@ResponseBody
	public AjaxJson changeAllLetter(Integer type,String lastUpdateTime) {
		AjaxJson ajaxJson = new AjaxJson();
		// 1.提取样品首字母和拼音
		switch (type) {
		case 0:
			List<BaseFoodType> list = baseFoodTypeService.queryFoodByLastUpdateTime(lastUpdateTime);;
			if (list != null && list.size() > 0) {
				list.forEach((item) -> {
					String name = item.getFoodName();
					String otherName=item.getFoodNameOther();
					try {
						if(StringUtil.isEmpty(otherName)) {
							item.setFoodFirstLetter(PingYinUtil.getFirstLetter(name));
							item.setFoodFullLetter(PingYinUtil.getFullLetter(name));
						}else {
							String [] others=otherName.split("[， , 、]");
							String firstStr="";
							String fullStr="";
							for (int i = 0; i < others.length; i++) {
								firstStr+=","+PingYinUtil.getFirstLetter(others[i]);
								fullStr+=","+PingYinUtil.getFullLetter(others[i]);
							}
							item.setFoodFirstLetter(PingYinUtil.getFirstLetter(name)+firstStr);
							item.setFoodFullLetter(PingYinUtil.getFullLetter(name)+fullStr);
						}
						baseFoodTypeService.updateById(item);
					} catch (Exception e) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品首字母和拼音异常：" + e.getMessage());
					}
				});
			}
			CommonDataController.terminalfoodList = null;
			break;
		case 1:
			// 2.提取所有委托单位
			List<RequesterUnit> requesterUnits = requesterUnitService.queryAll(lastUpdateTime);
			if (requesterUnits != null && requesterUnits.size() > 0) {
				requesterUnits.forEach((item) -> {
					String name = item.getRequesterName();
					try {
						item.setRequesterFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setRequesterFullLetter(PingYinUtil.getFullLetter(name));
						requesterUnitService.updateBySelective(item);
					} catch (Exception e) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品首字母和拼音异常：" + e.getMessage());
					}
				});
			}
			CommonDataController.terminalRequestList = null;
			break;
		case 2:
			// 3.提取所有样品来源
			List<BaseRegulatoryObject> regsList = baseRegulatoryObjectService.queryByDepartId(null, "1");
			if (regsList != null && regsList.size() > 0) {
				regsList.forEach((item) -> {
					String name = item.getRegName();
					try {
						item.setRegFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setRegFullLetter(PingYinUtil.getFullLetter(name));
						baseRegulatoryObjectService.updateBySelective(item);
					} catch (Exception e) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品首字母和拼音异常：" + e.getMessage());
					}
				});
				CommonDataController.terminalRegobjList = null;
			}
			break;
		case 3:
			// 4.提取所有档口
			List<BaseRegulatoryBusiness> businessList = baseRegulatoryBusinessService.queryByUpdateDate(lastUpdateTime);
			if (businessList != null && businessList.size() > 0) {
				businessList.forEach((item) -> {
					String name = item.getOpeShopCode();
					try {
						if(StringUtil.isNotEmpty(name)) {
							item.setBusinessFirstLetter(PingYinUtil.getFirstLetter(name));
							item.setBusinessFullLetter(PingYinUtil.getFullLetter(name));
							baseRegulatoryBusinessService.updateBySelective(item);
						}
					} catch (Exception e) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg(DateUtil.datetimeFormat.format(new Date()) + ",定期生成经营档口首字母和拼音异常：" + e.getMessage());
					}
				});
			}
			break;
		case 4:
			// 4.提取委托单位标签
			List<InspectionUnitUserLabel> labelList = labelService.queryAllByLastUpdateTime(null,lastUpdateTime);
			if (labelList != null && labelList.size() > 0) {
				labelList.forEach((item) -> {
					String name = item.getLabelName();
					try {
						if(StringUtil.isNotEmpty(name)) {
							item.setLabelFirstLetter(PingYinUtil.getFirstLetter(name));
							item.setLabelFullLetter(PingYinUtil.getFullLetter(name));
							item.setUpdateDate(new Date());
							labelService.updateBySelective(item);
						}
					} catch (Exception e) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg(DateUtil.datetimeFormat.format(new Date()) + ",定期生成委托单位标签首字母和拼音异常：" + e.getMessage());
					}
				});
			}
			break;
		default:
			break;
		}
		return ajaxJson;
	}
}
