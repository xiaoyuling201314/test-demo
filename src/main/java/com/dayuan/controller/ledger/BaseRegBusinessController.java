package com.dayuan.controller.ledger;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.regulatory.BaseRegulatoryBusinessModel;
import com.dayuan.model.regulatory.BaseRegulatoryObjectModel;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryLicenseService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.DyFileUtil;
import com.dayuan.util.QrcodeUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;

/**
 * 经营户
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/ledger/business")
public class BaseRegBusinessController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseRegBusinessController.class);
	
	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	@Autowired
	private BaseRegulatoryLicenseService baseRegulatoryLicenseService;
	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;

	@Value("${systemUrl}")
	private String systemUrl;

	/**
	 * 进入经营户管理界面
	 * @param request
	 * @param response
	 * @param isNewMenu 是否从监管对象新菜单进入：可选值：Y，N；默认为N否,
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,Integer regId, @RequestParam(required = false,defaultValue = "N") String isNewMenu){
		Map<String,Object> map = new HashMap<String,Object>();
		BaseRegulatoryObject regulatoryObject = null;
		try {
			//
			if(StringUtil.isNotEmpty(regId)){
				regulatoryObject = baseRegulatoryObjectService.queryById(regId);
			}
			BaseRegulatoryObject regulatoryType = baseRegulatoryObjectService.queryById(regId);
			if(regulatoryType!=null){
				map.put("manaType", regulatoryType.getManagementType());//获取市场类型
				map.put("regName", regulatoryType.getRegName());
			}
			map.put("isNewMenu",isNewMenu);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		map.put("regulatoryObject", regulatoryObject);
		return new ModelAndView("/ledger/regulatoryBusiness/list",map);
	}
	
	/**
	 * 市场方查询台账页面
	 * @param request
	 * @param response
	 * @param regId
	 * @return
	 */
	@RequestMapping("/ledgerList")
	public ModelAndView ledgerList(HttpServletRequest request,HttpServletResponse response,Integer regId){
		Map<String,Object> map = new HashMap<String,Object>();
		BaseRegulatoryObject regulatoryObject = null;
		try {
			if(regId==null){
			TSUser user =PublicUtil.getSessionUser();
			 regId=user.getRegId();
			}
			if(StringUtil.isNotEmpty(regId)){
				regulatoryObject = baseRegulatoryObjectService.queryById(regId);
			}
			BaseRegulatoryObject regulatoryType = baseRegulatoryObjectService.queryById(regId);
			if(regulatoryType!=null){
				map.put("manaType", regulatoryType.getManagementType());//获取市场类型
				map.put("regName", regulatoryType.getRegName());
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		map.put("regulatoryObject", regulatoryObject);
		return new ModelAndView("/ledger/regulatoryBusiness/ledgerList",map);
	}
	
	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryObjectModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseRegulatoryBusinessService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
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
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryBusinessModel model,@RequestParam(value="filePathImage",required=false) MultipartFile file){
		AjaxJson aj = new AjaxJson();
		try {
			if(model.getRegulatoryBusiness() != null){
				List<BaseRegulatoryBusiness> bus =baseRegulatoryBusinessService.queryByRegIdAndRegUser(model.getRegulatoryBusiness().getRegId(), model.getRegulatoryBusiness().getOpeShopCode());
				if(bus.size()==1&&!bus.get(0).getId().equals(model.getRegulatoryBusiness().getId())){//档口编号重复
					aj.setSuccess(false);
					aj.setMsg("档口编号已存在!");
					return aj;
				}else if(bus.size()>1){
					aj.setSuccess(false);
					aj.setMsg("档口编号已存在!");
					return aj;
				}
				if(StringUtil.isNotEmpty(model.getRegulatoryBusiness().getId())){//更新经营户
					PublicUtil.setCommonForTable(model.getRegulatoryBusiness(), false);
					baseRegulatoryBusinessService.updateBySelective(model.getRegulatoryBusiness());
					aj.setSuccess(true);
					aj.setMsg("编辑成功!");
				}else{
					model.getRegulatoryBusiness().setDeleteFlag((short) 0);
					//model.getRegulatoryBusiness().setChecked((short) 1);
					PublicUtil.setCommonForTable(model.getRegulatoryBusiness(), true);
					baseRegulatoryBusinessService.insert(model.getRegulatoryBusiness());
					aj.setSuccess(true);
					aj.setMsg("新增成功!");
				}
				
				if(model.getRegulatoryLicense() != null){
					//保存图片
					if(null != file){
						String fileName = uploadFile(request,"licenseImage/",file,null);
						model.getRegulatoryLicense().setLicenseImage("/resources/licenseImage/"+fileName);
					}
					if(StringUtil.isNotEmpty(model.getRegulatoryLicense().getId())){
						//更新营业执照
						PublicUtil.setCommonForTable(model.getRegulatoryLicense(), false);
						baseRegulatoryLicenseService.updateBySelective(model.getRegulatoryLicense());
					}else{
						//新增营业执照
//						model.getRegulatoryLicense().setId(UUIDGenerator.generate());
						model.getRegulatoryLicense().setSourceId(model.getRegulatoryBusiness().getId());
						model.getRegulatoryLicense().setSourceType("1");
						model.getRegulatoryLicense().setLicenseType((short) 0);
						model.getRegulatoryLicense().setDeleteFlag((short) 0);
						model.getRegulatoryLicense().setChecked((short) 1);
						PublicUtil.setCommonForTable(model.getRegulatoryLicense(), true);
						baseRegulatoryLicenseService.insert(model.getRegulatoryLicense());
					}
				}
				aj.setObj(model);
			}else{
				aj.setSuccess(false);
				aj.setMsg("保存失败");
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			aj.setSuccess(false);
			aj.setMsg("保存失败");
		}
		return aj;
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
				BaseRegulatoryBusinessModel businessModel = new BaseRegulatoryBusinessModel();
				BaseRegulatoryBusiness business = baseRegulatoryBusinessService.queryById(id);
				BaseRegulatoryLicense license = null;
				
				if(null != business){
					license = baseRegulatoryLicenseService.queryByBusinessId(id);
				}
				businessModel.setRegulatoryBusiness(business);
				businessModel.setRegulatoryLicense(license);
				jsonObject.setObj(businessModel);
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
			baseRegulatoryBusinessService.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 根据监管对象ID加载经营户信息
	 * @param request
	 * @param response
	 * @param regId 被检单位ID
	 * @return
	 */
	@RequestMapping("/queryByRegId")
	@ResponseBody
	public AjaxJson queryByRegId(HttpServletRequest request, HttpServletResponse response,Integer regId){
		AjaxJson jsonObject = new AjaxJson();
		List<BaseRegulatoryBusiness> list=null;
		try {
			list = baseRegulatoryBusinessService.queryByRegid(regId, null);
			//查询营业执照信息
			BaseRegulatoryLicense bean=baseRegulatoryLicenseService.queryBySourceIdAndType(regId,0);
			Map<String, Object> map=new HashMap<>();
			map.put("license", bean);
			jsonObject.setAttributes(map);
		} catch (Exception e) {
			jsonObject.setSuccess(false);
			jsonObject.setMsg("查询证照号码失败");
			log.error("******************************"+e.getMessage()+e.getStackTrace());
		}
		jsonObject.setObj(list);
		return jsonObject;
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
			
			String rootPath = WebConstant.res.getString("resources")+WebConstant.res.getString("businessQr");
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
				map.put("qrcodeSrc", "/resources/" + WebConstant.res.getString("businessQr") + business.getQrcode());
				map.put("opeShopName", business.getOpeShopName());
				map.put("opeShopCode", business.getOpeShopCode());
				qrcodes.add(map);
			}
			aj.setObj(qrcodes);
		} catch (Exception e) {
			aj.setSuccess(false);
			log.error("********************************"+e.getMessage()+e.getStackTrace());
		}
		return aj;
	}
}

