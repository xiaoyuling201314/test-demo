package com.dayuan.controller.data;

import java.util.Date;

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
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDeviceType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDeviceTypeModel;
import com.dayuan.service.data.BaseDeviceTypeService;

/**
 * 仪器类别维护
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月4日
 */
@Controller
@RequestMapping("/data/deviceSeries")
public class BaseDeviceTypeController extends BaseController {
	private final Logger log=Logger.getLogger(BaseDeviceTypeController.class);
	@Autowired
	private BaseDeviceTypeService baseDeviceTypeService;
	/**
	 * 进入页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView  list(HttpServletRequest request,HttpServletResponse response){
		
		return new ModelAndView("/data/deviceSeries/list");
	}
	/**
	 * 数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson  datagrid(BaseDeviceTypeModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("desc");
			page = baseDeviceTypeService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	@RequestMapping(value="/devicedatagrid")
	@ResponseBody
	public AjaxJson  devicedatagrid(BaseDeviceTypeModel model,Page page,HttpServletResponse response,int type){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page.setOrder("desc");
			if(type==0){
				model.setType((short)0);
			}else if (type==1) {
				model.setType((short)1);
			}
			page = baseDeviceTypeService.loadDatagrids(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
			log.error("******************************" + e.getMessage() + e.getStackTrace());
		}
		return jsonObj;
	}
	@RequestMapping("/savebaseDeviceType")
	@ResponseBody
	public AjaxJson savebaseDeviceType(BaseDeviceType baseDeviceType, HttpServletResponse response, HttpServletRequest request,HttpSession session,int type){
		AjaxJson jsonObject = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
			try {
				if(null!=baseDeviceType.getId()){
					if(type==1){
						baseDeviceType.setType((short)1);
					}
					//修改
					baseDeviceType.setUpdateBy(tsUser.getId());
					baseDeviceType.setUpdateDate(new Date());
					baseDeviceType.setChecked((short)1);
					baseDeviceTypeService.updateBySelective(baseDeviceType);
					
				}else {
					if(type==1){
						baseDeviceType.setType((short)1);
					}
					//新增
					baseDeviceType.setCreateBy(tsUser.getId());
					baseDeviceType.setCreateDate(new Date());
					baseDeviceType.setChecked((short)1);
					baseDeviceTypeService.insertSelective(baseDeviceType);
				}
			} catch (Exception e) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("操作失败");
				log.error("******************************" + e.getMessage() + e.getStackTrace());
			}
		
		return jsonObject;
	}
	@RequestMapping("/deleteone")
	@ResponseBody
	public AjaxJson deleteOne(HttpServletRequest request,HttpServletResponse response,int id,HttpSession session){
		AjaxJson jsonObj = new AjaxJson();
		TSUser tsUser = (TSUser)session.getAttribute(WebConstant.SESSION_USER);
		try {
			BaseDeviceType baseDeviceType=new BaseDeviceType();
			baseDeviceType.setId(id+"");
			baseDeviceType.setDeleteFlag((short)1);
			baseDeviceType.setUpdateBy(tsUser.getId());
			baseDeviceType.setUpdateDate(new Date());
			baseDeviceTypeService.updateBySelective(baseDeviceType);
		} catch (Exception e) {
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
			log.error("******************************" + e.getMessage() + e.getStackTrace());
		}
		return jsonObj;
	}
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseDeviceType bean,@RequestParam(value="filePathImage",required=false) MultipartFile file,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		response.setContentType("text/plain");
		BaseDeviceType deviceType=baseDeviceTypeService.queryByDeviceName(bean.getDeviceName());
		try {
			if(null != file){
				String fileName = uploadFile(request,"/deviceImage/",file,null);
				bean.setFilePath("/resources/deviceImage/"+fileName);
			}
			if(StringUtils.isBlank(bean.getId())){//新增数据
				if (deviceType == null) {
					//bean.setId(UUIDGenerator.generate());
					PublicUtil.setCommonForTable(bean, true);
					baseDeviceTypeService.insertSelective(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该类型已存在，请重新输入.");
				}
			}else{//修改数据
				PublicUtil.setCommonForTable(bean, false);
				if (deviceType == null || bean.getId().equals(deviceType.getId())) {
					baseDeviceTypeService.updateBySelective(bean);
				} else {
					jsonObject.setSuccess(false);
					jsonObject.setMsg("该类型已存在，请重新输入.");
				}
			}
			
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
	
	/**
	 * 查找数据，进入编辑页面
	 * @param id 数据记录id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String id,HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			BaseDeviceType bean  = baseDeviceTypeService.queryById(id);
			if(bean  == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
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
			baseDeviceTypeService.delete(ida);
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 查询所有的仪器类别信息
	 * @param request
	 * @param response
	 * @return
	 */
	public AjaxJson queryAll(HttpServletRequest request,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			baseDeviceTypeService.queryAll();
		} catch (Exception e) {
			log.error("*************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
