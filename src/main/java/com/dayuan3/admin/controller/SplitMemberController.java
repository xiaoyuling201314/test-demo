package com.dayuan3.admin.controller;

import cn.dev33.satoken.util.SaResult;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSFunction;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.BaseModel;
import com.dayuan.model.data.TreeNode;
import com.dayuan.model.system.UserRoleModel;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.SplitMember;
import com.dayuan3.admin.service.SplitMemberService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 分账子商户编号管理 前端控制器
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-21
 */
@RestController
@RequestMapping("/splitMember")
public class SplitMemberController {

    private final Logger log = Logger.getLogger(SplitMemberController.class);

    @Autowired
    private SplitMemberService splitMemberService;


    @RequestMapping("/list")
    public ModelAndView list() {
        return new ModelAndView("/split/member/list");
    }


    @RequestMapping(value = "/datagrid")
    public AjaxJson datagrid(BaseModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = splitMemberService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return jsonObj;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id:数据记录id
     * @throws Exception
     */
    @RequestMapping("/queryById")
    public AjaxJson queryById(String id){
        AjaxJson jsonObject = new AjaxJson();
        SplitMember bean = splitMemberService.getById(id);
        if (bean == null) {
            jsonObject.setSuccess(false);
            jsonObject.setMsg("没有找到对应的记录!");
        }
        jsonObject.setObj(bean);
        return jsonObject;
    }

    /**
     * 新增/修改用户信息方法
     *
     * @param bean
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save")
    public AjaxJson save(SplitMember bean){
        AjaxJson jsonObject = new AjaxJson();
        try {
            int result = splitMemberService.mySaveOrUpdate(bean);
            if (result == -2) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("保存失败，子账户编号重复!");
            } else if (result == -1) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("保存失败!");
            }
        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    public AjaxJson delete(String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(ids)) {
                String[] ida = ids.split(",");
                Integer[] idas = new Integer[ida.length];
                for (int i = 0; i < ida.length; i++) {
                    idas[i] = Integer.parseInt(ida[i]);
                }
                splitMemberService.deleteData(PublicUtil.getSessionUser().getId(), idas);
            } else {
                jsonObj.setSuccess(false);
            }
        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

}
