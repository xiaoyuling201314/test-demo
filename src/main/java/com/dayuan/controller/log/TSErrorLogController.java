package com.dayuan.controller.log;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.model.log.TSErrorLogModel;
import com.dayuan.service.log.TSErrorLogService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 错误日志Controller
 * Created by shit on 2018/6/21.
 */

@Controller
@RequestMapping("/errorLog")
public class TSErrorLogController {
    private final Logger log = Logger.getLogger(TSErrorLogController.class);

    @Autowired
    private TSErrorLogService tsErrorLogService;

    /**
     * 日志页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String list(Model model) throws Exception {
        return "/data/log/error_log";
    }

    /**
     * 数据列表
     */
    @RequestMapping("/datagrid")
    @ResponseBody
    public AjaxJson datagrid(TSErrorLogModel model, Page page, String startTime, String endTime, String keyword, String deviceType) {
        AjaxJson jsonObj = new AjaxJson();
        try {
           /* if (!StringUtil.isEmpty(keyword)) {
                keyword = new String(keyword.getBytes("iso8859-1"), "utf-8");
            }*/
            model.setStartTime(startTime);
            model.setEndTime(endTime);
            model.setKeyword(keyword);
            model.setDeviceType(deviceType);
            page = tsErrorLogService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
}
