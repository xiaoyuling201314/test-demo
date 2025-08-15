package com.dayuan.controller.regulatory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.regulatory.BaseRegulatoryPersonnel;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.regulatory.BaseRegulatoryObjectModel;
import com.dayuan.service.regulatory.BaseRegulatoryPersonnelService;
import com.dayuan.util.StringUtil;

/**
 * 监管对象人员
 * @Description:
 * @Company:食安科技
 * @author Dz  
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/regulatory/regulatoryPersonnel")
public class BaseRegulatoryPersonnelController extends BaseController {
	
	private final Logger log = Logger.getLogger(BaseRegulatoryPersonnelController.class);
	
	@Autowired
	private BaseRegulatoryPersonnelService baseRegulatoryPersonnelService;

//	/**
//	 * 进入监管对象管理界面
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping("/list")
//	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception{
//		return new ModelAndView("/regulatory/regulatoryObject/list");
//	}
	
//	/**
//	 * 进入新增/编辑监管对象界面
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping("/goAddRegulatoryObject")
//	public ModelAndView goAddRegulatoryObject(HttpServletRequest request,HttpServletResponse response,String id) throws Exception{
//		Map<String,Object> map = new HashMap<String,Object>();
//		BaseRegulatoryObject regulatoryObject = null;
//		BaseBusinessUser user = null;
//		if(StringUtil.isNotEmpty(id)){
//			//监管对象
//			regulatoryObject = regulatoryObjectService.queryById(id);
//			if(null != regulatoryObject){
//				//经营者信息
//				user = baseBusinessUserService.queryByRegid(id);
//			}
//		}
//		map.put("regulatoryObject", regulatoryObject);
//		map.put("user", user);
//		return new ModelAndView("/regulatory/regulatoryObject/addRegulatoryObject",map);
//	}
	
	/**
	 * 数据列表
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, BaseRegulatoryObjectModel model,Page page){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseRegulatoryPersonnelService.loadDatagrid(page, model);
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
	public AjaxJson save(HttpServletRequest request,HttpServletResponse response,BaseRegulatoryPersonnel personnel){
		AjaxJson aj = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(personnel.getId())){
				//更新
				PublicUtil.setCommonForTable(personnel, false);
				baseRegulatoryPersonnelService.updateBySelective(personnel);
			}else{
				//新增
//				personnel.setId(UUIDGenerator.generate());
				personnel.setDeleteFlag((short)0);
				PublicUtil.setCommonForTable(personnel, true);
				baseRegulatoryPersonnelService.insert(personnel);
			}
			aj.setObj(personnel);
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
			BaseRegulatoryPersonnel personnel = baseRegulatoryPersonnelService.queryById(id);
			jsonObject.setObj(personnel);
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
			baseRegulatoryPersonnelService.delete(idas);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
