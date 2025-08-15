package com.dayuan.controller.dataCheck;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.dataCheck.DataUnqualifiedRecordingMapper;
import com.dayuan.model.dataCheck.DataUnqualifiedRecordingModel;
import com.dayuan.service.DataCheck.DataUnqualifiedRecordingService;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 不合格处理
 *
 * @author shit
 */
@Controller
@RequestMapping("/dataCheck/unqualified/recording")
public class DataUnqualifiedRecordingController {
    private Logger log = Logger.getLogger(DataUnqualifiedRecordingController.class);
    @Autowired
    private DataUnqualifiedRecordingService recordingService;

    /**
     * 进入不合格数据列表
     */
    @RequestMapping("/list")
    public ModelAndView list() {
        return new ModelAndView("/dataCheck/unqualified/recording/list");
    }

    /**
     * 进入不合格数据历史检测列表
     */
    @RequestMapping("/history")
    public ModelAndView history(Model model, Integer id, String sampleCode) {
        model.addAttribute("id", id);
        model.addAttribute("sampleCode", sampleCode);
        return new ModelAndView("/dataCheck/unqualified/recording/history");
    }

    /**
     * 查询不合格数据的数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(DataUnqualifiedRecordingModel model, @RequestParam(required = false, defaultValue = "0") Integer isQueryAllData, Page page, String treatmentDateStartDate, String treatmentDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (isQueryAllData == 0) {
                Map map = recordingService.dataPermission("/dataCheck/unqualified/list.do");
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setPointArr((Integer[]) map.get("pointArr"));
                model.setUserRegId((Integer) map.get("userRegId"));
            }
            if (treatmentDateStartDate != null && !"".equals(treatmentDateStartDate.trim())) {
                model.setStartDateStr(treatmentDateStartDate + " 00:00:00");
            }
            if (treatmentDateEndDate != null && !"".equals(treatmentDateEndDate.trim())) {
                model.setEndDateStr(treatmentDateEndDate + " 23:59:59");
            }
            page = recordingService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    /**
     * 查询不合格数据的历史数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/history/datagrid")
    @ResponseBody
    public AjaxJson historyDatagrid(DataUnqualifiedRecordingModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = recordingService.loadDatagrid(page, model, DataUnqualifiedRecordingMapper.class, "loadDatagridHistory", "getRowTotalHistory");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 发送短信通知
     *
     * @param id     不合格数据ID
     * @param phone  电话号码，多个电话号码用逗号隔开
     * @param remark 备注信息
     * @param number 不合格条数
     * @return
     */
    @RequestMapping("/sendSms")
    @ResponseBody
    public AjaxJson save(Integer id, String phone, String remark, String number,String name) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser sessionUser = PublicUtil.getSessionUser();
            if (id == null) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("数据ID不能为空");
                return jsonObj;
            }
            if (StringUtil.isEmpty(phone)) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("手机号码不能为空");
                return jsonObj;
            }
            jsonObj = recordingService.sendUnqualifiedSmsNotice(id+"", phone, remark,name, number, sessionUser, jsonObj, 1);//发送不合格短信通知
        } catch (MissSessionExceprtion me1) {
            log.error("*************************" + me1.getMessage() + "====>" + me1.getStackTrace()[0].getClassName() + "." + me1.getStackTrace()[0].getMethodName() + ":" + me1.getStackTrace()[0].getLineNumber());
            me1.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("用户失效，请重新登录");
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败" + e.getMessage());
        }
        return jsonObj;
    }


    /**
     * 删除不合格处理数据
     *
     * @param id 不合格处理数据ID
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(Integer id) {
        AjaxJson aj = new AjaxJson();
        try {

        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("操作失败，请联系工作人员。");
        }
        return aj;
    }
}
