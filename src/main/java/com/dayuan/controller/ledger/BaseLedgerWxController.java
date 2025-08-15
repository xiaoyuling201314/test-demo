package com.dayuan.controller.ledger;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.view.RedirectView;

import com.alibaba.fastjson.JSONArray;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.bean.ledger.BaseLedgerHistory;
import com.dayuan.bean.ledger.BaseLedgerObjHistory;
import com.dayuan.bean.ledger.BaseLedgerSale;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.ledger.BaseLedgerUser;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.controller.wx.WxController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.ledger.BaseLedgerSaleModel;
import com.dayuan.model.ledger.BaseLedgerStockModel;
import com.dayuan.model.ledger.BaseLedgerUserModel;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.ledger.BaseLedgerHistoryService;
import com.dayuan.service.ledger.BaseLedgerObjHistoryService;
import com.dayuan.service.ledger.BaseLedgerSaleService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.service.ledger.BaseLedgerUserService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.wx.WeixinUtil;
import net.sf.json.JSONObject;

/** 微信台账管理
 * @author cola_hu */
@Controller
@RequestMapping("/ledger/wx")
public class BaseLedgerWxController extends BaseController {

	private final Logger log = Logger.getLogger(WxController.class);
	  private static final String appId=	  WebConstant.res.getString("appId");
	  private static final String secret = WebConstant.res.getString("secret");
	  private static final String redirectUri = WebConstant.res.getString("redirectUri");
	  public final static String mainUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+redirectUri +"ledger%2fwx%2flogin.do&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	  
	  
	public final static String code_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code ";
	public final static String refresh_token_url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=APPID&refresh_token=Refresh_token";
	
	@Autowired
	private BaseLedgerUserService ledgerUserService;
	@Autowired
	private BaseLedgerStockService stockService;
	@Autowired
	private BaseLedgerSaleService saleService;
	@Autowired
	private BaseFoodTypeService baseFoodTypeService;
	@Autowired
	private BaseLedgerHistoryService historyService;
	@Autowired
	private BaseLedgerObjHistoryService objHistoryService;
	@Autowired
	private BaseRegulatoryTypeService baseRegulatoryTypeService;
	@Autowired
	private BaseRegulatoryObjectService objectService;
	@Autowired
	private BaseRegulatoryBusinessService businessService;
	public static String foodListPath = WebConstant.res.getString("resources") + "/json/";

	/** 微信用户进入签到页面
	 * @param request
	 * @param response
	 * @author cola_hu
	 * @throws Exception */
	@RequestMapping("login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, String openid) throws Exception {
		// start 获取网页授权
		Map<String, Object> mapData = new HashMap<>();
		JSONObject jsonObject = null;
		if (StringUtils.isEmpty(openid)) {
			openid = (String) request.getSession().getAttribute("openid");
		}
		System.out.println("项目openid:"+openid);
		if (StringUtils.isEmpty(openid)) {
			String code = request.getParameter("code");// 用来获取网页授权
			if (code != null) {
				String requestUrl = code_url.replace("CODE", code).replace("APPID", appId).replace("APPSECRET", secret);
				jsonObject = WeixinUtil.httpRequest(requestUrl, "GET", null);
			}
			if (null != jsonObject) {
				System.out.println(jsonObject);
				try {
					if (jsonObject.getString("access_token") == null) {// 获取用户信息失败
						return new ModelAndView("/ledger/wx/login", mapData);
					} else {
						openid = jsonObject.getString("openid");
						mapData.put("openid", openid);
						request.getSession().setAttribute("openid", openid);
						if (openid != null) {
							request.getSession().setAttribute("openid", openid);
							BaseLedgerUser ledgerUser = ledgerUserService.selectByOpenid(openid);
							if (ledgerUser != null) {// 用户已绑定
								mapData.put("id", ledgerUser.getId());
								if (ledgerUser.getStatus() == 1) {// 说明是经营户已绑定且允许登录
									request.getSession().setAttribute("ledgerUser", ledgerUser);
									return new ModelAndView("/ledger/wx/main", mapData);
								}
							} else {// 用户未绑定
								return new ModelAndView("/ledger/wx/login", mapData);
							}
						}
					}
				} catch (Exception e) {
					System.out.println(e.getMessage());
					return new ModelAndView("/ledger/wx/login", mapData);
				}
			}
		} else {// 页面跳转
			mapData.put("openid", openid);
			BaseLedgerUser ledgerUser = ledgerUserService.selectByOpenid(openid);
			if (ledgerUser != null) {// 用户已绑定
				mapData.put("id", ledgerUser.getId());
				if (ledgerUser.getStatus() == 1) {// 说明是经营户已绑定且允许登录
					request.getSession().setAttribute("ledgerUser", ledgerUser);
					return new ModelAndView("/ledger/wx/main", mapData);
				}
			}
		}
		return new ModelAndView("/ledger/wx/login", mapData);
	}

	/** 用户绑定微信
	 * @param bean
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping(value = "/tologin")
	@ResponseBody
	public AjaxJson tologin(BaseLedgerUser bean, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			String openid = bean.getOpenid();
			String username = bean.getUsername();
			String password = bean.getPwd();
			if (StringUtils.isEmpty(openid)) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("获取信息失败，请进入公众号重试!");
				return jsonObject;
			}
			if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("账号或密码不能为空，请重试!");
				return jsonObject;
			}
			/*
			 * CipherUtil cipher = new CipherUtil(); String pwd =
			 * cipher.generatePassword(password); // 加密算法 TSUser user = new
			 * TSUser(); user.setUserName(userName); user.setPassword(pwd);
			 */
			BaseLedgerUserModel model = new BaseLedgerUserModel();
			model.setUsername(username);
			model.setPwd(password);
			BaseLedgerUser ledgerUser = ledgerUserService.selectByUsernameOrPwd(model);
			if (ledgerUser == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("账号或密码不正确，请重试!");
				return jsonObject;
			}
			if (ledgerUser.getStatus() != 1) {// 0停用1启用
				jsonObject.setSuccess(false);
				jsonObject.setMsg("账号没有权限登录，请联系管理员!");
				return jsonObject;
			}

			if (StringUtils.isNotEmpty(ledgerUser.getOpenid())) {// 该用户已被绑定
				if (!ledgerUser.getOpenid().equals(openid)) {// 被绑定的不是该openid
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该账号已被其他用户绑定!");
					return jsonObject;
				} else {
					jsonObject.setSuccess(true);
					jsonObject.setMsg("登录成功");
					request.getSession().setAttribute("ledgerUser", ledgerUser);
					return jsonObject;
				}
			} else if (StringUtils.isEmpty(ledgerUser.getOpenid())) {// 用户没有被绑定
				BaseLedgerUser wxopenid = ledgerUserService.selectByOpenid(openid);
				if (wxopenid != null) {// 微信已绑定账号
					jsonObject.setSuccess(true);
					jsonObject.setMsg("登录成功");
					request.getSession().setAttribute("ledgerUser", ledgerUser);
					return jsonObject;
				}
				Date now = new Date();
				ledgerUser.setOpenid(bean.getOpenid());
				ledgerUser.setCreateDate(now);
				ledgerUser.setUpdateDate(now);
				ledgerUserService.updateBySelective(ledgerUser);
				request.getSession().setAttribute("ledgerUser", ledgerUser);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("绑定成功");
			}
		} catch (Exception e) {
			log.error("*************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}

	/** 经营户登录到微信端首页
	 * @param request
	 * @param response
	 * @param openid
	 * @return
	 * @throws Exception */
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response,String listType, String openid) throws Exception {
		Map<String, Object> mapData = new HashMap<>();
		try {
			openid = (String) request.getSession().getAttribute("openid");
			BaseLedgerUser	ledgerUser = ledgerUserService.selectByOpenid(openid);
			request.getSession().setAttribute("ledgerUser", ledgerUser);
			if (ledgerUser != null&&ledgerUser.getStatus()==1) {
				mapData.put("ledgerUser", ledgerUser);
				mapData.put("listType", listType);
				return new ModelAndView("/ledger/wx/main", mapData);
			}
		} catch (Exception e) {
			return new ModelAndView(new RedirectView(mainUrl));
		}
		return new ModelAndView(new RedirectView(mainUrl));
	}

	/** 进货台账编辑页面
	 * @param request
	 * @param response
	 * @param openid
	 * @return
	 * @throws Exception */
	@RequestMapping("/editStock")
	public ModelAndView editStock(HttpServletRequest request, HttpServletResponse response, Integer id, String openid)
			throws Exception {
		Map<String, Object> mapData = new HashMap<>();
		try {
			BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
			if (ledgerUser != null) {
				mapData.put("ledgerUser", ledgerUser);
				if(ledgerUser.getType()==1){//市场方用户 
					BaseRegulatoryType	 objType=		baseRegulatoryTypeService.queryByRegId(ledgerUser.getRegId());
					if(objType!=null&&objType.getStockType()==0){//针对经营户录入台账
						List<BaseRegulatoryBusiness>	businessList=		businessService.queryByRegid(ledgerUser.getRegId(), null);
						mapData.put("businessList", businessList);
						}
					mapData.put("stockType", objType.getStockType());
				}
			}else{//获取用户失效
				return new ModelAndView(new RedirectView(mainUrl));
			}
			
			if (id != null) {
				BaseLedgerStock ledgerStock = stockService.queryById(id);
				if (ledgerStock!=null) {
					if(ledgerStock.getCheckProof_Img()!=null){//检验证明
						String CImg=ledgerStock.getCheckProof_Img();
						String[]	CImgList	=	CImg.split(",");
						mapData.put("CImgList", CImgList);
					}
					if(ledgerStock.getStockProof_Img()!=null){//进货凭证
						String SImg=ledgerStock.getStockProof_Img();
						String[]	SImgList	=	SImg.split(",");
						mapData.put("SImgList", SImgList);
					}
					if(ledgerStock.getQuarantineProof_Img()!=null){//检疫证明
						String QImg=ledgerStock.getQuarantineProof_Img();
						String[]	QImgList	=	QImg.split(",");
						mapData.put("QImgList", QImgList);
					}
				mapData.put("ledgerStock", ledgerStock);
				}
			}
		} catch (Exception e) {
			return new ModelAndView(new RedirectView(mainUrl));
		}
		return new ModelAndView("/ledger/wx/editStock", mapData);
	}

	/** 销售台账编辑页面
	 * @param request
	 * @param response
	 * @param openid
	 * @return
	 * @throws Exception */
	@RequestMapping("/editSale")
	public ModelAndView editSale(HttpServletRequest request, HttpServletResponse response, Integer id, String openid)
			throws Exception {
		Map<String, Object> mapData = new HashMap<>();
		try {
			BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
			if (ledgerUser != null) {
				mapData.put("ledgerUser", ledgerUser);
				if(ledgerUser.getType()==1){//市场方用户 
					BaseRegulatoryType	 objType=		baseRegulatoryTypeService.queryByRegId(ledgerUser.getRegId());
					if(objType!=null&&objType.getStockType()==0){//针对经营户录入台账
						List<BaseRegulatoryBusiness>	businessList=		businessService.queryByRegid(ledgerUser.getRegId(), null);
						mapData.put("businessList", businessList);
						}
					mapData.put("stockType", objType.getStockType());
				}
			}else{//获取用户失效
				return new ModelAndView(new RedirectView(mainUrl));
			}
			if (id != null) {
				BaseLedgerSale ledgerSale = saleService.queryById(id);
				mapData.put("ledgerSale", ledgerSale);
			}
			
		} catch (Exception e) {
			return new ModelAndView(new RedirectView(mainUrl));
		}
		return new ModelAndView("/ledger/wx/editSale", mapData);
	}

	@RequestMapping("/userCenter")
	public ModelAndView userCenter(HttpServletRequest request, HttpServletResponse response, String openid) throws Exception {
		Map<String, Object> mapData = new HashMap<>();
		try {
			BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
			if (ledgerUser != null) {
				mapData.put("ledgerUser", ledgerUser);
			}else{//获取用户失效
				return new ModelAndView(new RedirectView(mainUrl));
			}
		} catch (Exception e) {
			return new ModelAndView(new RedirectView(mainUrl));
		}
		return new ModelAndView("/ledger/wx/userCenter", mapData);
	}

	@SuppressWarnings({ "finally" })
	@RequestMapping(value = "/saveStock")
	@ResponseBody
	public AjaxJson saveStock(BaseLedgerStock bean, String details, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		/*if(StringUtils.isEmpty(bean.getFoodName())){//样品名称为空
			jsonObject.setSuccess(false);
			jsonObject.setMsg("样品名称不能为空！");
			return jsonObject;
		}*/
		//BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
		String filePath = "stock/";
		String path = WebConstant.res.getString("resources") + filePath;
		File file = new File(path);
		if (!file.exists()) {
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
			//BaseLedgerStock ledgerStock = null;
			if (StringUtils.isNotEmpty(bean.getBatchNumber())) {
				//ledgerStock = stockService.selectByBatchNumber(bean);// 查询批号是否重复
			}
			if (bean.getId() == null) {// 新增
				/*if (ledgerStock != null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("新增失败,批号不能重复！");
					return jsonObject;
				}*/
				//bean.setCreate_by(ledgerUser.getId().toString());
				bean.setCreate_date(now);
				bean.setStockProof_Img(StockProof_Img);
				bean.setQuarantineProof_Img(QuarantineProof_Img);
				bean.setCheckProof_Img(CheckProof_Img);
				stockService.insertSelective(bean);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("新增成功！");
			} else {// 更新
				BaseLedgerStock stock = stockService.queryById(bean.getId());
				if (stock == null) {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("更新失败,请重试！");
				} else {
					bean.setStockProof_Img(StockProof_Img);
					bean.setQuarantineProof_Img(QuarantineProof_Img);
					bean.setCheckProof_Img(CheckProof_Img);
					bean.setUpdate_date(now);
					stockService.updateBySelective(bean);
					jsonObject.setSuccess(true);
					jsonObject.setMsg("更新成功！");
				}
			}

			try {// 这是将输入记录存在数据库中
				BaseLedgerHistory history = new BaseLedgerHistory();
				BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
				if(ledgerUser!=null){
					history.setType(ledgerUser.getType());
				}
				if(bean.getBusinessId()!=null){
					history.setType((short)0);//经营户录入
					history.setUserId(bean.getBusinessId());
				}else{
					history.setUserId(bean.getRegId());
				}
				history.setKeyword(bean.getFoodName());
				history.setUserType((short) 1);
				history.setKeyType((short)2);//
				// 样品记录
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
						history.setKeyType((short) 2);
						history.setHistoryCount(1);
						historyService.insert(history);
					
				}
				// 市场经营户记录
				if (StringUtils.isNotEmpty(bean.getSupplier())) {
					BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
					if(ledgerUser!=null){
						objHistory.setType(ledgerUser.getType());
					}
					if(bean.getBusinessId()!=null){
						objHistory.setUserId(bean.getBusinessId());
					}else{
						objHistory.setUserId(bean.getRegId());
					}
					objHistory.setKeyType((short) 0);//进货
					objHistory.setUserType((short) 1);
					Boolean supplier = false;
					List<BaseLedgerObjHistory> objlist = objHistoryService.selectHistoryData(objHistory);
					for (BaseLedgerObjHistory baseLedgerObjHistory : objlist) {
						//short keytype = baseLedgerObjHistory.getKeyType();
						// keytype=1 进货台账 2销售
						if (baseLedgerObjHistory.getKeyword().equals(bean.getSupplier())&& baseLedgerObjHistory.getRegname().equals(bean.getParam1()) && baseLedgerObjHistory.getKeyType() == 1) {
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

	@RequestMapping(value = "/getStockData")
	@ResponseBody
	public AjaxJson getStockData(HttpServletRequest request, BaseLedgerStockModel model, Page page,
			HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		page.setOrder("desc");
		try {
			if (model.getBusinessId() == null&&model.getRegId()==null) {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("获取用户信息失败!");
			} else {
				page = stockService.loadDatagrid(page, model);
				jsonObj.setObj(page);
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	@SuppressWarnings("finally")
	@RequestMapping(value = "/saveSale")
	@ResponseBody
	public AjaxJson saveSale(BaseLedgerSale bean, HttpServletRequest request, HttpServletResponse response)
			throws MissSessionExceprtion {
		AjaxJson jsonObject = new AjaxJson();
		Date now = new Date();
		BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
		if (ledgerUser.getType()==0&&null == bean.getBusinessId()) {
			jsonObject.setSuccess(false);
			jsonObject.setMsg("获取经营户信息失败，请重试！");
			return jsonObject;
		}
		try {
			if (bean.getId() == null) {// 新增
				bean.setCreate_by(ledgerUser.getId().toString());
				bean.setCreate_date(now);
				bean.setDelete_flag((short) 0);
				saleService.insertSelective(bean);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("新增成功！");
			} else {// 更新
				bean.setUpdate_by(ledgerUser.getId().toString());
				bean.setUpdate_date(now);
				saleService.updateBySelective(bean);
				jsonObject.setSuccess(true);
				jsonObject.setMsg("更新成功！");
			}

			try {// 这是将输入记录存在数据库中
				BaseLedgerHistory history = new BaseLedgerHistory();
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
				}
				// 市场经营户记录
				BaseLedgerObjHistory objHistory = new BaseLedgerObjHistory();
				objHistory.setUserId(bean.getBusinessId());
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
					objHistory.setKeyType((short) 1);// 进货台账
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

	/** 获取销售台账数据
	 * @param request
	 * @param model
	 * @param page
	 * @param response
	 * @return */
	@RequestMapping(value = "/getSaleData")
	@ResponseBody
	public AjaxJson getSaleData(HttpServletRequest request, BaseLedgerSaleModel model, Page page, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		page.setOrder("desc");
		try {
			if (model.getBusinessId() == null&&model.getRegId()==null) {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("获取用户信息失败!");
			} else {
				page = saleService.loadDatagrid(page, model);
				jsonObj.setObj(page);
			}
		} catch (Exception e) {
			log.error("**********************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/** 获取全部食品类型
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping("/queryLocalFood")
	@ResponseBody
	public AjaxJson queryLocalFood(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String fileName = "foodList";
			String s = getDatafromFile(fileName);
			if (s != null) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(s);
				List<BaseFoodType> foodList = JSONArray.parseArray(jsonObject.getString("obj"), BaseFoodType.class);
				jsonObj.setObj(foodList);
			} else {
				if (saveDataToFile(fileName)) {
					s = getDatafromFile(fileName);
					if (s != null) {
						com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(s);
						List<BaseFoodType> foodList = JSONArray.parseArray(jsonObject.getString("obj"), BaseFoodType.class);
						jsonObj.setObj(foodList);
					}
				}
            }
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	@RequestMapping("/queryAllFood")
	@ResponseBody
	public AjaxJson queryAllFood(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			String s = getDatafromFile("foodList");
			com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(s);
			List<BaseFoodType> foodList = JSONArray.parseArray(jsonObject.getString("obj"), BaseFoodType.class);
			jsonObj.setObj(foodList);
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/** 根据用户不同sey_type获取历史输入数据
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping("/getHistory")
	@ResponseBody
	public AjaxJson getFoodHistory(BaseLedgerHistory bean, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
			if(ledgerUser!=null&&ledgerUser.getOpeId()!=null){
				bean.setType((short)0);
			}else {
				//bean.setType((short)1);
			}
		 
			List<BaseLedgerHistory> list = historyService.selectHistoryData(bean);
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/** 获取市场、档口历史数据
	 * @param bean
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping("/getObjHistory")
	@ResponseBody
	public AjaxJson getObjHistory(BaseLedgerObjHistory bean, String searchType,HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		List<BaseLedgerObjHistory> list =null ;
		try {
			BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
			if(ledgerUser!=null&&ledgerUser.getOpeId()!=null){
				bean.setType((short)0);
			}else if(ledgerUser!=null){
				bean.setType((short)1);
			}
			if(searchType.equals("1")){//查市场
			 list = objHistoryService.selectHistoryObj(bean);
			}else if(searchType.equals("0")){//查档口
			 list = objHistoryService.selectHistoryBus(bean);
			}
			jsonObj.setObj(list);
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/** 获取全部监管对象
	 * @param request
	 * @param response
	 * @return */
	@RequestMapping("/queryAllObj")
	@ResponseBody
	public AjaxJson queryAllObj(String regTypeId, HttpServletRequest request, HttpServletResponse response) {
		AjaxJson jsonObj = new AjaxJson();
		BaseLedgerUser ledgerUser = (BaseLedgerUser) request.getSession().getAttribute("ledgerUser");
		Integer departId = 1;
		try {
			List<BaseRegulatoryObject> objList = (List<BaseRegulatoryObject>) request.getSession().getAttribute("objList");
			if (objList == null) {
				jsonObj.setObj(objList);
				if (ledgerUser != null && ledgerUser.getDepartId() != null) {
					departId = ledgerUser.getDepartId();
				}
				BaseRegulatoryObject bean=new BaseRegulatoryObject();
				bean.setDepartId(departId);
				bean.setRegType(regTypeId);
				objList = objectService.queryAllByDepartId(bean);
				request.getSession().setAttribute("objList", objList);
			}
			jsonObj.setObj(objList);
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	private boolean saveDataToFile(String fileName) throws IOException {
		BufferedWriter writer = null;
		File file = new File(foodListPath);
		if (!file.exists()) {
			file.mkdir();
		}
		file = new File(foodListPath + fileName + ".json");// 文件不存在
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		}
		// 写入
		try {
			AjaxJson jsonObj = new AjaxJson();
			List<BaseFoodType> foodTypes = baseFoodTypeService.queryAllFood();
			jsonObj.setObj(foodTypes);
			String data = com.alibaba.fastjson.JSONObject.toJSON(jsonObj).toString();
			writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, false), StandardCharsets.UTF_8));
			writer.write(data);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (writer != null) {
					writer.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
		}
		// System.out.println("文件写入成功！");
		return true;
	}

	private String getDatafromFile(String fileName) throws IOException {
		String Path = foodListPath + fileName + ".json";
		File file = new File(Path);
		if (!file.exists()) {
			if (saveDataToFile("foodList")) {
				getDatafromFile(fileName);
			}
        }
		BufferedReader reader = null;
		String laststr = "";
		try {
			FileInputStream fileInputStream = new FileInputStream(Path);
			InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, StandardCharsets.UTF_8);
			reader = new BufferedReader(inputStreamReader);
			String tempString = null;
			while ((tempString = reader.readLine()) != null) {
				laststr += tempString;
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
					return null;
				}
			}
		}
		return laststr;
	}
	
	/**
	 * 校验openid 有效性 
	 * @param request
	 * @return
	 */
	public  boolean  checkOpenid(HttpServletRequest request) {
		String	openid = (String) request.getSession().getAttribute("openid");
		if(openid==null){
			return false ;
		}
		BaseLedgerUser	ledgerUser = ledgerUserService.selectByOpenid(openid);
        return ledgerUser != null;
    }
	/**
	 * 测试地址专用
	 * @param request
	 * @param response
	 * @param listType
	 * @param openid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/test")
	public ModelAndView test(HttpServletRequest request, HttpServletResponse response,String listType, String openid) throws Exception {
		Map<String, Object> mapData = new HashMap<>();
		BaseLedgerUser ledgerUser = ledgerUserService.selectByOpenid(openid);
		request.getSession().setAttribute("ledgerUser", ledgerUser);
		request.getSession().setAttribute("openid", openid);
	 	return new ModelAndView("/ledger/wx/test", mapData);
	}

}
