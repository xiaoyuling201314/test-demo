//package com.dayuan.controller.interfaces2;
//
//import com.alibaba.fastjson.JSONArray;
//import com.alibaba.fastjson.JSONObject;
//import com.dayuan.bean.InterfaceJson;
//import com.dayuan.bean.data.*;
//import com.dayuan.bean.dataCheck.CheckReportData;
//import com.dayuan.bean.dataCheck.DataCheckRecording;
//import com.dayuan.bean.dataCheck.DataCheckRecordingAddendum;
//import com.dayuan.bean.regulatory.BaseRegulatoryBusiness;
//import com.dayuan.bean.regulatory.BaseRegulatoryObject;
//import com.dayuan.bean.sampling.TbSampling;
//import com.dayuan.bean.sampling.TbSamplingDetail;
//import com.dayuan.bean.system.TSUser;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.common.WebConstant;
//import com.dayuan.exception.MyException;
//import com.dayuan.model.dataCheck.IDataCheckRecordingModel;
//import com.dayuan.service.DataCheck.CheckReportDataService;
//import com.dayuan.service.DataCheck.DataCheckRecordingService;
//import com.dayuan.service.data.*;
//import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//import com.dayuan.service.sampling.TbSamplingDetailService;
//import com.dayuan.service.sampling.TbSamplingService;
//import com.dayuan.service.task.TaskService;
//import com.dayuan.util.*;
//import com.dayuan3.common.util.SystemConfigUtil;
//import org.apache.commons.lang.StringUtils;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.multipart.MultipartFile;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.*;
//
///**
// * 检测数据接口
// *
// * @author Dz
// */
//@RestController
//@RequestMapping("/iDataChecking")
//public class IDataCheckController extends BaseInterfaceController {
//
//    private Logger log = Logger.getLogger(IDataCheckController.class);
//
//    @Autowired
//    private DataCheckRecordingService dataCheckRecordingService;
//    @Autowired
//    private BaseDeviceService baseDeviceService;
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//    @Autowired
//    private BaseRegulatoryObjectService baseRegulatoryObjectService;
//    @Autowired
//    private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
//    @Autowired
//    private TbSamplingService samplingService;
//    @Autowired
//    private TbSamplingDetailService samplingDetailService;
//    @Autowired
//    private BaseFoodTypeService baseFoodTypeService;
//    @Autowired
//    private TaskService taskService;
////    @Autowired
////    private WxPayService wxPayService;
//    @Autowired
//    private BasePointService basePointService;
////    @Autowired
////    private TbSamplingRequesterService tbSamplingRequesterService;
//    @Autowired
//    private CheckReportDataService reportDataService;
//    @Autowired
//    private TbFileService fileService;
//    @Autowired
//    private BaseDetectItemService itemService;
//
//    @Value("${systemUrl}")
//    private String systemUrl;
//    @Value("${filePath}")
//    private String filePath;
//
//    /**
//     * 检测结果上传 v1.1
//     *
//     * @param userToken 用户token
//     * @param results   传输的json数据
//     * @param files   附件
//     * @param outside   内外部接口标识0：外部接口，1：内部接口；默认0
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/uploadData", method = RequestMethod.POST)
//    public InterfaceJson uploadData(HttpServletRequest request, String userToken, String results,
//            MultipartFile[] files, @RequestParam(defaultValue = "0") int outside) {
//        InterfaceJson aj = new InterfaceJson();
//
//        try {
//            TSUser user = tokenExpired(userToken);    //token验证
//
//            required(user.getDepartId(), WebConstant.INTERFACE_CODE11, "数据异常，登录用户所属机构为空");
//            required(user.getPointId(), WebConstant.INTERFACE_CODE14, "非检测点用户无法上传检测数据");
//
//            required(results, WebConstant.INTERFACE_CODE1, "参数results不能为空");
//
//            List<DataCheckRecording> records = JSONArray.parseArray(results, DataCheckRecording.class);
//
//            required(records, WebConstant.INTERFACE_CODE2, "参数results不正确");
//
//            int cMinute = 5;    //上传数据检测时间可大于当前时间最大时间（分钟）限制
//
//            int successNum = 0;    //上传成功条数
//            int failNum = 0;        //上传失败条数
//
//            List<Map<String, Object>> failRecords = new ArrayList<Map<String, Object>>();    //失败信息数组
//            Map<String, Object> errMap = null;    //失败信息
//            InterfaceJson aj1 = null;
//
//            switch (outside) {
//                //外部接口
//                case 0:
//                    for (DataCheckRecording bean : records) {
//                        aj1 = new InterfaceJson();
//                        try {
//                            //必填验证
//                            required(bean.getId(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//
//                            //电子抽样检测数据
//                            if (bean.getSamplingDetailId() != null ) {
//                                TbSamplingDetail samplingDetail = samplingDetailService.queryById(bean.getSamplingDetailId());
//                                if (samplingDetail == null) {
//                                    throw new MyException("没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", "没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", WebConstant.INTERFACE_CODE5);
//                                }
//                                bean.setSamplingId(samplingDetail.getSamplingId());
//
//                                TbSampling sampling = samplingService.getById(samplingDetail.getSamplingId());
//                                if (sampling.getRegId() !=null && bean.getRegId() != null && sampling.getRegId().intValue() != bean.getRegId().intValue()) {
//                                    throw new MyException("regId与抽样信息不一致", "regId与抽样信息不一致", WebConstant.INTERFACE_CODE2);
//                                }
//                                if (!sampling.getRegName().equals(bean.getRegName())) {
//                                    throw new MyException("regName与抽样信息不一致", "regName与抽样信息不一致", WebConstant.INTERFACE_CODE2);
//                                }
//                                if ((sampling.getOpeId() == null && bean.getRegUserId() != null)
//                                        || (sampling.getOpeId() != null && bean.getRegUserId() == null)
//                                        || (sampling.getOpeId() != null && sampling.getOpeId().intValue() != bean.getRegUserId().intValue()) ) {
//                                    throw new MyException("regUserId与抽样信息不一致", "regUserId与抽样信息不一致", WebConstant.INTERFACE_CODE2);
//                                }
//                                if (!sampling.getOpeShopCode().equals(bean.getRegUserName())) {
//                                    throw new MyException("regUserName与抽样信息不一致", "regUserName与抽样信息不一致", WebConstant.INTERFACE_CODE2);
//                                }
//
//                                if (null == bean.getCheckDate()) {
//                                    //检测时间不能为空
//                                    throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//                                } else if (sampling.getSamplingDate().getTime() > bean.getCheckDate().getTime()){
//                                    throw new MyException("检测时间不能小于抽样时间", "检测时间不能小于抽样时间", WebConstant.INTERFACE_CODE3);
//                                }
//
//                                //非电子抽样检测数据
//                            } else {
//                                required(bean.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
//                                required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//                                BaseFoodType food = baseFoodTypeService.queryById(bean.getFoodId());
//                                required(food, WebConstant.INTERFACE_CODE2, "没有找到foodId为"+bean.getFoodId()+"的数据");
//                                required(food.getIsFood() == 1, WebConstant.INTERFACE_CODE2, "检测样品不能是食品类别");
//                                required(food.getFoodName().equals(bean.getFoodName()), WebConstant.INTERFACE_CODE2, "foodId和foodName不匹配，请更新基础数据");
//
//                                required(bean.getItemId(), WebConstant.INTERFACE_CODE1, "参数itemId不能为空");
//                                required(bean.getItemName(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
//                                BaseDetectItem item = itemService.queryById(bean.getItemId());
//                                required(item, WebConstant.INTERFACE_CODE2, "没有找到itemId为"+bean.getItemId()+"的数据");
//                                required(item.getDetectItemName().equals(bean.getItemName()), WebConstant.INTERFACE_CODE2, "itemId和itemName不匹配，请更新基础数据");
//
//                                required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//                                required(bean.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
//                                BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(bean.getRegId());
//                                required(regObj, WebConstant.INTERFACE_CODE2, "没有找到regId为"+bean.getRegId()+"的数据");
//                                required(regObj.getRegName().equals(bean.getRegName()), WebConstant.INTERFACE_CODE2, "regId和regName不匹配，请更新基础数据");
//
//                                if (bean.getRegUserId() != null) {
//                                    BaseRegulatoryBusiness regBus = baseRegulatoryBusinessService.queryById(bean.getRegUserId());
//                                    required(regBus, WebConstant.INTERFACE_CODE2, "没有找到regUserId为"+bean.getRegUserId()+"的数据");
//                                    required(bean.getRegId().equals(regBus.getRegId()), WebConstant.INTERFACE_CODE2, "regId和regUserId不匹配");
//                                    required(bean.getRegUserName().equals(regBus.getOpeShopCode()), WebConstant.INTERFACE_CODE2, "regUserId和regUserName不匹配，请更新基础数据");
//                                }
//                            }
//
//                            required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                            required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                            if (!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
//                                throw new MyException("参数conclusion错误，只能是合格或不合格", "参数conclusion错误，只能是合格或不合格", WebConstant.INTERFACE_CODE2);
//                            }
//
//                            bean.setDepartId(user.getDepartId());
//                            bean.setDepartName(user.getDepartName());
//                            bean.setPointId(user.getPointId());
//                            bean.setPointName(user.getPointName());
//
//                            if (null == bean.getCheckDate()) {
//                                //检测时间不能为空
//                                throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//
//                            } else if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                                //检测时间不能大于当前时间
//                                throw new MyException("检测时间不能大于当前时间", "检测时间不能大于当前时间", WebConstant.INTERFACE_CODE3);
//                            }
//
//                            //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
//                            int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
//                            if (spotcheck == 1) {
//                                required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");
//                            } else if (spotcheck == -1) {
//                                aj.setResultCode(WebConstant.INTERFACE_CODE14);
//                                aj.setMsg("上传失败，请联系管理员");
//                                return aj;
//                            }
//
//                            //设置为抽样单检测结果
//                            bean.setDataType((short) 0);
//                            //设置为外部数据
//                            bean.setDataSource((short) 5);
//
//                            // 根据仪器ID查询仪器信息
//                            if (StringUtil.isNotEmpty(bean.getDeviceId())) {
//                                BaseDevice device = baseDeviceService.queryBySerialNumber(bean.getDeviceId());
//                                if (device != null) {
//                                    bean.setDeviceId(device.getId());
//                                    bean.setDeviceName(device.getDeviceName());
//                                }
//                            }
//
//                            //检测人员
//                            if (null == bean.getCheckUsername() || "".equals(bean.getCheckUsername().trim())) {
//                                bean.setCheckUserid(user.getId());
//                                bean.setCheckUsername(user.getRealname());
//                            }
//
//                            //新增/重传检测数据
//                            dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                            successNum++;    //上传成功数量+1
//
//                        } catch (MyException e) {
//                            setAjaxJson(aj1, e.getCode(), e.getText());
//                            //记录上传检测数据失败原因
//                            errMap = new HashMap<String, Object>();
//                            errMap.put("id", bean.getId());
//                            errMap.put("errMsg", aj1.getMsg());
//                            failRecords.add(errMap);
//                            failNum++;    //上传失败数量+1
//
//                        } catch (Exception e) {
//                            log.error("*****上传检测数据失败[id:"+bean.getId()+"]，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
////                            setAjaxJson(aj1, WebConstant.INTERFACE_CODE11, "请确认参数无误");
//
//                            //记录上传检测数据失败原因
//                            errMap = new HashMap<String, Object>();
//                            errMap.put("id", bean.getId());
//                            if (e.getMessage().contains("reload_id")) {
//                                errMap.put("errMsg", "上传失败，ID["+bean.getId()+"]重复");
//                            } else {
////                                errMap.put("errMsg", e.getMessage());
//                                errMap.put("errMsg", "请确认参数无误");
//                            }
//                            failRecords.add(errMap);
//                            failNum++;    //上传失败数量+1
//                        }
//                    }
//
//                    break;
//
//                //内部接口
//                case 1:
//
//                    //保存附件路径
//                    String[] filePaths = null;
//                    if (files != null && files.length >0) {
//                        filePaths = new String[files.length];
//                    }
//
//                    for (DataCheckRecording bean : records) {
//                        aj1 = new InterfaceJson();
//                        try {
//                            //必填验证
//                            required(bean.getId(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//
//                            required(bean.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
//                            required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//
//                            required(bean.getItemId(), WebConstant.INTERFACE_CODE1, "参数itemId不能为空");
//                            required(bean.getItemName(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
//
//                            required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                            required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                            if (!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
//                                throw new MyException("参数conclusion错误，只能是合格或不合格", "参数conclusion错误，只能是合格或不合格", WebConstant.INTERFACE_CODE2);
//                            }
//
//                            required(bean.getDataSource(), WebConstant.INTERFACE_CODE1, "参数dataSource不能为空");
//
////						required(bean.getDepartId(), WebConstant.INTERFACE_CODE1, "参数departId不能为空");
////						required(bean.getDepartName(), WebConstant.INTERFACE_CODE1, "参数departName不能为空");
////						required(bean.getPointId(), WebConstant.INTERFACE_CODE1, "参数pointId不能为空");
////						required(bean.getPointName(), WebConstant.INTERFACE_CODE1, "参数pointName不能为空");
//
//                            bean.setDepartId(user.getDepartId());
//                            bean.setDepartName(user.getDepartName());
//                            bean.setPointId(user.getPointId());
//                            bean.setPointName(user.getPointName());
//
//                            //样品来源标识为空，默认为抽样单检测结果
//                            if (bean.getSamplingId() != null) {
//                                TbSampling tsamp = samplingService.getById(bean.getSamplingId());
//                                if (tsamp != null && tsamp.getPersonal() == 1) {
//                                    bean.setDataType((short) 1);
//                                } else {
//                                    bean.setDataType((short) 0);
//                                }
//                            } else {
//                                bean.setDataType((short) 0);
//                            }
//
//                            //抽样单检测数据验证市场ID、名称
//                            if (bean.getDataType() == 0) {
//                                required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//                                required(bean.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
//                            }
//
//                            if (bean.getRegId() != null) {
//                                BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(bean.getRegId());
//                                required(regObj, WebConstant.INTERFACE_CODE2, "regId不存在");
//                            }
//                            if (bean.getRegUserId() != null) {
//                                BaseRegulatoryBusiness regBus = baseRegulatoryBusinessService.queryById(bean.getRegUserId());
//                                required(regBus, WebConstant.INTERFACE_CODE2, "regUserId不存在");
//                                required(bean.getRegId().equals(regBus.getRegId()), WebConstant.INTERFACE_CODE2, "regId和regUserId不匹配");
//                            }
//
//                            if (null == bean.getCheckDate()) {
//                                //检测时间不能为空
//                                throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//
//                            } else if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                                //检测时间大于最大时间限制
//                                throw new MyException("检测时间不能大于当前时间", "检测时间不能大于当前时间", WebConstant.INTERFACE_CODE3);
//                            }
//
//                            //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
//                            int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
//                            if (spotcheck == 1) {
//                                required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");
//                            } else if (spotcheck == -1) {
//                                aj.setResultCode(WebConstant.INTERFACE_CODE14);
//                                aj.setMsg("上传失败，请联系管理员");
//                                return aj;
//                            }
//
//                            // 根据仪器ID查询仪器信息
//                            if (StringUtil.isNotEmpty(bean.getDeviceId())) {
//                                BaseDevice device = baseDeviceService.queryBySerialNumber(bean.getDeviceId());
//                                if (device != null) {
//                                    bean.setDeviceId(device.getId());
//                                    bean.setDeviceName(device.getDeviceName());
//                                }
//                            }
//
//                            //检测人员
//                            if (null == bean.getCheckUsername() || "".equals(bean.getCheckUsername().trim())) {
//                                bean.setCheckUserid(user.getId());
//                                bean.setCheckUsername(user.getRealname());
//                            }
//
//                            //新增/重传检测数据
//                            dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                            successNum++;    //上传成功数量+1
//
//                            //保存附件
//                            if (files != null && files.length >0) {
//                                for (int i=0; i<files.length; i++) {
//                                    //文件目录
//                                    String fPath1 = filePath + "check/";
//
//                                    if (null == filePaths[i] || "".equals(filePaths[i].trim())) {
//                                        //重新生成文件名
//                                        String fName1 = UUIDGenerator.generate()+ DyFileUtil.getFileExtension(files[i].getOriginalFilename());
//                                        //保存附件
//                                        String fileName1 = uploadFile(request, fPath1, files[i], fName1);
//
//                                        filePaths[i] = fileName1;
//                                    }
//
//                                    TbFile tbFile = new TbFile();
//                                    tbFile.setFileName(filePaths[i]);
//                                    tbFile.setSourceId(bean.getRid());
//                                    tbFile.setSourceType("check");
//                                    tbFile.setFilePath(fPath1 + filePaths[i]);
//                                    tbFile.setSorting((short) 0);
//                                    tbFile.setDeleteFlag((short) 0);
//                                    PublicUtil.setCommonForTable(tbFile, true, user);
//                                    fileService.insert(tbFile);
//                                }
//                            }
//
//
//                        } catch (MyException e) {
//                            setAjaxJson(aj1, e.getCode(), e.getText());
//                            //记录上传检测数据失败原因
//                            errMap = new HashMap<String, Object>();
//                            errMap.put("id", bean.getId());
//                            errMap.put("errMsg", aj1.getMsg());
//                            failRecords.add(errMap);
//                            failNum++;    //上传失败数量+1
//
//                        } catch (Exception e) {
//                            log.error("*****上传检测数据失败[id:"+bean.getId()+"]，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
////                            setAjaxJson(aj1, WebConstant.INTERFACE_CODE11, "操作失败！", e);
////                            setAjaxJson(aj1, WebConstant.INTERFACE_CODE11, "请确认参数无误");
//
//                            //记录上传检测数据失败原因
//                            errMap = new HashMap<String, Object>();
//                            errMap.put("id", bean.getId());
//                            if (e.getMessage().contains("reload_id")) {
//                                errMap.put("errMsg", "上传失败，ID["+bean.getId()+"]重复");
//                            } else {
////                                errMap.put("errMsg", e.getMessage());
//                                errMap.put("errMsg", "请确认参数无误");
//                            }
//                            failRecords.add(errMap);
//                            failNum++;    //上传失败数量+1
//                        }
//                    }
//                    break;
//
//                default:
//                    throw new MyException("参数:outside：" + outside + "未定义", "参数:outside：" + outside + "未定义", WebConstant.INTERFACE_CODE4);
//            }
//
//            //返回结果
//            Map<String, Object> resultMap = new HashMap<String, Object>();
//            resultMap.put("successNum", successNum);
//            resultMap.put("failNum", failNum);
//            resultMap.put("failRecords", failRecords);
//            aj.setObj(resultMap);
//
//            //返回值提示 20220525
//            String tips = "";
//            if (successNum > 0) {
//                tips = "上传成功"+ successNum + "条";
//            }
//            if (failNum > 0) {
//                if (!StringUtils.isEmpty(tips)) {
//                    tips += "；失败"+ failNum + "条";
//
//                } else {
//                    tips += "上传失败"+ failNum + "条";
//                }
//            }
//            aj.setMsg(tips);
//
//        } catch (MyException e) {
//            setAjaxJson(aj, e.getCode(), e.getText());
//        } catch (Exception e) {
//            log.error("*****上传检测数据失败，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//        }
//
//        return aj;
//
//    }
//
//    /**
//     * 上传检测结果，不校验样品和检测项目 v1.3
//     * @param userToken 用户token
//     * @param results   传输的json数据
//     * @param checkReg  校验被检单位：0_不校验，1_校验
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/uploadUcData", method = RequestMethod.POST)
//    public InterfaceJson uploadUcData(String userToken, String results, @RequestParam(defaultValue = "1") int checkReg) {
//        InterfaceJson aj = new InterfaceJson();
//
//        try {
//            TSUser user = tokenExpired(userToken);
//
//            required(user.getDepartId(), WebConstant.INTERFACE_CODE11, "数据异常，登录用户所属机构为空");
//            required(user.getPointId(), WebConstant.INTERFACE_CODE14, "非检测点用户无法上传检测数据");
//
//            required(results, WebConstant.INTERFACE_CODE1, "参数results不能为空");
//
//            List<DataCheckRecording> records = JSONArray.parseArray(results, DataCheckRecording.class);
//
//            required(records, WebConstant.INTERFACE_CODE2, "参数results不正确");
//
//            int cMinute = 5;    //上传数据检测时间可大于当前时间最大时间（分钟）限制
//
//            int successNum = 0;    //上传成功条数
//            int failNum = 0;        //上传失败条数
//
//            List<Map<String, Object>> failRecords = new ArrayList<Map<String, Object>>();    //失败信息数组
//            Map<String, Object> errMap = null;    //失败信息
//            InterfaceJson aj1 = null;
//
//            for (DataCheckRecording bean : records) {
//                aj1 = new InterfaceJson();
//                try {
//                    bean.setSamplingId(null);
//                    bean.setSamplingDetailId(null);
//
//                    bean.setDepartId(user.getDepartId());
//                    bean.setDepartName(user.getDepartName());
//                    bean.setPointId(user.getPointId());
//                    bean.setPointName(user.getPointName());
//
//                    if (bean.getDataType() == null || (bean.getDataType().intValue()!=0 && bean.getDataType().intValue()!=1)) {
//                        bean.setDataType((short) 0);
//                    }
//                    if (bean.getDataSource() == null) {
//                        bean.setDataSource((short) 5);
//                    }
//
//                    //必填验证
//                    required(bean.getId(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//
//                    required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//                    BaseFoodType food = baseFoodTypeService.queryByFoodName(bean.getFoodName(), null);
//                    if (food != null) {
//                        bean.setFoodId(food.getId());
//                    } else {
//                        bean.setFoodId(null);
//                    }
//
//                    required(bean.getItemName(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
//                    List<BaseDetectItem> items = itemService.queryByItemName(bean.getItemName());
//                    if (items!=null && items.size()>0) {
//                        bean.setItemId(items.get(0).getId());
//                    } else {
//                        bean.setItemId(null);
//                    }
//
//                    //不校验被检单位
//                    if (checkReg == 0) {
//                        if (bean.getRegId() != null) {
//                            BaseRegulatoryObject reg = baseRegulatoryObjectService.queryById(bean.getRegId().intValue());
//                            if (reg != null && !reg.getRegName().equals(bean.getRegName())) {
//                                bean.setRegId(null);
//                            }
//                        }
//                        if (bean.getRegUserId() != null) {
//                            BaseRegulatoryBusiness bus = baseRegulatoryBusinessService.queryById(bean.getRegUserId().intValue());
//                            if (bus != null && !bus.getOpeShopCode().equals(bean.getRegUserName())) {
//                                bean.setRegUserId(null);
//                            }
//                        }
//
//                    //校验被检单位
//                    } else {
//                        //送样单可不校验
//                        if (bean.getDataType().intValue()==0 || bean.getRegUserId() != null) {
//                            required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//                            required(bean.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
//                            BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(bean.getRegId());
//                            required(regObj, WebConstant.INTERFACE_CODE2, "没有找到regId为"+bean.getRegId()+"的数据");
//                            required(regObj.getRegName().equals(bean.getRegName()), WebConstant.INTERFACE_CODE2, "regId和regName不匹配，请更新基础数据");
//                        }
//
//                        if (bean.getRegUserId() != null) {
//                            BaseRegulatoryBusiness regBus = baseRegulatoryBusinessService.queryById(bean.getRegUserId());
//                            required(regBus, WebConstant.INTERFACE_CODE2, "没有找到regUserId为"+bean.getRegUserId()+"的数据");
//                            required(bean.getRegId().equals(regBus.getRegId()), WebConstant.INTERFACE_CODE2, "regId和regUserId不匹配");
//                            required(bean.getRegUserName().equals(regBus.getOpeShopCode()), WebConstant.INTERFACE_CODE2, "regUserId和regUserName不匹配，请更新基础数据");
//                        }
//                    }
//
//                    required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                    required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                    if (!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
//                        throw new MyException("参数conclusion错误，只能是合格或不合格", "参数conclusion错误，只能是合格或不合格", WebConstant.INTERFACE_CODE2);
//                    }
//
//                    if (null == bean.getCheckDate()) {
//                        //检测时间不能为空
//                        throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//
//                    } else if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                        //检测时间不能大于当前时间
//                        throw new MyException("检测时间不能大于当前时间", "检测时间不能大于当前时间", WebConstant.INTERFACE_CODE3);
//                    }
//
//                    //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
//                    int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
//                    if (spotcheck == 1) {
//                        required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");
//                    } else if (spotcheck == -1) {
//                        aj.setResultCode(WebConstant.INTERFACE_CODE14);
//                        aj.setMsg("上传失败，请联系管理员");
//                        return aj;
//                    }
//
//                    // 根据仪器ID查询仪器信息
//                    if (StringUtil.isNotEmpty(bean.getDeviceId())) {
//                        BaseDevice device = baseDeviceService.queryBySerialNumber(bean.getDeviceId());
//                        if (device != null) {
//                            bean.setDeviceId(device.getId());
//                            bean.setDeviceName(device.getDeviceName());
//                        }
//                    }
//
//                    //检测人员
//                    if (StringUtils.isBlank(bean.getCheckUsername())) {
//                        bean.setCheckUserid(user.getId());
//                        bean.setCheckUsername(user.getRealname());
//                    }
//
//                    //新增/重传检测数据
//                    dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                    //上传成功数量+1
//                    successNum++;
//
//                } catch (MyException e) {
//                    setAjaxJson(aj1, e.getCode(), e.getText());
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    errMap.put("errMsg", aj1.getMsg());
//                    failRecords.add(errMap);
//                    //上传失败数量+1
//                    failNum++;
//
//                } catch (Exception e) {
//                    log.error("*****上传检测数据失败[id:"+bean.getId()+"]，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    if (e.getMessage().contains("reload_id")) {
//                        errMap.put("errMsg", "上传失败，ID["+bean.getId()+"]重复");
//                    } else {
//                        errMap.put("errMsg", "请确认参数无误");
//                    }
//                    failRecords.add(errMap);
//                    //上传失败数量+1
//                    failNum++;
//                }
//            }
//
//            //返回结果
//            Map<String, Object> resultMap = new HashMap<String, Object>();
//            resultMap.put("successNum", successNum);
//            resultMap.put("failNum", failNum);
//            resultMap.put("failRecords", failRecords);
//            aj.setObj(resultMap);
//
//            //返回值提示 20220525
//            String tips = "";
//            if (successNum > 0) {
//                tips = "上传成功"+ successNum + "条";
//            }
//            if (failNum > 0) {
//                if (!StringUtils.isEmpty(tips)) {
//                    tips += "；失败"+ failNum + "条";
//
//                } else {
//                    tips += "上传失败"+ failNum + "条";
//                }
//            }
//            aj.setMsg(tips);
//
//        } catch (MyException e) {
//            setAjaxJson(aj, e.getCode(), e.getText());
//        } catch (Exception e) {
//            log.error("*****上传检测数据失败，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//        }
//
//        return aj;
//    }
//
//
//
//    /**
//     * 检测结果上传 v1.4（抽样上传专用）
//     *
//     * @param userToken 用户token
//     * @param results   传输的json数据
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/uSamCd", method = RequestMethod.POST)
//    public InterfaceJson uSamCd(HttpServletRequest request, String userToken, String results) {
//        InterfaceJson aj = new InterfaceJson();
//
//        try {
//            TSUser user = tokenExpired(userToken);    //token验证
//
//            required(user.getDepartId(), WebConstant.INTERFACE_CODE11, "数据异常，登录用户所属机构为空");
//            required(user.getPointId(), WebConstant.INTERFACE_CODE14, "非检测点用户无法上传检测数据");
//
//            required(results, WebConstant.INTERFACE_CODE1, "参数results不能为空");
//
//            List<DataCheckRecording> records = JSONArray.parseArray(results, DataCheckRecording.class);
//
//            required(records, WebConstant.INTERFACE_CODE2, "参数results不正确");
//
//            int cMinute = 5;    //上传数据检测时间可大于当前时间最大时间（分钟）限制
//
//            int successNum = 0;    //上传成功条数
//            int failNum = 0;        //上传失败条数
//
//            List<Map<String, Object>> failRecords = new ArrayList<Map<String, Object>>();    //失败信息数组
//            Map<String, Object> errMap = null;    //失败信息
//            InterfaceJson aj1 = null;
//
//            for (DataCheckRecording bean : records) {
//                aj1 = new InterfaceJson();
//                try {
//                    //必填验证
//                    required(bean.getId(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//
//                    required(bean.getSamplingId(), WebConstant.INTERFACE_CODE1, "参数samplingId不能为空");
//                    required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "参数samplingDetailId不能为空");
//
//                    TbSamplingDetail samplingDetail = samplingDetailService.queryById(bean.getSamplingDetailId());
//                    if (samplingDetail == null) {
//                        throw new MyException("没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", "没有找到samplingDetailId为"+bean.getSamplingDetailId()+"的数据", WebConstant.INTERFACE_CODE5);
//                    }
//                    required((bean.getSamplingId().intValue() == samplingDetail.getSamplingId().intValue()), WebConstant.INTERFACE_CODE2, "无效数据，samplingId和samplingDetailId不关联");
//
//                    TbSampling sampling = samplingService.getById(samplingDetail.getSamplingId());
//
//                    bean.setRegId(sampling.getRegId());
//                    bean.setRegName(sampling.getRegName());
//                    bean.setRegUserId(sampling.getOpeId());
//                    bean.setRegUserName(sampling.getOpeShopCode());
//
//                    bean.setFoodId(samplingDetail.getFoodId());
//                    bean.setFoodName(samplingDetail.getFoodName());
//                    bean.setItemId(samplingDetail.getItemId());
//                    bean.setItemName(samplingDetail.getItemName());
//
//                    bean.setDepartId(user.getDepartId());
//                    bean.setDepartName(user.getDepartName());
//                    bean.setPointId(user.getPointId());
//                    bean.setPointName(user.getPointName());
//
//                    //设置为抽样单检测结果
//                    bean.setDataType((short) 0);
//
//                    //数据来源： 0：检测工作站； 1：仪器上传监； 2：客户端APP上传； 3：平台录入； 4：导入； 5：外部仪器上传，后台通过outside标识判断
//                    required(bean.getDataSource(), WebConstant.INTERFACE_CODE1, "参数dataSource不能为空");
//                    if (bean.getDataSource().intValue() != 0
//                            && bean.getDataSource().intValue() != 1
//                            && bean.getDataSource().intValue() != 2
//                            && bean.getDataSource().intValue() != 3
//                            && bean.getDataSource().intValue() != 4
//                            && bean.getDataSource().intValue() != 5) {
//                        throw new MyException("未知数据来源", "未知数据来源", WebConstant.INTERFACE_CODE4);
//                    }
//
//                    required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                    required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                    if (!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
//                        throw new MyException("参数conclusion错误，只能是合格或不合格", "参数conclusion错误，只能是合格或不合格", WebConstant.INTERFACE_CODE2);
//                    }
//
//                    if (null == bean.getCheckDate()) {
//                        //检测时间不能为空
//                        throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//
//                    } else if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                        //检测时间大于最大时间限制
//                        throw new MyException("检测时间不能大于当前时间", "检测时间不能大于当前时间", WebConstant.INTERFACE_CODE3);
//                    }
//
//                    //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
//                    int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
//                    if (spotcheck == 1) {
//                        required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");
//                    } else if (spotcheck == -1) {
//                        aj.setResultCode(WebConstant.INTERFACE_CODE14);
//                        aj.setMsg("上传失败，请联系管理员");
//                        return aj;
//                    }
//
//                    // 根据仪器ID查询仪器信息
//                    if (StringUtil.isNotEmpty(bean.getDeviceId())) {
//                        BaseDevice device = baseDeviceService.queryBySerialNumber(bean.getDeviceId());
//                        if (device != null) {
//                            bean.setDeviceId(device.getId());
//                            bean.setDeviceName(device.getDeviceName());
//                        }
//                    }
//
//                    //检测人员
//                    if (null == bean.getCheckUsername() || "".equals(bean.getCheckUsername().trim())) {
//                        bean.setCheckUserid(user.getId());
//                        bean.setCheckUsername(user.getRealname());
//                    }
//
//                    //新增/重传检测数据
//                    dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                    successNum++;    //上传成功数量+1
//
//
//                } catch (MyException e) {
//                    setAjaxJson(aj1, e.getCode(), e.getText());
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    errMap.put("errMsg", aj1.getMsg());
//                    failRecords.add(errMap);
//                    failNum++;    //上传失败数量+1
//
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    log.error("*****上传检测数据失败[id:"+bean.getId()+"]，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    if (e.getMessage().contains("reload_id")) {
//                        errMap.put("errMsg", "上传失败，ID["+bean.getId()+"]重复");
//                    } else {
//                        errMap.put("errMsg", "请确认参数无误");
//                    }
//                    failRecords.add(errMap);
//                    failNum++;    //上传失败数量+1
//                }
//            }
//
//            //返回结果
//            Map<String, Object> resultMap = new HashMap<String, Object>();
//            resultMap.put("successNum", successNum);
//            resultMap.put("failNum", failNum);
//            resultMap.put("failRecords", failRecords);
//            aj.setObj(resultMap);
//
//            //返回值提示 20220525
//            String tips = "";
//            if (successNum > 0) {
//                tips = "上传成功"+ successNum + "条";
//            }
//            if (failNum > 0) {
//                if (!StringUtils.isEmpty(tips)) {
//                    tips += "；失败"+ failNum + "条";
//
//                } else {
//                    tips += "上传失败"+ failNum + "条";
//                }
//            }
//            aj.setMsg(tips);
//
//        } catch (MyException e) {
//            setAjaxJson(aj, e.getCode(), e.getText());
//        } catch (Exception e) {
//            e.printStackTrace();
//            log.error("*****上传检测数据失败，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//        }
//
//        return aj;
//    }
//
//    /**
//     * 上传检测结果_v1.5，增加新规字段
//     * @param userToken 用户token
//     * @param results   传输的json数据
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/saveCdOfv", method = RequestMethod.POST)
//    public InterfaceJson saveCdOfv(String userToken, String results) {
//        InterfaceJson aj = new InterfaceJson();
//
//        try {
//            TSUser user = tokenExpired(userToken);
//
//            required(user.getDepartId(), WebConstant.INTERFACE_CODE11, "数据异常，登录用户所属机构为空");
//            required(user.getPointId(), WebConstant.INTERFACE_CODE14, "非检测点用户无法上传检测数据");
//
//            required(results, WebConstant.INTERFACE_CODE1, "参数results不能为空");
//
//            List<IDataCheckRecordingModel> models = JSONArray.parseArray(results, IDataCheckRecordingModel.class);
//
//            required(models, WebConstant.INTERFACE_CODE2, "参数results不正确");
//
//            int cMinute = 5;    //上传数据检测时间可大于当前时间最大时间（分钟）限制
//
//            int successNum = 0;    //上传成功条数
//            int failNum = 0;        //上传失败条数
//
//            List<Map<String, Object>> failRecords = new ArrayList<Map<String, Object>>();    //失败信息数组
//            Map<String, Object> errMap = null;    //失败信息
//            InterfaceJson aj1 = null;
//
//            Date now = new Date();
//            for (IDataCheckRecordingModel model : models) {
//                aj1 = new InterfaceJson();
//                DataCheckRecording bean = null;
//                try {
//                    bean = new DataCheckRecording(model.getId(),
//                            model.getFoodId(), model.getFoodName(), model.getItemId(), model.getItemName(),
//                            model.getRegId(), model.getRegName(), model.getRegUserId(), model.getRegUserName(),
//                            user.getDepartId(), user.getDepartName(), user.getPointId(), user.getPointName(),
//                            model.getLimitValue(), model.getCheckResult(), model.getCheckUnit(), model.getConclusion(), model.getCheckDate(),
//                            model.getCheckAccordId(), model.getCheckAccord(),
//                            model.getCheckUserid(), model.getCheckUsername(),
//                            null, null, null, null, now,
//                            model.getDeviceId(), model.getDeviceName(), model.getDeviceCompany(), model.getDeviceModel(), model.getDeviceMethod(),
//                            (short)1, (short)1, (short)1, (short)0,
//                            user.getId(), user.getId(), now, now);
//
//                    //检测定位
//                    bean.setParam8(model.getCheckPosition());
//
//                    if (bean.getDataType() == null || (bean.getDataType().intValue()!=0 && bean.getDataType().intValue()!=1)) {
//                        bean.setDataType((short) 0);
//                    }
//
//                    TbSampling ts=null;
//                    if (model.getSamplingId()!=null) {
//                        ts = samplingService.getById(model.getSamplingId().intValue());
//                        if (ts == null) {
//                            throw new MyException("无效数据", "无效数据，samplingId数据不存在", WebConstant.INTERFACE_CODE2);
//                        }
//
//                        bean.setSamplingId(model.getSamplingId().intValue());
//                    }
//
//                    TbSamplingDetail tsd=null;
//                    if (model.getSamplingDetailId()!=null) {
//                        bean.setSamplingDetailId(model.getSamplingDetailId().intValue());
//                        tsd = samplingDetailService.queryById(model.getSamplingDetailId().intValue());
//
//                        if (tsd == null || tsd.getSamplingId().intValue() != model.getSamplingId().intValue()) {
//                            throw new MyException("无效数据", "无效数据，samplingId和samplingDetailId不关联", WebConstant.INTERFACE_CODE2);
//                        } else {
//                            bean.setFoodId(tsd.getFoodId().intValue());
//                            bean.setFoodName(tsd.getFoodName());
//                            bean.setItemId(tsd.getItemId());
//                            bean.setItemName(tsd.getItemName());
//                            bean.setRegId(ts.getRegId());
//                            bean.setRegName(ts.getRegName());
//                            bean.setRegUserId(ts.getOpeId());
//                            bean.setRegUserName(ts.getOpeShopCode());
//                        }
//                    }
//
//                    //附加表
//                    DataCheckRecordingAddendum addendum = new DataCheckRecordingAddendum(
//                            //经营者信息
//                            null,
//                            (model.getOperatorName()==null && ts!=null ? ts.getOpeName() : model.getOperatorName()),
//                            (model.getOperatorPhone()==null && ts!=null ? ts.getOpePhone() : model.getOperatorPhone()),
//                            null,
//
//                            //抽样信息
//                            (model.getSamplingDate()==null && ts!=null ? ts.getSamplingDate() : model.getSamplingDate()),
//                            (model.getSamplingUser()==null && ts!=null ? ts.getSamplingUsername() : model.getSamplingUser()),
//                            (ts!=null && StringUtils.isNotBlank(ts.getPlaceX()) && StringUtils.isNotBlank(ts.getPlaceY()) ? (ts.getPlaceX()+","+ts.getPlaceY()) : null),
//                            (model.getSamplingAddress()==null && tsd!=null ? null : model.getSamplingAddress()),
//                            (model.getSamplingNumber()==null && tsd!=null
//                                    ? (tsd.getSampleNumber()!=null ? tsd.getSampleNumber().doubleValue() : null) : model.getSamplingNumber()),
//
//                            //进货信息
//                            (model.getPurchaseDate()==null && tsd!=null ? tsd.getPurchaseDate() : model.getPurchaseDate()),
//                            (model.getPurchaseAmount()==null && tsd!=null
//                                    ? (tsd.getPurchaseAmount()!=null ? tsd.getPurchaseAmount().doubleValue(): null)
//                                        : (model.getPurchaseAmount()!=null ? model.getPurchaseAmount().doubleValue(): null) ),
//
//                            //供货商信息
//                            (StringUtils.isBlank(model.getSupplier()) && tsd!=null ? tsd.getSupplier() : model.getSupplier()),
//                            (StringUtils.isBlank(model.getSupplierAddress()) && tsd!=null ? tsd.getSupplierAddress() : model.getSupplierAddress()),
//                            (StringUtils.isBlank(model.getSupplierPerson()) && tsd!=null ? tsd.getSupplierPerson() : model.getSupplierPerson()),
//                            (StringUtils.isBlank(model.getSupplierPhone()) && tsd!=null ? tsd.getSupplierPhone() : model.getSupplierPhone()),
//                            (StringUtils.isBlank(model.getBatchNumber()) && tsd!=null ? tsd.getBatchNumber() : model.getBatchNumber()),
//                            (StringUtils.isBlank(model.getOrigin()) && tsd!=null ? tsd.getOrigin() : model.getOrigin()),
//
//                            //检测方法
//                            model.getCheckWay(), model.getReagent(), model.getItemVulgo(), null, null, null);
//
//                    //必填验证
//                    required(bean.getId(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//
//                    //不校验样品ID、检测项目ID和被检单位ID  --Dz 20230607
////                    required(bean.getFoodId(), WebConstant.INTERFACE_CODE1, "参数foodId不能为空");
//                    required(bean.getFoodName(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//                    //通过样品名称反查ID
//                    if (bean.getFoodId() == null) {
//                        BaseFoodType bft = baseFoodTypeService.queryByFoodName(bean.getFoodName(), null);
//                        if (bft != null) {
//                            bean.setFoodId(bft.getId().intValue());
//                        }
//                    }
//
////                    required(bean.getItemId(), WebConstant.INTERFACE_CODE1, "参数itemId不能为空");
//                    required(bean.getItemName(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
//                    //通过样品名称反查ID
//                    if (bean.getItemId() == null) {
//                        BaseDetectItem bdi = itemService.queryOneByItemName(bean.getItemName());
//                        if (bdi != null) {
//                            bean.setItemId(bdi.getId());
//                        }
//                    }
//
////                    required(bean.getRegId(), WebConstant.INTERFACE_CODE1, "参数regId不能为空");
//                    required(bean.getRegName(), WebConstant.INTERFACE_CODE1, "参数regName不能为空");
////                    BaseRegulatoryObject regObj = baseRegulatoryObjectService.queryById(bean.getRegId());
////                    required(regObj, WebConstant.INTERFACE_CODE2, "没有找到regId为"+bean.getRegId()+"的数据");
////                    required(regObj.getRegName().equals(bean.getRegName()), WebConstant.INTERFACE_CODE2, "regId和regName不匹配，请更新基础数据");
//
//                    //通过被检单位名称反查ID
//                    if (bean.getRegId() == null) {
//                        List<BaseRegulatoryObject> bros = baseRegulatoryObjectService.queryRegByDIdAndRegName2New(user.getDepartId(), null, bean.getRegName());
//                        if (bros != null && bros.size()>0) {
//                            bean.setRegId(bros.get(0).getId().intValue());
//                        }
//                    }
//
////                    if (bean.getRegUserId() != null) {
////                        BaseRegulatoryBusiness regBus = baseRegulatoryBusinessService.queryById(bean.getRegUserId());
////                        required(regBus, WebConstant.INTERFACE_CODE2, "没有找到regUserId为"+bean.getRegUserId()+"的数据");
////                        required(bean.getRegId().equals(regBus.getRegId()), WebConstant.INTERFACE_CODE2, "regId和regUserId不匹配");
////                        required(bean.getRegUserName().equals(regBus.getOpeShopCode()), WebConstant.INTERFACE_CODE2, "regUserId和regUserName不匹配，请更新基础数据");
////                    }
//
//                    required(bean.getCheckResult(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                    required(bean.getConclusion(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                    if (!"合格".equals(bean.getConclusion()) && !"不合格".equals(bean.getConclusion())) {
//                        throw new MyException("参数conclusion错误，只能是合格或不合格", "参数conclusion错误，只能是合格或不合格", WebConstant.INTERFACE_CODE2);
//                    }
//
//                    if (null == bean.getCheckDate()) {
//                        //检测时间不能为空
//                        throw new MyException("参数checkDate不能为空", "参数checkDate不能为空", WebConstant.INTERFACE_CODE1);
//
//                    } else if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                        //检测时间不能大于当前时间
//                        throw new MyException("检测时间不能大于当前时间", "检测时间不能大于当前时间", WebConstant.INTERFACE_CODE3);
//                    }
//
//                    //数据上传控制：-1_禁止数据上传，0_接收全部数据，1_仅限抽样检测数据；默认0
//                    int spotcheck = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 0, "system_config", "spot_check");
//                    if (spotcheck == 1) {
//                        required(bean.getSamplingDetailId(), WebConstant.INTERFACE_CODE1, "禁止上传非抽样检测数据");
//                    } else if (spotcheck == -1) {
//                        aj.setResultCode(WebConstant.INTERFACE_CODE14);
//                        aj.setMsg("上传失败，请联系管理员");
//                        return aj;
//                    }
//
//                    required(addendum.getOperatorName(), WebConstant.INTERFACE_CODE1, "参数operatorName不能为空");
//                    required(addendum.getOperatorPhone(), WebConstant.INTERFACE_CODE1, "参数operatorPhone不能为空");
//                    required(addendum.getSamplingDate(), WebConstant.INTERFACE_CODE1, "参数samplingDate不能为空");
//                    required(addendum.getSamplingUser(), WebConstant.INTERFACE_CODE1, "参数samplingUser不能为空");
//                    required(addendum.getOrigin(), WebConstant.INTERFACE_CODE1, "参数origin不能为空");
//                    required(addendum.getReagent(), WebConstant.INTERFACE_CODE1, "参数reagent不能为空");
//                    required(addendum.getCheckWay(), WebConstant.INTERFACE_CODE1, "参数checkWay不能为空");
//                    required(bean.getDeviceName(), WebConstant.INTERFACE_CODE1, "参数deviceName不能为空");
//
//                    // 根据仪器ID查询仪器信息
//                    if (StringUtil.isNotEmpty(bean.getDeviceId())) {
//                        BaseDevice device = baseDeviceService.queryBySerialNumber(bean.getDeviceId());
//                        if (device != null) {
//                            bean.setDeviceId(device.getId());
//                            bean.setDeviceName(device.getDeviceName());
//                        }
//                    }
//
//                    //检测人员
//                    if (StringUtils.isBlank(bean.getCheckUsername())) {
//                        bean.setCheckUserid(user.getId());
//                        bean.setCheckUsername(user.getRealname());
//                    }
//
//                    //附加表
//                    bean.setAddendum(addendum);
//
//                    //新增/重传检测数据
//                    dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                    //上传成功数量+1
//                    successNum++;
//
//                } catch (MyException e) {
//                    setAjaxJson(aj1, e.getCode(), e.getText());
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    errMap.put("errMsg", aj1.getMsg());
//                    failRecords.add(errMap);
//                    //上传失败数量+1
//                    failNum++;
//
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    log.error("*****上传检测数据失败[id:"+bean.getId()+"]，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", bean.getId());
//                    if (e.getMessage().contains("reload_id")) {
//                        errMap.put("errMsg", "上传失败，ID["+bean.getId()+"]重复");
//                    } else {
//                        errMap.put("errMsg", "请确认参数无误");
//                    }
//                    failRecords.add(errMap);
//                    //上传失败数量+1
//                    failNum++;
//                }
//            }
//
//            //返回结果
//            Map<String, Object> resultMap = new HashMap<String, Object>();
//            resultMap.put("successNum", successNum);
//            resultMap.put("failNum", failNum);
//            resultMap.put("failRecords", failRecords);
//            aj.setObj(resultMap);
//
//            //返回值提示 20220525
//            String tips = "";
//            if (successNum > 0) {
//                tips = "上传成功"+ successNum + "条";
//            }
//            if (failNum > 0) {
//                if (!StringUtils.isEmpty(tips)) {
//                    tips += "；失败"+ failNum + "条";
//
//                } else {
//                    tips += "上传失败"+ failNum + "条";
//                }
//            }
//            aj.setMsg(tips);
//
//        } catch (MyException e) {
//            setAjaxJson(aj, e.getCode(), e.getText());
//        } catch (Exception e) {
//            e.printStackTrace();
//            log.error("*****上传检测数据失败，未知异常:" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber()+";results:"+results);
//            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败，请确认数据格式无误！", e);
//        }
//
//        return aj;
//    }
//
//
//    /**
//     * 上传检测结果（新模式）
//     *
//     * @param userToken
//     * @param results
//     * @return
//     * @author Dz
//     * 2019年6月25日 下午7:43:42
//     */
//    @RequestMapping(value = "/newMode/uploadCheckData", method = RequestMethod.POST)
//    public InterfaceJson uploadCheckData(String userToken, String results) {
//        InterfaceJson aj = new InterfaceJson();
//
//        try {
//            TSUser user = tokenExpired(userToken);    //token验证
//
//            required(user.getDepartId(), WebConstant.INTERFACE_CODE11, "数据异常，登录用户所属机构为空");
//            required(user.getPointId(), WebConstant.INTERFACE_CODE14, "非检测点用户无法上传检测数据");
//
//            required(results, WebConstant.INTERFACE_CODE1, "参数results不能为空");
//
//            List<HashMap> records = JSONArray.parseArray(results, HashMap.class);
//
//            required(records, WebConstant.INTERFACE_CODE2, "参数results不正确");
//
//            int cMinute = 30;    //上传数据检测时间可大于当前时间最大时间（分钟）限制
//
//            int successNum = 0;    //上传成功条数
//            int failNum = 0;        //上传失败条数
//
//            List<Map<String, Object>> failRecords = new ArrayList<Map<String, Object>>();    //失败信息数组
//            Map<String, Object> errMap = null;    //失败信息
//
//            StringBuffer sampleDetailIds = new StringBuffer();
//            String projectPath = IDataCheckController.class.getResource("/").getPath().replaceFirst("/", "").replaceAll("WEB-INF/classes/", "");
//            String stdCode="";//检测标准编号
//            BasePoint point =null;
//            CheckReportData reportData=null;
//            //生成对应报告base64编码数据 add by xiaoyl 2020-03-10
//            point = basePointService.queryById(user.getPointId());
//			JSONObject reportConfig = SystemConfigUtil.REPORT_CONFIG;
//			String reviewImage=projectPath +reportConfig.getString("sign_file");//签名文件
//			String approveImage=projectPath +reportConfig.getString("approve_file");//批准文件
//			String signatureImage=projectPath +reportConfig.getString("signature_file");//电子签章
//			boolean isGeneratorBase64=true;
//            for (HashMap map : records) {
//                try {
//                    //必填验证
//                    required(map.get("id"), WebConstant.INTERFACE_CODE1, "参数id不能为空");
////					required(map.get("id").toString(), WebConstant.INTERFACE_CODE1, "参数id不能为空");
//                    required(map.get("foodName"), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
////					required(map.get("foodName").toString(), WebConstant.INTERFACE_CODE1, "参数foodName不能为空");
//                    required(map.get("itemName"), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
////					required(map.get("itemName").toString(), WebConstant.INTERFACE_CODE1, "参数itemName不能为空");
//                    required(map.get("checkResult"), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
////					required(map.get("checkResult").toString(), WebConstant.INTERFACE_CODE1, "参数checkResult不能为空");
//                    required(map.get("checkUnit"), WebConstant.INTERFACE_CODE1, "参数checkUnit不能为空");
////					required(map.get("checkUnit").toString(), WebConstant.INTERFACE_CODE1, "参数checkUnit不能为空");
//                    required(map.get("conclusion"), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
//                    if (!"合格".equals(map.get("conclusion").toString()) && !"不合格".equals(map.get("conclusion").toString())) {
//                        throw new MyException("参数conclusion错误，只能是合格或不合格","参数conclusion错误，只能是合格或不合格",WebConstant.INTERFACE_CODE2);
//                    }
////					required(map.get("conclusion").toString(), WebConstant.INTERFACE_CODE1, "参数conclusion不能为空");
////					required(map.get("checkDate"), WebConstant.INTERFACE_CODE1, "参数checkDate格式错误，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
////					checkTime(map.get("checkDate").toString(), WebConstant.INTERFACE_CODE1, "参数checkDate格式错误，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
//                    checkTime(map.get("checkDate"), WebConstant.INTERFACE_CODE1, "参数checkDate格式错误，支持:yyyy-MM-dd和yyyy-MM-dd HH:mm:ss");
//                    required(map.get("serialNumber"), WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
////					required(map.get("serialNumber").toString(), WebConstant.INTERFACE_CODE1, "参数serialNumber不能为空");
//
//
//                    sampleDetailIds.append(map.get("id").toString() + ",");
//
//                    DataCheckRecording bean = dataCheckRecordingService.queryBySamplingDetailId(Integer.parseInt(map.get("id").toString()));
//                    if (bean == null) {
//                        bean = new DataCheckRecording();
//                        bean.setId(UUIDGenerator.generate());
//                    }
//
//                    //检测结果记录检测值
//                    bean.setSamplingDetailId(Integer.parseInt(map.get("id").toString()));
//                    bean.setCheckResult(map.get("checkResult").toString());
//                    bean.setCheckUnit(map.get("checkUnit").toString());
//                    bean.setConclusion(map.get("conclusion").toString());
//
//                    bean.setCheckDate(DateUtil.parseDate(map.get("checkDate").toString(), "yyyy-MM-dd HH:mm:ss"));
//
//                    if (System.currentTimeMillis() < (bean.getCheckDate().getTime() - cMinute * 60 * 1000)) {
//                        //检测时间大于最大时间限制
//                        throw new MyException("参数checkDate不正确", "参数checkDate不正确", WebConstant.INTERFACE_CODE3);
//                    }
//
//                    //检测结果记录用户信息
//                    bean.setDepartId(user.getDepartId());
//                    bean.setDepartName(user.getDepartName());
//                    bean.setPointId(user.getPointId());
//                    bean.setPointName(user.getPointName());
//                    bean.setDataType((short) 2);    //订单检测结果
//                    bean.setDataSource((short) 1);    //仪器上传
//                    bean.setStatusFalg((short) 0);
//
//
//                    //查询抽样明细
//                    TbSamplingDetail samplingDetail = samplingDetailService.queryById(bean.getSamplingDetailId());
//                    required(samplingDetail, WebConstant.INTERFACE_CODE5, "样品信息不存在");
//                    TbSampling sampling = samplingService.getById(samplingDetail.getSamplingId());
//                    required(sampling, WebConstant.INTERFACE_CODE5, "样品信息不存在");
//                    bean.setSamplingId(sampling.getId());
//                    bean.setFoodId(samplingDetail.getFoodId());
//                    bean.setFoodName(samplingDetail.getFoodName());
//
//                    BaseFoodType food = baseFoodTypeService.queryById(samplingDetail.getFoodId());
//                    if (food != null) {
//                        bean.setFoodTypeId(food.getParentId());
//                        bean.setFoodTypeName(food.getParentName());
//                    }
//                    bean.setItemId(samplingDetail.getItemId());
//                    bean.setItemName(samplingDetail.getItemName());
//
//                    //shit 这里的setRegName需要通过订单的中间表tb_sampling_requester关联查询,记得把reg_name字段改为文本格式
//                 /*   List<TbSamplingRequester> reqUnits = tbSamplingRequesterService.queryBySamplingId(sampling.getId());
//                    if (reqUnits != null) {
//                        if (reqUnits.size() == 1) {
//                            bean.setRegId(reqUnits.get(0).getRequestId());
//                            bean.setRegName(reqUnits.get(0).getRequestName());
//                        } else if (reqUnits.size() > 1) {
//                            bean.setRegName(reqUnits.size()+"个");
//                        }
//                    }*/
//
//                    bean.setRegUserId(sampling.getOpeId());
//                    bean.setRegUserName(sampling.getOpeShopCode());
//
//                    bean.setCheckUserid(user.getId());
//                    bean.setCheckUsername(user.getRealname());
//                    bean.setAuditorId(user.getId());
//                    bean.setAuditorName(user.getRealname());
//                    bean.setUploadId(user.getId());
//                    bean.setUploadName(user.getRealname());
//                    bean.setUploadDate(new Date());
//
//                    //新模式不需要任务相关信息
////					if(sampling.getTaskId() != null) {
////						TbTask task = taskService.queryById(sampling.getTaskId()+"");
////						if(task!=null) {
////							bean.setTaskId(task.getId());
////							bean.setTaskName(task.getTaskTitle());
////							bean.setParam1(samplingDetail.getParam2());
////						}
////					}
//
//                    //获取检测项目判定标准
//                    StringBuffer subffer = new StringBuffer();
//                    subffer.append("SELECT bfi.id, bfi.checked,   " +
////							"	bft.id food_id, bft.food_name,   " +
//                            "	bdi.id item_id, bdi.detect_item_name item_name,   " +
//                            "	bs.id std_id, bs.std_name std_name,  bs.std_code, " +
//                            "	IF(bfi.use_default=0, bdi.detect_sign, bfi.detect_sign) detect_sign,   " +
//                            "	IF(bfi.use_default=0, bdi.detect_value, bfi.detect_value) detect_value,   " +
//                            "	IF(bfi.use_default=0, bdi.detect_value_unit, bfi.detect_value_unit) detect_value_unit " +
//                            "FROM base_food_item bfi   " +
////							"	INNER JOIN base_food_type bft ON bfi.food_id = bft.id   " +
//                            "	INNER JOIN base_detect_item bdi ON bfi.item_id = bdi.id   " +
//                            "	LEFT JOIN base_standard bs ON bdi.standard_id = bs.id " +
//                            "WHERE bfi.food_id = ? AND bfi.item_id = ? " +
//                            "	AND bfi.delete_flag = 0 " +
////							"	AND bft.delete_flag = 0 " +
//                            "	AND bdi.delete_flag = 0 ");
//
//
////					double detectValue = 50;	//农残检测判定值
//                    List<Map<String, Object>> list1 = jdbcTemplate.queryForList(subffer.toString(), new Object[]{bean.getFoodId(), bean.getItemId()});
//                    if (list1 != null && list1.size() > 0) {
//                        Map<String, Object> map1 = list1.get(0);
//                        bean.setCheckAccordId(map1.get("std_id") == null ? "" : map1.get("std_id").toString());
//                        bean.setCheckAccord(map1.get("std_name") == null ? "" : map1.get("std_name").toString());
//                        bean.setLimitValue((map1.get("detect_sign") == null ? "" : map1.get("detect_sign").toString()) + (map1.get("detect_value") == null ? "" : map1.get("detect_value").toString()));
//                        bean.setCheckUnit(map1.get("detect_value_unit") == null ? "" : map1.get("detect_value_unit").toString());
//                        stdCode=map1.get("std_code") == null ? "" : map1.get("std_code").toString();
////						detectValue = map1.get("detect_value") == null ? detectValue : Double.parseDouble(map1.get("detect_value").toString());
////						bean.setLimitValue((map1.get("detect_sign") == null ? "" : map1.get("detect_sign").toString())+detectValue);
//                    }
//                    //判定合格不合格
////					if(Integer.parseInt(bean.getCheckResult()) < detectValue) {
////						bean.setConclusion("合格");
////					}else {
////						bean.setConclusion("不合格");
////					}
//
//                    //查询仪器信息
//                    subffer.setLength(0);
//                    subffer.append("SELECT bd.id device_id, bd.device_name, bd.device_code, " +
//                            "	bdp.project_type, bdp.detect_method, bdt.device_maker " +
//                            "FROM base_device bd  " +
//                            "	LEFT JOIN base_device_parameter bdp ON bd.device_type_id = bdp. device_type_id " +
//                            "	LEFT JOIN base_device_type bdt ON bd.device_type_id = bdt.id " +
//                            "WHERE bd.delete_flag = 0 AND bd.serial_number = ? AND bdp.item_id = ? ");
//                    List<Map<String, Object>> list2 = jdbcTemplate.queryForList(subffer.toString(), new Object[]{map.get("serialNumber").toString(), bean.getItemId()});
//                    if (list2 != null && list2.size() > 0) {
//                        Map<String, Object> map2 = list2.get(0);
//                        bean.setDeviceId(map2.get("device_id").toString());
//                        bean.setDeviceName(map2.get("device_name").toString());
//                        bean.setDeviceModel(map2.get("project_type").toString());
//                        bean.setDeviceMethod(map2.get("detect_method").toString());
//                        bean.setDeviceCompany(map2.get("device_maker").toString());
//                    }
//
//                    //检测人员
//                    if (null == bean.getCheckUsername() || "".equals(bean.getCheckUsername().trim())) {
//                        bean.setCheckUserid(user.getId());
//                        bean.setCheckUsername(user.getRealname());
//                    }
//
//                    //新增/重传检测数据
//                    dataCheckRecordingService.saveOrUpdateDataChecking(bean, user);
//                    successNum++;    //上传成功数量+1
//
//                    //清空试管码
//                    subffer.setLength(0);
//                    subffer.append("UPDATE tb_sampling_detail_code  " +
//                            "	SET tube_code1=NULL, tube_code_time1=NULL, " +
//                            "		tube_code2=NULL, tube_code_time2=NULL, " +
//                            "		tube_code3=NULL, tube_code_time3=NULL, " +
//                            "		tube_code4=NULL, tube_code_time4=NULL,  " +
//                            "		delete_flag=0, update_date=NOW() " +
//                            "WHERE sampling_detail_id=? ");
//                    jdbcTemplate.update(subffer.toString(), new Object[]{Integer.parseInt(map.get("id").toString())});
//                	//TODO 写入检测报告附加信息至关联表中 check_report_data add by xiaoyl 2020/03/06
//                    reportData=reportDataService.queryByRecordingId(bean.getRid());
//                    if(isGeneratorBase64) {
//                    	reviewImage=StringUtil.isNotEmpty(reviewImage) ? Xml2Word2Pdf.img2Base64(reviewImage) : "";
//                    	approveImage=StringUtil.isNotEmpty(approveImage) ? Xml2Word2Pdf.img2Base64(approveImage) : "";
//                    	signatureImage=StringUtil.isNotEmpty(signatureImage) ? Xml2Word2Pdf.img2Base64(signatureImage) : "";
//                    	isGeneratorBase64=false;
//                    }
//                    if(reportData==null) {
//                    	reportData=new CheckReportData(bean.getRid(), stdCode,  point.getAddress(),point.getPhone(), reviewImage, approveImage, signatureImage);
//                    	reportDataService.insertSelective(reportData);
//                    }
//                } catch (MyException e) {
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", map.get("id").toString());
//                    errMap.put("errMsg", e.getText());
//                    failRecords.add(errMap);
//                    failNum++;    //上传失败数量+1
//
//                } catch (Exception e) {
//                    //记录上传检测数据失败原因
//                    errMap = new HashMap<String, Object>();
//                    errMap.put("id", map.get("id").toString());
//                    errMap.put("errMsg", e.getMessage());
//                    failRecords.add(errMap);
//                    failNum++;    //上传失败数量+1
//                }
//            }
//
//            //返回结果
//            Map<String, Object> resultMap = new HashMap<String, Object>();
//            resultMap.put("successNum", successNum);
//            resultMap.put("failNum", failNum);
//            resultMap.put("failRecords", failRecords);
//            aj.setObj(resultMap);
//      /*      try {
//                int recheckNumber = SystemConfigUtil.getInteger(SystemConfigUtil.OTHER_CONFIG, 2, "system_config", "recheck", "number");
//                //推送微信消息
//                sampleDetailIds = sampleDetailIds.deleteCharAt(sampleDetailIds.length() - 1);
//                StringBuffer sql = new StringBuffer();
//                //查询每次送样样品检测情况
//                sql.append("SELECT tsd.id, tsd.sampling_id samplingId, tsd.sample_code sampleCode, tsd.sample_tube_time sampleTubeTime, tsd.collect_code collectCode,  " +
//                        " COUNT(1) totalNum, " +    //此次送样样品数量
//                        " SUM(  " +
//                        "  IF ( IF(dcr.conclusion = '' OR (dcr.conclusion = '不合格' AND dcr.reload_flag < " + recheckNumber + "), NULL, dcr.conclusion) IS NULL, 0, 1 ) " +
//                        " ) checkedNum, " +    //已检测数量
//                        " MAX(dcr.check_date) checkDate " +    //已检测数量
//                        "FROM tb_sampling_detail tsd " +
//                        "INNER JOIN  " +
//                        "( " +
//                        " SELECT sampling_id, sample_tube_time " +    //查询上传结果的样品ID和送检时间
//                        "  FROM tb_sampling_detail  " +
//                        " WHERE id IN (" + sampleDetailIds.toString() + ") " +
//                        " AND sample_tube_time IS NOT NULL " +
//                        " GROUP BY sampling_id, sample_tube_time " +
//                        ") tb1 ON tb1.sampling_id = tsd.sampling_id AND tb1.sample_tube_time = tsd.sample_tube_time " +
//                        "LEFT JOIN data_check_recording dcr ON tsd.id = dcr.sampling_detail_id " +
//                        "GROUP BY tsd.sampling_id, tsd.sample_tube_time ");
//                List<Map<String, Object>> result = jdbcTemplate.queryForList(sql.toString());
//                for (Map<String, Object> res : result) {
//                    //送检数量 等于 已检测数量，此次送样已全部检测
//                    if (res.get("totalNum").toString().equals(res.get("checkedNum").toString())) {
//                        sql.setLength(0);
//                        //查询订单号、送检人OPEN_ID
//                        sql.append("SELECT ts.sampling_no samplingNo, iuu.open_id openId " +
//                                "FROM tb_sampling ts " +
//                                " INNER JOIN inspection_unit_user iuu ON ts.sampling_userid = iuu.id " +
//                                "WHERE ts.delete_flag = 0 AND ts.personal = 2 AND ts.order_status = 2 " +
//                                " AND ts.id = ? ");
//                        List<Map<String, Object>> result0 = jdbcTemplate.queryForList(sql.toString(), new Object[]{res.get("samplingId").toString()});
//                        if (result0.size() > 0 && result0.get(0).get("openId") != null && !"".equals(result0.get(0).get("openId").toString().trim())) {
//                            wxPayService.sendCheckMsg(result0.get(0).get("openId").toString(),
//                                    systemUrl+"collectSample/detail?samplingId="+res.get("samplingId").toString()+"&collectCode="+res.get("collectCode").toString(),
//                                    result0.get(0).get("samplingNo").toString(),
//                                    (Date) res.get("checkDate"), (Date) res.get("sampleTubeTime"));
//                        }
//                    }
//                }
//            } catch (Exception e) {
//                log.error("*****推送微信消息失败：" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
//            }*/
//
//        } catch (MyException e) {
//            setAjaxJson(aj, e.getCode(), e.getText());
//        } catch (Exception e) {
//            setAjaxJson(aj, WebConstant.INTERFACE_CODE11, "操作失败！", e);
//        }
//
//        return aj;
//
//    }
//
//
//}
