package com.dayuan3.terminal.controller;

import java.util.HashMap;
import java.util.Map;

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
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.model.RequesterUnitTypeModel;
import com.dayuan3.terminal.service.RequesterUnitTypeService;

/**
 * 委托单位类型管理
 * @author xiaoyl
 * @date   2020年6月30日
 */
@Controller
@RequestMapping("/requester/type")
public class RequesterUnitTypeController extends BaseController {
    private Logger log = Logger.getLogger(RequesterUnitTypeController.class);

    @Autowired
    private RequesterUnitTypeService reqTypeService;


    /**
     * 进入检测标准表页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list() {
        Map<String, Object> map = new HashMap<>();
        return new ModelAndView("/terminal/requester/type/list", map);
    }

    /**
     * 数据列表
     *
     * @param model
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(RequesterUnitTypeModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("asc");
            page = reqTypeService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(RequesterUnitType bean) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            //根据委托单位类型去查询校验其唯一性
            RequesterUnitType ru = reqTypeService.selectByName(bean.getUnitType());
            if (ru == null || bean.getId()==ru.getId()) {
                if (bean.getId() == null) {
                    PublicUtil.setCommonForTable(bean, true);
                    reqTypeService.insertSelective(bean);
                } else {
                    PublicUtil.setCommonForTable(bean, false);
                    reqTypeService.updateBySelective(bean);
                }
                CommonDataController.terminalRequestList = null;
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("委托单位类型已存在！");
            }

        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id 数据记录id
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id) {
        AjaxJson ajaxJson=new AjaxJson();
        try {
            RequesterUnitType bean = reqTypeService.queryById(id);
            ajaxJson.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return ajaxJson;
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
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
        	reqTypeService.delete(ids);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

}
