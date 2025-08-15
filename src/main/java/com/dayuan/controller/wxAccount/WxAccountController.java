package com.dayuan.controller.wxAccount;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.bean.wx.inspection.InspectionUser;
import com.dayuan.bean.wxAccount.wxAccount;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.data.DepartTreeModel;
import com.dayuan.model.wx.inspection.InspectionUserModel;
import com.dayuan.model.wxAccount.wxAccountModel;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.wx.inspection.InspectionUserService;
import com.dayuan.service.wxAccount.WxAccountService;
import com.dayuan.util.DateUtil;

/**
 * 
 *微信公众号管理
 * @author cola_hu
 *2018年11月7日
 */
@Controller
@RequestMapping("/wx/account")
public class WxAccountController extends BaseController {
	private final Logger log = Logger.getLogger(WxAccountController.class);
	@Autowired 
	private WxAccountService wxAccountService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private InspectionUserService inspectionUserService;
	
    /**
     * 进入微信公众号管理界面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request,HttpServletResponse response, HttpSession session){
    	Map<String, Object> map = new HashMap<>();
    	TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
    	DepartTreeModel departTree = null;
    	if (null != tsUser.getDepartId()) {
    		departTree = departService.getDepartPoint(tsUser.getDepartId());
    	}
    	map.put("departTree", departTree);
    	return new ModelAndView("/wxAccount/list");
    }
	/**
	 * 微信公众号关注人数列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
    @RequestMapping("/detail")
    public ModelAndView detail(Integer id,HttpServletRequest request,HttpServletResponse response, HttpSession session){
    	Map<String, Object> map = new HashMap<>();
    	try {
    		String start=DateUtil.firstDayOfMonth();
    		Date end=new Date();
    		wxAccount wx=wxAccountService.queryById(id);
    		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    		map.put("wx", wx);
    		map.put("start", start);
    		map.put("end", format.format(end));
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return new ModelAndView("/wxAccount/detail",map);
    }
    /**
     * 微信公众号统计汇总
     * @param id
     * @param request
     * @param response
     * @param session
     * @return
     */
    @RequestMapping("/report")
    public ModelAndView report(HttpServletRequest request,HttpServletResponse response, HttpSession session){
    	Map<String, Object> map = new HashMap<>();
    	try {
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return new ModelAndView("/wxAccount/report",map);
    }
    
    
	@RequestMapping("/samplingList")
	public ModelAndView samplingList(Integer id,HttpServletRequest request,HttpServletResponse response, HttpSession session){
	    Map<String, Object> map = new HashMap<>();
	    try {
	    	wxAccount wx=wxAccountService.queryById(id);
    		map.put("wx", wx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/wxAccount/samplingList",map);
	}
	
	   /**
     * 数据列表
     *
     * @param url
     * @param classifyId
     * @return
     * @throws MissSessionExceprtion
     * @throws Exception
     */
	@RequestMapping(value = "datagrid")
	@ResponseBody
	public AjaxJson datagrid(wxAccountModel model, Page page, HttpServletResponse response, HttpSession session) throws MissSessionExceprtion {
		AjaxJson jsonObj = new AjaxJson();
		TSDepart depart = (TSDepart) session.getAttribute(WebConstant.ORG);
		try {
			if(depart.getDepartCode()!=null){
				model.setDepartCode(depart.getDepartCode());
			}
			page=	wxAccountService.loadDatagrid(page, model);
			jsonObj.setObj(page);	
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return jsonObj;
	}
	/**
	 * 查询送样单数据列表
	 * @param model
	 * @param page
	 * @param response
	 * @param session
	 * @return
	 * @throws MissSessionExceprtion
	 */
	@RequestMapping(value = "datagrid2")
	@ResponseBody
	public AjaxJson datagrid2(wxAccountModel model, Page page, HttpServletResponse response, HttpSession session) throws MissSessionExceprtion {
		AjaxJson jsonObj = new AjaxJson();
		TSDepart depart = (TSDepart) session.getAttribute(WebConstant.ORG);
		try {
			if(model.getId()==null){
				
			}
			page=	wxAccountService.loadDatagrid2(page, model);
			jsonObj.setObj(page);	
		} catch (Exception e) {
			log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return jsonObj;
	}
	
	
    @RequestMapping(value = "getReport")
    @ResponseBody
    public AjaxJson getReport(wxAccountModel model, Page page, HttpServletResponse response, HttpSession session) throws MissSessionExceprtion {
        AjaxJson jsonObj = new AjaxJson();
        try {
        TSDepart depart = (TSDepart) session.getAttribute(WebConstant.ORG);
        List<wxAccountModel>	recording=	null;//检测批次
		List<wxAccountModel>	samNums=	null;//送检数量
		List<wxAccountModel>	sanUserNums=	null;//送检人数
	        if(depart.getDepartCode()!=null){
	        		model.setDepartCode(depart.getDepartCode());
	        		recording=	wxAccountService.selectRecordingNumByDepartCode(model);//检测批次
	        		samNums=	wxAccountService.selectSamNumByDepartCode(model);//送检数量
	        		sanUserNums=	wxAccountService.selectSamUserNumByDepartCode(model);//送检人数
	        }
        	 	page=	wxAccountService.loadDatagrid(page, model);
        	 	@SuppressWarnings("unchecked")
				List<wxAccount> wxList=(List<wxAccount>) page.getResults();
        	 	for (wxAccount wxAccount : wxList) {
        	 		String appId=wxAccount.getAccountAppid();
        	 		wxAccount.setSamNum("0");
        	 		wxAccount.setSamUserNum("0");
        	 		wxAccount.setRecordingNum("0");
					if(recording!=null){
						for (wxAccountModel record : recording) {
							if(appId.equals(record.getAccountAppid())){
								wxAccount.setRecordingNum(record.getRecordingNum());
							}
						}
					}
					if(samNums!=null){
						for (wxAccountModel samNum : samNums) {
							if(appId.equals(samNum.getAccountAppid())){
								wxAccount.setSamNum(samNum.getSamNum());
							}
						}
					}
					if(sanUserNums!=null){
						for (wxAccountModel sanUserNum : sanUserNums) {
							if(appId.equals(sanUserNum.getAccountAppid())){
								wxAccount.setSamUserNum(sanUserNum.getSamUserNum());
							}
						}	
					}
				}
        	 	page.setResults(wxList);
        	 	jsonObj.setObj(page);	
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return jsonObj;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id, HttpServletResponse response) {
    	AjaxJson jsonObject = new AjaxJson();
    	try {
    		wxAccount bean=wxAccountService.queryById(id);
    		if (bean == null) {
    			jsonObject.setSuccess(false);
    			jsonObject.setMsg("没有找到对应的记录!");
    		}
    		jsonObject.setObj(bean);
    	} catch (Exception e) {
    		log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
    	}
    	return jsonObject;
    }
    /**
     * 根据公众号appid,查询当天关注人数
     *
     * @param appid       数据记录appid
     * @param response
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("queryByAppid")
    @ResponseBody
    public AjaxJson queryByAppid(InspectionUserModel model, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
        	List<InspectionUser>	 list=inspectionUserService.selectByAppid(model);
        	List<Map<String, Object>> res = new ArrayList<Map<String, Object>>();
        	for(int i=-29;i<=0;i++){
				String ymd = DateUtil.xDayAgo(i);
				Map m = new HashMap<String, Object>();
				m.put("days", ymd);
				m.put("count", 0);
				if(list.size()==0){	//近30天无关注人数
					res.add(m);
				}else{
					for (InspectionUser inspectionUser : list) {//遍历是否有满足时间条件的
							if(inspectionUser.getDate().equals(ymd)){//时间匹配
								m.put("count", inspectionUser.getCount());
							}
					}
					res.add(m);
				}
        	}
        	jsonObject.setObj(res);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return jsonObject;
    }
    
    
    /**
     * 新增/修改用户信息方法
     *
     * @param bean
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public AjaxJson save(wxAccount bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
        	TSUser user = PublicUtil.getSessionUser();
        	Date  now=new Date();
        	bean.setUpdateBy(user.getId());
        	bean.setUpdateDate(now);
        	if(bean.getId()==null){//新增
        		bean.setCreateBy(user.getId());
        		bean.setCreateDate(now);
        		wxAccountService.insertSelective(bean);
        	}else{//更新
        		wxAccountService.updateBySelective(bean);
        	}
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
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
			wxAccountService.delete(idas);
		} catch (Exception e) {
			log.error("**************************" + e.getMessage() + e.getStackTrace());
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
		
		
}
