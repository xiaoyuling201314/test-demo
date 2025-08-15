//package com.dayuan.controller.delivery;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.dayuan.bean.AjaxJson;
//import com.dayuan.bean.Page;
//import com.dayuan.bean.data.TSDepart;
//import com.dayuan.bean.system.TSUser;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.controller.BaseController;
//import com.dayuan.model.delivery.DeliveryModel;
//import com.dayuan.service.delivery.TbDeliveryService;
//import com.dayuan.service.detect.DepartService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//
///**
// * 入场登记
// *
// */
//@Controller
//@RequestMapping("/delivery")
//public class TbDeliveryController extends BaseController {
//	private final Logger log = Logger.getLogger(TbDeliveryController.class);
//
//	@Autowired
//	private TbDeliveryService deliveryService;
//	@Autowired
//	private BaseRegulatoryObjectService regulatoryObjectService;
//	@Autowired
//	private DepartService departService;
//
//	/**
//	 * 入场登记
//	 */
//	@RequestMapping("/list")
//	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,Integer taskId){
//
//		Map<String,Object> map = new HashMap<String,Object>();
//		return new ModelAndView("/delivery/list",map);
//	}
//
//	/**
//	 * 表格数据
//	 */
//	@RequestMapping(value="/datagrid")
//	@ResponseBody
//	public AjaxJson  datagrid(HttpServletRequest request, HttpServletResponse response, DeliveryModel model, Page page){
//		AjaxJson jsonObj = new AjaxJson();
//		try {
//			TSUser user = PublicUtil.getSessionUser();
//			List<Integer> departIds = departService.querySonDeparts(user.getDepartId());
//			List<Integer> regIds = regulatoryObjectService.queryRegIdsByDepartIds(departIds);
//			model.setRegIds(regIds);
//
//			page = deliveryService.loadDatagrid(page, model);
//			jsonObj.setObj(page);
//		} catch (Exception e) {
//			log.error("******************************" + e.getMessage() + e.getStackTrace());
//			jsonObj.setSuccess(false);
//			jsonObj.setMsg("操作失败");
//		}
//		return jsonObj;
//	}
//
//	/**
//	 * 入场登记详情
//	 */
//	@RequestMapping("/detail")
//	public ModelAndView detail(HttpServletRequest request,HttpServletResponse response,Integer id){
//
//		Map<String,Object> map = new HashMap<String,Object>();
//
//		//根据登记日期获取入场信息
//		DeliveryModel deliveryModel = deliveryService.queryDeliveryById(id);
//
//		map.put("deliveryModel", deliveryModel);
//		return new ModelAndView("/delivery/detail",map);
//	}
//
//}
