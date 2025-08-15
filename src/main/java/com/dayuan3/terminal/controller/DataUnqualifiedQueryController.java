package com.dayuan3.terminal.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.DateUtil;
import com.dayuan3.common.bean.DataUnqualifiedModel;
import com.dayuan3.terminal.bean.DataUnqualifiedPrintlog;
import com.dayuan3.terminal.service.DataUnqualifiedPrintlogService;

/**
 * 不合格处理
 * @author xiaoyl
 * @date   2019年9月19日
 */
@Controller
@RequestMapping("/unqualified")
public class DataUnqualifiedQueryController extends BaseController {
    private Logger log = Logger.getLogger(DataUnqualifiedQueryController.class);
    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;
    @Autowired
    private DataUnqualifiedTreatmentService treatmentService;
    @Autowired
    private TbSamplingDetailService tbSamplingDetailService;

    @Autowired
    private DataUnqualifiedPrintlogService unqualifiedPrintlogService;
    @Value("${resources}")
    private String resources;


    /**
     * 进入不合格查看列表
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
    	String start = DateUtil.xDayAgo(-29);
        String end = DateUtil.date_sdf.format(new Date());
        Map<String, Object> map=new HashMap<String, Object>();
        map.put("start", start);
        map.put("end", end);
        return new ModelAndView("/terminal/unqualified/list",map);
    }


   /**
    * 查询首次检测结果不合格数据列表
    * @description
    * @param model
    * @param page
    * @param checkDateStartDate
    * @param checkDateEndDate
    * @return
    * @author xiaoyl
    * @date   2019年9月19日
    */
    @RequestMapping(value = "/loadDatagrid")
    @ResponseBody
    public AjaxJson datagrid(DataUnqualifiedModel model,  Page page, String checkDateStartDate, String checkDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
        	//获取当前用户信息
            page.setOrder("desc");
            TSUser user = PublicUtil.getSessionUser();
            Map map = treatmentService.dataPermission("/dataCheck/recording/list2");
//            model.setDepartArr((Integer[]) map.get("departArr"));
//            model.setPointArr((Integer[]) map.get("pointArr"));
            if (null != user.getRegId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setUserRegId((Integer) map.get("userRegId"));
            } else if (null != user.getPointId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setPointArr((Integer[]) map.get("pointArr"));
            } else {
                model.setDepartArr((Integer[]) map.get("departArr"));
            }
            model.setCheckDateStartDateStr(checkDateStartDate);
            model.setCheckDateEndDateStr(checkDateEndDate);

            page = treatmentService.loadDatagrid(page, model, DataUnqualifiedTreatmentMapper.class, "loadDatagridForUnqualFied", "getRowTotalUnqualFied");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
    /**
     *	 记录不合格数据打印记录
     * @description
     * @param request
     * @param response
     * @param ids
     * @return
     * @author xiaoyl
     * @date   2019年9月23日
     */
	@RequestMapping("/updatePrintLog")
	@ResponseBody
	public AjaxJson updatePrintLog(HttpServletRequest request, HttpServletResponse response, String ids) {
		AjaxJson jsonObj = new AjaxJson();
		try {
			TSUser user=PublicUtil.getSessionUser();
			if(user!=null) {
				String[] ida = ids.split(",");
				DataUnqualifiedPrintlog bean=null;
				List<DataUnqualifiedPrintlog> list=new ArrayList<DataUnqualifiedPrintlog>();
				for (String id : ida) {
					bean=new DataUnqualifiedPrintlog(Integer.valueOf(id),user.getId(), user.getUserName(), new Date());
					list.add(bean);
				}
				int count=unqualifiedPrintlogService.saveBatch(list);
				log.info("不合格打印复检单更新打印记录完成，时间："+DateUtil.yyyymmddhhmmss.format(new Date())+"更新记录数："+count);
			}else {
				jsonObj.setSuccess(false);
				jsonObj.setMsg("登录超时，请重新登录！");
			}
		} catch (Exception e) {
			log.error("***************************" + e.getMessage() + e.getStackTrace());
			e.printStackTrace();
			jsonObj.setSuccess(false);
			jsonObj.setMsg("操作失败");
		}
		return jsonObj;
	}
}
