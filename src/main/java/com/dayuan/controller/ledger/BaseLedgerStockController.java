package com.dayuan.controller.ledger;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.ledger.BaseLedgerHistory;
import com.dayuan.bean.ledger.BaseLedgerObjHistory;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.ledger.BaseLedgerStockModel;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.ledger.BaseLedgerHistoryService;
import com.dayuan.service.ledger.BaseLedgerObjHistoryService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.StringUtil;

/** 进货信息管理
 * @author cola_hu */
@Controller
@RequestMapping("/ledger/stock")
public class BaseLedgerStockController extends BaseController {
	private final Logger log = Logger.getLogger(BaseLedgerStockController.class);
	@Autowired
	private BaseLedgerStockService stockService;
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

	@Autowired
	private BaseRegulatoryBusinessService businessService;

	/** 进入经营户进货管理列表
	 * @param request
	 * @param response
	 * @param regId
	 * htmlType 页面进入类型 1.台账管理进入  3.台账数据列表进入
	 * winType: 窗口打开模式 1：ifream  2.网页链接
	 * @return */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,String ledgerType,String regTypeId, HttpServletResponse response, Integer regId, Integer businessId,String htmlType,String winType) {
		Map<String, Object> map = new HashMap<String, Object>();
		BaseRegulatoryObject regulatoryType;
		try {
			if(businessId!=null){
			BaseRegulatoryBusiness bus=businessService.queryById(businessId);
				map.put("bus", bus);//获取经营户名称
			}
			if(regId!=null){
				regulatoryType = baseRegulatoryObjectService.queryById(regId);//监管对象
				if(regulatoryType!=null){
					if(regulatoryType.getManagementType()==null){
						map.put("manaType", 0);//获取市场类型
					}else{
						map.put("manaType", regulatoryType.getManagementType());//获取市场类型
					}
				map.put("regName", regulatoryType.getRegName());
				}
			}
		map.put("businessId", businessId);
		map.put("regId", regId);
		map.put("ledgerType", ledgerType);
		map.put("regTypeId", regTypeId);
		map.put("htmlType", htmlType);
		map.put("winType", winType);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/ledger/stock/list", map);
	}

	/** 进入经营户进货编辑页面 添加多条数据
	 * @param request
	 * @param response
	 * @param regId
	 * @return 
	 * @throws MissSessionExceprtion */
	@RequestMapping("/editList")
	public ModelAndView editList(HttpServletRequest request, HttpServletResponse response, String id) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user = PublicUtil.getSessionUser();
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryByDepartId(user.getDepartId(), "1");
		map.put("regObj", regObj);
		return new ModelAndView("/ledger/stock/editList", map);
	}

	/** 单条台账查询 新增页面
	 * @param id 台账信息表id businessId 经营户id
	 * @param request
	 * @param response
	 * @return 
	 * winType: 窗口打开模式 1：ifream  2.网页链接
	 * @throws MissSessionExceprtion */
	
	@RequestMapping("/add")
	public ModelAndView add(Integer id, Integer regId, String businessId,String showType, String regTypeId,String htmlType,HttpServletRequest request,
			HttpServletResponse response,String winType) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user = PublicUtil.getSessionUser();
		try {
			if(regTypeId==null){
				BaseRegulatoryObject obj=baseRegulatoryObjectService.queryById(regId);
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
		if (null != id) {// 查询数据
				BaseLedgerStock bean = stockService.queryById(id);
				if (bean != null) {
					map.put("bean", bean);
				}
		
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
		bean.setRegType(regTypeId);
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryAllByDepartId(bean);
		map.put("regObj", regObj);
		map.put("htmlType", htmlType);
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
		}
		return new ModelAndView("/ledger/stock/add", map);
	}
	/** 单条台账查询 编辑页面
	 * @param id 台账信息表id businessId 经营户id
	 * @param request
	 * @param response
	 * @return 
	 * @throws MissSessionExceprtion */
	@RequestMapping("/edit")
	public ModelAndView edit(Integer id, Integer regId,String htmlType, String businessId,String showType, String regTypeId, HttpServletRequest request,
			HttpServletResponse response) throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user = PublicUtil.getSessionUser();
		if (null != id) {// 查询数据
			try {
				BaseLedgerStock bean = stockService.queryById(id);
				if (bean != null) {
					if(bean.getCheckProof_Img()!=null){//检验证明
						String CImg=bean.getCheckProof_Img();
						String[]	CImgList	=	CImg.split(",");
						map.put("CImgList", CImgList);
					}
					if(bean.getStockProof_Img()!=null){//进货凭证
						String SImg=bean.getStockProof_Img();
						String[]	SImgList	=	SImg.split(",");
						map.put("SImgList", SImgList);
					}
					if(bean.getQuarantineProof_Img()!=null){//检疫证明
						String QImg=bean.getQuarantineProof_Img();
						String[]	QImgList	=	QImg.split(",");
						map.put("QImgList", QImgList);
					}
					
					map.put("bean", bean);
					if(regTypeId==null){
						BaseRegulatoryObject  obj= baseRegulatoryObjectService.queryById(bean.getRegId());
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
				}
			} catch (Exception e) {
				log.error("**********************"+e.getMessage()+e.getStackTrace());
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
		if(regTypeId!=null){
			bean.setRegType(regTypeId);
		}
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryAllByDepartId(bean);
		map.put("regObj", regObj);
		map.put("htmlType", htmlType);
		return new ModelAndView("/ledger/stock/edit", map);
	}

	/** 这是同一供货商下同时创建多个台账信息
	 * @param mdoel
	 * @param details
	 * @param request
	 * @param response
	 * @return 
	 * @throws MissSessionExceprtion */
	@RequestMapping(value = "/saveList")
	@ResponseBody
	public AjaxJson saveList(BaseLedgerStockModel model, String details, HttpServletRequest request,
			HttpServletResponse response) throws MissSessionExceprtion {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		TSUser user = PublicUtil.getSessionUser();
		try {
			List<BaseLedgerStock> list = JSONArray.parseArray(details, BaseLedgerStock.class);
			for (BaseLedgerStock bean : list) {
				try {
					bean.setBusinessId(model.getBusinessId());
					bean.setSupplier(model.getSupplier());
					bean.setSupplierId(model.getSupplierId());
					bean.setSupplierTel(model.getSupplierTel());
					bean.setSupplierUser(model.getSupplierUser());
					bean.setCreate_by(user.getId());
					bean.setCreate_date(now);
					stockService.insertSelective(bean);
					jsonObject.setSuccess(true);
					jsonObject.setMsg("新增成功！");
				} catch (Exception e) {
					continue;
				}
			}
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	/**
	 * 
	 * @param bean
	 * @param stockCounts
	 * @param fileList
	 * @param request
	 * @param response
	 * 2019.4.18 需求变更：允许台账录入最多五张图片
	 * @return  
	 * @throws MissSessionExceprtion
	 */
	@SuppressWarnings("finally")
	@RequestMapping(value = "/save1")
	@ResponseBody
	public AjaxJson save1(BaseLedgerStock bean, String stockCounts, HttpServletRequest request, HttpServletResponse response) throws MissSessionExceprtion {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		TSUser user = PublicUtil.getSessionUser();
		String filePath = "stock/";
		String path = WebConstant.res.getString("resources") + filePath; 
		File file=new File(path);
		if(!file.exists()){
			DyFileUtil.createFolder(path);
		}
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
			
			String	StockProof_Img=null;//进货证明图片
			if(bean.getStockProof_Img()!=null){//如果是更新图片 则把原来的加上去
				StockProof_Img=bean.getStockProof_Img();
			}
			String	CheckProof_Img=null;//检验证明图片
			if(bean.getCheckProof_Img()!=null){
				CheckProof_Img=bean.getCheckProof_Img();
			}
			String	QuarantineProof_Img=null;//检疫证明图片
			if(bean.getQuarantineProof_Img()!=null){
				QuarantineProof_Img=bean.getQuarantineProof_Img();
			}
			
			for (Entry<String, MultipartFile> entity : fileMap.entrySet()) {
				String keyName=entity.getKey();
				if(keyName!=null){
					keyName=	keyName.substring(0, 4);//截取前4位标识
				}
				MultipartFile mf = entity.getValue(); // 获得原始文件名
				String  fileName = mf.getOriginalFilename();
				switch (keyName) {
				case "Img1"://进货凭证
					 MultipartFile Img1=entity.getValue();
					 if (null != Img1 && Img1.getSize() != 0) {// 进货证明图片
							String fileOldName = Img1.getOriginalFilename();
							String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
							fileName = UUID.randomUUID() + ext;
							uploadFile(request, filePath, Img1, fileName);
							 if(StockProof_Img==null){//不存在图片
								 StockProof_Img=	fileName;
							 }else{//存在
								 StockProof_Img+=","+fileName;
							 }
							
						}
					break;
				case "Img2"://检验证明
					MultipartFile Img2=entity.getValue();
					if (null != Img2 && Img2.getSize() != 0) {// 检验证明图片
						String fileOldName = Img2.getOriginalFilename();
						String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
						 fileName = UUID.randomUUID() + ext;
						 uploadFile(request, filePath, Img2, fileName);
						 if(CheckProof_Img==null){//不存在图片
							 CheckProof_Img=	fileName;
						 }else{//存在
							 CheckProof_Img+=","+fileName;
						 }
					}
					break;
				case "Img3"://检疫证明
					MultipartFile Img3=entity.getValue();
					if (null != Img3 && Img3.getSize() != 0) {// 检疫证明图片
						String fileOldName = Img3.getOriginalFilename();
						String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
						 fileName = UUID.randomUUID() + ext;
						uploadFile(request, filePath, Img3, fileName);
						if(QuarantineProof_Img==null){//不存在图片
							QuarantineProof_Img=	fileName;
						 }else{//存在
							 QuarantineProof_Img+=","+fileName;
						 }
					}
					break;
					
				default:
					break;
				}
				
			}
		
			//BaseLedgerStock ledgerStock=null;
			if(StringUtils.isNotEmpty(bean.getBatchNumber())){
				//	 ledgerStock = stockService.selectByBatchNumber(bean);// 查询批号是否重复
			}
			String foodName=bean.getFoodName();
			String[] foods=foodName.split(",");
			if (bean.getId() == null) {// 新增
				
				String size=bean.getSize();
				
				String[] sizes=size.split(",");
				String[] counts=stockCounts.split(",");
				for (int i = 0; i < foods.length; i++) {
					String food = foods[i];
					bean.setFoodName(food);
					bean.setSize(sizes[i]);
					bean.setStockCount(BigDecimal.valueOf(Double.parseDouble(counts[i])));
					bean.setStockProof_Img(StockProof_Img);
					bean.setQuarantineProof_Img(QuarantineProof_Img);
					bean.setCheckProof_Img(CheckProof_Img);
					bean.setCreate_by(user.getId());
					bean.setCreate_date(now);
					bean.setUpdate_by(user.getId());
					bean.setUpdate_date(now);
					stockService.insertSelective(bean);
				}
				/*if (ledgerStock != null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("新增失败,批号不能重复！");
					return jsonObject;
				}*/
				
				jsonObject.setSuccess(true);
				jsonObject.setMsg("新增进货台账成功！");
			} else {// 更新
				BaseLedgerStock stock = stockService.queryById(bean.getId());
				if (stock == null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("更新失败,请重试！");
				} else {
					/*if (ledgerStock != null && ledgerStock.getId() != stock.getId()) {
						jsonObject.setSuccess(false);
						jsonObject.setMsg("更新失败,批号不能重复！");
						return jsonObject;
					}*/
					bean.setStockProof_Img(StockProof_Img);
					bean.setQuarantineProof_Img(QuarantineProof_Img);
					bean.setCheckProof_Img(CheckProof_Img);
					bean.setUpdate_by(user.getId());
					bean.setUpdate_date(now);
					stockService.updateBySelective(bean);
					jsonObject.setSuccess(true);
					jsonObject.setMsg("更新进货台账成功！");
				}
			}
			
			try {// 这是将输入记录存在数据库中
				BaseLedgerHistory history = new BaseLedgerHistory();
				if(bean.getBusinessId()==null){//市场录入
					history.setType((short)1);
					history.setUserId(bean.getRegId());
				}else{
					history.setType((short)0);
					history.setUserId(bean.getBusinessId());
				}
				history.setKeyword(bean.getFoodName());
				history.setUserType((short) 1);
				history.setKeyType((short)2);//
				// 样品记录
				for (int i = 0; i < foods.length; i++) {
					history.setKeyword(foods[i]);
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
						history.setKeyword(foods[i]);
						history.setKeyType((short) 2);
						history.setHistoryCount(1);
						historyService.insert(history);
						
					}
					
				}
			 
				// 市场经营户记录
				/*if (StringUtils.isNotEmpty(bean.getSupplier())) {
					BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
					if(bean.getBusinessId()==null){//市场录入
						objHistory.setType((short)1);
						objHistory.setUserId(bean.getRegId());
					}else{
						objHistory.setType((short)0);
						objHistory.setUserId(bean.getBusinessId());
					}
					objHistory.setKeyType((short) 0);//进货
					objHistory.setUserType((short) 1);
					List<BaseLedgerObjHistory> objlist = objHistoryService.selectHistoryData(objHistory);
					if(objlist.size()>0){
						if(objlist.get(0).getHistoryCount()==null){
							objlist.get(0).setHistoryCount(1);//加你
						}else{
							objlist.get(0).setHistoryCount(objlist.get(0).getHistoryCount()+1);//加你
						}
						objlist.get(0).setPhone(bean.getSupplierTel());// 电话
						objlist.get(0).setOpeUser(bean.getSupplierUser());// 经营户
						objHistoryService.updateBySelective(objlist.get(0));
					}else{
							objHistory.setCreateDate(now);
							objHistory.setDeleteFlag((short) 0);
							objHistory.setKeyword(bean.getSupplier());// 新增关键字-档口
							objHistory.setRegname(bean.getParam1());// 市场
							objHistory.setPhone(bean.getSupplierTel());// 电话
							objHistory.setOpeUser(bean.getSupplierUser());// 经营户
							objHistory.setHistoryCount(1);
							objHistoryService.insert(objHistory);
					}
				 
				
				}*/
				// 市场经营户记录
				if (StringUtils.isNotEmpty(bean.getSupplier())) {
					BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
					if(bean.getBusinessId()==null){//市场录入
						objHistory.setType((short)1);
						objHistory.setUserId(bean.getRegId());
					}else{
						objHistory.setType((short)0);
						objHistory.setUserId(bean.getBusinessId());
					}
					objHistory.setKeyType((short) 0);//进货
					objHistory.setUserType((short) 1);
					Boolean supplier = false;
					List<BaseLedgerObjHistory> objlist = objHistoryService.selectHistoryData(objHistory);
					for (BaseLedgerObjHistory baseLedgerObjHistory : objlist) {
						//short keytype = baseLedgerObjHistory.getKeyType();
						// keytype=1 进货台账 2销售
						if (baseLedgerObjHistory.getKeyword().equals(bean.getSupplier()) && baseLedgerObjHistory.getRegname().equals(bean.getParam1()) && baseLedgerObjHistory.getKeyType() == 0) {
							if(baseLedgerObjHistory.getHistoryCount()==null){
								baseLedgerObjHistory.setHistoryCount(1);
							}else{
								baseLedgerObjHistory.setHistoryCount(baseLedgerObjHistory.getHistoryCount()+1);	
							}
							baseLedgerObjHistory.setPhone(bean.getSupplierTel());// 电话
							baseLedgerObjHistory.setOpeUser(bean.getSupplierUser());// 经营户
							objHistoryService.updateBySelective(baseLedgerObjHistory);
							supplier = true;
							break;
						}
					}
					objHistory.setCreateDate(now);
					objHistory.setDeleteFlag((short) 0);
					if (!supplier) {
						objHistory.setKeyword(bean.getSupplier());// 新增关键字-档口
						objHistory.setRegname(bean.getParam1());// 市场
						objHistory.setPhone(bean.getSupplierTel());// 电话
						objHistory.setOpeUser(bean.getSupplierUser());// 经营户
						objHistory.setKeyType((short) 0);// 进货台账
						objHistory.setHistoryCount(1);
						objHistoryService.insert(objHistory);
					}
				}
			}catch(Exception e){
				log.error("*************************" + e.getMessage() + e.getStackTrace());
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
	@SuppressWarnings("finally")
	@RequestMapping(value = "/save")
	@ResponseBody
	public AjaxJson save(BaseLedgerStock bean, String stockCounts,@RequestParam(value = "Img1", required = false) MultipartFile Img1,
			@RequestParam(value = "Img2", required = false) MultipartFile Img2, String details,
			@RequestParam(value = "Img3", required = false) MultipartFile Img3, @RequestParam(value = "fileList", required = false) List<MultipartFile> fileList,HttpServletRequest request,
			HttpServletResponse response) throws MissSessionExceprtion {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		TSUser user = PublicUtil.getSessionUser();
		String filePath = "stock/";
		String path = WebConstant.res.getString("resources") + filePath; 
		File file=new File(path);
		if(!file.exists()){
			DyFileUtil.createFolder(path);
		}
		try {
			if (null != Img1 && Img1.getSize() != 0) {// 进货证明图片
				String fileOldName = Img1.getOriginalFilename();
				String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
				String fileName = UUID.randomUUID() + ext;
				bean.setStockProof_Img(fileName);
				uploadFile(request, filePath, Img1, fileName);
			}
			if (null != Img2 && Img2.getSize() != 0) {// 检验证明图片
				String fileOldName = Img2.getOriginalFilename();
				String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
				String fileName = UUID.randomUUID() + ext;
				bean.setCheckProof_Img(fileName);
				uploadFile(request, filePath, Img2, fileName);
			}
			if (null != Img3 && Img3.getSize() != 0) {// 检疫证明图片
				String fileOldName = Img3.getOriginalFilename();
				String ext = fileOldName.substring(fileOldName.lastIndexOf("."));
				String fileName = UUID.randomUUID() + ext;
				bean.setQuarantineProof_Img(fileName);
				uploadFile(request, filePath, Img3, fileName);
			}
			//BaseLedgerStock ledgerStock=null;
			if(StringUtils.isNotEmpty(bean.getBatchNumber())){
		//	 ledgerStock = stockService.selectByBatchNumber(bean);// 查询批号是否重复
			}
			String foodName=bean.getFoodName();
			if (bean.getId() == null) {// 新增
			
				String size=bean.getSize();
				String[] foods=foodName.split(",");
				String[] sizes=size.split(",");
				String[] counts=stockCounts.split(",");
				for (int i = 0; i < foods.length; i++) {
					String food = foods[i];
					bean.setFoodName(food);
					bean.setSize(sizes[i]);
					bean.setStockCount(BigDecimal.valueOf(Double.parseDouble(counts[i])));
					bean.setCreate_by(user.getId());
					bean.setCreate_date(now);
					bean.setUpdate_by(user.getId());
					bean.setUpdate_date(now);
					stockService.insertSelective(bean);
				}
				/*if (ledgerStock != null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("新增失败,批号不能重复！");
					return jsonObject;
				}*/
			
				jsonObject.setSuccess(true);
				jsonObject.setMsg("新增进货台账成功！");
			} else {// 更新
				BaseLedgerStock stock = stockService.queryById(bean.getId());
				if (stock == null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("更新失败,请重试！");
				} else {
					/*if (ledgerStock != null && ledgerStock.getId() != stock.getId()) {
						jsonObject.setSuccess(false);
						jsonObject.setMsg("更新失败,批号不能重复！");
						return jsonObject;
					}*/
					bean.setUpdate_by(user.getId());
					bean.setUpdate_date(now);
					stockService.updateBySelective(bean);
					jsonObject.setSuccess(true);
					jsonObject.setMsg("更新进货台账成功！");
				}
			}

			try {// 这是将输入记录存在数据库中
				BaseLedgerHistory history = new BaseLedgerHistory();
				history.setUserId(bean.getBusinessId());
				history.setUserType((short) 1);
				// 样品记录
				List<BaseLedgerHistory> list = historyService.selectHistoryData(history);
				Boolean foodName1 = false;
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
						foodName1 = true;
					}
				}
				history.setCreateDate(now);
				history.setDeleteFlag((short) 0);
				if (!foodName1) {
					String[] foods=foodName.split(",");
					for (int i = 0; i < foods.length; i++) {
						history.setKeyword(foods[i]);
						history.setKeyType((short) 2);
						history.setHistoryCount(1);
						historyService.insert(history);
					}
				}
				// 市场经营户记录
				if (StringUtils.isNotEmpty(bean.getSupplier())) {
					BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
					objHistory.setUserId(bean.getBusinessId());
					objHistory.setKeyType((short) 0);//进货
					objHistory.setUserType((short) 1);
					Boolean supplier = false;
					List<BaseLedgerObjHistory> objlist = objHistoryService.selectHistoryData(objHistory);
					for (BaseLedgerObjHistory baseLedgerObjHistory : objlist) {
						//short keytype = baseLedgerObjHistory.getKeyType();
						// keytype=1 进货台账 2销售
						if (baseLedgerObjHistory.getKeyword().equals(bean.getSupplier()) && baseLedgerObjHistory.getRegname().equals(bean.getParam1()) && baseLedgerObjHistory.getKeyType() == 0) {
							if(baseLedgerObjHistory.getHistoryCount()==null){
							baseLedgerObjHistory.setHistoryCount(1);
							}else{
								baseLedgerObjHistory.setHistoryCount(baseLedgerObjHistory.getHistoryCount()+1);	
							}
							baseLedgerObjHistory.setPhone(bean.getSupplierTel());// 电话
							baseLedgerObjHistory.setOpeUser(bean.getSupplierUser());// 经营户
							objHistoryService.updateBySelective(baseLedgerObjHistory);
							supplier = true;
							break;
						}
					}
					objHistory.setCreateDate(now);
					objHistory.setDeleteFlag((short) 0);
					if (!supplier) {
						objHistory.setKeyword(bean.getSupplier());// 新增关键字-档口
						objHistory.setRegname(bean.getParam1());// 市场
						objHistory.setPhone(bean.getSupplierTel());// 电话
						objHistory.setOpeUser(bean.getSupplierUser());// 经营户
						objHistory.setKeyType((short) 0);// 进货台账
						objHistory.setHistoryCount(1);
						objHistoryService.insert(objHistory);
					}
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

	/** 获取进货信息详情
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception */
	@RequestMapping(value = "/getStock")
	@ResponseBody
	public AjaxJson getDev(HttpServletRequest request, String pointId, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		return jsonObj;
	}

	/** 查询检测结果数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception */
	@RequestMapping(value = "/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, BaseLedgerStockModel model, Page page, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		page.setOrder("desc");
		try {
			//高级搜索时间范围，覆盖默认时间范围
			Map<String,String> dateMap = page.getDateMap();
			if(null != dateMap) {
				if(StringUtil.isNotEmpty(dateMap.get("stockDateStartDate"))) {
					model.setStockDateStartDate(dateMap.get("stockDateStartDate"));
				}
				if(StringUtil.isNotEmpty(dateMap.get("stockDateEndDate"))) {
					model.setStockDateEndDate(dateMap.get("stockDateEndDate")+" 23:59:59");
				}
			}
			TSUser user;
			user = PublicUtil.getSessionUser();
			if(user.getRegId()!=null){//判断用户是否为市场用户 不为空则是市场用户
				model.setReg_id(user.getRegId().toString());
				model.setRegId(user.getRegId());
			}
			TSDepart depart= (TSDepart) request.getSession().getAttribute("org");
			if(depart!=null){
			model.setDepartId(depart.getId()); 
			}
			page = stockService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/** 删除文件，可以是文件或文件夹
	 *
	 * @param fileName 要删除的文件名
	 * @return 删除成功返回true，否则返回false */
	public static boolean delete(String fileName) {
		File file = new File(fileName);
		if (!file.exists()) {
			System.out.println("删除文件失败:" + fileName + "不存在！");
			return false;
		} else {
			if (file.isFile())
				return deleteFile(fileName);
		}
		return false;
	}

	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		// 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
		if (file.exists() && file.isFile()) {
            return file.delete();
		} else {
			return false;
		}
	}

	/** 台账统计报表
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
		return new ModelAndView("/ledger/stock/reportList", map);
	}

	/**
	 */
	@RequestMapping(value = "loadRegReport")
	@ResponseBody
	public AjaxJson loadRegReport(HttpServletRequest request, HttpServletResponse response, HttpSession session, String type,
			String month, String season, String year, String start, String end, String regTypeId, Integer did) {
		TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
		AjaxJson jsonObj = new AjaxJson();
		if (!StringUtils.isEmpty(end)) {
			end += " 23:59:59";
		}
		List<BaseLedgerStockModel> model = null;
		try {
			if (null == did) {
				did=tsUser.getDepartId();
			}
			TSDepart depart=departService.getById(did);
			String departCode=depart.getDepartCode();
			BaseRegulatoryType bean=	baseRegulatoryTypeService.queryById(regTypeId);
			if(bean.getStockType()==null||bean.getStockType()==0){
				model = stockService.loadRegReport(departCode, regTypeId, type, month, season, year, start, end);
			}else if(bean.getStockType()==1){
				model = stockService.loadRegReport2(departCode, regTypeId, type, month, season, year, start, end);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("scstock", 1);
				jsonObj.setAttributes(map);
			}
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+e.getStackTrace());
		}
		jsonObj.setObj(model);
		return jsonObj;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			Integer[] idas = new Integer[ida.length];
			for (int i = 0; i < ida.length; i++) {
				idas[i] = Integer.parseInt(ida[i]);
			}
			stockService.delete(idas);
		} catch (Exception e) {
			log.error("**************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/** 台账管理列表 全部台账
	 * @param request
	 * @param response
	 * @param regId
	 * @return */
	@RequestMapping("/ledgerList")
	public ModelAndView ledgerList(HttpServletRequest request,String ledgerType,String regName,String regTypeId, Integer regId,HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
		if(StringUtils.isNotEmpty(regName)){
		map.put(regName, regName);
		}

            Integer regId1=regId;
		TSUser user;

			user = PublicUtil.getSessionUser();
			if(user.getRegId()!=null){//判断用户是否为市场用户 不为空则是市场用户
				regId=user.getRegId();
			}
			BaseRegulatoryType type;
			try {
				List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
				map.put("regulatoryTypes", regulatoryTypes);
				if(regTypeId==null&&regId==null){
					regTypeId=regulatoryTypes.get(0).getId();
				}else if(regId!=null){
					 BaseRegulatoryObject	 obj=baseRegulatoryObjectService.queryById(regId);
					 if(obj!=null){
						 regTypeId=obj.getRegType();
					 }
				}
				type = baseRegulatoryTypeService.queryById(regTypeId);
				if(type.getStockType()==null){
					map.put("showReg", 0);
				}else if(type.getStockType().equals((short)1)){//针对市场录入台账
					map.put("showReg", 1);
				}else{
					map.put("showReg", 0);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(user.getRegId()==null){//判断用户是否为市场用户 不为空则是市场用户
				map.put("regId", regId);
			}else{
				map.put("regId", regId1);
			}
			map.put("ledgerType", ledgerType);
			map.put("regTypeId", regTypeId);
		BaseRegulatoryObject bean=new BaseRegulatoryObject();
		bean.setDepartId(user.getDepartId());
		if(user.getRegId()!=null){
		bean.setId(user.getRegId());
		}
		bean.setRegType(regTypeId);
		List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryAllByDepartId(bean);
		map.put("regObj", regObj);
		} catch (MissSessionExceprtion e1) {
			e1.printStackTrace();
		}
		return new ModelAndView("/ledger/stock/ledgerList", map);
	}
	
	/** 获取全部监管对象
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping("/queryAllObj")
	@ResponseBody
	public AjaxJson queryAllObj(String regTypeId, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser	user = PublicUtil.getSessionUser();
			Integer departId = user.getDepartId();
				BaseRegulatoryObject bean=new BaseRegulatoryObject();
				bean.setDepartId(departId);
				bean.setRegType(regTypeId);
			List<BaseRegulatoryObject>	 objList = baseRegulatoryObjectService.queryAllByDepartId(bean);
			jsonObj.setObj(objList);
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	@RequestMapping("/upload")
	public void uploadInformation(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("收到图片!");
        MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
        String upaloadUrl =  "D:/upload/";// 得到当前工程路径拼接上文件名
        File dir = new File(upaloadUrl);
        if (!dir.exists())// 目录不存在则创建
            dir.mkdirs();
        int counter = 0;
        for (MultipartFile file : files.values()) {
            counter++;
            String fileName = file.getOriginalFilename();
            File tagetFile = new File(upaloadUrl + fileName);// 创建文件对象
            if (!tagetFile.exists()) {// 文件名不存在 则新建文件，并将文件复制到新建文件中
                try {
                    tagetFile.createNewFile();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                try {
                    file.transferTo(tagetFile);
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
        System.out.println("接收完毕");
    }
}
