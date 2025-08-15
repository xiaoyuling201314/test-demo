package com.dayuan.controller.dataCheck;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.dataCheck.DataUnqualifiedRecordingLogModel;
import com.dayuan.service.DataCheck.DataUnqualifiedRecordingLogService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Description 不合格数据短信通知日志表-表：data_unqualified_recording_log
 *
 * @Author teng
 * @Date 2021/4/16 10:45
 */
@Controller
@RequestMapping("/dataCheck/unqualified/recording/log")
public class DataUnqualifiedRecordingLogController {
    private final Logger log = Logger.getLogger(DataUnqualifiedRecordingLogController.class);
    @Autowired
    private DataUnqualifiedRecordingLogService durlogService;

    /**
     * 进入操作记录列表
     *
     * @param id         data_unqualified_recording.id
     * @param sampleCode 样品编码
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model, Integer id, String sampleCode) {
        model.addAttribute("id", id);
        model.addAttribute("sampleCode", sampleCode);
        return "/dataCheck/unqualified/recording/log_list";
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(DataUnqualifiedRecordingLogModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = durlogService.loadDatagrid(page, model);
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
            TSUser sessionUser = PublicUtil.getSessionUser();
            durlogService.deleteLog(ids, sessionUser.getId());
        } catch (MissSessionExceprtion me) {
            log.error("******************************" + me.getMessage() + me.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("用户失效，请重新登录");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


}
