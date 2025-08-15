package com.dayuan.controller.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.app.TbSignIn;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.controller.BaseController;
import com.dayuan.mapper.app.TbSignInMapper1;
import com.dayuan.model.app.TbSignInModel;
import com.dayuan.service.app.TbSignInService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.util.StringUtil;

/**
 * 人员签到
 */
@Controller
@RequestMapping("/signIn")
public class SignInController extends BaseController {
	private final Logger log=Logger.getLogger(SignInController.class);
	
	@Autowired
	private TbSignInMapper1 mapper1;
	@Autowired
	private TbSignInService tbSignInService;
	@Autowired
	private TSDepartService departService;

	/**
	 * 进入人员签到列表页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		//是否显示进货数量字段
		map.put("signType", SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("signType"));
		return new ModelAndView("/signIn/list",map);
	}
	
	/**
	 * 数据列表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	/*
	 * delete by xiaoyl 2020-05-11 优化查询方式
	 * @RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(TbSignInModel model,Page page,HttpServletResponse response){
		AjaxJson jsonObj = new AjaxJson();
		try {
			if(StringUtil.isNotEmpty(model.getDepartId())){	//人员签到，通过机构ID查询人员签到信息
				
				// 获取当前机构和其下属机构ID
				List<TSDepart> sDeparts = departService.getAllSonDepartsByID(model.getDepartId());
				Integer [] departIds = new Integer [sDeparts.size()];
				if(sDeparts !=null && sDeparts.size()>0) {
					for(int i=0;i<sDeparts.size();i++) {
						departIds[i] = sDeparts.get(i).getId();
					}
				}
				
				model.setDepartArr(departIds);
				page = tbSignInService.loadDatagrid(page, model);
			}
			if(StringUtil.isNotEmpty(model.getUserId())){	//人员签到，通过用户ID查询用户签到信息
				page = tbSignInService.loadDatagrid(page, model, mapper1);
			}
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}*/
	/**
	 * 人员签到查询
	 * @description
	 * @param model
	 * @param page
	 * @param model
     * @param page
     * @param type
     * @param month
     * @param season
     * @param year
     * @param start 自定义开始时间
     * @param end	自定义结束时间
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月11日
	 */
	@RequestMapping(value="/datagrid")
	@ResponseBody
	public AjaxJson datagrid(TbSignInModel model,Page page,String type,String month,String season,String year,String start,String end){
		AjaxJson jsonObj = new AjaxJson();
		try {
			model.formatTime(type,month,season,year,start,end,model);
			if(StringUtil.isEmpty(model.getUserId())){	//人员签到，通过机构ID查询人员签到信息
				
				// 获取当前机构和其下属机构ID
				List<TSDepart> sDeparts = departService.getAllSonDepartsByID(model.getDepartId());
				Integer [] departIds = new Integer [sDeparts.size()];
				if(sDeparts !=null && sDeparts.size()>0) {
					for(int i=0;i<sDeparts.size();i++) {
						departIds[i] = sDeparts.get(i).getId();
					}
				}
				
				model.setDepartArr(departIds);
				page = tbSignInService.loadDatagrid(page, model);
			}else if(StringUtil.isNotEmpty(model.getUserId())){	//人员签到，通过用户ID查询用户签到信息
				page = tbSignInService.loadDatagrid(page, model, mapper1);
			}
			jsonObj.setObj(page);
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
	/**
	 * 查询指定用户的签到数据
	 * @description
	 * @param userId
	 * @return
	 * @author xiaoyl
	 * @date   2020年5月11日
	 */
    @RequestMapping("/sign_detail")
    public ModelAndView sign_detail(String userId,String realname,@RequestParam(required = false,defaultValue = "") String signType) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", userId);
		map.put("realname", realname);
		map.put("signType", signType);
		map.put("signTypeConfig", SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("signType"));
		return new ModelAndView("/signIn/sign_detail", map);
    }
    /**
     * 	根据用户ID查询最后一次定位信息
     * @description
     * @param userId
     * @param response
     * @return
     * @author xiaoyl
     * @date   2020年5月12日
     */
	@RequestMapping("/queryById")
	@ResponseBody
	public AjaxJson queryById(String userId, HttpServletResponse response) {
		AjaxJson jsonObject = new AjaxJson();
		TbSignInModel bean = null;
		try {
			bean = tbSignInService.queryLastSignByUserId(userId);
			if (bean == null) {
				jsonObject.setSuccess(false);
				jsonObject.setMsg("没有找到对应的记录!");
			}
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		jsonObject.setObj(bean);
		return jsonObject;
	}

	/**
	* @Description 检测点用户查看各自的打卡签到信息，可在网页上进行上下班打卡录入
	* @Date 2020/10/31 10:41
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/point_list")
	public ModelAndView point_list() throws MissSessionExceprtion {
		Map<String, Object> map = new HashMap<String, Object>();
		TSUser user= PublicUtil.getSessionUser();
		map.put("userId", user.getId());
		map.put("signTypeConfig", SystemConfigUtil.OTHER_CONFIG==null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("signType"));
		return new ModelAndView("/signIn/point_list", map);
	}
	/**
	* @Description 在线打卡签到
	* @Date 2020/10/31 11:36
	* @Author xiaoyl
	* @Param
	* @return
	*/
	@RequestMapping("/save")
	@ResponseBody
	public AjaxJson save(TbSignIn bean,String realName) {
		AjaxJson jsonObject = new AjaxJson();
		try {
			TSUser user= PublicUtil.getSessionUser();
			bean.setParam1("5");
			tbSignInService.saveSignDataForWEB(bean,user,realName);
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() + e.getStackTrace());
			jsonObject.setSuccess(false);
			jsonObject.setMsg("操作异常.");
		}
		return jsonObject;
	}
}
