package com.dayuan3.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dayuan.logs.aop.SystemLog;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan3.common.bean.SystemConfig;
import com.dayuan3.common.bean.SystemConfigType;
import com.dayuan3.common.model.SystemConfigModel;
import com.dayuan3.common.service.SystemConfigService;
import com.dayuan3.common.service.SystemConfigTypeService;
import com.dayuan3.common.servlet.SystemConfigServlet;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;

/**
 * 送检单位
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/system")
public class SystemConfigController extends BaseController {
    private Logger log = Logger.getLogger(SystemConfigController.class);
    @Value("${resources}")
    private String resources;
    
    @Autowired
    private SystemConfigTypeService systemConfigTypeService;
    
    @Autowired
    private SystemConfigService systemConfigService;

    /**
     * 	进入系统配置列表查看页面
     * @description
     * @param request
     * @param response
     * @return
     * @author xiaoyl
     * @date   2019年9月26日
     */
    @RequestMapping("/config")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();
        return new ModelAndView("/system/config", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(SystemConfigModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("DESC");
            model.setProjectID("1");
            page = systemConfigService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月18日
     */
    @RequestMapping(value = "/save")
    @ResponseBody
//    @SystemLog(module = "系统参数管理",methods = "新增与编辑",type = 1,serviceClass = "systemConfigService")
    public AjaxJson save(SystemConfig bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
        	bean.setConfigParam(bean.getConfigParam().replace("\r\n", "").replace("    ", ""));
            SystemConfigType typeBean=systemConfigTypeService.queryById(bean.getConfigTypeId());
        	if (bean.getId() == null) {
            	int count=systemConfigService.queryByConfigType(bean.getProjectId(),bean.getConfigTypeId());
            	if(count>0) {
            		PublicUtil.setCommonForTable(bean, false);
            		systemConfigService.updateBySelective(bean);
            	}else {
            		PublicUtil.setCommonForTable(bean, true);
            		systemConfigService.insertSelective(bean);
            	}
            } else {//修改系统参数配置
                PublicUtil.setCommonForTable(bean, false);
                systemConfigService.updateBySelective(bean);
            }
        	if(typeBean!=null) {
        		SystemConfigServlet.updateJson(typeBean.getConfigCode(), bean.getConfigParam());//更新内存中的数据
        	}
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",bean.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public ModelAndView queryById(Integer id, HttpServletResponse response) {
    	Map<String, Object> map = new HashMap<>();
        try {
        	if(id!=null) {
        		SystemConfig bean = systemConfigService.queryById(id);
        		map.put("bean", bean);
        	}
        	List<SystemConfigType> list=systemConfigTypeService.queryAll();
        	map.put("list", list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/system/add", map);
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param request
     * @param response
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @SystemLog(module = "系统参数管理",methods = "删除",type = 3,serviceClass = "systemConfigService")
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
        	SystemConfig bean=null;
        	for (Integer id : ids) {
        		bean=systemConfigService.queryById(id);
        		if(bean!=null) {
            		SystemConfigServlet.updateJson(bean.getConfigCode(), null);//更新内存中的数据
            	}
        		systemConfigService.delete(id);
			}
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


}
