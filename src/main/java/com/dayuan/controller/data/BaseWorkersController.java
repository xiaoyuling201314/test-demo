package com.dayuan.controller.data;

import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.system.TSType;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseWorkersModel;
import com.dayuan.service.data.BasePointUserService;
import com.dayuan.service.data.BaseWorkersService;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.service.system.TSTypeService;
import com.dayuan.util.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Timestamp;
import java.util.*;

/**
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月18日
 */
@Controller
@RequestMapping("/data/workers")
public class BaseWorkersController extends BaseController {
    private final Logger log = Logger.getLogger(BaseWorkersController.class);
    @Autowired
    private BaseWorkersService baseWorkersService;
    @Autowired
    private TSTypeService tSTypeService;
    @Autowired
    private TBImportHistoryService importHistoryService;
    @Autowired
    BasePointUserService basePointUserService;

    /**
     * 进入检测标准表页面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();

        TSType position = tSTypeService.queryByTypeCode("position");
        map.put("position", position);//职位选项
        return new ModelAndView("/data/workers/list", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(BaseWorkersModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSUser tsUser = PublicUtil.getSessionUser();
            model.setDepartId(tsUser.getDepartId());
            page = baseWorkersService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 进入机构人员列表页面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
//	@RequestMapping("/personnelList")
//	public ModelAndView personnelList(HttpServletRequest request,HttpServletResponse response,String departId,String pointId) throws Exception{
//		Map<String,Object> map = new HashMap<String,Object>();
//		if(StringUtil.isEmpty(departId)){
//			departId = "";
//		}
//		if(StringUtil.isEmpty(pointId)){
//			pointId = "";
//		}
//		map.put("departId", departId);
//		map.put("pointId", pointId);
//		return new ModelAndView("/data/workers/personnelList",map);
//	}

    /**
     * 保存
     *
     * @param bean
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(BaseWorkers bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        BaseWorkers worker = baseWorkersService.queryByWorkerName(bean.getWorkerName(), bean.getMobilePhone());
        try {
            if (StringUtils.isBlank(bean.getId())) {//新增数据
                if (worker == null) {
                    bean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(bean, true);
                    baseWorkersService.insert(bean);
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该人员已存在，请重新输入.");
                }
            } else {//修改数据
                PublicUtil.setCommonForTable(bean, false);
                if (worker == null || bean.getId().equals(worker.getId())) {
                    baseWorkersService.updateBySelective(bean);
                    //如果状态为离职,就把该人员的中间表信息删除
                    if (bean.getStatus() == 1) {
                        basePointUserService.deleteByUserId(bean.getId());
                    }
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该人员已存在，请重新输入.");
                }
            }

        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 查找数据，进入编辑页面
     *
     * @param id       数据记录id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public AjaxJson queryById(String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            BaseWorkers bean = baseWorkersService.queryById(id);
            if (bean == null) {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("没有找到对应的记录!");
            }
            jsonObject.setObj(bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        return jsonObject;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param request
     * @param response
     * @param ids      要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            //删除人员
            baseWorkersService.delete(ida);
            //移除检测点（删除中间表信息）
            for (String userId : ida) {
                basePointUserService.deleteByUserId(userId);
            }
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 查找数据，检测点页面添加人员
     */
    @RequestMapping("/queryWorkers")
    @ResponseBody
    public AjaxJson queryWorkers(HttpServletResponse response, String departId, String userName) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(departId)) {
                //机构下属人员
                List<BaseWorkers> workers = baseWorkersService.queryByDepartId(departId, userName);
                jsonObj.setObj(workers);
            } else {
                //闲置人员
                List<BaseWorkers> workers = baseWorkersService.queryIdleWorkers(userName);
                jsonObj.setObj(workers);
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("查询失败");
        }
        return jsonObj;
    }

    @RequestMapping(value = "/exportFile")
    @ResponseBody
    private ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response, HttpSession session, String types,
                                              BaseWorkersModel model, String status) {
        ResponseEntity<byte[]> responseEntity = null;
        TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("storageDirectory") + "workers/";
        String realPath = request.getServletContext().getRealPath("/");
        File logoSaveFile = new File(rootPath);
        if (!logoSaveFile.exists())
            logoSaveFile.mkdirs();

        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        String db = WebConstant.res.getString("db1");
        try {
            SXSSFWorkbook workbook = null;

            //model.setDepartId(tsUser.getDepartId());
            //model.getBaseBean().setStatu(Short.parseShort(status));

            BaseWorkers workers = new BaseWorkers();
            workers.setStatus(Short.parseShort(status));
            model.setBaseBean(workers);

            List<BaseWorkers> list = baseWorkersService.queryByList(model);
            if ("word".equals(types)) {
                String docName = fileName + ".doc";
                ItextTools.createWorkesWordDocument(rootPath, rootPath + docName, Excel.WORKE_HEADERS, list, null, request);
                responseEntity = DyFileUtil.download(request, response, rootPath, docName);
                return responseEntity;
            }

            String xlsName = fileName + ".xlsx";
            workbook = new SXSSFWorkbook(100);
            Excel.outputExcelFile(workbook, Excel.WORKE_HEADERS, Excel.WORKE_FIELDS, list, rootPath + xlsName, "1","");
            FileOutputStream fOut = new FileOutputStream(rootPath + xlsName);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            if ("excel".equals(types)) {
                responseEntity = DyFileUtil.download(request, response, rootPath, xlsName);
            } else if ("pdf".equals(types)) {
                if (!getLicense()) {
                    return null;
                }
                Workbook wb = new Workbook(rootPath + xlsName);
                String pdfName = fileName + ".pdf";
                wb.removeExternalLinks();
                wb.save(new FileOutputStream(new File(rootPath + pdfName)), SaveFormat.PDF);
                responseEntity = DyFileUtil.download(request, response, rootPath, pdfName);
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
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

    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request, Integer type) throws JSONException {
        request.setAttribute("type", type);
        return new ModelAndView("/data/workers/toImport");
    }

    @RequestMapping("/importData")
    @ResponseBody
    public AjaxJson importData(@RequestParam("xlsx") MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session, String departId) {
        AjaxJson jsonObject = new AjaxJson();
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String path = WebConstant.res.getString("resources") + "workers/";
        int successCount = 0;
        int failCount = 0;
        List<ImportBaseData> errList = new ArrayList<ImportBaseData>();
        TSUser user = (TSUser) session.getAttribute(WebConstant.SESSION_USER);

        try {
            fos = FileUtils.openOutputStream(new File(path + "/" + fileName));
            IOUtils.copy(file.getInputStream(), fos);
            org.apache.poi.ss.usermodel.Workbook workBook = WorkbookFactory.create(new FileInputStream(new File(path + "/" + fileName)));
            Sheet sheet = workBook.getSheetAt(0);
            Row row = null;
            int totalRow = sheet.getLastRowNum();
            TBImportHistory t = new TBImportHistory();
            for (int i = 1; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (isEmptyRow(row)) continue;
                String workerName = getCellValue(row.getCell(0));//人员名称,必填
                String genders = getCellValue(row.getCell(1));//性别
                String mobilePhone = getCellValue(row.getCell(2));//手机号码
                String position = getCellValue(row.getCell(3));//职位,必填
                String jobState = getCellValue(row.getCell(4));//人员状态
                String statu = getCellValue(row.getCell(5));//状态

                if (i == 1) {
                    if (!workerName.equals("人员名称") || !mobilePhone.equals("手机号码")) {
                        t.setRemark("导入数据的模板不正确");
                        jsonObject.setSuccess(false);
                        break;
                    }
                } else {
                    if (StringUtil.isEmpty(workerName)) {
                        addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "人员名称不能为空");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(mobilePhone)) {
                        addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "手机号码不能为空");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(position)) {
                        addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "职位不能为空");
                        failCount++;
                        continue;
                    }
                    //进行查询判断是否已经存在该人员
                    BaseWorkers worker = baseWorkersService.queryByWorkerName(workerName, mobilePhone);
                    if (worker != null) {
                        addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "该人员已经存在,不可重复导入");
                        failCount++;
                        continue;
                    }
                    BaseWorkers workers = new BaseWorkers();
                    workers.setId(UUIDGenerator.generate());
                    workers.setWorkerName(workerName);
                    if (StringUtil.isNotEmpty(genders)) {
                        if (("男").equals(genders)) {
                            workers.setGender((short) 0);
                        } else if (("女").equals(genders)) {
                            workers.setGender((short) 1);
                        } else {
                            addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "请正确填写性别格式");
                            failCount++;
                            continue;
                        }
                    }

                    workers.setMobilePhone(mobilePhone);
                    workers.setPosition(position);
                    if (StringUtil.isNotEmpty(jobState)) {
                        if (("正式").equals(jobState)) {
                            workers.setJobState(jobState);
                        } else if (("实习").equals(jobState)) {
                            workers.setJobState(jobState);
                        } else if (("试用").equals(jobState)) {
                            workers.setJobState(jobState);
                        } else {
                            addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "请正确填写人员状态格式");
                            failCount++;
                            continue;
                        }
                    }
                    if (StringUtil.isNotEmpty(statu)) {
                        if (("离职").equals(statu)) {
                            workers.setStatus((short) 1);
                        } else if (("在职").equals(statu)) {
                            workers.setStatus((short) 0);
                        } else {
                            addToErrList(errList, workerName, genders, mobilePhone, position, jobState, statu, "请正确填写状态格式");
                            failCount++;
                            continue;
                        }
                    }

                    PublicUtil.setCommonForTable(workers, true);
                    baseWorkersService.insertSelective(workers);
                    successCount++;
                }
            }
            String errFile = null;
            if (errList.size() > 0) {
                errFile = fileName.substring(0, fileName.indexOf(".")) + "_err.xlsx";
                SXSSFWorkbook wb = new SXSSFWorkbook(80);
                Excel.outputExcelFile(wb, ImportBaseData.headers, ImportBaseData.fields, errList, path + errFile, "1","");
                FileOutputStream fOut = new FileOutputStream(path + "/" + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
            }

            t.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            t.setUserId(user.getId());
            t.setUsername(user.getRealname());
            t.setSourceFile("/workers/" + fileName);
            t.setErrFile(errFile == null ? null : "/workers/" + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(stamp);
            t.setImportType(4);
            t.setEndDate(new Date());
            importHistoryService.insertSelective(t);
            jsonObject.setMsg(errFile);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("导入失败");
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                log.error("******************************" + e.getMessage() + e.getStackTrace());
            }
        }
        return jsonObject;
    }

    private void addToErrList(List<ImportBaseData> errList, String workerName, String genders, String mobilePhone, String position, String jobState, String statu,
                              String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setWorkerName(workerName);
        d.setGenders(genders);
        d.setMobilePhone(mobilePhone);
        d.setPosition(position);
        d.setJobState(jobState);
        d.setStatu(statu);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    public static class ImportBaseData {
        public static String[] headers = {"人员名称", "性别", "手机号码", "职位", "人员状态", "状态", "导入失败原因"};
        public static String[] fields = {"workerName", "genders", "mobilePhone", "position", "jobState", "statu", "errMsg"};
        String workerName;// 人员名称
        String genders;// 性别
        String mobilePhone;//手机号码
        String position;//职位
        String jobState;//人员状态
        String statu;//状态
        String errMsg;// 导入失败原因

        public static String[] getHeaders() {
            return headers;
        }

        public static void setHeaders(String[] headers) {
            ImportBaseData.headers = headers;
        }

        public static String[] getFields() {
            return fields;
        }

        public static void setFields(String[] fields) {
            ImportBaseData.fields = fields;
        }

        public String getWorkerName() {
            return workerName;
        }

        public void setWorkerName(String workerName) {
            this.workerName = workerName;
        }

        public String getGenders() {
            return genders;
        }

        public void setGenders(String genders) {
            this.genders = genders;
        }

        public String getMobilePhone() {
            return mobilePhone;
        }

        public void setMobilePhone(String mobilePhone) {
            this.mobilePhone = mobilePhone;
        }

        public String getPosition() {
            return position;
        }

        public void setPosition(String position) {
            this.position = position;
        }

        public String getJobState() {
            return jobState;
        }

        public void setJobState(String jobState) {
            this.jobState = jobState;
        }

        public String getStatu() {
            return statu;
        }

        public void setStatu(String statu) {
            this.statu = statu;
        }

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }
    }

}
