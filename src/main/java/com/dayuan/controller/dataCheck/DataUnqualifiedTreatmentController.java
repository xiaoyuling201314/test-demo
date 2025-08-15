package com.dayuan.controller.dataCheck;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TbFile;
import com.dayuan.bean.dataCheck.DataCheckHistoryRecording;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.dataCheck.DataUnqualifiedConfig;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.bean.ledger.BaseLedgerStock;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.mapper.dataCheck.DataUnqualifiedTreatmentMapper;
import com.dayuan.model.dataCheck.CheckResultModel;
import com.dayuan.model.dataCheck.DataUnqualifiedRecordingModel;
import com.dayuan.model.dataCheck.DataUnqualifiedTreatmentModel;
import com.dayuan.service.DataCheck.*;
import com.dayuan.service.data.TbFileService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.ledger.BaseLedgerStockService;
import com.dayuan.service.sampling.TbSamplingDetailService;
import com.dayuan.util.*;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.util.ModularConstant;
import com.dayuan3.common.util.SystemConfigUtil;
import com.ibm.icu.text.SimpleDateFormat;
import net.sf.json.JSONObject;
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
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * 不合格处理
 *
 * @author Bill
 */
@Controller
@RequestMapping("/dataCheck/unqualified")
public class DataUnqualifiedTreatmentController extends BaseController {
    private final Logger log = Logger.getLogger(DataUnqualifiedTreatmentController.class);
    @Autowired
    private DataCheckRecordingService dataCheckRecordingService;
    @Autowired
    private DataCheckHistoryRecordingService dataCheckHistoryRecordingService;
    @Autowired
    private DataUnqualifiedTreatmentService treatmentService;
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
    @Autowired
    private GSDataUnqualifiedTreatmentService gsDataUnqualifiedTreatmentService;

    @Autowired
    private TSDepartService departService;

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
        return new ModelAndView("/dataCheck/unqualified/list");
    }

    /**
     * 进入处理中列表
     */
    @RequestMapping("/dissentList")
    public ModelAndView dissentList(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/dataCheck/unqualified/dissentList");
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
        return new ModelAndView("/dataCheck/unqualified/affirmList");
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
            //选定检测机构查询数据
            if (model.getDepartId() != null) {
                List<Integer> dil = departService.querySonDeparts(model.getDepartId());
                Integer[] dia = new Integer[dil.size()];
                dil.toArray(dia);
                model.setDepartArr(dia);
            }else if (isQueryAllData == 0) {
                Map map = treatmentService.dataPermission("/dataCheck/unqualified/list.do");
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

//            page = dealMethod != null && dealMethod == 1 ? treatmentService.loadDealDatagrid(page, model) : treatmentService.loadDatagrid(page, model);
            page = dealMethod != null && dealMethod == 1 ? treatmentService.loadDatagrid(page, model, DataUnqualifiedTreatmentMapper.class, "loadDealDatagrid", "getDealRowTotal") : treatmentService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("**********" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
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
            log.error("******" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作失败");
        }
        return jsonObject;
    }

    /**
     * 进入待处理操作界面
     */
    @RequestMapping("/goHandle")
    public ModelAndView hand(HttpServletRequest request, HttpServletResponse response, Integer id) {
        //不合格处理方法
        Map<String, Object> map = new HashMap<String, Object>();
        List<DataUnqualifiedConfig> configList = configService.getList();
        CheckResultModel checkResult = dataCheckRecordingService.getRecording(id);

        map.put("checkResult", checkResult);
        map.put("configList", configList);
        return new ModelAndView("/dataCheck/unqualified/hand", map);
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
            CheckResultModel checkResult = dataCheckRecordingService.getRecording(id);
            List<DataCheckHistoryRecording> checkHistoryList = dataCheckHistoryRecordingService.selectCheckHistoryByRid(id);
            map.put("checkResult", checkResult);
            map.put("configList", configList);
            map.put("checkHistoryList", checkHistoryList);
        } catch (Exception e) {
            log.error("******" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
        }
        return new ModelAndView("/dataCheck/unqualified/handling", map);
    }

    /**
     * 有异议保存到处理中
     *
     * @param request
     * @param response
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping("/dissent")
    public ModelAndView dissent(HttpServletRequest request, HttpServletResponse response, Integer id) throws Exception {
        if (null != id) {
            DataCheckRecording dataCheck = new DataCheckRecording();
            dataCheck.setId(id);
            dataCheckRecordingService.updateById(dataCheck);
        }
        return new ModelAndView("/dataCheck/list");
    }
    /**
     *delete by xiaoyl 2022/03/11 不合格处理取证材料图片太大，需要进一步处理
     * 进行处理保存(待处理)
     * @param request
     * @return
     *
     @RequestMapping("/save")
     @ResponseBody public AjaxJson save(HttpServletRequest request, DataUnqualifiedTreatmentModel dataCheckModel, @RequestParam(required = false, value = "dealImgurlFile") MultipartFile[] files) {
     AjaxJson jsonObj = new AjaxJson();
     try {
     //新增/更新不合理处理表236
     int treatmentId = treatmentService.addSelective(dataCheckModel, null, null);
     if (files.length > 0 && !files[0].isEmpty()) {
     for (MultipartFile file : files) {
     //保存不合格处理监督人签名
     String fPath1 = WebConstant.res.getString("filePath") + "Enforce" + "/";    //文件目录
     String fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());    //文件名
     String fileName1 = uploadFile(request, fPath1, file, fName1);    //保存附件

     TbFile tbFile = new TbFile();
     tbFile.setSourceId(treatmentId);
     tbFile.setSourceType("Enforce");
     tbFile.setFileName(fileName1);
     tbFile.setFilePath(fPath1 + fileName1);
     if (tbFile.getSorting() == null) {
     tbFile.setSorting((short) 0);
     }
     tbFile.setDeleteFlag((short) 0);
     PublicUtil.setCommonForTable(tbFile, true);
     fileService.insert(tbFile);
     }
     }
     //保存签名
     String spersonName = dataCheckModel.getTreatment().getSpersonName();//送检人签名
     String supervisor = dataCheckModel.getTreatment().getSupervisor();//监督人签名
     String type2 = WebConstant.FILE_TYPE2;
     String fPath = WebConstant.res.getString("filePath") + type2 + "/";    //文件目录
     File file6 = new File(resources + "/" + fPath );
     if (!file6.exists() && !file6.isDirectory()) {
     file6.mkdirs();
     }
     String fileName = UUIDGenerator.generate() + DateUtil.yyyymmddhhmmss.format(new Date()) + ".jpg";
     String path = resources + "/" + fPath + "/" + fileName;
     String name = "";
     if (StringUtil.isNotEmpty(spersonName)) {
     name = spersonName;
     }
     if (StringUtil.isNotEmpty(supervisor)) {
     name = supervisor;
     }
     if (StringUtil.isNotEmpty(name)) {
     CreateImgUtil.createImage(path, name);
     //创建tbFile 保存如库
     TbFile tbFile = new TbFile();
     tbFile.setSourceId(treatmentId);
     tbFile.setSourceType(type2);
     tbFile.setFileName(fileName);
     tbFile.setFilePath(fPath + fileName);
     if (tbFile.getSorting() == null) {
     tbFile.setSorting((short) 0);
     }
     tbFile.setDeleteFlag((short) 0);
     PublicUtil.setCommonForTable(tbFile, true);
     fileService.insert(tbFile);
     }
     } catch (Exception e) {
     log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
     e.printStackTrace();
     jsonObj.setSuccess(false);
     jsonObj.setMsg("操作失败" + e.getMessage());
     }
     return jsonObj;
     }
     */

    /**
     * 进行处理保存(待处理)
     *
     * @param request
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxJson save(HttpServletRequest request, DataUnqualifiedTreatmentModel dataCheckModel, @RequestParam(required = false, value = "dealImgurlFile") MultipartFile[] files) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            //新增/更新不合理处理表236
            int treatmentId = treatmentService.addSelective(dataCheckModel, null, null);
            if (files.length > 0 && !files[0].isEmpty()) {
                for (MultipartFile file : files) {
                    //保存取证材料 update by xiaoyl 2022-03-14
                    String fPath1 = WebConstant.res.getString("filePath") + "Enforce" + "/";    //文件目录
                    String fName1 = "";
                    String fileName1 = "";
                    if (file.getContentType().indexOf("image") > -1) {//表示是图片
                        //将不合格处理图片生成缩略图,获取原图的宽高
//                        BufferedImage bufferedImage = ImageIO.read(file.getInputStream());
//                        fName1 = UUIDGenerator.generate()+"_"+bufferedImage.getWidth()+"x"+bufferedImage.getHeight()+DyFileUtil.getFileExtension(file.getOriginalFilename());	//文件名
                        fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());    //文件名
                        fileName1 = uploadFile(request, fPath1, file, fName1);    //保存附件
                        String filePath = resources + fPath1 + fName1;
                        String directoryPath = resources + fPath1 + thumbnailPath;
                        //生成缩略图
                        ImageDealUtil.GenerateFixedSizeImage(filePath, 30, 30, directoryPath);
                    } else {//其他格式处理，例如视频
                        fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());    //文件名
                        fileName1 = uploadFile(request, fPath1, file, fName1);    //保存附件
                    }

                   /* delete by xiaoyl 2022-03-14 不合格处理取证图片直接上传方式
                    String fPath1 = WebConstant.res.getString("filePath") + "Enforce" + "/";    //文件目录
                    String fName1 = UUIDGenerator.generate() + DyFileUtil.getFileExtension(file.getOriginalFilename());    //文件名
                    String fileName1 = uploadFile(request, fPath1, file, fName1);    //保存附件*/

                    TbFile tbFile = new TbFile();
                    tbFile.setSourceId(treatmentId);
                    tbFile.setSourceType("Enforce");
                    tbFile.setFileName(fileName1);
                    tbFile.setFilePath(fPath1 + fileName1);
                    if (tbFile.getSorting() == null) {
                        tbFile.setSorting((short) 0);
                    }
                    tbFile.setDeleteFlag((short) 0);
                    PublicUtil.setCommonForTable(tbFile, true);
                    fileService.insert(tbFile);
                }
            }
            //保存签名
            String spersonName = dataCheckModel.getTreatment().getSpersonName();//送检人签名
            String supervisor = dataCheckModel.getTreatment().getSupervisor();//监督人签名
            String type2 = WebConstant.FILE_TYPE2;
            String fPath = WebConstant.res.getString("filePath") + type2 + "/";    //文件目录
            File file6 = new File(resources + "/" + fPath);
            if (!file6.exists() && !file6.isDirectory()) {
                file6.mkdirs();
            }

            //不用监督人姓名生成签名文件 -Dz 20220815
//            String fileName = UUIDGenerator.generate() + DateUtil.yyyymmddhhmmss.format(new Date()) + ".jpg";
//            String path = resources + "/" + fPath + "/" + fileName;
//            String name = "";
//            if (StringUtil.isNotEmpty(spersonName)) {
//                name = spersonName;
//            }
//            if (StringUtil.isNotEmpty(supervisor)) {
//                name = supervisor;
//            }
//            //根据监督人姓名生成签名文件
//            if (StringUtil.isNotEmpty(name)) {
//                CreateImgUtil.createImage(path, name);
//                //创建tbFile 保存如库
//                TbFile tbFile = new TbFile();
//                tbFile.setSourceId(treatmentId);
//                tbFile.setSourceType(type2);
//                tbFile.setFileName(fileName);
//                tbFile.setFilePath(fPath + fileName);
//                if (tbFile.getSorting() == null) {
//                    tbFile.setSorting((short) 0);
//                }
//                tbFile.setDeleteFlag((short) 0);
//                PublicUtil.setCommonForTable(tbFile, true);
//                fileService.insert(tbFile);
//            }

            //add by xiaoyl 2022/05/19 start 根据系统参数配置是否更新不合格处理考核状态,如果没有配置系统参数则设置默认为1关闭
            Integer assessmentState = SystemConfigUtil.GS_ASSESSMENT_CONFIG==null? 1 : SystemConfigUtil.GS_ASSESSMENT_CONFIG.getInteger("assessment_state");
            if(null!=assessmentState && assessmentState==0){//过滤掉已删除的数据
                gsDataUnqualifiedTreatmentService.updateSingleHandledAssessment(dataCheckModel.getTreatment().getCheckRecordingId(),null);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败" + e.getMessage());
        }

        return jsonObj;
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
        CheckResultModel checkResult = treatmentService.getRecording(id);
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
        return new ModelAndView("/dataCheck/unqualified/handled", map);
    }

    /**
     * 下载文件
     *
     * @param request
     * @param response
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping("/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request, HttpServletResponse response, Integer id) {
        DataUnqualifiedTreatment bean = null;
        ResponseEntity<byte[]> responseEntity = null;
        try {
            bean = treatmentService.queryById(id);
            String realpath = WebConstant.res.getString("resources") + "dealImg/";
            responseEntity = download(request, realpath, bean.getDealImgurl());
        } catch (Exception e) {
            log.error("文件下载异常**********************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        if (responseEntity != null) {
            return responseEntity;
        } else {
            HttpHeaders headers = new HttpHeaders();
            MediaType mediaType = new MediaType("text", "html", StandardCharsets.UTF_8);
            headers.setContentType(mediaType);
            String message = "下载文件不存在!!!<a href='/dykjfw2/dataCheck/unqualified/affirmList.do'><i class='icon iconfont icon-fanhui'></i>返回</a>";
            return new ResponseEntity(message, headers, HttpStatus.OK);
        }
    }

    /**
     * 使用Ajax异步上传图片
     *
     * @param pic      封装图片对象
     * @param request
     * @param response
     * @throws IOException
     * @throws IllegalStateException
     */
    @RequestMapping("/uploadPic")
    public void uploadPic(MultipartFile pic, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {

        try {
            // 获取图片原始文件名
            String originalFilename = pic.getOriginalFilename();
            System.out.println(originalFilename);

            // 文件名使用当前时间
            String name = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());

            // 获取上传图片的扩展名
            String extension = FilenameUtils.getExtension(originalFilename);

            // 图片上传的相对路径（因为相对路径放到页面上就可以显示图片）
            String path = "/img/dataCheck/" + name + "." + extension;

            // 图片上传的绝对路径
            String url = request.getSession().getServletContext().getRealPath("") + path;

            File dir = new File(url);

            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 上传图片
            pic.transferTo(new File(url));

            // 将相对路径写回（json格式）
            JSONObject jsonObject = new JSONObject();
            // 将图片上传到本地
            jsonObject.put("path", path);

            // 设置响应数据的类型json
            response.setContentType("application/json; charset=utf-8");
            // 写回
            response.getWriter().write(jsonObject.toString());

        } catch (Exception e) {
            log.error("**********" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            throw new RuntimeException("服务器繁忙，上传图片失败");
        }
    }

    @RequestMapping("/see_picture")
    public String seeFileCommentViews(Model model, String url) throws Exception {
        model.addAttribute("src", "/resources/" + url);
        return "/dataCheck/unqualified/seejpg";
    }

    /**
     * 查看检测历史数据（复检数据）
     *
     * @param model
     * @param rid
     * @return
     * @throws Exception
     */
    @RequestMapping("/check_history")
    public String checkHistory(Model model, Integer rid) throws Exception {
        List<DataCheckHistoryRecording> checkHistoryList = dataCheckHistoryRecordingService.selectCheckHistoryByRid(rid);
        CheckResultModel checkResult = dataCheckRecordingService.getRecording(rid);
        //BaseLedgerStock ledgerStock = null;    //溯源
        List<DataUnqualifiedConfig> configList = configService.getList();
        Date date = checkResult.getSamplingDate() != null ? checkResult.getSamplingDate() : checkResult.getCheckDate();    //有抽样时间，用抽样时间查询台账，否则用检测时间查询
        //ledgerStock = baseLedgerStockService.queryByBatchNumber(checkResult.getRegId(), checkResult.getOpeId(), checkResult.getFoodName(), checkResult.getBatchNumber(), DateUtil.formatDate(date, "yyyy-MM-dd"));
        model.addAttribute("checkResult", checkResult);
        model.addAttribute("configList", configList);
        model.addAttribute("checkHistoryList", checkHistoryList);
        return "/dataCheck/unqualified/check_history";
    }


    /**
     * 查询其溯源信息 暂时没调用该方法
     *
     * @param rId 检测数据ID
     * @return
     */
    @RequestMapping("/sourceData")
    @ResponseBody
    public AjaxJson queryDataCheckByRegobjId(Integer rId) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            //1.去查询其抽样单明细（内也可能含有溯源信息）
            Map<String, Object> map = tbSamplingDetailService.selectDetailByRid(rId);
            String souce = WebConstant.res.getString("toSource");
            map.put("souce", souce);
            if (souce.equals("1")) {//获取台账管理信息
                //2.然后根据抽样单明显信息去查询溯源表中数据（看配置toSource 字段 为1展示溯源表中数据，如果数据为空就展示明显表中数据）
                BaseLedgerStock ledgerStock = tbSamplingDetailService.selectSource((Integer) map.get("regId"), (Integer) map.get("opeId"), (String) map.get("foodName"), (String) map.get("batchNumber"));//根据经营户查询溯源信息
                map.put("ledgerStock", ledgerStock);
            }
            ajaxJson.setObj(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ajaxJson;
    }

    /**
     * @return
     * @Description 不合格处理中：已处理数据存档，有权限的用户可以查看到整个系统的已处理数据
     * @Date 2020/11/19 10:00
     * @Author xiaoyl
     * @Param
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
        return new ModelAndView("/dataCheck/unqualified/affirmListFile");
    }

    /**
     * 删除不合格处理数据
     *
     * @param request
     * @param id      不合格处理数据ID
     * @param remark  备注
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(HttpServletRequest request, String id, String remark) {
        AjaxJson aj = new AjaxJson();
        try {
            treatmentService.deleteData(id);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("操作失败，请联系工作人员。");
        }
        logUtilService.saveOperatorLog(2, ModularConstant.OPERATION_MODULE_UNQUALIFIED, this.getClass().toString(), "delete",
                "删除不合格处理数据，备注：" + remark, aj.isSuccess(), aj.getMsg(), request);
        return aj;
    }

    /**
     * @return
     * @Description 查看检测数据的复检记录
     * @Date 2022/02/28 10:40
     * @Author xiaoyl
     * @Param id 检测数据ID
     * @Param sampleCode 样品编号，选填，有就传没有就不传，用于数据页面展示使用
     */
    @RequestMapping("/history")
    public ModelAndView history(Model model, Integer id, String sampleCode) {
        model.addAttribute("id", id);
        model.addAttribute("sampleCode", sampleCode);
        return new ModelAndView("/dataCheck/unqualified/history");
    }

    /**
     * 查询不合格复检历史记录表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagridForRecheck")
    @ResponseBody
    public AjaxJson datagridForRecheck(DataUnqualifiedRecordingModel model, @RequestParam(required = false, defaultValue = "0") Integer isQueryAllData, Page page, String treatmentDateStartDate, String treatmentDateEndDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (isQueryAllData == 0) {
                Map map = dataCheckHistoryRecordingService.dataPermission("/dataCheck/unqualified/list.do");
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
            page = dataCheckHistoryRecordingService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("**********" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * @return
     * @Description 根据指定目录生成缩略图
     * @Date 2022/03/14 14:41
     * @Author xiaoyl
     * @Param startDate 获取指定开始日期之后的文件进行生成缩略图
     */
    @RequestMapping("/GenerateThumbnail")
    @ResponseBody
    public AjaxJson GenerateThumbnail(HttpServletRequest request,@RequestParam(defaultValue = "2000-01-01",required = false) String startDate) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            //要生成缩略图的目录
            String oldFilePath = resources + WebConstant.res.getString("filePath") + "Enforce" + "/";
            //缩略图存放目录
            String directoryPath = oldFilePath + thumbnailPath;
            File[] file = new File(oldFilePath).listFiles();
            Date beginGeneratorDate=DateUtil.date_sdf.parse(startDate);
            for (File fileItem : file) {
//                String ext = FilenameUtils.getExtension(fileItem.getName());
                //StringUtils.isNotBlank(ext) &&
                if (ImageDealUtil.checkIsImage(fileItem.getName()) && !fileItem.isDirectory()) {
                    //判断修改时间是否为指定日期之后
                    if(fileItem.lastModified()>beginGeneratorDate.getTime()){
                        //调用单张图片生成缩略图方法
                        ImageDealUtil.GenerateFixedSizeImage(fileItem.getPath(), 30, 30, directoryPath);
                    }

                }
            }
            //直接使用根据文件夹生成有子目录或者视频有问题
//           ImageDealUtil.GenerateDirectoryThumbnail(oldFilePath,30,30,directoryPath);
        } catch (Exception e) {
            log.error("**********" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败：" + e.getMessage());
        }
        return jsonObj;
    }
    /**
     * 疑似不合格数据查询：首次检测结果为不合格的检测数据，复检结果为阴性则不再显示，复检结果为阳性则不显示并进入待处理，
     */
    @RequestMapping("/suspected_list")
    public ModelAndView suspectedList(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/dataCheck/unqualified/suspected_list");
    }
    /**
    * @Description 修改疑似阳性数据为已审核状态
    * @Date 2022/11/24 11:41
    * @Author xiaoyl
    * @Param
    * @return
    */
    @RequestMapping("/updateReviewStatus")
    @ResponseBody
    public AjaxJson updateReviewStatus(Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser user = PublicUtil.getSessionUser();
            dataCheckRecordingService.updateReviewStatus(ids,user.getId());
            //删除抽样单数据前，删除抽样单明细和抽样单购样小票文件
        } catch (Exception e) {
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败" + e.getMessage());
        }
        return jsonObj;
    }

}
