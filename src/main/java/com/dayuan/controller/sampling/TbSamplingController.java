//package com.dayuan.controller.sampling;
//
//import com.alibaba.fastjson.JSONArray;
//import com.alibaba.fastjson.JSONObject;
//import com.dayuan.bean.AjaxJson;
//import com.dayuan.bean.Page;
//import com.dayuan.bean.data.BasePoint;
//import com.dayuan.bean.data.TbFile;
//import com.dayuan.bean.regulatory.BaseRegulatoryObject;
//import com.dayuan.bean.sampling.TbSampling;
//import com.dayuan.bean.sampling.TbSamplingDetail;
//import com.dayuan.bean.system.TSUser;
//import com.dayuan.bean.task.TbTask;
//import com.dayuan.common.PublicUtil;
//import com.dayuan.common.WebConstant;
//import com.dayuan.controller.BaseController;
//import com.dayuan.exception.MyException;
//import com.dayuan.model.sampling.TbSamplingDetailReport;
//import com.dayuan.model.sampling.TbSamplingModel;
//import com.dayuan.model.task.RecTaskModel;
//import com.dayuan.service.data.BasePointService;
//import com.dayuan.service.data.TbFileService;
//import com.dayuan.service.detect.DepartService;
//import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
//import com.dayuan.service.sampling.TbSamplingDetailRecevieService;
//import com.dayuan.service.sampling.TbSamplingDetailService;
//import com.dayuan.service.sampling.TbSamplingService;
//import com.dayuan.service.system.TSUserService;
//import com.dayuan.service.task.TaskService;
//import com.dayuan.util.DateUtil;
//import com.dayuan.util.DyFileUtil;
//import com.dayuan.util.QrcodeUtil;
//import com.dayuan.util.StringUtil;
//import com.dayuan3.common.util.SystemConfigUtil;
//import org.apache.commons.io.FileUtils;
//import org.apache.log4j.Logger;
//import org.springframework.beans.BeanUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.ModelAndView;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.File;
//import java.util.*;
//
///**
// * 抽样单管理
// * Description:
// *
// * @author bill
// * @Company: 食安科技
// * @date 2017年8月4日
// */
//@Controller
//@RequestMapping("/sampling")
//public class TbSamplingController extends BaseController {
//
//    private final Logger log = Logger.getLogger(TbSamplingController.class);
//
//    @Autowired
//    private TbSamplingService tbSamplingService;
//    @Autowired
//    private TbSamplingDetailService tbSamplingDetailService;
//    @Autowired
//    private TbSamplingDetailRecevieService samplingDetailRecevieService;
//    @Autowired
//    private BaseRegulatoryObjectService baseRegulatoryObjectService;
//    @Autowired
//    private DepartService departService;
//    @Autowired
//    private BasePointService pointService;
//    @Autowired
//    private TSUserService tsUserService;
//
//    @Autowired
//    private TaskService taskService;
//    @Autowired
//    private TbFileService fileService;
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//
//    @Value("${resources}")
//    private String resources;
//    @Value("${opeSignaturePath}")
//    private String opeSignaturePath;
//    @Value("${samplingQr}")
//    private String samplingQr;
//    @Value("${samplingQrPath}")
//    private String samplingQrPath;
//    @Value("${defaultSignatureFile}")
//    private String defaultSignatureFile;
////	@Value(value = "classpath:/js/json/itemGroup.json")
////	private Resource itemData;
//
//    public static void main(String[] args) {
//
//    }
//
//    /**
//     * 进入数据列表页面
//     *
//     * @param request
//     * @param response
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/list")
//    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
//        Map<String, Object> data = new HashMap<String, Object>();
//        int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//        JSONObject config = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//        if (config != null &&  config.getInteger("systemFlag") != null) {
//            systemFlag = config.getInteger("systemFlag");
//        }
//        data.put("systemFlag",systemFlag);
//        return new ModelAndView("/sampling/list",data);
//    }
//
//    /**
//     * 数据列表
//     *
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/datagrid")
//    @ResponseBody
//    public AjaxJson datagrid(TbSamplingModel model, Page page, HttpServletResponse response, String opeName, String opeShopName, String regLinkPerson, HttpSession session) {
//            AjaxJson jsonObj = new AjaxJson();
//        try {
//            TSUser user = PublicUtil.getSessionUser();
//
//            Map map = tbSamplingService.dataPermission("/sampling/list.do");
//            if (null != user.getRegId()) {
//                model.setDepartArr((Integer[]) map.get("departArr"));
//                model.setUserRegId((Integer) map.get("userRegId"));
//            } else if (null != user.getPointId()) {
//                model.setDepartArr((Integer[]) map.get("departArr"));
//                model.setPointArr((Integer[]) map.get("pointArr"));
//            } else {
//                model.setDepartArr((Integer[]) map.get("departArr"));
//            }
//
//            //选定检测机构查询数据
//            if (model.getDepartId() != null) {
//                List<Integer> dil = departService.querySonDeparts(model.getDepartId());
//                Integer[] dia = new Integer[dil.size()];
//                dil.toArray(dia);
//                model.setDepartArr(dia);
//            }
//
//            page = tbSamplingService.loadDatagrid(page, model);
//            jsonObj.setObj(page);
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObj.setSuccess(false);
//            jsonObj.setMsg("操作失败");
//        }
//        return jsonObj;
//    }
//
//    @RequestMapping("/queryById")
//    public ModelAndView queryById(HttpServletRequest request, HttpServletResponse response, String id) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//        TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
//        //1.查询已分配任务
//        RecTaskModel taskDetail = new RecTaskModel();
//        if (null != user) {
//            if (StringUtil.isNotEmpty(user.getPointId())) {
//                taskDetail.setReceiveNodeid(user.getPointId());
//            } else {
//                taskDetail.setReceivePointid(user.getDepartId());
//            }
//        }
//        List<TbTask> taskList = taskService.queryByReceiveId(taskDetail);
//        map.put("taskList", taskList);
//        //2.查询被检单位-->监管对象
//        List<BaseRegulatoryObject> regObj = baseRegulatoryObjectService.queryByDepartId(user.getDepartId(), "1");
//        map.put("regObj", regObj);
//
//        //购样费用功能；0_关闭，1_开启
//        Integer showSampleCost = 0;
//        JSONObject config = SystemConfigUtil.OTHER_CONFIG;
//        if (config != null && config.getJSONObject("system_config") != null && config.getJSONObject("system_config").getInteger("show_sample_cost") != null) {
//            showSampleCost = config.getJSONObject("system_config").getInteger("show_sample_cost");
//        }
//        map.put("showSampleCost", showSampleCost);
//        // add by xiaoyl 2020/10/30 武陵系统将抽样单默认抽样数量为0.5KG；
//        int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//        JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//        if (systemFlagConfig != null &&  systemFlagConfig.getInteger("systemFlag") != null) {
//            systemFlag = systemFlagConfig.getInteger("systemFlag");
//        }
//        map.put("systemFlag",systemFlag);
//        return new ModelAndView("/sampling/edit", map);
//    }
//
//    /**
//     * 新增抽样单
//     *
//     * @param bean
//     * @param details
//     * @param request
//     * @param response
//     * @return
//     */
//    @RequestMapping(value = "/save")
//    @ResponseBody
//    public AjaxJson save(TbSampling bean, String details, HttpServletRequest request, HttpServletResponse response) {
//        AjaxJson jsonObject = new AjaxJson();
//        try {
//            TSUser user = PublicUtil.getSessionUser();
//            if (null == user.getRegId() && null == user.getPointId()) {
//                jsonObject.setSuccess(false);
//                jsonObject.setMsg("机构用户不能新增抽样单");
//                return jsonObject;
//            }
//
//            bean.setSamplingNo(WebConstant.SAMPLING_NUM2);
//            bean.setSamplingDate(new Date());
//            bean.setSamplingUserid(user.getId());
//            bean.setSamplingUsername(user.getRealname());
//            bean.setStatus((short) 0);
//            bean.setPersonal((short) 0);// add by xiaoyuling 2018-05-15 0：抽样单，1：送样单
//            bean.setOrderPlatform((short)2);//add by xiaoyuling 2022-11-14 表示是网页端抽样
//            List<TbSamplingDetail> listDetail = JSONArray.parseArray(details, TbSamplingDetail.class);
//            tbSamplingService.addSampling(bean, listDetail, user, null);
//        } catch (MyException e) {
//            jsonObject.setSuccess(false);
//            if (e.getText().contains("请更新食品种类数据")) {
//                jsonObject.setMsg("保存失败，检测样品数据异常，请刷新页面后重新录入！");
//            } else if (e.getText().contains("请更新检测项目数据")) {
//                jsonObject.setMsg("保存失败，检测项目数据异常，请刷新页面后重新录入！");
//            } else if (e.getText().contains("请更新监管对象数据")) {
//                jsonObject.setMsg("保存失败，监管对象数据异常，请刷新页面后重新录入！");
//            } else {
//                jsonObject.setMsg("保存失败，" + e.getText());
//            }
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObject.setSuccess(false);
//            jsonObject.setMsg("保存失败");
//        }
//        return jsonObject;
//    }
//
//    /**
//     * 删除数据，单条删除与批量删除通用方法
//     *
//     * @param request
//     * @param response
//     * @param ids      要删除的数据记录id集合
//     * @return
//     */
//    @RequestMapping("/delete")
//    @ResponseBody
//    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
//        AjaxJson jsonObj = new AjaxJson();
//        try {
//            String[] ida = ids.split(",");
//            Integer[] idas = new Integer[ida.length];
//            for (int i = 0; i < ida.length; i++) {
//                idas[i] = Integer.parseInt(ida[i]);
//            }
//            tbSamplingService.delete(idas);
//            //删除抽样单数据前，删除抽样单明细和抽样单购样小票文件
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObj.setSuccess(false);
//            jsonObj.setMsg("操作失败" + e.getMessage());
//        }
//        return jsonObj;
//    }
//
//    /**
//     * 更新抽样时间
//     *
//     * @param request
//     * @param id      抽样单ID
//     * @param sDate   抽样时间
//     * @return
//     */
//    @RequestMapping("/resetSamplingDate")
//    @ResponseBody
//    public AjaxJson resetSamplingDate(HttpServletRequest request, Integer id, Date sDate) {
//        AjaxJson jsonObj = new AjaxJson();
//        try {
//            TbSampling sampling = tbSamplingService.getById(id);
//            sampling.setSamplingDate(sDate);
//            PublicUtil.setCommonForTable(sampling, false);
//            tbSamplingService.updateBySelective(sampling);
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObj.setSuccess(false);
//            jsonObj.setMsg("操作失败");
//        }
//        return jsonObj;
//    }
//
//    /**
//     * 查看抽样单和检测报告
//     *
//     * @param request
//     * @param response
//     * @param id
//     * @param type     type=detail时查看抽样单，type=report时查看检测报告
//     * @return
//     */
//    @RequestMapping("/toWord")
//    public ModelAndView toWord(HttpServletRequest request, HttpServletResponse response, String id, String type) {
//        Map<String, Object> data = new HashMap<String, Object>();
//        List list = new ArrayList();
//        String viewName = "";
//        try {
//            String[] id0 = id.split(",");
//            for (String id1 : id0) {
//                Integer id2 = Integer.parseInt(id1);
//
//                Map<String, Object> dataMap = new HashMap<String, Object>();
//                TbSampling sampling = tbSamplingService.getById(id2);//根据id查询抽样单
//                if (StringUtil.isNotEmpty(sampling.getOpeSignature())) {
//                    sampling.setOpeSignature(opeSignaturePath + sampling.getOpeSignature());
//                }
//                //查询抽样人员是否有电子签名，有的话直接在抽样单中显示签名，没有则显示名称 add by xiaoyl 2022-01-23
//                TSUser samplUser=tsUserService.queryById(sampling.getSamplingUserid());
//                if(StringUtil.isNotEmpty(samplUser.getSignatureFile())){
//                    dataMap.put("samplSignatureFile",samplUser.getSignatureFile());
//                }
//                dataMap.put("sampling", sampling);
//                if (type.equals("detail")) {
//                    List<TbSamplingDetail> samplingDetailList = tbSamplingDetailService.queryBySamplingIdUnionItems(id2);//根据抽样单id查询抽样单的详情,合并检测项目
//                    viewName = "/sampling/sheet_1";
//                    dataMap.put("samplingDetailList", samplingDetailList);
//                } else {
//                    List<TbSamplingDetailReport> samplingDetailList = tbSamplingDetailService.queryBySamplingId(id2);//根据抽样单id查询抽样单的详情
//                    viewName = "/sampling/sheet_2";
//                    //检测人员、时间
//                    //update by xiaoyl 2020/12/10 获取抽样单中最后检测的时间作为检测报告的时间
////                    String sql1 = "SELECT check_username checkUsername, check_user_signature checkUserSignature, upload_date uploadDate,GROUP_CONCAT(DISTINCT device_name) deviceName,GROUP_CONCAT(DISTINCT conclusion)  conclusion FROM data_check_recording where sampling_id=? group by check_userid order by upload_date desc";
//                    String sql1 = "SELECT check_username checkUsername, check_user_signature checkUserSignature, max(check_date) uploadDate,GROUP_CONCAT(DISTINCT device_name) deviceName,GROUP_CONCAT(DISTINCT conclusion)  conclusion FROM data_check_recording where sampling_id=? group by check_userid order by upload_date desc";
//                    List<Map<String, Object>> recordings = jdbcTemplate.queryForList(sql1, id);
//                    dataMap.put("recordings", recordings);
//                    //模板编号：001 默认，002 京东定制模板,处理匹配的检测项目数据
//                    if (null != SystemConfigUtil.REPORT_TEMPLATE && "002".equals(SystemConfigUtil.REPORT_TEMPLATE.getString("template_code"))) {
//                        //查询检测报告封面相关数据信息
//                        sql1 = "select GROUP_CONCAT(DISTINCT food_name) foodNae,GROUP_CONCAT(DISTINCT item_name) itemName, batch_number batchNumber,purchase_date purchaseDate from tb_sampling_detail where sampling_id=?";
//                        Map<String, Object> reportModel = jdbcTemplate.queryForMap(sql1, id);
//                        data.put("reportModel", reportModel);
//                        List<TbSamplingDetailReport> samplingDetailList2 = tbSamplingService.readItemGroupFile(request, samplingDetailList);
//                        dataMap.put("samplingDetailList", samplingDetailList2 == null ? samplingDetailList : samplingDetailList2);
//                    } else {
//                        dataMap.put("samplingDetailList", samplingDetailList);
//                    }
//                }
//                String rootPath = resources + samplingQr;
//                DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建
//                File qrFile = new File(rootPath + sampling.getQrcode());
//                if (!qrFile.exists()) {
//                    QrcodeUtil.generateSamplingQrcode(request, sampling.getQrcode(), samplingQrPath + sampling.getSamplingNo(), rootPath);
//                }
//                dataMap.put("samplingQr", samplingQr + sampling.getQrcode());
//                //根据抽样单所属检测ID配置正确的电子章 add by xiaoyl2020-07-18 武陵区项目不同检测点电子章不一样
//                String signatureFile = "";
//                //检测机构
//                String checkDepart = "";
//                BasePoint point = pointService.queryById(sampling.getPointId());
//                if (point != null) {
//                    checkDepart = point.getCheckDepart();
//                    if (StringUtil.isNotEmpty(point.getSignatureFile()) && point.getSignatureType() == 1) {//自定义电子签章
//                        signatureFile = "/resources/signatureFile/" + point.getSignatureFile();
//                    } else if (point.getSignatureType() == 2) {
//                        signatureFile = "";
//                    } else {
//                        signatureFile = defaultSignatureFile;
//                    }
//                } else {
//                    signatureFile = defaultSignatureFile;
//                }
//
//                //检测报告检测单位名称，默认检测机构
//                if (SystemConfigUtil.REPORT_TEMPLATE != null && "2".equals(SystemConfigUtil.REPORT_TEMPLATE.getString("check_depart"))) {
//                    dataMap.put("checkDepart", point.getPointName());
//                } else {
//                    dataMap.put("checkDepart", checkDepart);
//                }
//
//                dataMap.put("signatureFilePicture", signatureFile);
//                list.add(dataMap);
//            }
//            if (SystemConfigUtil.REPORT_TEMPLATE != null) {
//                if (type.equals("detail")) {
//                    viewName = SystemConfigUtil.REPORT_TEMPLATE.getString("detail");
//                } else {
//                    viewName = SystemConfigUtil.REPORT_TEMPLATE.getString("report");
//                }
//            }
//            //增加报告打印份数限制
//            if (SystemConfigUtil.SAMPLING_PRINT_CONFIG != null) {
//                data.put("printNumber", SystemConfigUtil.SAMPLING_PRINT_CONFIG.getString("printNumber"));
//            }
//            data.put("list", list);
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            return new ModelAndView("/common/404");
//        }
//        return new ModelAndView(viewName, data);
//    }
//
//
////	@RequestMapping("/samplingMap")
////	public ModelAndView samplingMap(HttpServletRequest request,HttpServletResponse response,String samplingId){
////		Map<String, Object> map = new HashMap<String, Object>();
////		String x = null;
////		String y = null;
////		try {
////			TbSampling sampling = tbSamplingService.getById(samplingId);
////			if(sampling != null){
////				x = sampling.getPlaceX();
////				y = sampling.getPlaceY();
////			}
////		} catch (Exception e) {
////			e.printStackTrace();
////		}
////		map.put("x", x);
////		map.put("y", y);
////		return new ModelAndView("/common/map",map);
////	}
//
//    /**
//     * 重发检测任务
//     *
//     * @param request
//     * @param response
//     * @return
//     */
//    @RequestMapping(value = "/issuedTask")
//    @ResponseBody
//    public AjaxJson issuedTask(HttpServletRequest request, HttpServletResponse response, Integer id) {
//        AjaxJson jsonObject = new AjaxJson();
//        try {
////			TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
////			Map<String,Object> map=new HashMap<>();
////
////			TbSampling sampling = tbSamplingService.getById(id);
////
////			List<TbSamplingDetail> list=tbSamplingDetailService.queryTaskBySamplingId(id);
////			if(list.size()==0){
////				jsonObject.setSuccess(false);
////				jsonObject.setMsg("全部任务已下发");
////				return jsonObject;
////			}
////			int count=tbSamplingService.updateReceviesStatus(list);
////			if(count==0){
////				jsonObject.setSuccess(false);
////				jsonObject.setMsg("此任务无仪器可接收");
////			}else if(count==-1){
////				jsonObject.setSuccess(false);
////				jsonObject.setMsg("任务下发失败");
////			}else if(count==1){
////				jsonObject.setMsg("任务下发成功");
////			}else if(count==2){
////				jsonObject.setMsg("部分任务下发成功");
////			}
//
//            TbSampling sampling = tbSamplingService.getById(id);
//            List<TbSamplingDetail> list = tbSamplingDetailService.queryTaskBySamplingId(id);
//
//            //重发任务数量
//            int taskNumber = 0;
//            for (TbSamplingDetail tbSamplingDetail : list) {
//                if (tbSamplingDetail.getStatus()==0) {
//                    taskNumber++;
//                    //仪器拒收后重发到另一台仪器
//                    samplingDetailRecevieService.updateStatus(PublicUtil.getSessionUser(), tbSamplingDetail.getId(), tbSamplingDetail.getRecevieDevice(), (short) 2, true);
//
//                    TbSamplingDetail samplingDetail = tbSamplingDetailService.queryById(tbSamplingDetail.getId());
//                    //所有仪器拒收任务
//                    if (StringUtil.isEmpty(samplingDetail.getRecevieDevice())) {
//                        //新一轮重发
//                        samplingDetailRecevieService.updateStatus(PublicUtil.getSessionUser(), tbSamplingDetail.getId(), "", (short) 2, true);
//
//                        //无接收仪器
//                        samplingDetail = tbSamplingDetailService.queryById(tbSamplingDetail.getId());
//                        if (StringUtil.isEmpty(samplingDetail.getRecevieDevice())) {
//                            taskNumber--;
//                        }
//                    }
//                }
//            }
//
//            if (taskNumber == 0) {
//                jsonObject.setMsg("不用下发，任务已接收");
//
//            } else {
//                jsonObject.setMsg("下发成功，数量："+taskNumber);
//            }
//
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObject.setSuccess(false);
//            jsonObject.setMsg("下发失败");
//        }
//        return jsonObject;
//    }
//
//    /**
//     * 你送我检抽样单列表
//     *
//     * @return
//     */
//    @RequestMapping("/sendSamplesList")
//    public ModelAndView sendSamplesList(HttpServletRequest request, HttpServletResponse response) {
//        Map<String, Object> data = new HashMap<String, Object>();
//        int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//        JSONObject config = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//        if (config != null &&  config.getInteger("systemFlag") != null) {
//            systemFlag = config.getInteger("systemFlag");
//        }
//        data.put("systemFlag",systemFlag);
//        return new ModelAndView("/sampling/sendSamples/list",data);
//    }
//
//    /**
//     * 进入新增送检单页面
//     *
//     * @param request
//     * @param response
//     * @param id
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/addSendSample")
//    public ModelAndView addSendSample(HttpServletRequest request, HttpServletResponse response, String id) throws Exception {
//        // add by xiaoyl 2020/10/30 武陵系统将抽样单默认抽样数量为0.5KG；
//        Map<String, Object> data = new HashMap<String, Object>();
//        int systemFlag=0;//系统标志，0 为通用系统，1 武陵定制系统；用于抽样单复核和修改"档口"为"摊位"做判断使用
//        JSONObject systemFlagConfig = SystemConfigUtil.SYSTEM_NAME_CONFIG;
//        if (systemFlagConfig != null &&  systemFlagConfig.getInteger("systemFlag") != null) {
//            systemFlag = systemFlagConfig.getInteger("systemFlag");
//        }
//        data.put("systemFlag",systemFlag);
//        return new ModelAndView("/sampling/sendSamples/edit",data);
//    }
//
//    /**
//     * 新增送检单
//     * @param bean
//     * @param details
//     * @param request
//     * @param response
//     * @return
//     */
//    @RequestMapping(value = "/saveSendSample")
//    @ResponseBody
//    public AjaxJson saveSendSample(HttpServletRequest request, HttpServletResponse response, TbSampling bean, String details, @RequestParam(value = "filePath", required = false) MultipartFile[] files) {
//        AjaxJson jsonObject = new AjaxJson();
//        try {
//            TSUser user = PublicUtil.getSessionUser();
//            if (null == user.getRegId() && null == user.getPointId()) {
//                jsonObject.setSuccess(false);
//                jsonObject.setMsg("机构用户不能新增送检单");
//                return jsonObject;
//            }
//
//            bean.setSamplingNo(WebConstant.SAMPLING_NUM4);
//            bean.setSamplingDate(new Date());
//            bean.setSamplingUserid(user.getId());
//            bean.setSamplingUsername(user.getRealname());
//            bean.setStatus((short) 0);
//
//            List<TbSamplingDetail> listDetail = JSONArray.parseArray(details, TbSamplingDetail.class);
//            tbSamplingService.addSampling(bean, listDetail, user, null);
//
//            String fPath = "";
//            String fileName = "";
//            Date date = null;
//            TbFile tbFile = new TbFile();
//            tbFile.setSourceType("shoppingRec");
//            if (files != null && files.length > 0) {//有上传数据
//                for (MultipartFile file : files) {
//                    if (file.getSize() > 0) {
//                        date = new Date();
//                        fPath = WebConstant.res.getString("filePath") + tbFile.getSourceType() + "/";    //文件目录
//                        String fName = DateUtil.formatDate(date, "yyyyMMddHHmmssSSS") + DyFileUtil.getFileExtension(file.getOriginalFilename());    //文件名
//                        fileName = uploadFile(request, fPath, file, fName);    //保存附件
//                        //购样小票写入附件上传记录
//                        tbFile.setFileName(fileName);
//                        tbFile.setSourceId(bean.getId());
//                        tbFile.setFilePath(WebConstant.res.getString("filePath") + tbFile.getSourceType() + "/" + fileName);
//                        if (tbFile.getSorting() == null) {
//                            tbFile.setSorting((short) 0);
//                        }
//                        tbFile.setDeleteFlag((short) 0);
//                        PublicUtil.setCommonForTable(tbFile, true, user);
//                        fileService.insert(tbFile);
//                    }
//                }
//            }
//
//        } catch (MyException e) {
//            jsonObject.setSuccess(false);
//            if (e.getText().contains("请更新食品种类数据")) {
//                jsonObject.setMsg("保存失败，检测样品数据异常，请刷新页面后重新录入！");
//            } else if (e.getText().contains("请更新检测项目数据")) {
//                jsonObject.setMsg("保存失败，检测项目数据异常，请刷新页面后重新录入！");
//            } else {
//                jsonObject.setMsg("保存失败，" + e.getText());
//            }
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObject.setSuccess(false);
//            jsonObject.setMsg("保存失败");
//        }
//        return jsonObject;
//    }
//
//    /**
//     * 你送我检抽样单列表
//     *
//     * @return
//     */
//    @RequestMapping("/sendResultList")
//    public ModelAndView sendResultList(HttpServletRequest request, HttpServletResponse response) {
//        return new ModelAndView("/sampling/sendSamples/resultList");
//    }
//
//    /**
//     * 更新报告打印次数
//     *
//     * @param samplingId
//     * @param request
//     * @param response
//     * @return
//     * @description
//     * @author xiaoyl
//     * @date 2020年7月18日
//     */
//    @RequestMapping(value = "/updatePrintNumber")
//    @ResponseBody
//    public AjaxJson updatePrintNumber(Integer samplingId, HttpServletRequest request, HttpServletResponse response) {
//        AjaxJson jsonObject = new AjaxJson();
//        try {
//            TSUser user = PublicUtil.getSessionUser();
//            TbSampling sampling = tbSamplingService.getById(samplingId);
//            sampling.setPrintNum((short) (sampling.getPrintNum() + 1));
//            sampling.setUpdateBy(user.getId());
//            sampling.setUpdateDate(new Date());
//            tbSamplingService.updateBySelective(sampling);
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            e.printStackTrace();
//            jsonObject.setSuccess(false);
//            jsonObject.setMsg("保存失败");
//        }
//        return jsonObject;
//    }
//
//    /**
//    * @Description 武陵系统：复核抽样单
//    * @Date 2020/10/29 13:26
//    * @Author xiaoyl
//    * @Param
//    * @return
//    */
//    @RequestMapping("/reviewSampling")
//    @ResponseBody
//    public AjaxJson reviewSampling(HttpServletRequest request, String ids, String reviewName,Integer pointId) {
//        AjaxJson jsonObj = new AjaxJson();
//        try {
//            TSUser user = PublicUtil.getSessionUser();
//            String approvalSignature="";
//            if(SystemConfigUtil.APPROVAL_SAMPLING_CONFIG!=null){
//              JSONArray configArray=SystemConfigUtil.APPROVAL_SAMPLING_CONFIG.getJSONArray("approval_signature");
//                for(Iterator iterator=configArray.iterator();iterator.hasNext();){
//                    JSONObject obj = (JSONObject) iterator.next();
//                    if(obj.getInteger("point_id").equals(pointId)) {//获取当前检测检测点的批准人配置信息
//                        if (StringUtil.isNotEmpty(obj.getString("approval_user_id"))){//有配置批准用户ID的，根据ID查找用户签名
//                            TSUser user1=tsUserService.queryById(obj.getString("approval_user_id"));
//                            if(user1!=null && StringUtil.isNotEmpty(user1.getSignatureFile())){//用户签名不为空，设置签名文件；否则的话获取配置中的批准人名字
//                                approvalSignature=user1.getSignatureFile();
//                            }else if(user1!=null){
//                                approvalSignature=user1.getRealname();
//                            }else{
//                                approvalSignature=obj.getString("approval_user_realname");
//                            }
//                        }else{
//                            approvalSignature=obj.getString("approval_user_realname");
//                        }
//                        break;
//                    }
//                }
//            }
//            String[] ida = ids.split(",");
//            if(ida.length==1){//复核单个订单
//                TbSampling sampling = tbSamplingService.getById(Integer.valueOf(ida[0]));
//                sampling.setApprovalSignature(approvalSignature);
//                sampling.setReviewSignature(reviewName);
//                tbSamplingService.updateBySelective(sampling);
//            }else if(ida.length>1){//批量复核
//                Integer[] idas = new Integer[ida.length];
//                for (int i = 0; i < ida.length; i++) {
//                    idas[i] = Integer.parseInt(ida[i]);
//                }
//                tbSamplingService.reviewSamplingBatch(idas,reviewName,approvalSignature,user.getId());
//            }
//
//        } catch (Exception e) {
//            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
//            jsonObj.setSuccess(false);
//            jsonObj.setMsg("操作失败");
//        }
//        return jsonObj;
//    }
//
//}
