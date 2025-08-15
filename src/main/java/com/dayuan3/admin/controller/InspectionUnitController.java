package com.dayuan3.admin.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.util.*;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.admin.bean.chain.ColdChainUnit;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.admin.service.chain.ColdChainUnitService;
import com.dayuan3.api.vo.InspectionUnitRespVo;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.terminal.model.InspectionUnitModel;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

/**
 * Description 冷链仓口管理
 * @Author xiaoyl
 * @Date 2025/6/10 14:33
 */
@Controller
@RequestMapping("/inspection/unit")
public class InspectionUnitController extends BaseController {
    private Logger log = Logger.getLogger(InspectionUnitController.class);
    @Value("${resources}")
    private String resources;
    @Autowired
    private InspectionUnitService inspectionUnitService;

    @Autowired
    private TBImportHistoryService importHistoryService;// 用于记录导入人员的信息

    @Autowired
    private ColdChainUnitService coldChainUnitService;//用于联查ColdUnitId

    /**
     * 进入页面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();

        // 获取前端传来的 regId
        String coldUnitId = request.getParameter("regId");
        map.put("coldUnitId", coldUnitId);

        map.put("inspectionUnitPath", WebConstant.res.getString("inspectionUnitPath"));
        return new ModelAndView("/terminal/inspection/list", map);
    }

    /**
     * 数据列表
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(InspectionUnitModel model, Page page, Integer coldUnitId,Short companyType,HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();

        if(coldUnitId!=null) {
            model.setColdUnitId(coldUnitId);
        }
        if(companyType!=null){
            model.setCompanyType(companyType);
        }
        //System.out.println("coldid:"+coldUnitId);
        try {
            page.setOrder("DESC");
            page = inspectionUnitService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * @param request
     * @param response
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月18日
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(InspectionUnit bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            if (bean.getId() == null) {
                InspectionUnit model = inspectionUnitService.queryByCreditCode(bean.getCreditCode());
                if (model == null) {
                    PublicUtil.setCommonForTable(bean, true, null);
                    inspectionUnitService.insertSelective(bean);
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该单位已被登记过，请输入正确的单位信息！");
                }
            } else {
                if (null == bean.getCompanyName()) {
                    bean.setCompanyName("");
                }
                if (null == bean.getCreditCode()) {
                    bean.setCreditCode("");
                }
                if (null == bean.getLegalPerson()) {
                    bean.setLegalPerson("");
                }
                if (null == bean.getLegalPhone()) {
                    bean.setLegalPhone("");
                }
                if (null == bean.getLinkUser()) {
                    bean.setLinkUser("");
                }
                if (null == bean.getLinkPhone()) {
                    bean.setLinkPhone("");
                }
                if (null == bean.getCompanyAddress()) {
                    bean.setCompanyAddress("");
                }
                if (null == bean.getRemark()) {
                    bean.setRemark("");
                }
                PublicUtil.setCommonForTable(bean, false, null);
                inspectionUnitService.updateBySelective(bean);
                CommonDataController.inspectionList = null;
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
     * @param id   数据记录id
     * @param type 0企业，1个人
     * @throws Exception
     */
    @RequestMapping("/queryById")
    public String queryById(Model model, Integer id, Integer type) {
        try {
            model.addAttribute("id", id);
            model.addAttribute("type", type);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return "/terminal/inspection/add";
    }


    /**
     * 根据冷链单位ID查询经营者列表
     */
    @RequestMapping(value = "/queryByColdUnitId")
    @ResponseBody
    public AjaxJson queryByColdUnitId(@RequestParam("coldUnitId") Integer coldUnitId,
                                      @RequestParam(value = "companyCode", required = false) String companyCode) {
        AjaxJson json = new AjaxJson();
        try {
            List<InspectionUnitRespVo> list = inspectionUnitService.queryByColdId(coldUnitId, companyCode);
            json.setSuccess(true);
            json.setObj(list);
        } catch (Exception e) {
            log.error("查询经营者失败：" + e.getMessage(), e);
            json.setSuccess(false);
            json.setMsg("查询经营者失败");
        }
        return json;
    }


    /**
     * 送检单位编辑界面数据回显
     *
     * @param id 项目ID
     * @return
     */
    @RequestMapping("/edit_echo")
    @ResponseBody
    public AjaxJson editEcho(Integer id) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            InspectionUnit inspectionUnit = inspectionUnitService.queryById(id);
            ajaxJson.setObj(inspectionUnit);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("操作失败");
        }
        return ajaxJson;
    }

    /**
     * 删除数据，单条删除与批量删除通用方法
     *
     * @param ids    s  要删除的数据记录id集合
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            inspectionUnitService.delete(ids);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 查询送检单位二维码
     *
     * @param request
     * @param response
     * @param ids
     * @return
     */
    @RequestMapping("/inspectionQrcode")
    @ResponseBody
    public AjaxJson InspectionQrcode(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson aj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("inspectionQr");
            DyFileUtil.createFolder(rootPath);// 判断该目录是否存在，不存在则进行创建

            InspectionUnit unit = null;
            List qrcodes = new ArrayList(); // 二维码
            for (String unitId : ida) {
                Map<String, Object> map = new HashMap<String, Object>();
                unit = inspectionUnitService.queryById(Integer.parseInt(unitId));
                if (unit == null) {
                    throw new Exception("查看送检单位二维码失败，委托单位不存在！");
                }

                if (StringUtil.isNotEmpty(unit.getQrcode())) {
                    // 读取二维码
                    File qrFile = new File(rootPath + unit.getQrcode());
                    if (!qrFile.exists()) {
                        QrcodeUtil.generateSamplingQrcode(request, unit.getQrcode(),
                                WebConstant.res.getString("inspectionUnitPath") + unit.getId(), rootPath);
                    }
                } else {
                    // 生成二维码
                    String qrcodeName = UUIDGenerator.generate() + ".png";
                    QrcodeUtil.generateSamplingQrcode(request, qrcodeName,
                            WebConstant.res.getString("inspectionUnitPath") + unit.getId(), rootPath);
                    unit.setQrcode(qrcodeName);
                    inspectionUnitService.updateBySelective(unit);
                }
                map.put("qrcodeSrc", "/resources/" + WebConstant.res.getString("inspectionQr") + unit.getQrcode());
                map.put("qrcodeName", unit.getCompanyName());
                qrcodes.add(map);
            }
            aj.setObj(qrcodes);
        } catch (Exception e) {
            aj.setSuccess(false);
            log.error("********************************" + e.getMessage() + e.getStackTrace());
        }
        return aj;
    }

    /**
     * 送检单位导入页面 shit 2019-09-04
     *
     * @param request
     * @param companyType 0：企业 1：个人
     * @return
     * @throws JSONException
     */
    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request, Integer companyType) throws JSONException {
        request.setAttribute("type", companyType);
        String from = request.getParameter("from");
        request.setAttribute("fromPage",from);
        return new ModelAndView("/terminal/inspection/toImport");
    }

    /**
     * 送检单位导入页面 shit 2019-09-04
     *
     * @return
     * @throws JSONException
     */
    @RequestMapping("/toImport2")
    private ModelAndView toImport2() throws JSONException {
        return new ModelAndView("/terminal/inspection/toImport2");
    }

    /**
     * 送检单位导入方法
     *
     * @param file 导入的excel文件
     * @param type 0：企业 1：个人
     * @return
     */
    @RequestMapping("/importData")
    @ResponseBody
    public AjaxJson importData(@RequestParam("file") MultipartFile file, Short type) {
        AjaxJson jsonObject = new AjaxJson();
        // 1.获取当前时间戳，设置保存的导入文件名称，设置导入文件存放地址
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String mypath = "/inspection/unit/";
        String path = resources + mypath;
        int successCount = 0; // 导入成功条数
        int failCount = 0; // 导入失败条数
        List<ImportBaseData> errList = new ArrayList<>();

        // 定义所有的字段
        Integer coldUnitId = null;
        String departName=null;//所属机构名称
        String regName=null;//冷链单位名称

        String companyName = null; // 姓名/单位名称
        String companyCode = null;
        String companyType = null; // 单位类型,非必填，有默认值
        String creditCode = null; // 身份证号码/社会信用代码
        String legalPerson = null; // 法定代表人
        String legalPhone = null; // 法人联系方式
        String linkUser = null; // 联系人
        String linkPhone = null; // 手机号码
        String companyAddress = null; // 详细地址
        String checked = null; // 审核状态 为空时默认为已审核（1：已审核 0：未审核）
        String remark = null; // 备注

        //String regNumber = null; // 注册号
        //String mystate = null; // 营业状态 为空时默认为开业（0：开业 1：停业）
        //String supplier = null; // 是否供应商 为空时默认为否（0：否 1：是）
        //String setupDateStr = null; // 成立日期
        //String regAuthority = null; // 登记机关


        try {
            // 2.导入前的准备工作
            fos = FileUtils.openOutputStream(new File(path + fileName));// 得到文件输出流
            IOUtils.copy(file.getInputStream(), fos);// 保存文件
            Workbook workBook = WorkbookFactory.create(new FileInputStream(new File(path + fileName)));// 创建工作簿对象
            Sheet sheet = workBook.getSheetAt(0);// 获取第一张工作表 sheet1
            Row row = null;
            int totalRow = sheet.getLastRowNum();// 获取最大行数
            TBImportHistory t = new TBImportHistory();// 创建记录导入历史的对象
            // 3.遍历总行数，读取sheet文件内容进行数据的处理和入库
            for (int i = 1; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (null == row)
                    continue;
                if (isEmptyRow(row))
                    continue;
                /*
                // 个人
                if (type == 1) {
                    companyType = getCellValue(row.getCell(0)); // 单位类型,非必填，有默认值
                    companyName = getCellValue(row.getCell(1)); // 姓名
                    creditCode = getCellValue(row.getCell(2)); // 身份证号码
                    linkPhone = getCellValue(row.getCell(3)); // 手机号码
                    checked = getCellValue(row.getCell(4)); // 审核状态 为空时默认为已审核
                    remark = getCellValue(row.getCell(5)); // 备注
                    if (i == 1) {
                        if (!"单位类型".equals(companyType) || !"姓名".equals(companyName) || !"身份证号码".equals(creditCode)
                                || !"手机号码".equals(linkPhone) || !"审核状态".equals(checked)) {
                            t.setRemark("导入数据的模板不正确");
                            jsonObject.setSuccess(false);
                            break;
                        }
                    } else {
                        // 判断必填项未填写时，跳过该条数据并输出报错到输出文档
                        if (StringUtil.isEmpty(companyName)) {
                            addToErrList2(errList, type, companyName, creditCode, checked, linkPhone, remark, "姓名不能为空");
                            failCount++;
                            continue;
                        }
                        if (StringUtil.isEmpty(creditCode)) {
                            addToErrList2(errList, type, companyName, creditCode, checked, linkPhone, remark,
                                    "身份证号码不能为空");
                            failCount++;
                            continue;
                        }
                        if (StringUtil.isEmpty(linkPhone)) {
                            addToErrList2(errList, type, companyName, creditCode, checked, linkPhone, remark,
                                    "电话号码不能为空");
                            failCount++;
                            continue;
                        }

                        // 当审核状态为空或者未填写时就默认为 “已审核” 其他情况默认为 “未审核”
                        if (StringUtil.isEmpty(checked) || "已审核".equals(checked)) {
                            checked = "1";
                        } else {
                            checked = "0";
                        }
                        // 创建送检单位的bean并设置导入信息进行数据入库
                        InspectionUnit inspectionUnit = new InspectionUnit();
                        inspectionUnit.setCompanyName(companyName);
                        inspectionUnit.setCompanyType(type);
                        inspectionUnit.setCreditCode(creditCode);
                        inspectionUnit.setLegalPhone(linkPhone);
                        inspectionUnit.setChecked(new Short(checked));
                        inspectionUnit.setRemark(remark);
                        PublicUtil.setCommonForTable(inspectionUnit, true);
                        inspectionUnitService.insertSelective(inspectionUnit);
                        successCount++;
                    }

                    // 企业或者供应商
                }else if (type == 0 || type == 2) {*/

                    departName = getCellValue(row.getCell(0));
                    regName = getCellValue(row.getCell(1));
                    companyName = getCellValue(row.getCell(2)); // 姓名/单位名称
                    companyCode = getCellValue(row.getCell(3));
                    companyType = getCellValue(row.getCell(4)); // 单位类型,非必填，默认值
                    creditCode = getCellValue(row.getCell(5)); // 身份证号码/社会信用代码

                    legalPerson = getCellValue(row.getCell(6)); // 法定代表人
                    legalPhone = getCellValue(row.getCell(7)); // 法人联系方式
                    linkUser = getCellValue(row.getCell(8)); // 联系人
                    linkPhone = getCellValue(row.getCell(9)); // 手机号码
                    companyAddress = getCellValue(row.getCell(10)); // 详细地址

                    //regNumber = getCellValue(row.getCell(2)); // 注册号


                    checked = getCellValue(row.getCell(11)); // 审核状态 为空时默认为已审核
                    //mystate = getCellValue(row.getCell(9)); // 营业状态 为空时默认为开业
                    //supplier = getCellValue(row.getCell(10)); // 营业状态 为空时默认为开业
                    //setupDateStr = getCellValue(row.getCell(11)); // 成立日期
                    //regAuthority = getCellValue(row.getCell(12)); // 登记机关
                    remark = getCellValue(row.getCell(12)); // 备注

                    if (i == 1) {
                        if (!"所属机构".equals(departName) || !"冷链单位名称".equals(regName) || !"类型".equals(companyType) || !"名称".equals(companyName) || !"仓口编号".equals(companyCode)
                                || !"统一社会信用代码/身份证".equals(creditCode) || !"法定代表人".equals(legalPerson)
                                || !"法人联系方式".equals(legalPhone) || !"联系人".equals(linkUser) || !"联系方式".equals(linkPhone)
                                || !"审核状态".equals(checked) ||  !"详细地址".equals(companyAddress)) {
                            t.setRemark("导入数据的模板不正确");
                            jsonObject.setSuccess(false);
                            break;
                        }
                    } else {
                        // 判断必填项未填写时，跳过该条数据并输出报错到输出文档

                        if (StringUtil.isEmpty(departName)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName,creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked,companyAddress,
                                    remark, "所属机构不能为空");
                            failCount++;
                            continue;
                        }
                        if (StringUtil.isEmpty(regName)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName,creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked,companyAddress,
                                    remark, "冷链单位名称不能为空");
                            failCount++;
                            continue;
                        }
                        if (StringUtil.isEmpty(companyName)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName, creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked,  companyAddress,
                                    remark, "名称不能为空");
                            failCount++;
                            continue;
                        }
                        if (StringUtil.isEmpty(companyCode)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName,creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked, companyAddress,
                                    remark, "仓口编号不能为空");
                            failCount++;
                            continue;
                        }


                        if (StringUtil.isEmpty(companyType)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName,creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked, companyAddress,
                                    remark, "类型不能为空");
                            failCount++;
                            continue;
                        }


                        if (StringUtil.isEmpty(creditCode)) {
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName, creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked, companyAddress,
                                    remark, "统一社会信用代码/身份证不能为空");

                            failCount++;
                            continue;
                        }

                        Short typec = null;
                        if(companyType.equals("企业") || companyType.equals("个人")) {
                            if (companyType.equals("企业")){
                                typec=0;
                            }
                            if (companyType.equals("个人")){
                                typec=1;
                            }
                        }else{
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName, creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked, companyAddress,
                                    remark, "类型不正确");

                            failCount++;
                            continue;

                        }

                        ColdChainUnit chainUnit= coldChainUnitService.selectByDepartNameAndRegName(departName,regName);
                        if(chainUnit==null){
                            addToErrList1(errList, departName,regName,companyCode,companyType, companyName, creditCode, legalPerson, legalPhone,
                                    linkUser, linkPhone, checked, companyAddress,
                                    remark, "所属机构或者冷链单位名称不正确");
                            failCount++;
                            continue;
                        }
                        coldUnitId=chainUnit.getId();





                        // 当审核状态为空或者未填写时就默认为 “已审核” 其他情况默认为 “未审核”
                        if (StringUtil.isEmpty(checked) || "已审核".equals(checked)) {
                            checked = "1";
                        } else {
                            checked = "0";
                        }






                        // 创建送检单位的bean并设置导入信息进行数据入库
                        InspectionUnit inspectionUnit = new InspectionUnit();
                        inspectionUnit.setColdUnitId(coldUnitId);
                        inspectionUnit.setCompanyType(typec);
                        inspectionUnit.setCompanyCode(companyCode);
                        inspectionUnit.setCompanyName(companyName);
                        inspectionUnit.setCreditCode(creditCode);
                        inspectionUnit.setLegalPerson(legalPerson);
                        inspectionUnit.setLegalPhone(legalPhone);
                        inspectionUnit.setLinkUser(linkUser);
                        inspectionUnit.setLinkPhone(linkPhone);
                        inspectionUnit.setChecked(new Short(checked));
                        inspectionUnit.setCompanyAddress(companyAddress);
                        inspectionUnit.setRemark(remark);
                        PublicUtil.setCommonForTable(inspectionUnit, true);
                        inspectionUnitService.insertSelective(inspectionUnit);
                        successCount++;
                    }
                //}
            }
            String errFile = null;
            if (errList.size() > 0) {
                SXSSFWorkbook wb = new SXSSFWorkbook(100);
                //if (type == 0) {
                    errFile = fileName.substring(0, fileName.indexOf(".")) + "_err1.xlsx";
                    Excel.outputExcelFile(wb, ImportBaseData.headers2,
                            ImportBaseData.fields2, errList, path + errFile, "1","");
                /*} else if (type == 1) {
                    errFile = fileName.substring(0, fileName.indexOf(".")) + "_err2.xlsx";
                    Excel.outputExcelFile(wb, ImportBaseData.headers,
                            ImportBaseData.fields, errList, path + errFile, "1","");
                }else if (type == 2) {
                    errFile = fileName.substring(0, fileName.indexOf(".")) + "_err3.xlsx";
                    Excel.outputExcelFile(wb, InspectionUnitController.ImportBaseData.headers,
                            InspectionUnitController.ImportBaseData.fields, errList, path + errFile, "1");
                }*/
                FileOutputStream fOut = new FileOutputStream(path + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
                jsonObject.setSuccess(false);
                jsonObject.setObj("失败");
            }
            TSDepart tsDepart = PublicUtil.getSessionUserDepart();
            TSUser user = PublicUtil.getSessionUser();
            t.setDepartId(tsDepart.getId());
            t.setDepartCode(tsDepart.getDepartCode());
            t.setDepartName(tsDepart.getDepartName());
            t.setUsername(user.getRealname());
            t.setUserId(user.getId());
            t.setSourceFile(mypath + fileName);
            t.setErrFile(errFile == null ? null : mypath + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(stamp);
            t.setImportType(6);
            t.setEndDate(new Date());
            importHistoryService.insertSelective(t);
            jsonObject.setMsg(mypath + errFile);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("导入失败");
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                log.error("**********************" + e.getMessage() + e.getStackTrace());
            }
        }
        return jsonObject;
    }

    private void addToErrList2(List<ImportBaseData> errList, Short type, String companyName,
                               String creditCode, String checked, String linkPhone, String remark, String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setCompanyType(type + "");
        d.setCompanyName(companyName);
        d.setCreditCode(creditCode);
        d.setChecked(checked);
        d.setLinkPhone(linkPhone);
        d.setRemark(remark);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    private void addToErrList1(List<ImportBaseData> errList, String departName,String regName,String companyCode,String companyType, String companyName,
                               String creditCode, String legalPerson, String legalPhone, String linkUser,
                               String linkPhone, String checked,String companyAddress, String remark, String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setCompanyType(companyType);
        d.setDepartName(departName);
        d.setRegName(regName);
        d.setCompanyCode(companyCode);
        d.setCompanyName(companyName);
        //d.setRegNumber(regNumber);
        d.setCreditCode(creditCode);
        d.setLegalPerson(legalPerson);
        d.setLegalPhone(legalPhone);
        d.setLinkUser(linkUser);
        d.setLinkPhone(linkPhone);
        d.setChecked(checked);
        //d.setMystate(mystate);
        //d.setSupplier(supplier);
        //d.setSetupDate(setupDateStr);
        //d.setRegAuthority(regAuthority);
        d.setCompanyAddress(companyAddress);
        d.setRemark(remark);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    public static class ImportBaseData {
        // 导入送检单位（个人）
        public static String[] headers = {"单位类型", "姓名", "身份证号码", "手机号码", "审核状态", "备注", "导入失败原因"};
        public static String[] fields = {"companyType", "companyName", "creditCode", "linkPhone", "mychecked",
                "remark", "errMsg"};

        // 导入送检单位（企业）
        public static String[] headers2 = {"所属机构","冷链单位名称","名称", "仓口编号", "类型", "统一社会信用代码/身份证", "法定代表人", "法人联系方式", "联系人", "联系方式", "详细地址",
                "审核状态","备注", "导入失败原因"};
        public static String[] fields2 = {"departName","regName","companyName", "companyCode", "companyType", "creditCode", "legalPerson",
                "legalPhone", "linkUser", "linkPhone", "companyAddress","checked", "remark", "errMsg"};

        String departName;//所属机构
        String regName;
        String companyCode;//仓口编号
        String companyType; // 送检单位类型 0：企业 1：个人
        String companyName; // 送检单位名称/姓名
        String creditCode; // 统一社会信用代码/身份证号码
        String checked; // 审核状态 0：未审核 1：已审核
        String linkPhone; // 手机号码
        String remark; // 备注信息
        String errMsg; // 导入行失败的错误提示
        String regNumber; // 注册号
        String legalPerson; // 法定代表人
        String legalPhone; // 法人联系方式
        String linkUser; // 联系人
        String mystate; // 营业状态 0：开业 1：停业
        String setupDate; // 成立日期
        String regAuthority; // 登记机关
        String companyAddress; // 详细地址
        String supplier; // 是否供应商 0：否 1：是

        public String getDepartName(){
            return departName;
        }
        public void setDepartName(String departName){

            this.departName=departName;
        }
        public String getRegName(){
            return regName;
        }
        public void setRegName(String regName){

            this.regName=regName;
        }
        public String getCompanyCode(){
            return companyCode;
        }
        public void setCompanyCode(String companyCode){

            this.companyCode=companyCode;
        }



        public String getSetupDate() {
            return setupDate;
        }

        public void setSetupDate(String setupDate) {
            this.setupDate = setupDate;
        }

        public String getRegNumber() {
            return regNumber;
        }

        public void setRegNumber(String regNumber) {
            this.regNumber = regNumber;
        }

        public String getLegalPerson() {
            return legalPerson;
        }

        public void setLegalPerson(String legalPerson) {
            this.legalPerson = legalPerson;
        }

        public String getLegalPhone() {
            return legalPhone;
        }

        public void setLegalPhone(String legalPhone) {
            this.legalPhone = legalPhone;
        }

        public String getLinkUser() {
            return linkUser;
        }

        public void setLinkUser(String linkUser) {
            this.linkUser = linkUser;
        }

        public String getMystate() {
            return mystate;
        }

        public void setMystate(String mystate) {
            this.mystate = "0".equals(mystate) ? "开业" : "停业";

        }

        public String getRegAuthority() {
            return regAuthority;
        }

        public void setRegAuthority(String regAuthority) {
            this.regAuthority = regAuthority;
        }

        public String getCompanyAddress() {
            return companyAddress;
        }

        public void setCompanyAddress(String companyAddress) {
            this.companyAddress = companyAddress;
        }

        public static String[] getHeaders2() {
            return headers2;
        }

        public static void setHeaders2(String[] headers2) {
            ImportBaseData.headers2 = headers2;
        }

        public static String[] getFields2() {
            return fields2;
        }

        public static void setFields2(String[] fields2) {
            ImportBaseData.fields2 = fields2;
        }

        public String getLinkPhone() {
            return linkPhone;
        }

        public void setLinkPhone(String linkPhone) {
            this.linkPhone = linkPhone;
        }

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

        public String getCompanyType() {
            return companyType;
        }

        public void setCompanyType(String companyType) {

            this.companyType = "1".equals(companyType) ? "个人" : "企业";
        }

        public String getCompanyName() {
            return companyName;
        }

        public void setCompanyName(String companyName) {
            this.companyName = companyName;
        }

        public String getCreditCode() {
            return creditCode;
        }

        public void setCreditCode(String creditCode) {
            this.creditCode = creditCode;
        }

        public String getChecked() {
            return checked;
        }

        public void setChecked(String checked) {
            this.checked = checked;
        }

        public String getRemark() {
            return remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }

        public String getSupplier() {

            return supplier;
        }

        public void setSupplier(String supplier) {
            this.supplier = "1".equals(supplier) ? "是" : "否";
        }
    }

    /**
     * 送检单位导出方法 删除数据，单条删除与批量删除通用方法
     *
     * @return
     */
    @RequestMapping("/exportFile")
    @ResponseBody
    public ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response,
                                             InspectionUnitModel model) {
        ResponseEntity<byte[]> responseEntity = null;
        try {
            // 1.设置查询时传递的参数
            String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("storageDirectory")
                    + "/inspection/unit/";
            File logoSaveFile = new File(rootPath);
            if (!logoSaveFile.exists())
                logoSaveFile.mkdirs();
            String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
            SXSSFWorkbook workbook = null;
            // 2.进行导出数据的查询
            List<InspectionUnit> list = inspectionUnitService.quaryList(model);
            // 3.生成导出的文件进行数据导出
            String xlsName = fileName + ".xlsx";
            workbook = new SXSSFWorkbook(100);
            if (model != null && model.getCompanyType() != null) {
                /*if (new Short("0").equals(model.getCompanyType())) {// 导出企业
                    Excel.outputExcelFileIU(workbook, Excel.INSPECTION_UNIT_HEADERS1, Excel.INSPECTION_UNIT_FIELDS1, list, "1");
                } else if (new Short("1").equals(model.getCompanyType())) {// 导出个人*/
                    Excel.outputExcelFileIU(workbook, Excel.INSPECTION_UNIT_HEADERS3, Excel.INSPECTION_UNIT_FIELDS3, list, "1");
                /*} else if (new Short("2").equals(model.getCompanyType())) {// 导出供应商
                    Excel.outputExcelFileIU(workbook, Excel.INSPECTION_UNIT_HEADERS3, Excel.INSPECTION_UNIT_FIELDS3, list, "1");
                }*/
            }
            FileOutputStream fOut = new FileOutputStream(rootPath + xlsName);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            responseEntity = DyFileUtil.download(request, response, rootPath, xlsName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseEntity;
    }


    /**
     * 送检单位和委托单位的二维码导出
     *
     * @param codeJsonArr  存储二维码base64编码和二维码名称的json数组字符串[{src:'base64编码1'，name:'名称1'},{src:'base64编码2'，name:'名称2'}]
     * @param codeState    二维码大小状态 1：小 2：中 3：大
     * @param functionName
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/export_code")
    @ResponseBody
    private AjaxJson exportCode(String codeJsonArr, Integer codeState, String functionName, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            if (StringUtil.isNotEmpty(codeJsonArr)) {
                String path = WebConstant.res.getString("storageDirectory") + "qrcode/";
                String rootPath = WebConstant.res.getString("resources") + path;
                File logoSaveFile = new File(rootPath);
                if (!logoSaveFile.exists())
                    logoSaveFile.mkdirs();
                String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmss");
                String docName = fileName + ".doc";
                ItextTools.exportCode(rootPath + docName, functionName, request, codeJsonArr, codeState);
              /*  ResponseEntity<byte[]> responseEntity = null;
                responseEntity = DyFileUtil.download(request, response, rootPath, docName);*/
                ajaxJson.setObj(path + docName);
            }
            return ajaxJson;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return ajaxJson;
    }
}
