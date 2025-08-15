package com.dayuan.controller.dataCheck;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TbFile;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentGSMapper;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataUnqualifiedRecordingModel;
import com.dayuan.model.dataCheck.DataUnqualifiedTreatmentModel;
import com.dayuan.service.DataCheck.*;
import com.dayuan.service.data.TbFileService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.*;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.ibm.icu.text.SimpleDateFormat;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @Description 甘肃平台不合格处理相关功能
* @Date 2022/05/17 15:21
* @Author xiaoyl
* @Param
* @return
*/
@Controller
@RequestMapping("/dataCheck/unqualified/gs")
public class GSDataUnqualifiedTreatmentController extends BaseController {
    private Logger log = Logger.getLogger(GSDataUnqualifiedTreatmentController.class);
    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;
    @Autowired
    private DataCheckHistoryRecordingService dataCheckHistoryRecordingService;
    @Autowired
    private DataUnqualifiedTreatmentService treatmentService;
    @Autowired
    private GSDataUnqualifiedTreatmentService treatmentGSService;
    @Autowired
    private TbSamplingDetailService tbSamplingDetailService;
    @Autowired
    private DataUnqualifiedConfigService configService;
    @Autowired
    private TbFileService fileService;
    @Autowired
    private BaseLedgerStockService stockService;
    @Autowired
    private CommonLogUtilService logUtilService;

    @Value("${resources}")
    private String resources;
    @Value("${thumbnailPath}")
    private String thumbnailPath;//不合格取证图片缩略图
    @Autowired
    private BaseLedgerStockService baseLedgerStockService;

    /**
     * 进入不合格待处理列表
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "0") Integer queryTimeOutHandel) {
        if (StringUtil.isNotEmpty(dateStr)) {
            request.setAttribute("start", dateStr);
            request.setAttribute("end", dateStr);
        }
        request.setAttribute("queryTimeOutHandel", queryTimeOutHandel);
        return new ModelAndView("/dataCheck/unqualified/gs/list");
    }

    /**
     * 进入处理中列表
     */
    @RequestMapping("/dissentList")
    public ModelAndView dissentList(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/dataCheck/unqualified/gs/dissentList");
    }

    /**
     * 进入已处理列表
     */
    @RequestMapping("/affirmList")
    public ModelAndView affirmList(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "0") Integer queryNoneFile) {
        if (StringUtil.isNotEmpty(dateStr)) {
            request.setAttribute("start", dateStr);
            request.setAttribute("end", dateStr);
        } else {
            String start = DateUtil.xDayAgo(-29);
            String end = DateUtil.date_sdf.format(new Date());
            request.setAttribute("start", start);
            request.setAttribute("end", end);
        }
        request.setAttribute("queryNoneFile", queryNoneFile);
        return new ModelAndView("/dataCheck/unqualified/gs/affirmList");
    }
    /**
    * @Description
    * @Date 2022/05/19 14:21
    * @Author xiaoyl
    * @Param
    * @return
    */
    @RequestMapping("/affirmListFile")
    public ModelAndView affirmListFile(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "0") Integer queryNoneFile) {
        if (StringUtil.isNotEmpty(dateStr)) {
            request.setAttribute("start", dateStr);
            request.setAttribute("end", dateStr);
        } else {
            String start = DateUtil.xDayAgo(-29);
            String end = DateUtil.date_sdf.format(new Date());
            request.setAttribute("start", start);
            request.setAttribute("end", end);
        }
        request.setAttribute("queryNoneFile", queryNoneFile);
        return new ModelAndView("/dataCheck/unqualified/gs/affirmListFile");
    }
    /**
     * 查询检测结果数据列表
     *
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(CheckResultModel model, String regTypeId, @RequestParam(required = false, defaultValue = "0") Integer isQueryAllData, Page page, String treatmentDateStartDate, String treatmentDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            //获取当前用户信息
            page.setOrder("desc");
            if (isQueryAllData == 0) {
                Map map = treatmentService.dataPermission("/dataCheck/unqualified/gs/list.do");
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setPointArr((Integer[]) map.get("pointArr"));
                model.setUserRegId((Integer) map.get("userRegId"));
                if (StringUtil.isNotEmpty(regTypeId)) {
                    model.setRegTypeId(regTypeId);
                }
            }
            if (treatmentDateStartDate != null && !"".equals(treatmentDateStartDate.trim())) {
                model.setStartDateStr(treatmentDateStartDate + " 00:00:00");
            }
            if (treatmentDateEndDate != null && !"".equals(treatmentDateEndDate.trim())) {
                model.setEndDateStr(treatmentDateEndDate + " 23:59:59");
            }
            Short dealMethod = model.getDealMethod();
            //dealMethod处理状态:0 处理中 1已处理(控制列表显示关键字)
            page = dealMethod != null && dealMethod == 1 ? treatmentGSService.loadDatagrid(page, model, DataUnqualifiedTreatmentGSMapper.class, "loadDealDatagrid", "getDealRowTotal")
                    : treatmentGSService.loadDatagrid(page, model, DataUnqualifiedTreatmentGSMapper.class, "loadDatagridForGS", "getRowTotalForGS");
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
     * 进入待处理操作界面
     */
    @RequestMapping("/goHandle")
    public ModelAndView hand(HttpServletRequest request, HttpServletResponse response, Integer id) {
        //不合格处理方法
        Map<String, Object> map = new HashMap<String, Object>();
        List<DataUnqualifiedConfig> configList = configService.getList();
        CheckResultModel checkResult = treatmentGSService.getRecording(id);

        map.put("checkResult", checkResult);
        map.put("configList", configList);
        return new ModelAndView("/dataCheck/unqualified/gs/hand", map);
    }

    /**
     * 处理中-->进入待处理操作界面
     */
    @RequestMapping("/goHanding")
    public ModelAndView handing(HttpServletRequest request, HttpServletResponse response, Integer id) {
        //不合格处理方法
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<DataUnqualifiedConfig> configList = configService.getList();
            CheckResultModel checkResult = treatmentGSService.getRecording(id);
            List<DataCheckHistoryRecording> checkHistoryList = dataCheckHistoryRecordingService.selectCheckHistoryByRid(id);
            map.put("checkResult", checkResult);
            map.put("configList", configList);
            map.put("checkHistoryList", checkHistoryList);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
        }
        return new ModelAndView("/dataCheck/unqualified/gs/handling", map);
    }

    /**
     * 进入已处理结果详情
     *
     * @param id 已处理的检测数据ID
     * @return
     * @throws Exception
     */
    @RequestMapping("/handled")
    public ModelAndView handled(Integer id) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        CheckResultModel checkResult = treatmentGSService.getRecording(id);
        //根据检测数据ID查询溯源信息
        //BaseRegulatoryObject regObject =  treatmentService.selectSourceByRid(id);
        List<TbFile> unqualifiedSign = null;    //不合格处理监督人签名
        List<TbFile> unqualifiedFile = null;    //不合格处理取证文件
        if (checkResult != null) {
            /**
             已处理界面：
             有异议 送样人图片  监督人图片  根据创建时间来区分，送样人签名图片先创建
             无异议 监督人图片
             */
            unqualifiedSign = fileService.queryBySource(checkResult.getDutId(), WebConstant.FILE_TYPE2);
            unqualifiedFile = fileService.queryBySource(checkResult.getDutId(), WebConstant.FILE_TYPE3);
        }

        map.put("unqualifiedSign", unqualifiedSign);
//        add by xiaoyl 2022-03-16 不合格处理采用轮播图方式查看
        map.put("unqualifiedFile",JSON.toJSONString(unqualifiedFile));
        //delete by xiaoyl 2022-03-16 不合格处理采用轮播图方式查看
//        map.put("unqualifiedFile", unqualifiedFile);
        map.put("checkResult", checkResult);
        map.put("rId", id);
        List<DataCheckHistoryRecording> checkHistoryList = dataCheckHistoryRecordingService.selectCheckHistoryByRid(id);
        map.put("checkHistoryList", checkHistoryList);
        return new ModelAndView("/dataCheck/unqualified/gs/handled", map);
    }

    /**
    * @Description 判断不合格处理考核状态为不合规或者造假
    * @Date 2022/05/18 14:56
    * @Author xiaoyl
    * @param id      不合格处理数据ID
    * @param handledAssessment 考核状态：3 不合格，5 造假
    * @param handledRemark  备注
    * @return
    */
    @RequestMapping("/determineFraud")
    @ResponseBody
    public AjaxJson determineFraud(HttpServletRequest request, Integer id,Integer handledAssessment, String handledRemark) {
        AjaxJson aj = new AjaxJson();
        try {
            treatmentGSService.updateCheckDataAssessment(id,handledAssessment,handledRemark);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("操作失败，请联系工作人员。");
        }
        logUtilService.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_UNQUALIFIED, this.getClass().toString(), "delete",
                "删除不合格处理数据，备注：" + handledRemark, aj.isSuccess(), aj.getMsg(), request);
        return aj;
    }
    /**
     * 删除不合格处理数据
     *
     * @param request
     * @param id      不合格处理数据ID
     * @param remark  备注
     * @param delt  删除类型：1校验删除，2批量删除
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson  delete(HttpServletRequest request, String id, String remark, int delt) {
        AjaxJson aj = new AjaxJson();
        try {
            String[] ids = id.split(",");
            if (delt == 1) {
                //删除单条数据，校验是否允许删除
                CheckResultModel dealModel=treatmentGSService.queryByRid(Integer.parseInt(ids[0]));
                JSONObject jsonObject= SystemConfigUtil.GS_ASSESSMENT_CONFIG.getJSONObject("unqualified_config");
                Integer handledTime = jsonObject.getInteger("handled_delete") == null ? 3 : jsonObject.getInteger("handled_delete");//不合格处理删除有效性时间，默认为3天
                if(DateUtil.checkIsTimeOut(dealModel.getUpdateDate(),new Date(),handledTime)){
                    aj.setSuccess(false);
                    aj.setMsg("操作失败，只支持删除"+handledTime+"天内的处置数据！");
                    return aj;
                }
                treatmentGSService.deleteData(Integer.parseInt(ids[0]),remark);
                logUtilService.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_UNQUALIFIED, this.getClass().toString(), "delete",
                        "删除不合格处理数据，备注：" + remark, aj.isSuccess(), aj.getMsg(), request);

            } else if (delt == 2){
                //批量删除(内部权限)
                for (String id0 : ids) {
                    treatmentGSService.deleteData(Integer.parseInt(id0), "批量删除");
                }
                logUtilService.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_UNQUALIFIED, this.getClass().toString(), "delete",
                        "批量删除不合格处理数据", aj.isSuccess(), aj.getMsg(), request);

            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("操作失败，请联系工作人员。");
        }

        return aj;
    }

    /**
     * 激活数据
     * 数据状态：超时处置 -> 正常数据
     *
     * @param rids      检测数据RID
     * @return
     */
    @RequestMapping("/activation")
    @ResponseBody
    public AjaxJson activation(HttpServletRequest request, String rids) {
        AjaxJson aj = new AjaxJson();
        try {
            treatmentGSService.activation(rids);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("操作失败，请联系工作人员。");
        }
        logUtilService.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_UNQUALIFIED, this.getClass().toString(), "delete",
                "删除不合格处理数据，备注：", aj.isSuccess(), aj.getMsg(), request);
        return aj;
    }

}
