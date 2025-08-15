package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BasePointUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseWorkersModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.BasePointUserService;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 检测机构、点人员
 * Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2017年9月3日
 */
@Controller
@RequestMapping("/data/pointUser")
public class BasePointUserController extends BaseController {
	private final Logger log=Logger.getLogger(BasePointUserController.class);
	@Autowired
	private BasePointUserService basePointUserService;
	@Autowired
	private BasePointService basePointService;

	/**
	 * 进入机构人员列表页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response,Integer departId,Integer pointId) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		BasePoint point = basePointService.queryById(pointId);
		if(point != null){
			map.put("pointName", point.getPointName());
		}else{
			map.put("pointName", null);
		}

		map.put("departId", departId);
		map.put("pointId", pointId);
		return new ModelAndView("/data/workers/personnelList",map);
	}

	/**
	 * 数据列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(BaseWorkersModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			page = basePointUserService.loadDatagrid(page, model);
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

	/**
	 * 保存
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request, HttpServletResponse response, String ids, Integer pointId, Integer departId){
		AjaxJson jsonObject = new AjaxJson();
		try {
			String[] idArray = ids.split(",");
			if(null != pointId){
				//保存检测点人员
				System.out.println(idArray+"--"+departId+"--"+pointId);
				basePointUserService.savePointUser(idArray, departId, pointId);
			}else if(StringUtil.isNotEmpty(departId)){
				//保存检测机构人员
				basePointUserService.saveDepartUser(idArray, departId);
			}else{
				jsonObject.setSuccess(false);
				jsonObject.setMsg("保存失败");
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}

	/**
	 * 更新
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/update")
	@ResponseBody
	public AjaxJson update(HttpServletRequest request, HttpServletResponse response, BasePointUser bean){
		AjaxJson jsonObject = new AjaxJson();
		try {
			if(bean!=null  && StringUtil.isNotEmpty(bean.getId())){
				PublicUtil.setCommonForTable(bean, false);
				basePointUserService.updateByPrimaryKeySelective(bean);
			}else{
				jsonObject.setSuccess(false);
				jsonObject.setMsg("保存失败");
			}
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("保存失败");
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
			BasePointUser bean  = basePointUserService.queryById(id);
			if(bean  == null){
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
			jsonObject.setObj(bean);
		} catch (Exception e) {
			log.error("******************************"+e.getMessage()+e.getStackTrace());
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
			basePointUserService.delete(ida);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}

}
