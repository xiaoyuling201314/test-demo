package com.dayuan.controller.system;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.logs.aop.SystemLog;
import com.dayuan.model.BaseModel;
import com.dayuan.model.system.TSRoleModel;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system/scheduled")
public class ScheduledController extends BaseController {
    @Autowired
    private ScheduledService scheduledService;

    private static final Logger log = Logger.getLogger(ScheduledController.class);

    /**
     * 定时器页面
     *
     * @param model
     * @return
     * @author wtt
     * @date 2018年10月23日
     */
    @RequestMapping("/scheduledList")
    public String scheduledList(Model model) {
        try {
            //查询出所有机构和其检测点
            List<Map<String, Object>> departs = scheduledService.selectDepart();
            model.addAttribute("departs", JSON.toJSONString(departs));
        } catch (Exception e) {
            log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return "/system/scheduled/scheduled";
    }

    /**
     * 数据列表
     *
     * @param model
     * @param page
     * @return
     * @throws Exception
     * @author wtt
     * @date 2018年10月23日
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(BaseModel model, Page page) throws Exception {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("asc");
            page = scheduledService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 根据ID查询数据
     *
     * @param id
     * @return
     * @author wtt
     * @date 2018年10月23日
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            Scheduled bean = scheduledService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage());
        }
        return jsonObject;
    }

    /**
     * 新增/更新
     *
     * @param scheduled
     * @return
     * @author wtt
     * @date 2018年10月23日
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    @SystemLog(module = "定时器管理",methods = "新增与编辑",type = 1,serviceClass = "scheduledService",parameterType = "Integer",queryMethod = "selectById")
    public AjaxJson save(Scheduled scheduled) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(scheduled.getId())) {
                PublicUtil.setCommonForTable(scheduled, false);
                scheduledService.updateById(scheduled);
            } else {
                PublicUtil.setCommonForTable(scheduled, true);
                scheduledService.insertSelective(scheduled);
            }
        } catch (Exception e) {
            jsonObject.setSuccess(false);
            jsonObject.setMsg("保存失败"+e.getMessage());
            log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",scheduled.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }

    /**
     * 删除
     *
     * @param ids
     * @return
     * @author wtt
     * @date 2018年10月23日
     */
    @RequestMapping("/delete")
    @ResponseBody
    @SystemLog(module = "定时器管理",methods = "删除",type = 3,serviceClass = "scheduledService")
    public AjaxJson delete(String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            Integer[] idas = new Integer[ida.length];
            for (int i = 0; i < ida.length; i++) {
                idas[i] = Integer.parseInt(ida[i]);
            }
            scheduledService.delete(idas);
        } catch (Exception e) {
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
   /**
   * @Description 更新定时器状态
   * @Date 2023/04/07 15:03
   * @Author xiaoyl
   * @Param
   * @return
   */
    @RequestMapping(value = "/updateTaskStatus")
    @ResponseBody
    @SystemLog(module = "定时器管理",methods = "定时任务停止与开启",type = 1,serviceClass = "scheduledService",parameterType = "Integer",queryMethod = "selectById")
    public AjaxJson updateTaskStatus(Scheduled scheduled) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            PublicUtil.setCommonForTable(scheduled, false);
            scheduledService.updateBySelective(scheduled);
        } catch (Exception e) {
            jsonObject.setSuccess(false);
            jsonObject.setMsg("保存失败"+e.getMessage());
            log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        Map<String,Object> map=new HashMap<>();
        map.put("id",scheduled.getId());
        jsonObject.setAttributes(map);
        return jsonObject;
    }
}
