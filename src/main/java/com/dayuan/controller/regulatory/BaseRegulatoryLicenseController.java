package com.dayuan.controller.regulatory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.regulatory.BaseRegulatoryLicense;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.regulatory.BaseRegulatoryObjectModel;
import com.dayuan.service.regulatory.BaseRegulatoryLicenseService;
import com.dayuan.util.StringUtil;

/**
 * 监管对象管理
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/regulatory/regulatoryLicense")
public class BaseRegulatoryLicenseController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseRegulatoryLicenseController.class);
	
	@Autowired
	private BaseRegulatoryLicenseService baseRegulatoryLicenseService;

	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryObjectModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseRegulatoryLicenseService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 保存
	 */
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryLicense license,@RequestParam(value="filePathImage",required=false) MultipartFile file){
		AjaxJson aj = new AjaxJson();
		response.setContentType("text/plain");
		try {
			//保存图片
			if(null != file){
				String fileName = uploadFile(request,"licenseImage/",file,null);
				license.setLicenseImage("/resources/licenseImage/"+fileName);
			}
			if(StringUtil.isNotEmpty(license.getId())){
				//更新
				PublicUtil.setCommonForTable(license, false);
				baseRegulatoryLicenseService.updateBySelective(license);
			}else{
				//新增
//				license.setId(UUIDGenerator.generate());
				license.setDeleteFlag((short) 0);
				PublicUtil.setCommonForTable(license, true);
				baseRegulatoryLicenseService.insert(license);
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
			BaseRegulatoryLicense license = baseRegulatoryLicenseService.queryById(id);
			jsonObject.setObj(license);
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
			baseRegulatoryLicenseService.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
