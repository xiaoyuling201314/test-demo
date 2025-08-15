package com.dayuan3.common.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.util.wx.WeixinUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.InspectionUnitUserLabel;
import com.dayuan3.common.bean.OrderObjhistory;
import com.dayuan3.common.bean.TerminalBaseFood;
import com.dayuan3.common.bean.TerminalBaseRegObj;
import com.dayuan3.common.bean.TerminalRequestUnit;
import com.dayuan3.common.bean.baseFood;
import com.dayuan3.common.bean.baseInspectionUnit;
import com.dayuan3.common.bean.baseObj;
import com.dayuan3.common.bean.baseUnit;
import com.dayuan3.common.service.CommonDataService;
import com.dayuan3.common.service.InspectionUnitUserLabelService;
import com.dayuan3.common.service.OrderObjhistoryService;
import com.dayuan3.common.service.OrderhistoryService;
import com.dayuan3.terminal.bean.InsUnitReqUnit;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.service.InsUnitReqUnitService;
import com.dayuan3.admin.service.InspectionUnitService;

/**
 * 订单支付系统 基础数据查询
 *
 * @author cola_hu
 *2019年7月18日
 */
@Controller
@RequestMapping("/wx/order")
public class CommonDataController {
	private Logger log = Logger.getLogger(CommonDataController.class);
	
	@Autowired
	private OrderhistoryService orderHistory ;
	@Autowired
	private OrderObjhistoryService orderObjHistory ;
	@Autowired
	private InspectionUnitUserLabelService labelService;
	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	@Autowired
	private BaseDetectItemService baseDetectItemService;
	@Autowired
	private CommonDataService dataService;
	
	@Autowired
	private InsUnitReqUnitService insUnitReqUnitService;
	
	public static  List<baseFood> foodList=null;//样品列表
	public static  List<baseObj> objList=null;//监管对象列表
	public static  List<baseUnit> unitList=null;//委托单位列表
	
	public static  List<baseInspectionUnit> inspectionList=null;//送检单位列表
	
	//自动更新数据
	public static  Date unitDate=null;//委托单位更新时间
	public static  Date foodDate=null;//委托单位更新时间
	public static  Date objDate=null;//委托单位更新时间
	
	public static  Date inspectionListDate=null;//送检单位更新时间
	
	
	//自助终端使用数据
	public static  List<TerminalBaseFood> terminalfoodList=null;//自助终端样品列表 add by xiaoyuling 2019-07-23
	public static  List<TerminalRequestUnit> terminalRequestList=null;//自助终端委托单位 add by xiaoyuling 2019-07-23
	public static  List<TerminalBaseRegObj> terminalRegobjList=null;//自助终端--样品来源 add by xiaoyuling 2019-07-23
	
	//充值活动内容
	public static  TopupActivities activitie =null;
	public static  String activitie_uuid =null;//充值活动id
	
	
	@Autowired
	private InspectionUnitService inspectionUnitService;
	@Value("${requesterKey}")
	private String requesterKey;//企查查接口key
	@Value("${requesterSecretKey}")
	private String requesterSecretKey;//企查查接口秘钥
	@Value("${requesterUrl}")
	private String requesterUrl;//企查查接口url
	/**
	 * 获取 全部历史信息
	 * @param request
	 * @param response
	 * @param userType 用户类型 1自助终端 2 微信 0状态下无权限
	 * @param keyType 0 来源1档口
	 * @param regName： HistoryType =3时 必传
	 * @param HistoryType：查询历史数据类型 1.委托单位 2.来源 3.档口 4.样品
	 * @return
	 */
	@RequestMapping(value="/getHistory")
	@ResponseBody
	public  AjaxJson getHistory(HttpServletRequest request,@RequestParam(defaultValue = "0") Integer userType, Integer HistoryType, HttpServletResponse response,String regName){
		AjaxJson jsonObject = new AjaxJson();
		try {
			Integer userId=0;
			
			if(userType==2){//微信公众号获取历史记录
				
				/*InspectionUnitUser  user= WeixinUtil.getSessionUser();
				 if(user!=null){
					 userId=user.getId();
				 }*/
				 
			}else if(userType==1){//自助终端
				InspectionUnitUser user=(InspectionUnitUser) request.getSession().getAttribute(WebConstant.SESSION_USER1);
				 if(user!=null){
					 userId=user.getId();
				 }
			}
			
			//无用户查询失败 校验用户
			if(userId==0||userId==null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("查询失败,用户信息失效!");	
				return jsonObject;
			}
			
			switch (HistoryType) { //根据查询类型查询数据
			
			case 1://委托单位
				List<RequesterUnit>	unitlist=	 orderHistory.selectUnitHistory(userId);
				jsonObject.setObj(unitlist);
				break;
				
			case 2://来源
				
				List<OrderObjhistory>	list1=	 orderObjHistory.selectObjHistory(userId, (short) 0, null);
				jsonObject.setObj(list1);
				break;
				
			case 3://档口
				
				List<OrderObjhistory>	list2=	 orderObjHistory.selectObjHistory(userId, (short) 1, regName);
				jsonObject.setObj(list2);
				break;
				
			case 4://样品
				
				List<baseFood>	foodlist=	 orderHistory.selectFoodHistory(userId);
				jsonObject.setObj(foodlist);
				
				break;

			default:
				break;
			}
			
	 
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	
 
	
	
	@RequestMapping(value="/getFoods")
	@ResponseBody
	public  AjaxJson getFoods(HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//获取样品种类
			if(foodList==null){
				foodDate=new Date();
				foodList = dataService.queryAllFood2();
			}
			jsonObject.setObj(foodList);
			
			
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	
	/**
	 * 获取送检单位信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getInspectionList")
	@ResponseBody
	public  AjaxJson getInspectionList(HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//获取样品种类
			if(inspectionList==null){
				inspectionListDate=new Date();
				inspectionList = dataService.queryInspection();
			}
			jsonObject.setObj(inspectionList);
			
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
 
	/**
	 * 页面获取 基础参数 委托单位
	 * @param request
	 * @param response
	 * @param bean
	 * @param details
	 * @param files
	 * @return
	 */
	@RequestMapping(value="/getRequesterUnits")
	@ResponseBody
	public  AjaxJson getRequesterUnits(HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//获取委托单位
			if(unitList==null){
				unitDate=new Date();
			unitList = dataService.queryAll2();
			}
			jsonObject.setObj(unitList);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	
	/**
	 * 获取来源市场
	 * @param request
	 * @param response
	 * @param bean
	 * @param details
	 * @param files
	 * @return
	 */
	@RequestMapping(value="/getObj")
	@ResponseBody
	public  AjaxJson getObj(HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(objList==null){
				objDate=new Date();
				objList= dataService.queryByDepartId2(null, "1");
				 jsonObject.setObj(objList);
			}else{
				jsonObject.setObj(objList);
			}
			 
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	
	/**
	 * 查找数据，进入编辑页面 查询档口
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/getOpes")
	@ResponseBody
	public AjaxJson getOpes(Integer regId,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(regId)){
				List<BaseRegulatoryBusiness> business = baseRegulatoryBusinessService.queryByRegid(regId, null);
				jsonObject.setObj(business);
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
		}
		return jsonObject;
	}

	
	
	
	@RequestMapping("/queryByFoodId")
	@ResponseBody
	public AjaxJson queryByFoodId(HttpServletRequest request,HttpServletResponse response,String foodId){
		AjaxJson jsonObject = new AjaxJson();
		List<BaseDetectItem> list=null;
		try {
			//通过样品ID查询检测项目(只查询当前样品的检测项目，不再向上或向下查询)
			list=baseDetectItemService.queryByFoodId(new String[] {foodId});
			jsonObject.setObj(list);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
		}
		return jsonObject;
	}
	/**
	 * 自助终端查询--查询所有样品信息，多了首拼和全拼
	 * @description
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月23日
	 */
	@RequestMapping(value="/getFoodsForTerminal")
	@ResponseBody
	public  AjaxJson getFoodsForTerminal(HttpServletRequest request, HttpServletResponse response,String md5Str){
		AjaxJson jsonObject = new AjaxJson();
		try {
				//获取样品种类
				if(terminalfoodList==null){
					terminalfoodList = dataService.queryCommonFood();
				}
				//MD5值校验
				String obj=CipherUtil.getMessageDigest(JSONObject.toJSONString(terminalfoodList).getBytes());
				if(md5Str==null || !md5Str.equals(obj)) {//首次进入或者数据已修改
					jsonObject.setObj(terminalfoodList);
				}
				jsonObject.setResultCode(obj);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	/**
	  * 自助终端--查询委托单位信息
	 * @description
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月23日
	 */
	@RequestMapping(value="/getRequesterUnitsForTerminal")
	@ResponseBody
	public  AjaxJson getRequesterUnitsForTerminal(HttpServletRequest request, HttpServletResponse response,String md5Str){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//获取委托单位
			if(terminalRequestList==null){
				terminalRequestList = dataService.queryRequestForTerminal();
			}
			//MD5值校验
			String obj=CipherUtil.getMessageDigest(JSONObject.toJSONString(terminalRequestList).getBytes());
			if(md5Str==null || !md5Str.equals(obj)) {//首次进入或者数据已修改
				jsonObject.setObj(terminalRequestList);
			}
			jsonObject.setResultCode(obj);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	/**
	  * 自助终端--查询委托单位标签信息
	 * @description
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2020年1月8日
	 */
	@RequestMapping(value="/getUserLabelForTerminal")
	@ResponseBody
	public  AjaxJson getUserLabelForTerminal(HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			 InspectionUnitUser user = PublicUtil.getSessionTerminalUser();
			//获取委托单位标签
			 List<InspectionUnitUserLabel> terminalLabelList = labelService.queryAllByLastUpdateTime(user.getId(),null);
			 List<InsUnitReqUnit> list=insUnitReqUnitService.loadInspectionUnit(user.getInspectionId(), null, null);
			 if(list!=null && list.size()>0) {
				 int count=labelService.selectAllCountLabel(user.getInspectionId(), user.getId());
				 InspectionUnitUserLabel bean=new InspectionUnitUserLabel(0,user.getId(),"全部",count);
				 terminalLabelList.add(bean);
			 }
			jsonObject.setObj(terminalLabelList);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	/**
	  * 自助终端--样品来源信息
	 * @description
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月23日
	 */
	@RequestMapping(value="/getRegobjForTerminal")
	@ResponseBody
	public  AjaxJson getRegobjForTerminal(HttpServletRequest request, HttpServletResponse response,String md5Str){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(terminalRegobjList==null){
				terminalRegobjList= dataService.queryRegByDepartId(null, "1");
			}
			//MD5值校验
			String obj=CipherUtil.getMessageDigest(JSONObject.toJSONString(terminalRegobjList).getBytes());
			if(md5Str==null || !md5Str.equals(obj)) {//首次进入或者数据已修改
				jsonObject.setObj(terminalRegobjList);
			}
			jsonObject.setResultCode(obj);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	
	/**
	 * 定时更新基础数据 当前为5分钟更新一次
	 */
	//@Scheduled(cron = "0 0/5 * * * ?")
	@RequestMapping("/updateUnitData")
	public  void updateUnitData() {
		try {
			if(unitDate==null||unitList==null){//更新时间为空 
				unitDate=new Date();
				unitList = dataService.queryAll2();
			}else{
				int num=		dataService.queryUnitSatus(unitDate);
				if(num>0){
					unitDate=new Date();
					unitList = dataService.queryAll2();
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//@Scheduled(cron = "0 0/5 * * * ?")
	@RequestMapping("/updateFoodData")
	public  void updateFoodData() {
		try {
			if(foodDate==null||foodList==null){//更新时间为空 
				foodDate=new Date();
				foodList = dataService.queryAllFood2();
			}else{
				int num=		dataService.queryFoodSatus(foodDate);
				if(num>0){
					foodDate=new Date();
					foodList = dataService.queryAllFood2();
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//@Scheduled(cron = "0 0/5 * * * ?")
	@RequestMapping("/updateObjData")
	public  void updateObjData() {
		try {
			if(objDate==null||objList==null){//更新时间为空 
				objDate=new Date();
				objList= dataService.queryByDepartId2(null, "1");
			}else{
				int num=		dataService.queryUnitSatus(objDate);
				if(num>0){
					objDate=new Date();
					objList= dataService.queryByDepartId2(null, "1");
				}
				
			}
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/checkUpdate")
	@ResponseBody
	public  AjaxJson checkUpdate(String md5,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			//MD5值校验
			String obj=JSONObject.toJSONString(terminalfoodList);
			if(!obj.equals(md5)) {//校验数据是否需要更新
				jsonObject.setObj("update");
			}
		} catch (Exception e) {
			log.error("**************************"+e.getMessage());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败!");
		}
		return jsonObject;
	}
	/**
	 * 根据社会信用代码查询送检单位信息，返回送检单位对象；
	 * 前端展示单位名称、并隐藏单位ID值用于用户注册时关联
	 * @description
	 * @param creditCode
	 * @param request
	 * @param response
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月29日
	 */
	@RequestMapping(value="/checkCreditCode")
	@ResponseBody
	public  AjaxJson checkCreditCode(String creditCode,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(creditCode.length()==18) {
				InspectionUnit bean=inspectionUnitService.queryRequesterByInterface(requesterKey, requesterSecretKey, requesterUrl, creditCode);
				jsonObject.setObj(bean);
			}else {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("请输入正确的社会统一代码");
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
}
