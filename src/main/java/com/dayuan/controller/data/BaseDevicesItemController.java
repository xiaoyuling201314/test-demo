package com.dayuan.controller.data;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDevicesItemModel;
import com.dayuan.service.data.BaseDevicesItemService;
import com.dayuan.util.StringUtil;

/**
 * 注册仪器项目管理
 * Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2017年8月21日
 */
@Controller
@RequestMapping("/data/devicesItem")
public class BaseDevicesItemController extends BaseController {
	private final Logger log=Logger.getLogger(BaseDevicesItemController.class);
	@Autowired
	private BaseDevicesItemService baseDevicesItemService;
	
	/**
	 * 进入注册仪器项目管理页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView  list(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("/data/devicesItem/list");
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
	public AjaxJson datagrid(BaseDevicesItemModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = baseDevicesItemService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
	/**
	 * 修改注册仪器项目
	 * @param bean
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public  AjaxJson save(BaseDevicesItem bean,HttpServletRequest request, HttpServletResponse response){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(bean.getId())){
				//更新仪器项目
				PublicUtil.setCommonForTable(bean, false);
				baseDevicesItemService.updateBySelective(bean);
			}else{
				jsonObject.setSuccess(false);
				jsonObject.setMsg("更新失败");
			}
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
		} catch (Exception e) {
			log.error("**********************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
		} catch (Exception e) {
			log.error("***************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	
}
