package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan3.terminal.bean.InsUnitReqUnit;
import com.dayuan3.terminal.model.InsUnitReqUnitModel;
import com.dayuan3.terminal.service.InsUnitReqUnitService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 送检单位和委托单位中间表Controller
 *
 * @author shit
 * @date 2019年01月06日
 */
@Controller
@RequestMapping("/ins_req")
public class InsUnitReqUnitController extends BaseController {
    private Logger log = Logger.getLogger(InsUnitReqUnitController.class);

    @Autowired
    private InsUnitReqUnitService insUnitReqUnitService;


    /**
     * 进入送检单位关联的委托单位页面
     *
     * @param inspId 送检单位ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/queryByInspId")
    public String queryByInspId(Model model, Integer inspId) {
        model.addAttribute("inspId", inspId);
        return "/terminal/inspection_requester/inspection_requester";
    }

    /**
     * 送检单位关联的委托单位页面-数据列表
     *
     * @param model
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagridByInspId")
    @ResponseBody
    public AjaxJson datagridByInspId(InsUnitReqUnitModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = insUnitReqUnitService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 进入送检单位关联的委托单位页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/listAll")
    public String queryAll() {
        return "/terminal/inspection_requester/listAll";
    }


    @RequestMapping(value = "/add")
    @ResponseBody
    public AjaxJson save(InsUnitReqUnit bean) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            PublicUtil.setCommonForTable(bean, true);//设置基础参数
            if (bean.getReqIds().length > 0) {
                for (Integer reqId : bean.getReqIds()) {
                    bean.setRequestId(reqId);
                    insUnitReqUnitService.insert(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }


    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param ids 要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            insUnitReqUnitService.delete(ids);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


}
