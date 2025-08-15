package com.dayuan.controller.dataCheck;

import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSONObject;
import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.*;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.regulatory.BaseRegulatoryObject;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.data.BaseRegionModel;
import com.dayuan.model.data.TBImportHistoryModel;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.DataCheck.DataUnqualifiedTreatmentService;
import com.dayuan.service.data.*;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.service.task.TaskDetailService;
import com.dayuan.service.task.TaskService;
import com.dayuan.util.*;
import com.dayuan3.api.vo.check.SaveCheckDataDTO;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.*;

/**
 * 检测结果
 *
 * @author Bill
 */
@Controller
@RequestMapping("/dataCheck/recording")
public class DataCheckRecordingController extends BaseController {
    private Logger log = Logger.getLogger(DataCheckRecordingController.class);

    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private DataUnqualifiedTreatmentService treatmentService;
    @Autowired
    private TbSamplingService samplingService;
    @Autowired
    private TbSamplingDetailService samplingDetailService;
    @Autowired
    private BaseDeviceService baseDeviceService;
    @Autowired
    private BaseLedgerStockService baseLedgerStockService;
    @Autowired
    private BaseDeviceParameterService baseDeviceParameterService;
    @Autowired
    private BaseRegionService regionService;
    @Autowired
    private BaseRegulatoryObjectService regulatoryObjectService;
    @Autowired
    private TBImportHistoryService importHistoryService;
    @Autowired
    private BasePointService pointService;
    @Autowired
    private BaseRegulatoryBusinessService businessService;
    @Autowired
    private BaseFoodTypeService foodTypeService;
    @Autowired
    private BaseDetectItemService detectItemService;
//    @Autowired
//    private TbSamplingRequesterService tbSamplingRequesterService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private TaskDetailService taskDetailService;
//    @Autowired
//    private ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Autowired
    private BaseDeviceTypeService baseDeviceTypeService;
    @Value("${resources}")
    private String resources;
    @Value("${storageDirectory}")
    private String storageDirectory;

    /**
     * 进入抽样单检测结果列表
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "") String conclusion) {
        Map<String, Object> map = new HashMap<String, Object>();
        String start = "";
        String end = "";
        if (StringUtil.isNotEmpty(dateStr)) {
            start = dateStr;
            end = dateStr;
        } else {
            start = DateUtil.xDayAgo(-29);
            end = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
        }

        map.put("start", start);
        map.put("end", end);
        map.put("conclusion", conclusion);
        map.put("dataType", 0); //抽样单检测结果
        //是否显示进货数量字段
        map.put("showPurchaseNumber", SystemConfigUtil.OTHER_CONFIG == null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        return new ModelAndView("/dataCheck/list", map);
    }

    /**
     * 进入订单检测结果列表
     */
    @RequestMapping("/list2")
    public ModelAndView list2(HttpServletRequest request, HttpServletResponse response, HttpSession session, Integer taskId) {
        Map<String, Object> map = new HashMap<String, Object>();
        String start = DateUtil.xDayAgo(-29);
        String end = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
        request.setAttribute("start", start);
        request.setAttribute("end", end);

        map.put("dataType", 2); //订单检测结果
        //是否显示进货数量字段
        map.put("showPurchaseNumber", SystemConfigUtil.OTHER_CONFIG == null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        return new ModelAndView("/dataCheck/list", map);
    }

    /**
     * 新检测结果
     * 可查看数据有效性
     */
    @RequestMapping("/list3")
    public ModelAndView list3(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "") String conclusion) {
        Map<String, Object> map = new HashMap<String, Object>();
        String start = "";
        String end = "";
        if (StringUtil.isNotEmpty(dateStr)) {
            start = dateStr;
            end = dateStr;
        } else {
            start = DateUtil.xDayAgo(-29);
            end = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
        }

        map.put("start", start);
        map.put("end", end);
        map.put("conclusion", conclusion);
        map.put("dataType", 0); //抽样单检测结果
        //是否显示进货数量字段
        map.put("showPurchaseNumber", SystemConfigUtil.OTHER_CONFIG == null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        return new ModelAndView("/dataCheck/list3", map);
    }

    /**
     * 进入抽样数据上传
     */
    @RequestMapping("/upload")
    public ModelAndView upload(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/dataCheck/upload");
    }

    /**
     * 进入检测数据录入
     */
    @RequestMapping("/upload1")
    public ModelAndView upload1(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //监管对象必填，0_必填，1_非必填
            int regRequired = 0;
            JSONObject config = SystemConfigUtil.OTHER_CONFIG;
            if (config != null && config.getJSONObject("system_config") != null && config.getJSONObject("system_config").getInteger("reg_required") != null) {
                regRequired = config.getJSONObject("system_config").getInteger("reg_required");
            }

            TSUser user = PublicUtil.getSessionUser();
            List<BaseRegulatoryObject> regObjs = null;
            if (user != null) {
                regObjs = regulatoryObjectService.queryByDepartId(user.getDepartId(), "1");
            }
            //add by xiaoyl 20220622 考核功能开关：0开启，1关闭,用于手工录入完成后跳转页面判断使用
            int assessmentState = (SystemConfigUtil.GS_ASSESSMENT_CONFIG != null && SystemConfigUtil.GS_ASSESSMENT_CONFIG.containsKey("assessment_state")
                    ? SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state") : 1);
            map.put("assessmentState", assessmentState);
            map.put("regObjs", regObjs);
            map.put("user", user);
            map.put("regRequired", regRequired);
        } catch (MissSessionExceprtion e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return new ModelAndView("/dataCheck/upload1", map);
    }

    /**
     * 进入检测结果详情
     *
     * @param request
     * @param response
     * @param id       检测结果ID
     * @param source   查看来源：monitor: 实时监控；unqualified:不合格处理；默认为"",检测数据
     * @return
     */
    @RequestMapping("/checkDetail")
    public ModelAndView checkDetail(HttpServletRequest request, HttpServletResponse response, Integer id, String source, Integer showValid) {
        Map<String, Object> map = new HashMap<String, Object>();

        CheckResultModel checkResult = dataCheckRecordingService.getRecording(id);
        map.put("checkResult", checkResult);
        map.put("source", source);
//        map.put("reqUnits", reqUnits);
        //是否显示进货数量字段
        map.put("showPurchaseNumber", SystemConfigUtil.OTHER_CONFIG == null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        //是否显示有效性，0隐藏，1显示
        map.put("showValid", showValid == null ? 0 : showValid);
        return new ModelAndView("/dataCheck/checkDetail", map);
    }

    /**
     * 查询检测结果数据列表
     *
     * @param model
     * @param page
     * @param regTypeId
     * @param refrel
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(CheckResultModel model, Page page, String regTypeId, String refrel, String checkDateStartDate, String checkDateEndDate, String regIdsStr) {
        AjaxJson jsonObj = new AjaxJson();
        page.setOrder("desc");
        try {
            TSUser user = PublicUtil.getSessionUser();
            Map map = treatmentService.dataPermission(refrel);
            if (null != user.getRegId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setUserRegId((Integer) map.get("userRegId"));
            } else if (null != user.getPointId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setPointArr((Integer[]) map.get("pointArr"));
            }else if(null !=model.getDepartId()){//add by xiaoyl 2022/07/13 高级查询选择检测机构，查询所有下级机构相关的数据
                List<Integer> departArr=departService.querySonDeparts(model.getDepartId());
                model.setDepartArr(departArr.toArray(new Integer[0]));
                model.setDepartId(null);
            } else {
                model.setDepartArr((Integer[]) map.get("departArr"));
            }
            if (StringUtil.isNotEmpty(regTypeId)) {
                model.setRegTypeId(regTypeId);
            }

            //搜索时间范围
            Map<String, String> dateMap = page.getDateMap();
            if (null != dateMap) {
                String checkDateStartDateStr = dateMap.get("checkDateStartDate");
                if (null != checkDateStartDateStr && !"".equals(checkDateStartDateStr.trim())) {
                    model.setCheckDateStartDateStr(checkDateStartDateStr + " 00:00:00");
                }
                String checkDateEndDateStr = dateMap.get("checkDateEndDate");
                if (null != checkDateEndDateStr && !"".equals(checkDateEndDateStr.trim())) {
                    model.setCheckDateEndDateStr(checkDateEndDateStr + " 23:59:59");
                }
            }
            if (checkDateStartDate != null && !"".equals(checkDateStartDate.trim())) {
                model.setCheckDateStartDateStr(checkDateStartDate + " 00:00:00");
            }
            if (checkDateEndDate != null && !"".equals(checkDateEndDate.trim())) {
                model.setCheckDateEndDateStr(checkDateEndDate + " 23:59:59");
            }

            if (StringUtil.isNotEmpty(regIdsStr)) {
                String[] regIds1 = regIdsStr.split(",");
                Integer[] regIds = new Integer[regIds1.length];
                for (int i = 0; i < regIds1.length; i++) {
                    regIds[i] = Integer.parseInt(regIds1[i]);
                }
                model.setRegIds(regIds);
            }

            page = dataCheckRecordingService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 未上传检测结果抽样单数据列表(平台数据上传)
     */
    @RequestMapping(value = "/datagrid1")
    @ResponseBody
    public AjaxJson datagrid1(HttpServletRequest request, CheckResultModel model, Page page, Date samplingDateStartDate, Date samplingDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            Map map = treatmentService.dataPermission("/dataCheck/recording/upload.do");
            model.setDepartArr((Integer[]) map.get("departArr"));
            model.setPointArr((Integer[]) map.get("pointArr"));
            model.setUserRegId((Integer) map.get("userRegId"));

            if (samplingDateStartDate != null) {
                model.setCheckDateStartDateStr(DateUtil.formatDate(samplingDateStartDate, "yyyy-MM-dd 00:00:00"));
            }
            if (samplingDateEndDate != null) {
                model.setCheckDateEndDateStr(DateUtil.formatDate(samplingDateEndDate, "yyyy-MM-dd 23:59:59"));
            }

            page.setOrder("desc");
//            page = dataCheckRecordingService.loadDatagrid(page, model, DataCheckRecordingMapper.class, "loadDatagridUpload2", "getRowTotalUpload2");
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(Integer id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            DataCheckRecording bean = dataCheckRecordingService.getById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    /**
     * 删除检测结果
     *
     * @param checkData     删除数据
     * @param hasDeadline   是否有删除期限，0无，1有
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(DataCheckRecording checkData, Integer hasDeadline) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            //删除期限校验
            if (hasDeadline != null && hasDeadline == 1) {
                //考核功能开关：0开启，1关闭
                int assessmentState = (SystemConfigUtil.GS_ASSESSMENT_CONFIG != null && SystemConfigUtil.GS_ASSESSMENT_CONFIG.containsKey("assessment_state")
                        ? SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state") : 1);

                if (assessmentState == 0) {
                    //检测数据删除有效时间（小时）
                    int delHours = (SystemConfigUtil.GS_ASSESSMENT_CONFIG != null && SystemConfigUtil.GS_ASSESSMENT_CONFIG.containsKey("delate")
                            ? SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("delate") : 72);

                    DataCheckRecording dcr = dataCheckRecordingService.getById(checkData.getId());
                    Calendar c = Calendar.getInstance();
                    c.add(Calendar.HOUR_OF_DAY, -delHours);
//                    if (dcr.getParam6().intValue() == 9) {
//                        jsonObject.setSuccess(false);
//                        jsonObject.setMsg("删除失败，不允许删除造假数据！");
//                        return jsonObject;
//
//                    } else if (c.getTimeInMillis() > dcr.getCheckDate().getTime() && dcr.getParam6().intValue() == 0) {
//                        jsonObject.setSuccess(false);
//                        jsonObject.setMsg("删除失败，超出"+delHours+"小时删除期限！");
//                        return jsonObject;
//                    }
                }
            }

            //删除数据
            dataCheckRecordingService.deleteCheckData(checkData.getId());
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    /**
     * 重置检测数据同步状态
     *
     * @param id
     * @param response
     * @return
     */
    @RequestMapping("/resetUploadStatus")
    @ResponseBody
    public AjaxJson resetUploadStatus(String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            TSUser user = PublicUtil.getSessionUser();
            String[] idStrArr = id.split(",");
            Integer[] idIntArr = new Integer[idStrArr.length];
            for (int i = 0; i < idStrArr.length; i++) {
                idIntArr[i] = Integer.parseInt(idStrArr[i]);
            }
            int status = dataCheckRecordingService.resetUploadStatus(idIntArr, user.getId());
            if (status == 0) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("操作失败");
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    /**
     * 查询上传检测结果选项数据
     *
     * @param samplingDetailId 抽样单明细ID
     * @param deviceId         注册仪器ID
     * @param qt               其他仪器标识
     * @param pointId          检测点ID add by xiaoyl 2020/03/04    用于订单数据上传中根据选择检测点加载仪器
     * @return
     */
    @RequestMapping("/queryUploadData")
    @ResponseBody
    public AjaxJson queryUploadData(HttpServletResponse response, Integer samplingDetailId, String deviceId, String qt, Integer pointId) {
        AjaxJson jsonObject = new AjaxJson();
        Map<String, Object> map = new HashMap<String, Object>();
        List<BaseDevice> devices = new ArrayList<BaseDevice>();
        List<BaseDeviceParameter> deviceParameters = new ArrayList<BaseDeviceParameter>();
        try {
            if (StringUtil.isNotEmpty(samplingDetailId)) {
                TbSamplingDetail detail = samplingDetailService.getById(samplingDetailId);
                if (detail != null) {

                    TbSampling sampling = samplingService.getById(detail.getSamplingId());
                    if (StringUtil.isEmpty(deviceId)) {
                        if ("Y".equals(qt)) {
                            //其他仪器，通过检测项目获取检测模块、方法
                            deviceParameters = baseDeviceParameterService.queryByItemG(detail.getItemId());
                            for (BaseDeviceParameter deviceParameter : deviceParameters) {
                                deviceParameter.setId(null);
                            }

                            //增加其他检测模块、方法选项
                            BaseDeviceParameter qtp = new BaseDeviceParameter();
                            qtp.setProjectType("其他");
                            deviceParameters.add(qtp);

                        } else {
                            //初始化，获取仪器、检测模块、检测方法数据
                            if (sampling != null) {
                                //获取检测点仪器
                                devices = baseDeviceService.queryAllDeviceByPointId(pointId == null ? sampling.getPointId() : pointId, null, "仪器设备");

                                //无检测点仪器，通过上级机构获取仪器
//								if(devices.size()==0){
//									BasePoint point = basePointService.queryById(sampling.getPointId());
//									if(point != null)
//										devices = baseDeviceService.queryAllDeviceByPointId(null,point.getDepartId(),"仪器设备");
//								}

                                //增加其他检测仪器选项
                                BaseDevice bd = new BaseDevice();
                                bd.setDeviceName("其他");
                                devices.add(bd);

                                //获取第一台仪器检测模块和方法
                                if (devices != null && devices.size() > 0) {
                                    deviceParameters = baseDeviceParameterService.queryByDeviceItem(devices.get(0).getDeviceTypeId(), detail.getItemId());
                                }
                            }
                        }
                    } else {
                        //指定检测仪器
                        BaseDevice device = baseDeviceService.getById(deviceId);
                        if (device != null) {
                            deviceParameters = baseDeviceParameterService.queryByDeviceItem(device.getDeviceTypeId(), detail.getItemId());
                        }
                    }

                }
            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        map.put("devices", devices);
        map.put("deviceParameters", deviceParameters);
        jsonObject.setObj(map);
        return jsonObject;
    }

    /**
     * 检查抽样明细是否已上传检测数据
     *
     * @param request
     * @param response
     * @param samplingDetailId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkUploadData", method = RequestMethod.POST)
    public AjaxJson checkUploadData(HttpServletRequest request, HttpServletResponse response, Integer samplingDetailId) {
        AjaxJson ajaxObject = new AjaxJson();
        try {

//            if (StringUtil.isNotEmpty(samplingDetailId)) {
//                DataCheckRecording dc = dataCheckRecordingService.queryBySamplingDetailId(samplingDetailId);
//                if (dc == null) {
//                    ajaxObject.setSuccess(true);
//                } else {
//                    //抽样明细已上传检测数据
//                    ajaxObject.setSuccess(false);
//                }
//            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("查询失败");
        }
        return ajaxObject;
    }

    /**
     * 平台上传检测数据(有抽样单)
     */
    @ResponseBody
    @RequestMapping(value = "/uploadData", method = RequestMethod.POST)
    public AjaxJson uploadData(HttpServletRequest request, HttpServletResponse response, DataCheckRecording bean, String deviceParameterId) {
        AjaxJson ajaxObject = new AjaxJson();
        try {

            Date now = new Date();
            if (null == bean.getCheckDate()) {
                //检测时间不能为空
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能为空");
            } else if ((now.getTime() + 60 * 1000) < bean.getCheckDate().getTime()) {
                //检测时间 大于 服务器延迟一分钟后时间
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能大于当前时间");
            } else {
                //上传检测结果
                bean.setUid(UUIDGenerator.generate());    //生成ID
                TSUser user = PublicUtil.getSessionUser();
                if (user != null) {
                    bean.setCheckUserid(user.getId());
                    bean.setCheckUsername(user.getRealname());
                }
                //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
                int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
                if (spotcheck == -1) {
                    ajaxObject.setSuccess(false);
                    ajaxObject.setMsg("上传失败，请联系管理员");
                    return ajaxObject;
                }
                SaveCheckDataDTO dto = BeanUtil.toBean(bean, SaveCheckDataDTO.class);
                try {
                    BaseDeviceType deviceType = baseDeviceTypeService.queryById(deviceParameterId);
                    if (deviceType != null) {
                        dto.setDeviceCompany(deviceType.getDeviceMaker());
                        dto.setDeviceName(deviceType.getDeviceName());
                    }
                } catch (Exception e) {
                    log.error("获取设备类型信息失败", e);
                }
                // 保存检测数据
                dataCheckRecordingService.saveCheckData(dto);
//                dataCheckRecordingService.uploadData(bean, deviceParameterId, projectPath);
            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("上传失败");
        }
        return ajaxObject;
    }

    /**
     * 平台批量上传检测数据(有抽样单)
     *
     * @param ids         抽样单ID
     * @param conclusion  检测结果
     * @param checkResult 检测值
     * @param checkDate   检测时间
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/uploadData2", method = RequestMethod.POST)
    public AjaxJson uploadData2(String ids, String conclusion, String checkResult, Date checkDate) {
        AjaxJson ajaxObject = new AjaxJson();
        try {
            Date now = new Date();
            if (null == checkDate) {
                //检测时间不能为空
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能为空");
            } else if ((now.getTime() + 60 * 1000) < checkDate.getTime()) {
                //检测时间 大于 服务器延迟一分钟后时间
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能大于当前时间");
            } else {
                //上传检测结果
                String[] samplingDetailIdsStr = ids.split(",");
                List<Integer> samplingDetailIds = new ArrayList<Integer>(samplingDetailIdsStr.length);
                for (String samplingDetailIdStr : samplingDetailIdsStr) {
                    samplingDetailIds.add(Integer.parseInt(samplingDetailIdStr));
                }
                String projectPath = DataCheckRecordingController.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "");

                //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
                int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
                if (spotcheck == -1) {
                    ajaxObject.setSuccess(false);
                    ajaxObject.setMsg("上传失败，请联系管理员");
                    return ajaxObject;
                }

                dataCheckRecordingService.uploadData2(samplingDetailIds, conclusion, checkResult, checkDate, projectPath);
            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("上传失败");
        }
        return ajaxObject;
    }

    /**
     * 平台录入检测数据(无抽样单)
     */
    @ResponseBody
    @RequestMapping(value = "/uploadData1", method = RequestMethod.POST)
    public AjaxJson uploadData1(HttpServletRequest request, HttpServletResponse response, DataCheckRecording bean, @RequestParam(value = "file", required = false) MultipartFile file) {
        AjaxJson ajaxObject = new AjaxJson();
        try {
            Date now = new Date();
            if (null == bean.getCheckDate()) {
                //检测时间不能为空
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能为空");
            } else if ((now.getTime() + 60 * 1000) < bean.getCheckDate().getTime()) {
                //检测时间 大于 服务器延迟一分钟后时间
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能大于当前时间");
            } else {
                TSUser user = PublicUtil.getSessionUser();

                if (null == user.getPointId()) {
                    ajaxObject.setSuccess(false);
                    ajaxObject.setMsg("非检测点用户不可录入检测数据");
                    return ajaxObject;
                }

                bean.setUid(UUIDGenerator.generate());    //生成ID

                bean.setDepartId(user.getDepartId());
                bean.setDepartName(user.getDepartName());
                bean.setPointId(user.getPointId());
                bean.setPointName(user.getPointName());

                bean.setDataSource(3);

                if (bean.getUploadDate() == null) {
                    bean.setUploadDate(now);

                } else if ((now.getTime() + 60 * 1000) < bean.getUploadDate().getTime() || (now.getTime() - 60 * 1000) > bean.getUploadDate().getTime()) {
                    //上传时间与服务器时间误差大于一分钟，将上传时间设为服务器时间
                    bean.setUploadDate(now);
                }

                //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
                int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
                if (spotcheck == 1) {
                    ajaxObject.setSuccess(false);
                    ajaxObject.setMsg("禁止上传非抽样检测数据");
                    return ajaxObject;
                } else if (spotcheck == -1) {
                    ajaxObject.setSuccess(false);
                    ajaxObject.setMsg("上传失败，请联系管理员");
                    return ajaxObject;
                }

                //保存附件
                if (file != null && !file.isEmpty()) {
                    String filePath = "/checkVoucher/" + UUIDGenerator.generate() + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."), file.getOriginalFilename().length());
                    DyFileUtil.saveFile(file, resources + filePath);
//                    bean.setCheckVoucher(filePath);
                }

                PublicUtil.setCommonForTable(bean, true);
                dataCheckRecordingService.uploadData(bean, null, null);
            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("上传失败");
        }
        return ajaxObject;
    }

    /**
     * 平台更改检测数据
     */
    @ResponseBody
    @RequestMapping(value = "/modifiedData", method = RequestMethod.POST)
    public AjaxJson modifiedData(DataCheckRecording bean) {
        AjaxJson ajaxObject = new AjaxJson();
        try {
            TSUser user = PublicUtil.getSessionUser();
            Date now = new Date();
            if (null == bean.getCheckDate()) {
                //检测时间不能为空
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能为空");
            } else if ((now.getTime() + 60 * 1000) < bean.getCheckDate().getTime()) {
                //检测时间 大于 服务器延迟一分钟后时间
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("检测时间不能大于当前时间");
            } else {
                dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
            }

        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("上传失败");
        }
        return ajaxObject;
    }

    /**
     * 判定数据有效性
     */
    @ResponseBody
    @RequestMapping(value = "/judge", method = RequestMethod.POST)
    public AjaxJson judge(Integer rid, Integer param6, String remark) {
        AjaxJson ajaxObject = new AjaxJson();
        try {
            //考核功能开关：0开启，1关闭
            int assessmentState = (SystemConfigUtil.GS_ASSESSMENT_CONFIG != null && SystemConfigUtil.GS_ASSESSMENT_CONFIG.containsKey("assessment_state")
                    ? SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state") : 1);
            if (assessmentState == 1) {
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("操作失败，数据有效性功能未开启！");
                return ajaxObject;
            }

            int result = dataCheckRecordingService.judge(rid, param6, remark);
            if (result == -1) {
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("操作失败，数据过了有效上传时间！");
            } else if (result == 0) {
                ajaxObject.setSuccess(false);
                ajaxObject.setMsg("操作失败，没找到数据！");
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            ajaxObject.setSuccess(false);
            ajaxObject.setMsg("操作失败！");
        }
        return ajaxObject;
    }

    /**
     * 数据导出
     *
     * @param request
     * @param response
     * @param session
     * @param type           导出文件类型
     * @param model
     * @param exportDataType 导出数据类型；1_检测数据，2_台账，3_快检公示
     * @return
     */
    @RequestMapping(value = "/exportFile")
    private ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response, HttpSession session, String type,
                                              CheckResultModel model, String exportDataType, String ids, String url) {
        ResponseEntity<byte[]> responseEntity = null;
        TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        try {
            StringBuffer rootPath = new StringBuffer(resources + storageDirectory);

            if (StringUtils.isEmpty(url)) {
                url = "/dataCheck/recording/list.do";
            }
            //获取当前用户信息
            Map map = treatmentService.dataPermission(url);

            if (null != tsUser.getRegId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setUserRegId((Integer) map.get("userRegId"));
            } else if (null != tsUser.getPointId()) {
                model.setDepartArr((Integer[]) map.get("departArr"));
                model.setPointArr((Integer[]) map.get("pointArr"));
            } else {
                if (null != model.getPointId()) {//机构用户导出数据
                    model.setPointArr((Integer[]) map.get("pointId"));
                }
                model.setDepartArr((Integer[]) map.get("departArr"));
            }

            Integer taskId = (Integer) session.getAttribute("taskId");
            model.setTaskId(taskId);

            if (model.getDepartName() != null) {
                String departName = model.getDepartName().replace(",", "");
                model.setDepartName(departName);
            }
            //拼接结束时间范围
            String checkDateEndDateStr=model.getCheckDateEndDateStr();
            if (checkDateEndDateStr != null && !"".equals(checkDateEndDateStr.trim())
                    && !checkDateEndDateStr.contains("23:59:59")) {
                model.setCheckDateEndDateStr(model.getCheckDateEndDateStr() + " 23:59:59");
            }
            List<DataCheckRecording> list = null;
            if (ids != null && !"".equals(ids.trim()) && ids.split(",").length > 0) {
                String[] idsStr = ids.split(",");
                List<Integer> idsInt = new ArrayList<Integer>();
                for (String x : idsStr) {
                    idsInt.add(Integer.parseInt(x));
                }
                list = dataCheckRecordingService.listByIds(idsInt);
            } else {
//                list = dataCheckRecordingService.queryByList(model);
            }

            if ("word".equals(type)) {
                rootPath.append("checkrecording/");
                File logoSaveFile = new File(rootPath.toString());
                if (!logoSaveFile.exists()) {
                    logoSaveFile.mkdirs();
                }
                String docName = fileName + ".doc";
                ItextTools.createWordDocument(rootPath.toString(), rootPath + docName, Excel.DATACHECKRECORDING_HEADERS, list, null, request);
                responseEntity = DyFileUtil.download(request, response, rootPath.toString(), docName);
                return responseEntity;
            }


            String xlsName = fileName + ".xlsx";
            SXSSFWorkbook workbook = null;
            workbook = new SXSSFWorkbook(100);

            //导出检测数据
            if ("1".equals(exportDataType)) {
                rootPath.append("checkrecording/");
                File logoSaveFile = new File(rootPath.toString());
                if (!logoSaveFile.exists()) {
                    logoSaveFile.mkdirs();
                }
                String[] names;
                String[] attributes;
                String title = "";//标题
                if (null != SystemConfigUtil.EXPORT_CONFIG) {
                    names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("CHECKDATA").getString("names").split(",");
                    attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("CHECKDATA").getString("attributes").split(",");
                    title = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("CHECKDATA").getString("title");
                } else {
                    names = Excel.DATACHECKRECORDING_HEADERS;
                    attributes = Excel.DATACHECKRECORDING_FIELDS;
                }
                Excel.outputExcelFile(workbook, names, attributes, list, rootPath + xlsName, "1",title);
                //导出台账
            } else if ("2".equals(exportDataType)) {
                rootPath.append("ledger/");
                File logoSaveFile = new File(rootPath.toString());
                if (!logoSaveFile.exists()) {
                    logoSaveFile.mkdirs();
                }

                String[] names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("LEDGER").getString("names").split(",");
                String[] attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("LEDGER").getString("attributes").split(",");
                //一级标题
                String title = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("LEDGER").getString("title");
                //二级标题
                String subtitle = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("LEDGER").getString("subtitle");
                Excel.outputExcelFileForStandBook(workbook, title, subtitle, names, attributes, list, rootPath + xlsName, model.getPointName(), model.getCheckDateStartDateStr());

                //导出快检公示
            } else if ("3".equals(exportDataType)) {
                rootPath.append("announcement/");
                File logoSaveFile = new File(rootPath.toString());
                if (!logoSaveFile.exists()) {
                    logoSaveFile.mkdirs();
                }

                String[] names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("ANNOUNCEMENT").getString("names").split(",");
                String[] attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("ANNOUNCEMENT").getString("attributes").split(",");
                String title = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("ANNOUNCEMENT").getString("title");
                Excel.outputExcelFile(workbook, names, attributes, list, rootPath + xlsName, "1",title);
            }

            FileOutputStream fOut = new FileOutputStream(rootPath + File.separator + xlsName);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            if ("excel".equals(type)) {
                responseEntity = DyFileUtil.download(request, response, rootPath.toString(), xlsName);
            } else if ("pdf".equals(type)) {
                if (!getLicense()) {
                    return null;
                }
                Workbook wb = new Workbook(rootPath + File.separator + xlsName);
                String pdfName = fileName + ".pdf";
                wb.removeExternalLinks();
                wb.save(new FileOutputStream(new File(rootPath + pdfName)), SaveFormat.PDF);
                responseEntity = DyFileUtil.download(request, response, rootPath.toString(), pdfName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }

        return responseEntity;
    }

    public static boolean getLicense() {
        boolean result = false;
        try {
            InputStream is = BaseController.class.getClassLoader().getResourceAsStream("\\license.xml");
            License aposeLic = new License();
            aposeLic.setLicense(is);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 实时监控- 检测分布图
     *
     * @return
     * @throws Exception
     * @author LuoYX
     * @date 2018年4月24日
     */
    @RequestMapping("/checkDistribution")
    public ModelAndView checkDistribution(HttpServletRequest request) throws Exception {
        TSUser user = PublicUtil.getSessionUser();
        TSDepart depart = departService.getById(user.getDepartId());
        String[] regionIds = depart.getRegionId().split(",");
        //regionIds = ['国regionId','省regionId','市regionId','县regionId']
        String regionId = "";
        BaseRegion region = null;
        if (regionIds.length == 1) {
            //只有国regionId,看中国 34 省地图
            regionId = regionIds[0];
        } else if (regionIds.length == 2) {
            //有国regionId,省regionId，看全省市级地图
            regionId = regionIds[1];
            region = regionService.queryById(Integer.parseInt(regionId));
        } else if (regionIds.length == 3) {
            //有国regionId,省regionId,'市regionId'，看全市县级地图
            regionId = regionIds[2];
            region = regionService.queryById(Integer.parseInt(regionId));
        } else if (regionIds.length == 4) {
            //有'国regionId','省regionId','市regionId','县regionId',，看全县镇级地图(暂时没有资源)
            regionId = regionIds[3];
        }
        request.setAttribute("start", DateUtil.firstDayOfMonth());
        request.setAttribute("end", DateUtil.date_sdf.format(new Date()));
        request.setAttribute("region", region);
        request.setAttribute("regionIds", JSONObject.toJSONString(regionIds));
        return new ModelAndView("/dataCheck/checkDistribution");
    }

    /**
     * 检测分布图数据
     *
     * @param regionId   要查看地图的行政机构ID
     * @param regionName 要查看地图的行政机构行政机构名称
     * @param start      开始时间
     * @param end        结束时间
     * @param level      级别
     * @return
     * @throws Exception
     * @author LuoYX
     * @date 2018年4月26日
     */
    @RequestMapping("/checkDistributionData")
    public @ResponseBody
    AjaxJson checkDistributionData(Integer regionId, String regionName, String start, String end, Integer level) throws Exception {
        AjaxJson json = new AjaxJson();
        TSUser user = PublicUtil.getSessionUser();
        TSDepart t = departService.getById(user.getDepartId());
        List<Integer> userDepartIds = departService.querySubDeparts(t.getDepartCode());
//		List<String> userDeparts = Arrays.asList(userDepartStr.split(","));
        BaseRegion region = null;
        if (null != regionId) {
            region = regionService.queryById(regionId);
        } else {
            if (StringUtil.isNotEmpty(regionName)) {
                region = regionService.queryByRegionName(regionName);
            }
        }
        // 1. 查询 要显示的下级行政区域
        List<BaseRegion> regions = regionService.querySubRegionById(region.getRegionId());
        List<TSDepart> regionDeparts = null;

        List<BaseRegionModel> resultModel = new ArrayList<BaseRegionModel>();
        for (BaseRegion r : regions) {
            // 2. 循环行政区域，按照每个行政区域查询 是这个行政区域的 depart, 并且过滤掉不在当前登录用户机构下的 所有子机构的 depart
            //		比如： 当前登录用户的departId=1 , getChildDepartLst('1') = '1,2,3,4,5,'
            //		中国行政区下的 子行政区 = ['广东','广西'...]等 34个省、直辖市、自治区
            //		循环该 子行政区 ，(1)广东 行政区  有 [2,20,200,200...]多个depart。
            //		List<TSDepart> regionDeparts = departService.queryDepartsByRegionId(regionId);
            //		为什么能查询到以上结果？ 因为：t_s_depart表记录的region_id 是可重复的
            //		depart表：departid=2,departname=广东1, regionId=1,20,,   这里记录的regionId 实际是 ['国regionId','省regionId','市regionId','县regionId']
            //		depart表：departid=20,departname=广东2, regionId=1,20,,  考虑的是同一个地方 几期项目同时进行，会有两个机构 都同属 同一个 行政区
            //		关键是echart-map 是按行政区域显示， 而检测数据 是关联的depart表的id,  我是departid=2 的登录用户 就需要去掉 我下属机构之外的机构
            if (level == 1) {//国-省
                regionDeparts = departService.queryDepartsByRegionId(region.getRegionId() + "," + r.getRegionId() + ",,,");
            } else if (level == 2) {//省-市
                regionDeparts = departService.queryDepartsByRegionId("1," + region.getRegionId() + "," + r.getRegionId() + ",,");
            } else if (level == 3) {//市-县
                BaseRegion pregion = regionService.queryById(region.getParentId());
                regionDeparts = departService.queryDepartsByRegionId("1," + pregion.getRegionId() + "," + region.getRegionId() + "," + r.getRegionId() + ",");
            } else if (level == 4) {//县-镇
                regionDeparts = departService.queryDepartsByRegionId("1,28,326,3145,");
            }
            Set<Integer> set = new HashSet<Integer>();
            List<Integer> regIdss = new ArrayList<Integer>();
            for (int i = 0; i < regionDeparts.size(); i++) {
                TSDepart d = regionDeparts.get(i);
                if (userDepartIds.contains(d.getId())) {
                    List<Integer> subIds = departService.querySubDeparts(d.getDepartCode());
                    List<Integer> regIds = regulatoryObjectService.queryRegIdsByDepartIds(subIds);
                    set.addAll(regIds);
                }
            }
            regIdss.addAll(set);

            Map<String, Object> map = dataCheckRecordingService.queryCountByRegIds(regIdss, start, end);
            Long count = (Long) map.get("count");
            Integer qual = ((Long) map.get("qual")).intValue();
            Integer unqual = ((Long) map.get("unqual")).intValue();

            BaseRegionModel regionModel = new BaseRegionModel();
            regionModel.setRegionName(r.getRegionName());
            regionModel.setCount(count);
            regionModel.setQualCount(qual);
            regionModel.setUnqualCount(unqual);
            resultModel.add(regionModel);
        }
        json.setObj(resultModel);
        return json;
    }

    /**
     * 数据导入 List界面
     *
     * @param request
     * @return
     * @author LuoYX
     * @date 2018年5月12日
     */
    @RequestMapping("/importList")
    public ModelAndView importList(HttpServletRequest request, Integer importType) {
        request.setAttribute("importType", importType);
        return new ModelAndView("/dataCheck/importList");
    }

    /**
     * 数据导入DataList
     *
     * @param model
     * @param page
     * @return
     * @author LuoYX
     * @date 2018年5月12日
     */
    @RequestMapping("/importListData")
    public @ResponseBody
    AjaxJson importListData(TBImportHistoryModel model, Page page) {
        AjaxJson json = new AjaxJson();
        try {
            model.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            page = importHistoryService.loadDatagrid(page, model);
            json.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("操作失败");
        }
        return json;
    }

    @RequestMapping("/toImport")
    public ModelAndView toImport(HttpServletRequest request, Integer type) {
        request.setAttribute("type", type);
        return new ModelAndView("/dataCheck/toImport");
    }

    /**
     * 导入检测数据
     *
     * @param file
     * @param bean
     * @return
     * @throws MissSessionExceprtion
     * @author LuoYX
     * @date 2018年5月14日
     */
    @RequestMapping("/importData")
    public @ResponseBody
    AjaxJson importData(@RequestParam("file") MultipartFile file, TBImportHistory bean) throws MissSessionExceprtion {
        TSUser user = PublicUtil.getSessionUser();
        AjaxJson json = new AjaxJson();
        Date now = new Date();
        String resources = WebConstant.res.getString("resources");
        FileOutputStream fos = null;

        int successCount = 0;
        int failCount = 0;
        List<ImportDataCheckRecording> problems = new ArrayList<ImportDataCheckRecording>();

        try {
            String section = resources + "checkdata/";
            String fName = DateUtil.formatDate(now, "yyyyMMddHHmmssSSS") + ".xlsx";
            File f = new File(section + fName);
            if (!f.getParentFile().exists()) {
                f.getParentFile().mkdirs();
            }
            fos = FileUtils.openOutputStream(f);
            IOUtils.copy(file.getInputStream(), fos);
            TSDepart d = departService.getById(bean.getDepartId());
            //查询出机构下所有的检测点及数量
            List<Map<String, Object>> pointListMap = pointService.queryByDepartCode(d.getDepartCode(), "Y");
            //查询机构下的市场
            List<Map<String, Object>> regListMap = regulatoryObjectService.queryRegMapByDepartCode(d.getDepartCode(), "Y");
            //查询机构下的经营户
            List<Map<String, Object>> busListMap = businessService.queryBusMapByDepartCode(d.getDepartCode(), "Y");
            //查询所有的样品
            List<Map<String, Object>> foodListMap = foodTypeService.queryFoodTypeMap();
            //查询所有检测项目
            List<Map<String, Object>> itemListMap = detectItemService.queryItemMap();

            Map<String, Map<String, Object>> pointMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < pointListMap.size(); i++) {
                Map<String, Object> p = pointListMap.get(i);
                String pointKey = (String) p.get("point_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("departId", p.get("depart_id"));
                map.put("departName", p.get("depart_name"));
                map.put("count", p.get("count"));
                pointMap.put(pointKey, map);
            }
            Map<String, Map<String, Object>> regMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < regListMap.size(); i++) {
                Map<String, Object> p = regListMap.get(i);
                String regKey = (String) p.get("reg_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("regType", p.get("reg_type"));
                map.put("count", p.get("count"));
                map.put("showBusiness", p.get("show_business"));
                regMap.put(regKey, map);
            }
            Map<String, Map<String, Object>> busMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < busListMap.size(); i++) {
                Map<String, Object> p = busListMap.get(i);
                String busKey = (String) p.get("ope_shop_code") + "";
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                //map.put("regName", p.get("reg_name"));
                map.put("opeShopCode", p.get("ope_shop_code"));
                map.put("count", p.get("count"));
                busMap.put(busKey, map);
            }
            Map<String, Map<String, Object>> foodMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < foodListMap.size(); i++) {
                Map<String, Object> p = foodListMap.get(i);
                String foodKey = (String) p.get("food_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("typeId", p.get("parent_id"));
                map.put("typeName", p.get("type_name"));
                map.put("count", p.get("count"));
                foodMap.put(foodKey, map);
            }
            Map<String, Map<String, Object>> itemMap = new HashMap<String, Map<String, Object>>();
            for (int i = 0; i < itemListMap.size(); i++) {
                Map<String, Object> p = itemListMap.get(i);
                String itemKey = (String) p.get("detect_item_name");
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("id", p.get("id"));
                map.put("stdId", p.get("std_id"));
                map.put("stdCode", p.get("std_code"));
                map.put("valueUnit", p.get("detect_value_unit"));
                map.put("count", p.get("count"));
                itemMap.put(itemKey, map);
            }
            //update by xiaoyl 2019-06-05 start
            //调用create(InputStream inp) 方法，兼容xls和xlsx版本
            InputStream excelInputStream = new FileInputStream(f);
            org.apache.poi.ss.usermodel.Workbook workBook = org.apache.poi.ss.usermodel.WorkbookFactory.create(excelInputStream);
            //update by xiaoyl 2019-06-05 end
            Sheet sheet = workBook.getSheetAt(0);
            Row row = null;
            int totalRow = sheet.getLastRowNum();
            TBImportHistory t = new TBImportHistory();
            for (int i = 1; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (null == row) continue;
                if (isEmptyRow(row)) continue;
                String pointName = getCellValue(row.getCell(0));//检测点名称(必填)
                String regName = getCellValue(row.getCell(1));//被检单位(必填)
                String regUserName = getCellValue(row.getCell(2));//档口编号(非必填)，如果有与编号对应的经营户，补全经营户ID，否则只存档口编号
                String foodName = getCellValue(row.getCell(3));//样品名称(必填)
                String ckItem = getCellValue(row.getCell(4));//检测项目(必填)
                String liValue = getCellValue(row.getCell(5));//限定值
                String ckResult = getCellValue(row.getCell(6));//检测值(必填)
                String conclusion = getCellValue(row.getCell(7));//检测结论(必填)
                String ckUser = getCellValue(row.getCell(8));//检测人员(必填)
                String ckDate = getCellValue(row.getCell(9));//检测时间(必填)
                String auditor = getCellValue(row.getCell(10));//审核人员姓名
                String upUser = getCellValue(row.getCell(11));//上报人员姓名
                String deviceName = getCellValue(row.getCell(12));//检测设备名称
                String modul = getCellValue(row.getCell(13));//检测模块
                String method = getCellValue(row.getCell(14));//检测方法
                String deviceComp = getCellValue(row.getCell(15));//仪器生产厂家
                String remark = getCellValue(row.getCell(16));//备注

                if (i == 1) {
                    if (!"检测点名称".equals(pointName) || !"被检单位".equals(regName) || !"档口编号".equals(regUserName) || !"样品名称".equals(foodName) || !"检测项目".equals(ckItem) || !"检测值".equals(ckResult) || !"检测结论".equals(conclusion)) {
                        t.setRemark("导入数据的模板不正确");
                        json.setSuccess(false);
                        break;
                    }
                } else {
                    String msg = "";
                    if (StringUtil.isEmpty(pointName)) {
                        msg = "检测点不能为空";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(regName)) {
                        msg = "被检单位不能为空";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(foodName)) {
                        msg = "样品名称不能为空";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(ckItem)) {
                        msg = "检测项目不能为空";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(ckResult)) {
                        msg = "检测值不能为空";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(conclusion) || (!"合格".equals(conclusion) && !"不合格".equals(conclusion))) {
                        msg = StringUtil.isEmpty(conclusion) ? "检测结论不能为空" : "检测结论只能是合格或不合格";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(ckUser)) {
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, "检测人员姓名不能为空");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(ckDate)) {
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, "检测时间不能为空");
                        failCount++;
                        continue;
                    }
                    Date checkDate = null;
                    try {
                        if (DateUtil.checkDate(ckDate)) {
                            checkDate = DateUtil.datetimeFormat.parse(ckDate);
                        } else if (DateUtil.checkDates(ckDate)) {
                            checkDate = DateUtil.datetimeFormat2.parse(ckDate);
                        } else {
                            addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                    ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, "检测时间格式不正确");
                            failCount++;
                            continue;
                        }

                    } catch (Exception e) {
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, "检测时间格式不正确");
                        failCount++;
                        continue;
                    }

                    if (checkDate.after(now)) {
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, "检测时间不能大于当前时间");
                        failCount++;
                        continue;
                    }
                    Map<String, Object> pMap = pointMap.get(pointName);
                    if (null == pMap || (Long) pMap.get("count") > 1) {
                        msg = null == pMap ? "导入机构下查询不到检测点：[" + pointName + "]" : "导入机构下有多个检测点：[" + pointName + "]";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    Map<String, Object> rMap = regMap.get(regName);
                    if (null == rMap || (Long) rMap.get("count") > 1) {
                        msg = null == rMap ? "导入机构下查询不到监管对象：[" + regName + "]" : "导入机构下有多个监管对象：[" + regName + "]";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    Map<String, Object> bMap = null;
                    //档口编号非必填 --Dz 20210309
//                    if ("1".equals(rMap.get("showBusiness").toString())) {
//                        if (StringUtil.isEmpty(regUserName)) {
//                            msg = "档口编号不能为空";
//                            addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
//                                    ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
//                            failCount++;
//                            continue;
//                        }
//                        bMap = busMap.get(regUserName + regName);
//                        if (null == bMap) {
//                            msg = "监管对象：[" + regName + "]下查询不到档口：[" + regUserName + "]的经营户";
//                            addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
//                                    ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
//                            failCount++;
//                            continue;
//                        } else if ((Long) bMap.get("count") > 1) {
//                            msg = "监管对象：[" + regName + "]下有多个档口为：[" + regUserName + "]的经营户";
//                            addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
//                                    ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
//                            failCount++;
//                            continue;
//                        }
//                    }
                    Map<String, Object> fMap = foodMap.get(foodName);
                    if (null == fMap) {// || (Long) fMap.get("count") > 1 delete by xiaoyl 2020-04-24 绍兴平台导入数据异常处理
                        msg = null == fMap ? "食品种类中查询不到名为：[" + foodName + "]的食品" : "食品种类中有多个名为：[" + foodName + "]的食品";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }
                    Map<String, Object> iMap = itemMap.get(ckItem);
                    if (null == iMap) {//|| (Long) iMap.get("count") > 1 delete by xiaoyl 2020-04-24 绍兴平台导入数据异常处理
                        msg = null == iMap ? "查询不到名为:[" + ckItem + "]的检测项目" : "查询到有多个名为:[" + ckItem + "]的检测项目";
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, msg);
                        failCount++;
                        continue;
                    }

                    DataCheckRecording r = new DataCheckRecording();
                    r.setUid(UUIDGenerator.generate());
                    //设置 食品种类 和名称
                    r.setFoodId((Integer) fMap.get("id"));
                    r.setFoodName(foodName);

                    //设置 市场 和档口
                    r.setRegId((Integer) rMap.get("id"));
                    r.setRegName(regName);
                    r.setRegUserId(null == bMap ? null : (Integer) bMap.get("id"));
                    r.setRegUserName(regUserName);

                    //设置部门 和 检测点
                    r.setDepartId((Integer) pMap.get("departId"));
                    r.setDepartName((String) pMap.get("departName"));
                    r.setPointId((Integer) pMap.get("id"));
                    r.setPointName(pointName);
                    // 设置检测项目和 检测标准(依据)
                    r.setItemId((String) iMap.get("id"));
                    r.setItemName(ckItem);
                    r.setCheckAccordId(String.valueOf((Integer) iMap.get("stdId")));
                    r.setCheckAccord((String) iMap.get("stdCode"));
                    r.setCheckUnit((String) iMap.get("valueUnit"));
                    //设置 其他不用验证的值
                    r.setLimitValue(liValue);
                    r.setCheckResult(ckResult);
                    r.setConclusion(conclusion);
                    r.setCheckDate(checkDate);
                    r.setCheckUsername(ckUser);
                    r.setUploadDate(now);
                    r.setDeviceName(deviceName);
                    r.setDeviceCompany(deviceComp);
                    r.setDeviceModel(modul);
                    r.setDeviceMethod(method);
                    r.setReloadFlag(1);
                    r.setDataSource(4);
                    r.setStatusFalg(1);
                    r.setDeleteFlag(0);
                    r.setCreateBy(user.getId());
                    r.setUpdateBy(user.getId());
                    r.setCreateDate(now);
                    r.setUpdateDate(now);

                    try {
//                        dataCheckRecordingService.insertSelective(r);
                        //使用统一新增检测数据方法，判断数据有效性  --Dz 20220622
                        dataCheckRecordingService.saveOrUpdateDataChecking(r, user);
                        successCount++;
                    } catch (Exception e) {
                        addToProblems(problems, pointName, regName, regUserName, foodName, ckItem, liValue, ckResult, conclusion, ckUser,
                                ckDate, auditor, upUser, deviceName, modul, method, deviceComp, remark, e.getMessage());
                        failCount++;
                        continue;
                    }
                }
            }

            String errFile = null;
            SXSSFWorkbook wb = null;
            if (problems.size() > 0) {
                errFile = fName.substring(0, fName.lastIndexOf(".")) + "_err.xlsx";
                wb = new SXSSFWorkbook(500);
                Excel.outputExcelFile(wb, ImportDataCheckRecording.headers, ImportDataCheckRecording.fields, problems, section + errFile, "1","");
                FileOutputStream fOut = new FileOutputStream(section + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
            }

            t.setUserId(user.getId());
            t.setDepartId(bean.getDepartId());
            t.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            t.setDepartName(bean.getDepartName());
            t.setUsername(user.getRealname());
            t.setSourceFile("/checkdata/" + fName);
            t.setErrFile(errFile == null ? null : "/checkdata/" + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(now);
            t.setImportType(1);
            t.setEndDate(new Date());
            importHistoryService.insert(t);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            json.setSuccess(false);
            json.setMsg("导入失败！" + e.getMessage());
        }
        return json;
    }

    /**
     * 进入新模式订单数据上传
     *
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月3日
     */
    @RequestMapping("/uploadForOrder")
    public ModelAndView uploadForOrder(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/dataCheck/uploadForOrder");
    }

    /**
     * 新模式数据上传
     * 未上传检测结果抽样单数据列表(平台数据上传)
     *
     * @param model
     * @param page
     * @param samplingDateStartDate
     * @param samplingDateEndDate
     * @return
     * @description
     * @author xiaoyl
     * @date 2020年3月9日
     */
    @RequestMapping(value = "/datagridForOrder")
    @ResponseBody
    public AjaxJson datagridForOrder(CheckResultModel model, Page page, String samplingDateStartDate, String samplingDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            Map map = treatmentService.dataPermission("/dataCheck/recording/upload.do");
            model.setDepartArr((Integer[]) map.get("departArr"));
            model.setPointArr((Integer[]) map.get("pointArr"));
            model.setUserRegId((Integer) map.get("userRegId"));

            if (samplingDateStartDate != null && !"".equals(samplingDateStartDate.trim())) {
                model.setStartDateStr(samplingDateStartDate + " 00:00:00");
            }
            if (samplingDateEndDate != null && !"".equals(samplingDateEndDate.trim())) {
                model.setEndDateStr(samplingDateEndDate + " 23:59:59");
            }

            page = dataCheckRecordingService.loadDatagridForOrder(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }
/**********************************************甘肃项目-智云达检测数据查看 start*************************************************************/
    /**
     * @return
     * @Description 甘肃项目，查看智云达检测数据
     * @Date 2021/01/18 13:35
     * @Author xiaoyl
     * @Param
     */
    @RequestMapping("/list_zyd")
    public ModelAndView list_zyd(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(required = false) String dateStr, @RequestParam(required = false, defaultValue = "") String conclusion) {
        Map<String, Object> map = new HashMap<String, Object>();
        String start = "";
        String end = "";
        if (StringUtil.isNotEmpty(dateStr)) {
            start = dateStr;
            end = dateStr;
        } else {
            start = DateUtil.xDayAgo(-29);
            end = DateUtil.formatDate(new Date(), "yyyy-MM-dd");
        }

        map.put("start", start);
        map.put("end", end);
        map.put("conclusion", conclusion);
        map.put("dataType", 0); //抽样单检测结果
        //是否显示进货数量字段
        map.put("showPurchaseNumber", SystemConfigUtil.OTHER_CONFIG == null ? 0 : SystemConfigUtil.OTHER_CONFIG.getJSONObject("wx_purchase").getString("show_req"));
        return new ModelAndView("/dataCheck/list_zyd", map);
    }

    /**
     * 查看智云达检测数据详情
     *
     * @param request
     * @param response
     * @param id       检测结果ID
     * @return
     */
    @RequestMapping("/checkDetail_zyd")
    public ModelAndView checkDetail_zyd(HttpServletRequest request, HttpServletResponse response, String id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("id", id);
        return new ModelAndView("/dataCheck/checkDetail_zyd", map);
    }

    /**********************************************甘肃项目-智云达检测数据查看 end*************************************************************/

    private void addToProblems(List<ImportDataCheckRecording> problems, String pointName, String regName, String regUserName, String foodName, String ckItem, String liValue, String ckResult,
                               String conclusion, String ckUser, String ckDate, String auditor, String upUser, String deviceName, String modul, String method, String deviceComp, String remark, String errMsg) {
        ImportDataCheckRecording r = new ImportDataCheckRecording();
        r.setPointName(pointName);
        r.setRegName(regName);
        r.setRegUserName(regUserName);
        r.setFoodName(foodName);
        r.setCkItem(ckItem);
        r.setCkResult(ckResult);
        r.setLiValue(liValue);
        r.setConclusion(conclusion);
        r.setCkUser(ckUser);
        r.setCkDate(ckDate);
        r.setAuditor(auditor);
        r.setUpUser(upUser);
        r.setDeviceName(deviceName);
        r.setModul(modul);
        r.setMethod(method);
        r.setDeviceComp(deviceComp);
        r.setRemark(remark);
        r.setErrMsg(errMsg);
        problems.add(r);
    }

    public static class ImportDataCheckRecording {
        public static String[] headers = {"检测点名称", "被检单位", "档口编号", "样品名称", "检测项目", "限定值", "检测值",
                "检测结论", "检测人员", "检测时间", "审核人员姓名", "上报人员姓名", "检测设备名称", "检测模块", "检测方法", "仪器生产厂家", "备注", "导入失败原因"};
        public static String[] fields = {"pointName", "regName", "regUserName", "foodName", "ckItem", "liValue", "ckResult",
                "conclusion", "ckUser", "ckDate", "auditor", "upUser", "deviceName", "modul", "method", "deviceComp", "remark", "errMsg"};
        String errMsg;
        String pointName;//检测点名称(必填)
        String regName;//被检单位(必填)
        String regUserName;//档口编号(必填)
        String foodName;
        ;//样品名称(必填)
        String ckItem;//检测项目(必填)
        String liValue;//限定值
        String ckResult;//检测值(必填)
        String conclusion;//检测结论(必填)
        String ckUser;//检测人员(必填)
        String ckDate;//检测时间(必填)
        String auditor;//审核人员姓名
        String upUser;//上报人员姓名
        String deviceName;//检测设备名称
        String modul;//检测模块
        String method;//检测方法
        String deviceComp;//仪器生产厂家
        String remark;//备注

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }

        public String getPointName() {
            return pointName;
        }

        public void setPointName(String pointName) {
            this.pointName = pointName;
        }

        public String getRegName() {
            return regName;
        }

        public void setRegName(String regName) {
            this.regName = regName;
        }

        public String getRegUserName() {
            return regUserName;
        }

        public void setRegUserName(String regUserName) {
            this.regUserName = regUserName;
        }

        public String getFoodName() {
            return foodName;
        }

        public void setFoodName(String foodName) {
            this.foodName = foodName;
        }

        public String getCkItem() {
            return ckItem;
        }

        public void setCkItem(String ckItem) {
            this.ckItem = ckItem;
        }

        public String getCkResult() {
            return ckResult;
        }

        public void setCkResult(String ckResult) {
            this.ckResult = ckResult;
        }

        public String getLiValue() {
            return liValue;
        }

        public void setLiValue(String liValue) {
            this.liValue = liValue;
        }

        public String getConclusion() {
            return conclusion;
        }

        public void setConclusion(String conclusion) {
            this.conclusion = conclusion;
        }

        public String getCkUser() {
            return ckUser;
        }

        public void setCkUser(String ckUser) {
            this.ckUser = ckUser;
        }

        public String getCkDate() {
            return ckDate;
        }

        public void setCkDate(String ckDate) {
            this.ckDate = ckDate;
        }

        public String getAuditor() {
            return auditor;
        }

        public void setAuditor(String auditor) {
            this.auditor = auditor;
        }

        public String getUpUser() {
            return upUser;
        }

        public void setUpUser(String upUser) {
            this.upUser = upUser;
        }

        public String getDeviceName() {
            return deviceName;
        }

        public void setDeviceName(String deviceName) {
            this.deviceName = deviceName;
        }

        public String getModul() {
            return modul;
        }

        public void setModul(String modul) {
            this.modul = modul;
        }

        public String getMethod() {
            return method;
        }

        public void setMethod(String method) {
            this.method = method;
        }

        public String getDeviceComp() {
            return deviceComp;
        }

        public void setDeviceComp(String deviceComp) {
            this.deviceComp = deviceComp;
        }

        public String getRemark() {
            return remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }
    }
}
