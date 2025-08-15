package com.dayuan.controller.data;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectMethod;
import com.dayuan.bean.data.BaseDetectModular;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDetectMethodModel;
import com.dayuan.service.data.BaseDetectMethodService;
import com.dayuan.service.data.BaseDetectModularService;
import com.dayuan.util.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 仪器检测项目参数管理 Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月17日
 */
@Controller
@RequestMapping("/data/detectMethod")
public class BaseDetectMethodController extends BaseController {
    private final Logger log = Logger.getLogger(BaseDetectMethodController.class);
    @Autowired
    private BaseDetectMethodService baseDetectMethodService;
    @Autowired
    private BaseDetectModularService baseDetectModularService;

    /**
     * 进入检测模块页面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(String detectModularId, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<>();
        BaseDetectModular detectModular = baseDetectModularService.queryById(detectModularId);
        if (detectModular != null) {
            map.put("detectModular", detectModular.getDetectModular());
        }
        map.put("detectModularId", detectModularId);
        return new ModelAndView("/data/detectMethod/list", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(BaseDetectMethodModel model, Page page, HttpServletResponse response) throws Exception {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = baseDetectMethodService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 新增/更新检测方法
     * @param bean
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(BaseDetectMethod bean) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        try {
            //在新增和编辑之前先根据检测方法名称去查询校验唯一性
            BaseDetectMethod bdm = baseDetectMethodService.selectByMethod(bean.getDetectMethod(), bean.getDetectModularId());
            if (bdm == null) {
                //新增
                if (StringUtils.isEmpty(bean.getId())) {
                    bean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(bean, true);
                    bean.setDeleteFlag((short) 0);
                    baseDetectMethodService.insertSelective(bean);

                //更新
                } else {
                    PublicUtil.setCommonForTable(bean, false);
                    baseDetectMethodService.updateBySelective(bean);
                }

            //更新
            } else if (bdm.getId().equals(bean.getId())) {
                PublicUtil.setCommonForTable(bean, false);
                baseDetectMethodService.updateBySelective(bean);

            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("检测方法已存在！");
            }

        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public AjaxJson delete(BaseDetectMethod bean, HttpServletRequest request, HttpServletResponse response) throws Exception {
        AjaxJson jsonObject = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        try {
            Date now = new Date();
            if (StringUtils.isNotEmpty(bean.getId())) {//逻辑删除
                bean.setUpdateDate(now);
                bean.setUpdateBy(user.getId());
                bean.setDeleteFlag((short) 1);
                baseDetectMethodService.updateBySelective(bean);
                jsonObject.setSuccess(true);
                jsonObject.setMsg("编辑成功！");
            } else {//没有获取到id
                jsonObject.setSuccess(false);
                jsonObject.setMsg("删除失败.");
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
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
    public AjaxJson queryById(String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        BaseDetectMethod bean = null;
        try {
            bean = baseDetectMethodService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

}
