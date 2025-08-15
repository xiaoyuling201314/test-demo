package com.dayuan.controller.ledger;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.ledger.BaseLedgerHistory;
import com.dayuan.bean.ledger.BaseLedgerObjHistory;
import com.dayuan.bean.ledger.BaseLedgerSale;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.ledger.BaseLedgerSaleModel;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.ledger.BaseLedgerHistoryService;
import com.dayuan.service.ledger.BaseLedgerObjHistoryService;
/**
 * 这是销售台站管理
 * @author cola_hu
 *
 */
import com.dayuan.service.ledger.BaseLedgerSaleService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.StringUtil;
@Controller
@RequestMapping("/ledger/sale")
public class BaseLedgerSaleController extends BaseController {
	private final Logger log = Logger.getLogger(BaseLedgerSaleController.class);
	@Autowired
	private BaseLedgerSaleService   saleService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private BaseRegulatoryTypeService baseRegulatoryTypeService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BaseLedgerHistoryService historyService;
	@Autowired
	private BaseLedgerObjHistoryService objHistoryService;
	

	/** 进入经营户进货管理列表
	 * @param request
	 * @param response
	 * @param regId
	 * 	htmlType 页面进入类型 1.台账管理进入  3.台账数据列表进入
	 * @return */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, Integer regId, Integer businessId,String htmlType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("businessId", businessId);
		map.put("regId", regId);
		map.put("htmlType", htmlType);
		return new ModelAndView("/ledger/sale/list", map);
	}
	
	/** 单条台账查询 新增页面
	 * @param id 台账信息表id businessId 经营户id
	 * @param request
	 * @param response
	 * @return 
	 * @throws MissSessionExceprtion */
	@RequestMapping("/add")
	public ModelAndView add(Integer id, Integer regId, Integer businessId,String showType,String htmlType,  String regTypeId,HttpServletRequest request,
			HttpServletResponse response,String winType) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user = PublicUtil.getSessionUser();
		try {
		
			if (null!= id) {// 查询数据
				BaseLedgerSale sale=saleService.queryById(id);
				if(regId==null){
					regId=sale.getRegId();
				}
				map.put("sale", sale);
			} else {
				map.put("regId", regId);
				map.put("businessId", businessId);
			}
		map.put("showType", showType);
		map.put("regTypeId", regTypeId);
		map.put("winType", winType);
		BaseRegulatoryObject bean=new BaseRegulatoryObject();
		bean.setDepartId(user.getDepartId());
		if(user.getRegId()!=null){
			bean.setId(user.getRegId());
		}
		if(regId==null){
			
		}
		BaseRegulatoryObject	  obj =	baseRegulatoryObjectService.queryById(regId);
		if(obj!=null){
			regTypeId=obj.getRegType();
		}
		BaseRegulatoryType type=	baseRegulatoryTypeService.queryById(regTypeId);
		if(type!=null){
			if(type.getStockType()==null){
				map.put("showReg", 0);
				bean.setManagementType("0");
			}else if(type.getStockType().equals((short)1)){//针对市场录入台账
				map.put("showReg", 1);
			}else{
				map.put("showReg", 0);
				bean.setManagementType("0");
			}
		}
		bean.setRegType(regTypeId);
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryAllByDepartId(bean);
		map.put("regObj", regObj);
		map.put("htmlType", htmlType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/ledger/sale/add", map);
	}
	
	/** 单条台账查询 编辑页面
	 * @param id 台账信息表id businessId 经营户id
	 * @param request
	 * @param response
	 * @return 
	 * @throws MissSessionExceprtion */
	@RequestMapping("/edit")
	public ModelAndView edit(Integer id, Integer regId, Integer businessId,String showType, String regTypeId, HttpServletRequest request,
			HttpServletResponse response,String htmlType) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user = PublicUtil.getSessionUser();
		try {
			if (null!= id) {// 查询数据
					BaseLedgerSale sale=saleService.queryById(id);
					if(regId==null){
						regId=sale.getRegId();
					}
					map.put("sale", sale);
					if(regTypeId==null){
						BaseRegulatoryObject  obj= baseRegulatoryObjectService.queryById(sale.getRegId());
						if(obj!=null){
							regTypeId=obj.getRegType();
						}
					}
					BaseRegulatoryType type=	baseRegulatoryTypeService.queryById(regTypeId);
					if(type!=null){
						if(type.getStockType()==null){
							map.put("showReg", 0);
						}else if(type.getStockType().equals((short)1)){//针对市场录入台账
							map.put("showReg", 1);
						}else{
							map.put("showReg", 0);
						}
					}
			} else {
				map.put("regId", regId);
				map.put("businessId", businessId);
			}
		map.put("showType", showType);
		BaseRegulatoryObject bean=new BaseRegulatoryObject();
		bean.setDepartId(user.getDepartId());
		if(user.getRegId()!=null){
		bean.setId(user.getRegId());
		}
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryAllByDepartId(bean);
		map.put("regObj", regObj);
		map.put("htmlType", htmlType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/ledger/sale/edit", map);
	}

	
	@RequestMapping(value = "/save")
	@ResponseBody
	public AjaxJson save(BaseLedgerSale bean,HttpServletRequest request,HttpServletResponse response) throws MissSessionExceprtion {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		TSUser user = PublicUtil.getSessionUser();
		try {
			if(bean.getId()==null) {//新增
				bean.setCreate_by(user.getId());
				bean.setCreate_date(now);
				bean.setDelete_flag((short)0);
				saleService.insertSelective(bean);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("新增成功！");
			}else  {// 更新
				bean.setUpdate_by(user.getId());
				bean.setUpdate_date(now);
				saleService.updateBySelective(bean);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("更新成功！");
			} 
			try {// 这是将输入记录存在数据库中
			/*	BaseLedgerHistory history = new BaseLedgerHistory();
				history.setUserId(bean.getBusinessId());
				history.setUserType((short) 2);
				// 样品记录
				List<BaseLedgerHistory> list = historyService.selectHistoryData(history);
				Boolean foodName = false;
				for (BaseLedgerHistory baseLedgerHistory : list) {
					short keytype = baseLedgerHistory.getKeyType();
					// 食品种类
					if (baseLedgerHistory.getKeyword().equals(bean.getFoodName()) && keytype == 2) {
						if(baseLedgerHistory.getHistoryCount()==null){
							baseLedgerHistory.setHistoryCount(1);
							}else{
							baseLedgerHistory.setHistoryCount(baseLedgerHistory.getHistoryCount()+1);
							}
						historyService.updateBySelective(baseLedgerHistory);
						foodName = true;
						break;
					}
				}
				history.setCreateDate(now);
				history.setDeleteFlag((short) 0);
				if (!foodName) {
					history.setKeyword(bean.getFoodName());
					history.setKeyType((short) 2);
					history.setHistoryCount(1);
					historyService.insert(history);
				}*/
				BaseLedgerHistory history = new BaseLedgerHistory();
				if(bean.getBusinessId()==null){//市场录入
					history.setType((short)1);
					history.setUserId(bean.getRegId());
				}else{
					history.setType((short)0);
					history.setUserId(bean.getBusinessId());
				}
				history.setKeyword(bean.getFoodName());
				history.setUserType((short) 2);
				history.setKeyType((short)2);//
				// 样品记录
					history.setKeyword(bean.getFoodName());
					List<BaseLedgerHistory> list = historyService.selectHistoryData(history);
					if(list.size()>0){//已存在
						if(list.get(0).getHistoryCount()==null){
							list.get(0).setHistoryCount(1);//加你
						}else{
							list.get(0).setHistoryCount(list.get(0).getHistoryCount()+1);//加你
						}
						historyService.updateBySelective(list.get(0));
						
					}else{//新增
						history.setCreateDate(now);
						history.setDeleteFlag((short) 0);
						history.setKeyword(bean.getFoodName());
						history.setHistoryCount(1);
						historyService.insert(history);
						
					}
					
				// 市场经营户记录
				BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
				if(bean.getBusinessId()==null){//市场录入
					objHistory.setType((short)1);
					objHistory.setUserId(bean.getRegId());
				}else{
					objHistory.setType((short)0);
					objHistory.setUserId(bean.getBusinessId());
				}
				objHistory.setUserType((short) 1);
				objHistory.setKeyType((short) 1);//销售
				Boolean supplier = false;
				List<BaseLedgerObjHistory> objlist = objHistoryService.selectHistoryData(objHistory);
				for (BaseLedgerObjHistory baseLedgerObjHistory : objlist) {
					short keytype = baseLedgerObjHistory.getKeyType();
					// keytype=1 进货台账 2销售
					if (baseLedgerObjHistory.getKeyword().equals(bean.getCustomer())
							&& baseLedgerObjHistory.getRegname().equals(bean.getParam1()) && keytype == 1) {
						if(baseLedgerObjHistory.getHistoryCount()==null){
							baseLedgerObjHistory.setHistoryCount(1);
							}else{
								baseLedgerObjHistory.setHistoryCount(baseLedgerObjHistory.getHistoryCount()+1);	
							}
						objHistoryService.updateBySelective(baseLedgerObjHistory);
						supplier = true;
						break;
					}
				}
				objHistory.setCreateDate(now);
				objHistory.setDeleteFlag((short) 0);
				if (!supplier) {
					objHistory.setKeyword(bean.getCustomer());// 新增关键字-档口
					objHistory.setRegname(bean.getCusRegName());// 市场
					objHistory.setPhone(bean.getCusPhone());// 电话
					objHistory.setOpeUser(bean.getBusinessName());// 经营户
					objHistory.setKeyType((short) 1);// 销售
					objHistory.setHistoryCount(1);
					objHistoryService.insert(objHistory);
				}
			} finally {
				return jsonObject;
			}
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	
	
	/** 查询检测结果数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception */
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, BaseLedgerSaleModel model, Page page, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		page.setOrder("desc");
		try {
			//高级搜索时间范围，覆盖默认时间范围
			Map<String,String> dateMap = page.getDateMap();
			if(null != dateMap) {
				if(StringUtil.isNotEmpty(dateMap.get("saleDateStartDate"))) {
					model.setSaleDateStartDate(dateMap.get("saleDateStartDate"));
				}
				if(StringUtil.isNotEmpty(dateMap.get("salekDateEndDate"))) {
					model.setSaleDateEndDate(dateMap.get("salekDateEndDate")+" 23:59:59");
				}
			}
			TSDepart depart= (TSDepart) request.getSession().getAttribute("org");
			if(depart!=null){
			model.setDepartId(depart.getId()); 
			}
			page = saleService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(Integer id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(id)){
				BaseLedgerSale sale=saleService.queryById(id);
				if(sale!=null){
				jsonObject.setObj(sale);
				}
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询失败");
		}
		return jsonObject;
	}
	
	
	/**
	 * 删除数据，单条删除与批量删除通用方法
	 * @param request
	 * @param response
	 * @param ids 要删除的数据记录id集合
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request,HttpServletResponse response,String ids){
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			Integer[] idas = new Integer[ida.length];
			for (int i = 0; i < ida.length; i++) {
				idas[i] = Integer.parseInt(ida[i]);
			}
			saleService.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	
	/** 销售台账统计报表
	 * @param request
	 * @param response
	 * @param regId
	 * @return */
	@RequestMapping("/reportList")
	public ModelAndView report(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryByRegTypeCode("0");
		if (regulatoryType != null) {
			String regTypeId = regulatoryType.getId();
			map.put("regTypeId", regTypeId);
		}
		List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
		map.put("regulatoryTypes", regulatoryTypes);
		return new ModelAndView("/ledger/sale/reportList", map);
	}

	/**
	 */
	@RequestMapping(value = "loadRegReport")
	@ResponseBody
	public AjaxJson loadReg(HttpServletRequest request, HttpServletResponse response, HttpSession session, String type,
			String month, String season, String year, String start, String end, String regTypeId, Integer did) {
		TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		if (!StringUtils.isEmpty(end)) {
			end += " 23:59:59";
		}
		List<BaseLedgerSaleModel> model = null;
		try {
			if (null == did) {
				did=tsUser.getDepartId();
			}
			TSDepart depart=departService.getById(did);
			String departCode=depart.getDepartCode();
			BaseRegulatoryType bean=	baseRegulatoryTypeService.queryById(regTypeId);
			if(bean.getStockType()==null||bean.getStockType()==0){
			model = saleService.loadRegReport(departCode, regTypeId, type, month, season, year, start, end);
			}else if(bean.getStockType()==1){
				model = saleService.loadRegReport2(departCode, regTypeId, type, month, season, year, start, end);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("scstock", 1);
				jsonObj.setAttributes(map);
			}
			jsonObj.setObj(model);
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
		}
		
		return jsonObj;
	}
	
	
}
