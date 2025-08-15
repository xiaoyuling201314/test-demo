package com.dayuan.controller.ledger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.mapper.regulatory.BaseRegulatoryObjectMapper;
import com.dayuan.model.data.TreeNode;
import com.dayuan.model.regulatory.BaseRegulatoryObjectModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.service.system.SystemConfigJsonService;
import com.dayuan.util.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLDecoder;
import java.util.*;

/**
 * 监管对象管理
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/ledger/regulatoryObject")
public class BaseRegObjectController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseRegObjectController.class);
	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;
	@Autowired
	private BaseRegulatoryTypeService baseRegulatoryTypeService;
	@Autowired
	private TSDepartService departService;
	@Autowired
	private BasePointService basePointService;
	@Autowired
	private SystemConfigJsonService systemConfigJsonService;

	@Value("${systemUrl}")
	private String systemUrl;
	@Value("${resources}")
	private String resources;
	@Value("${regObjectQr}")
	private String regObjectQr;
	@Value("${businessQr}")
	private String businessQr;

	/**
	 * 进入监管对象管理界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,String regTypeCode){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
		String regType = "";
		String regTypeId = "";
		TSUser user;
			user = PublicUtil.getSessionUser();
			if(user.getRegId()!=null){//判断用户是否为市场用户 不为空则是市场用户
				map.put("reg", user.getRegId());
			}
		List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
		map.put("regulatoryTypes", regulatoryTypes);
		if(regulatoryTypes!=null){
			BaseRegulatoryType	regulatoryType=regulatoryTypes.get(0);
			if(null == regulatoryType || regulatoryType.getShowBusiness() != 1){
				//隐藏经营户
				map.put("showBusiness", false);
			}else{
				//显示经营户
				map.put("showBusiness", true);
			}
			regType = regulatoryType.getRegType();
			regTypeId = regulatoryType.getId();
			map.put("regType", regType);
			map.put("regTypeId", regTypeId);
		}
	 
	
		} catch (MissSessionExceprtion e) {
			
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/ledger/regulatoryObject/list",map);
	}
	/**
	 * 进入台账管理-监管对象页面
	 * @param request
	 * @param response
	 * @param regTypeCode
	 * @return
	 */
	@RequestMapping("/ledgerList")
	public ModelAndView ledgerList(HttpServletRequest request,HttpServletResponse response,String regTypeCode,String regTypeId){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
		//getOperationList(request.getServletPath()+"?regTypeCode="+regTypeCode, request, tSFunctionService, tSOperationService);
		
		String regType = "";
		TSUser user;
			user = PublicUtil.getSessionUser();
			if(user.getRegId()!=null){//判断用户是否为市场用户 不为空则是市场用户
				map.put("reg", user.getRegId());
				try {
					BaseRegulatoryObject object=	baseRegulatoryObjectService.queryById(user.getRegId());
					if(object!=null){
						regTypeId=object.getRegType();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
			if(regulatoryTypes!=null){
				BaseRegulatoryType	regulatoryType=regulatoryTypes.get(0);
				if(null == regulatoryType || regulatoryType.getShowBusiness() != 1){
					//隐藏经营户
					map.put("showBusiness", false);
				}else{
					//显示经营户
					map.put("showBusiness", true);
				}
				regType = regulatoryType.getRegType();
				if(regTypeId==null){
					regTypeId = regulatoryType.getId();
				}
			}
			map.put("regulatoryTypes", regulatoryTypes);
			if(regTypeId!=null){
				for (BaseRegulatoryType baseRegulatoryType : regulatoryTypes) {
					if(baseRegulatoryType.getId().equals(regTypeId)){
						if(baseRegulatoryType.getShowBusiness() != 1){
							//隐藏经营户
							map.put("showBusiness", false);
						}else{
							//显示经营户
							map.put("showBusiness", true);
						}
						regType = baseRegulatoryType.getRegType();
						regTypeId = baseRegulatoryType.getId();
					}
				}
			}
			map.put("regType", regType);
			map.put("regTypeId", regTypeId);
			
		} catch (MissSessionExceprtion e) {
			
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/ledger/regulatoryObject/ledgerList",map);
	}
	
	/**
	 * 进入新增/编辑监管对象界面
	 * @param request
	 * @param response
	 * @param isNewMenu 是否从监管对象新菜单进入：可选值：Y，N；默认为N否,
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goAddRegulatoryObject")
	public ModelAndView goAddRegulatoryObject(HttpServletRequest request,HttpServletResponse response,Integer id,String regTypeId,@RequestParam(required = false,defaultValue = "N") String isNewMenu){
		Map<String,Object> map = new HashMap<String,Object>();
		BaseRegulatoryObject regulatoryObject = null;
		try {
			if(null != id){
				//监管对象
				regulatoryObject = baseRegulatoryObjectService.queryById(id);
				map.put("regulatoryObject", regulatoryObject);
			}
			
			//当前监管对象类型
			BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryById(regTypeId);
			map.put("regulatoryType", regulatoryType);
			
			//所有监管对象类型
			List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
			map.put("regulatoryTypes", regulatoryTypes);
			map.put("isNewMenu",isNewMenu);

			//当前用户
			map.put("user", PublicUtil.getSessionUser());
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/ledger/regulatoryObject/addRegulatoryObject",map);
	}
	/**
	 * 进入新增/编辑监管对象界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/ledgerAddRegulatoryObject")
	public ModelAndView ledgergoAddRegulatoryObject(HttpServletRequest request,HttpServletResponse response,Integer id,String regTypeId){
		Map<String,Object> map = new HashMap<String,Object>();
		BaseRegulatoryObject regulatoryObject = null;
		try {
			if(null != id){
				//监管对象
				regulatoryObject = baseRegulatoryObjectService.queryById(id);
				map.put("regulatoryObject", regulatoryObject);
			}
			
			//当前监管对象类型
			BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryById(regTypeId);
			map.put("regulatoryType", regulatoryType);
			
			//所有监管对象类型
			List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
			map.put("regulatoryTypes", regulatoryTypes);

			//当前用户
			map.put("user", PublicUtil.getSessionUser());
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/ledger/regulatoryObject/ledgerAddRegulatoryObject",map);
	}

	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryObjectModel model,Page page,Integer did){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser user=PublicUtil.getSessionUser();
			if(user!=null&&user.getRegId()!=null){//市场用户
				model.getRegulatoryObject().setId(user.getRegId());
			}

			Calendar c = Calendar.getInstance();
			c.add(Calendar.MONTH, -1);
			c.set(Calendar.HOUR_OF_DAY, 0);
			c.set(Calendar.MINUTE, 0);
			c.set(Calendar.SECOND, 0);
			Date date = c.getTime();

			String startTime = DateUtil.formatDate(date, "yyyy-MM-dd HH:mm:ss");
			model.setStartTime(startTime);
			TSDepart depart = PublicUtil.getSessionUserDepart();
			if(depart != null){
				model.setDepartCode(depart.getDepartCode());
			}
			if(did!=null&&!did.equals(0)){
				TSDepart depart2=departService.getById(did);
				model.setDepartCode(depart2.getDepartCode());
			}
			 if(model.getIsQueryUnqualified()==1) {//统计当天的不合格数，传入时间参数
				String dateStr=DateUtil.date_sdf.format(new Date());
				model.setStartDateStr(dateStr);
				model.setEndDateStr(dateStr+" 23:59:59");
			}
			page = baseRegulatoryObjectService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid2")
	@ResponseBody
	public AjaxJson datagrid2(BaseRegulatoryObjectModel model, Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser user = PublicUtil.getSessionUser();
			if(user!=null){
                //市场用户
			    if (user.getRegId()!=null) {
                    model.getRegulatoryObject().setId(user.getRegId());

			    //检测室用户
                } else if (user.getPointId()!=null) {
			        //企业检测室用户只能查看关联的监管对象
					BasePoint bp = basePointService.queryById(user.getPointId());
					if (bp != null && bp.getRegulatoryId() != null && !"".equals(bp.getRegulatoryId().trim())){
						model.getRegulatoryObject().setId(Integer.parseInt(bp.getRegulatoryId().trim()));
					}
                }
			}

			if (model.getRegulatoryObject() == null) {
				model.setRegulatoryObject(new BaseRegulatoryObject());
			}
            if (model.getRegulatoryObject().getDepartId() == null){
				model.getRegulatoryObject().setDepartId(user.getDepartId());
            }

            //项目预览，查询监管对象当天不合格数据数量
            if (model.getIsQueryUnqualified() == 1) {
            	Calendar c = Calendar.getInstance();
				model.setStartDateStr(DateUtil.formatDate(c.getTime(), "yyyy-MM-dd 00:00:00"));
				model.setEndDateStr(DateUtil.formatDate(c.getTime(), "yyyy-MM-dd HH:mm:ss"));
			}

			page = baseRegulatoryObjectService.loadDatagrid(page, model, BaseRegulatoryObjectMapper.class, "loadDatagrid2", "getRowTotal2");
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 保存监管对象
	 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryObject obj){
		AjaxJson aj = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(obj.getId())){
				//更新
				PublicUtil.setCommonForTable(obj, false);
				baseRegulatoryObjectService.updateById(obj);
			}else{
				//新增
//				obj.setId(UUIDGenerator.generate());
				obj.setDeleteFlag((short) 0);
				if(obj.getChecked()==null){
					obj.setChecked((short) 0);
				}
				PublicUtil.setCommonForTable(obj, true);
				baseRegulatoryObjectService.insert(obj);
			}
			aj.setObj(obj);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
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
			String[] ida = null;
			if(StringUtil.isNotEmpty(ids)){
				ida = ids.split(",");
				Integer[] idas = new Integer[ida.length];
				for (int i = 0; i < ida.length; i++) {
					idas[i] = Integer.parseInt(ida[i]);
				}
				baseRegulatoryObjectService.deleteData(PublicUtil.getSessionUser().getId(), idas);
			}else{
				jsonObj.setSuccess(false);
			}
		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	@RequestMapping("/queryRegByDepartId")
	public @ResponseBody AjaxJson queryRegByDepartId(Integer departId,String regualtoryTypeId){
		AjaxJson json = new AjaxJson();
		List<BaseRegulatoryObject> regs = baseRegulatoryObjectService.queryRegByDepartId(departId,regualtoryTypeId);
		json.setObj(regs);
		return json;
	}
	/**
	 * 查看经营户二维码
	 * @param ids 经营户ID
	 * @return
	 */
	@RequestMapping("/businessQrcode")
	@ResponseBody
	public AjaxJson businessQrcode(HttpServletRequest request,HttpServletResponse response, String ids) {
		AjaxJson aj = new AjaxJson();
		try {
			String[] ida = ids.split(",");
			
			String rootPath = resources + businessQr;
			DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
			
			BaseRegulatoryBusiness business = null;
			List qrcodes = new ArrayList();	//二维码
			for(String businessId : ida){
				Map<String,Object> map = new HashMap<String,Object>();
				business = baseRegulatoryBusinessService.queryById(Integer.parseInt(businessId));
				if(business == null){
					throw new Exception("查看经营户二维码失败，经营户不存在！");
				}
				
				if(StringUtil.isNotEmpty(business.getQrcode())){
					//读取二维码
					File qrFile = new File(rootPath+business.getQrcode());
					if(!qrFile.exists()){
						QrcodeUtil.generateSamplingQrcode(request, business.getQrcode(), systemUrl + "iRegulatory/businessApp.do?id=" + business.getId(), rootPath);
					}
				}else{
					//生成二维码
					String qrcodeName = UUIDGenerator.generate()+".png";
					QrcodeUtil.generateSamplingQrcode(request, qrcodeName, systemUrl + "iRegulatory/businessApp.do?id=" + business.getId(), rootPath);
					business.setQrcode(qrcodeName);
					baseRegulatoryBusinessService.updateBySelective(business);
				}
				map.put("qrcodeSrc", "/resources/" + businessQr + business.getQrcode());
				map.put("opeShopName", business.getOpeShopName());
				map.put("opeShopCode", business.getOpeShopCode());
				qrcodes.add(map);
			}
			aj.setObj(qrcodes);
		} catch (Exception e) {
			aj.setSuccess(false);
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return aj;
	}
	
	/**
	 * 查询当前用户机构下全部市场
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryAllObj")
	@ResponseBody
	public AjaxJson  queryById(HttpServletRequest request,HttpServletResponse response,String id) throws Exception{
		AjaxJson jsonObj = new AjaxJson();
		TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
		List<BaseRegulatoryObject> regObj=baseRegulatoryObjectService.queryByDepartId(user.getDepartId(),"1");
		jsonObj.setObj(regObj);
		return jsonObj;
	}
	/**
	* @Description 进入监管对象管理界面--复选监管类型版本
	* @Date 2020/09/29 11:42
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/list_new")
	public ModelAndView list_new(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String regType = "";
			String regTypeId = "";
			TSUser user;
			user = PublicUtil.getSessionUser();
			if(user.getRegId()!=null){//判断用户是否为市场用户 不为空则是市场用户
				map.put("reg", user.getRegId());
			}
			List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
			map.put("regulatoryTypes", regulatoryTypes);
			if(regulatoryTypes!=null){
				BaseRegulatoryType	regulatoryType=regulatoryTypes.get(0);
				if(null == regulatoryType || regulatoryType.getShowBusiness() != 1){
					//隐藏经营户
					map.put("showBusiness", false);
				}else{
					//显示经营户
					map.put("showBusiness", true);
				}
				regType = regulatoryType.getRegType();
				regTypeId = regulatoryType.getId();
				map.put("regType", regType);
				map.put("regTypeId", regTypeId);
			}

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return new ModelAndView("/ledger/regulatoryObject/list_new",map);
	}
	/**
	 * 获取监管类型树形菜单
	 *
	 * @return
	 * @throws MissSessionExceprtion
	 */
	@RequestMapping("/getRegTypeTree")
	@ResponseBody
	public List<TreeNode> getRegTypeTree(HttpServletRequest request, HttpServletResponse response){
		List<TreeNode> trees = new ArrayList<>();
		List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
		TreeNode node=null;
		for(BaseRegulatoryType type : regulatoryTypes) {
			node= new TreeNode();
			node.setId(type.getId() + "");
			node.setText(type.getRegType());
			trees.add(node);
		}
		//拼接父类全选节点
		node = new TreeNode();
		node.setId("");
		node.setText("--全部--");
		node.setChildren(trees);
		List<TreeNode> regTypeTree2 = new ArrayList<>();
		regTypeTree2.add(node);
		return regTypeTree2;
	}

	/**
	 * 查看监管对象二维码
	 * @param ids 监管对象ID
	 * @return
	 */
	@RequestMapping("/regObjectQrcode")
	@ResponseBody
	public AjaxJson regObjectQrcode(HttpServletRequest request,HttpServletResponse response, String ids) {
		AjaxJson aj = new AjaxJson();
		try {
			String[] ida = ids.split(",");

			String rootPath = resources + regObjectQr;
			DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建

			BaseRegulatoryObject regObject = null;
			List qrcodes = new ArrayList();	//二维码
			for(String regObjectId : ida){
				Map<String,Object> map = new HashMap<String,Object>();
				regObject = baseRegulatoryObjectService.queryById(Integer.parseInt(regObjectId));
				if(regObject == null){
					throw new Exception("查看监管对象二维码失败，监管对象不存在！");
				}

				String qrcodeLogoPath = URLDecoder.decode(this.getClass().getResource("/").getPath().split("/WEB-INF")[0]+"/img/qrcode-logo.png","UTF-8");
				qrcodeLogoPath = qrcodeLogoPath.substring(1);

				if(StringUtil.isNotEmpty(regObject.getQrcode())){
					//读取二维码
					File qrFile = new File(rootPath + regObject.getQrcode());
					if(!qrFile.exists()){
//						//没logo
//						QrcodeUtil.generateSamplingQrcode(request, regObject.getQrcode(), systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath);
						//有logo
						QrcodeUtil.generateQrcode(systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath + regObject.getQrcode(),  QrcodeUtil.QRCODE_WIDTH, QrcodeUtil.QRCODE_HEIGHT, qrcodeLogoPath);
					}
				}else{
					//生成二维码
					String qrcodeName = UUIDGenerator.generate()+".png";
					regObject.setQrcode(qrcodeName);

//					//没logo
//					QrcodeUtil.generateSamplingQrcode(request, regObject.getQrcode(), systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath);
					//有logo
					QrcodeUtil.generateQrcode(systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath + regObject.getQrcode(),  QrcodeUtil.QRCODE_WIDTH, QrcodeUtil.QRCODE_HEIGHT, qrcodeLogoPath);

					baseRegulatoryObjectService.updateBySelective(regObject);
				}
				map.put("qrcodeSrc", "/resources/" + regObjectQr + regObject.getQrcode());
				map.put("regName", regObject.getRegName());
				qrcodes.add(map);
			}
			aj.setObj(qrcodes);
		} catch (Exception e) {
			aj.setSuccess(false);
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return aj;
	}

	/**
	 * 读取监管对象二维码风格
	 * @return
	 */
	@RequestMapping("/getRegQrcodeStyle")
	@ResponseBody
	public AjaxJson getRegQrcodeStyle() {
		AjaxJson aj = new AjaxJson();
		try {
			Map<String, Object> map = new HashMap<String, Object>(3);
			map.put("regQrcodeStyle", systemConfigJsonService.getSystemConfig(SystemConfigJsonService.systemConfigType.REG_QRCODE_STYLE));
			map.put("regQrcodeUrl", systemUrl+"iRegulatory/regObjectApp.do?id=");
			map.put("busQrcodeUrl", systemUrl+"iRegulatory/businessApp.do?id=");
			aj.setObj(map);

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
		}
		return aj;
	}

	/**
	 * 更新二维码风格
	 * @param title		添加文字
	 * @param fontSize	文字尺寸
	 * @param size		二维码尺寸
	 * @param logoNo		logo序号
	 * @param logos		logo base64数组
	 * @return
	 */
	@RequestMapping("/setRegQrcodeStyle")
	@ResponseBody
	public AjaxJson setRegQrcodeStyle(String title, String fontSize, String size, String logoNo, String logos) {
		AjaxJson aj = new AjaxJson();
		try {
			JSONObject style = new JSONObject();
			style.put("title", title);
			style.put("fontSize", fontSize);
			style.put("size", size);
			style.put("logoNo", logoNo);

            JSONArray logosArr = JSONArray.parseArray(logos);
            style.put("logos", logosArr);

			systemConfigJsonService.setSystemConfig(SystemConfigJsonService.systemConfigType.REG_QRCODE_STYLE, style);

		} catch (Exception e) {
			log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			aj.setSuccess(false);
		}
		return aj;
	}
}
