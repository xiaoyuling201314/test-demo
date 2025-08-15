package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.service.data.TbFileService;
import com.dayuan.util.*;
import com.dayuan3.common.bean.Orderhistory;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.common.service.OrderhistoryService;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;
import com.dayuan3.terminal.model.RequesterUnitModel;
import com.dayuan3.terminal.service.RequesterUnitService;
import com.dayuan3.terminal.service.RequesterUnitTypeService;
import com.dayuan3.terminal.util.WXPayUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.*;

/**
 * 委托单位
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
@Controller
@RequestMapping("/requester/unit")
public class RequesterUnitController extends BaseController {
    private Logger log = Logger.getLogger(RequesterUnitController.class);

    @Autowired
    private RequesterUnitService requesterUnitService;

    @Autowired
    private RequesterUnitTypeService requesterTypeService;

    @Autowired
    private TBImportHistoryService importHistoryService;

    @Autowired
    TbFileService tbFileService;

    @Autowired
    private OrderhistoryService orderhistoryService;

    @Value("${resources}")
    private String resources;

    /**
     * 进入检测标准表页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list() {
        Map<String, Object> map = new HashMap<>();
        map.put("requesterUnitPath", WebConstant.res.getString("requesterUnitPath"));
        return new ModelAndView("/terminal/requester/list", map);
    }

    /**
     * 进入弹框页面
     *
     * @return
     * @param filterDelete 是否过滤已删除单位：0 过滤，1 不过滤
     * @throws Exception
     */
    @RequestMapping("/listview")
    public ModelAndView listview(String samplingId,@RequestParam(required = false,defaultValue = "0")Short filterDelete,Model model) {
        Map<String, Object> map = new HashMap<>();
        map.put("requesterUnitPath", WebConstant.res.getString("requesterUnitPath"));
        map.put("samplingId", samplingId);
        map.put("filterDelete", filterDelete);
        return new ModelAndView("/terminal/requester/listview", map);
    }

    /**
     * 数据列表
     *
     * @param model
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(RequesterUnitModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("desc");
            page = requesterUnitService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 数据列表
     *
     * @param model
     * @param page
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagridView")
    @ResponseBody
    public AjaxJson datagridView(RequesterUnitModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("desc");
            page = requesterUnitService.loadDatagrid2(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(RequesterUnit bean, @RequestParam(required = false, value = "files") MultipartFile[] files) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            String type = "reUnit";                                     //保存在tb_file表中的类型
            String fPath = "/requesterUnit/";                           //保存文件路径名称
            //根据委托单位名称去查询校验其唯一性
            RequesterUnit ru = requesterUnitService.selectByName(bean.getRequesterName(), bean.getId());
            if (ru == null) {
                if (bean.getId() == null) {
                    PublicUtil.setCommonForTable(bean, true);
                    requesterUnitService.insertSelective(bean);
                } else {
                    tbFileService.delete(bean.getDeleteFileIds());          //删除编辑时删除的文件
                    PublicUtil.setCommonForTable(bean, false);
                    requesterUnitService.updateBySelective(bean);
                }
                CommonDataController.terminalRequestList = null;
            } else {
                jsonObject.setSuccess(false);
                jsonObject.setMsg("委托单位已存在！");
            }

            tbFileService.saveFile(files, bean.getId(), type, fPath);   //保存当前新添加的文件
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
     * @param id 数据记录id
     * @throws Exception
     */
    @RequestMapping("/queryById")
    @ResponseBody
    public ModelAndView queryById(Integer id) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<RequesterUnitType> list = requesterTypeService.queryAllType();
            map.put("list", list);  //单位类型
            map.put("id", id);      //当前ID
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/requester/add", map);
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
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, Integer[] ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            requesterUnitService.delete(ids);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 获取所有委托单位
     *
     * @return
     */
    @RequestMapping(value = "/queryAll")
    @ResponseBody
    public AjaxJson queryAll() {
        AjaxJson jsonObj = new AjaxJson();
        try {
            List<RequesterUnit> list = requesterUnitService.queryAll("2000-01-01 00:00:00");
            jsonObj.setObj(list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 扫描委托单位二维码页面
     *
     * @param id
     * @param request
     * @return
     * @author shit
     */
    @RequestMapping("/scanQrcode")
    @ResponseBody
    public ModelAndView scanQrcode(Integer id, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        try {
            RequesterUnit unit = requesterUnitService.queryById(id);
            if (unit != null) {//扫描次数加1
                if (unit.getScanNum() == null) {
                    unit.setScanNum((short) 1);
                } else {
                    unit.setScanNum((short) (unit.getScanNum() + 1));
                }
                requesterUnitService.updateBySelective(unit);
            }
            map.put("unit", unit);
            map.put("id", id);
            //获取进货数量的显示和必填配置传入界面
            map.put("showReq", WXPayUtil.getShowReq());
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        //存储搜索的记录
        try {
            Date now = new Date();
            //1.先到session中查看是否存在openid
            String openid = (String) request.getSession().getAttribute("openid");
            //1.1存在openid（根据openid把该人员的历史数据查询出来）
            if (StringUtil.isNotEmpty(openid)) {
                Orderhistory orderhistory = orderhistoryService.selectHisrotyByOpenid(openid, new Short("2"));
                if (orderhistory != null) {
                    //1.1-1该人员的历史中的requestId和当前id对比，不相同就更新，相同则不更新
                    if (id != null && !id.equals(orderhistory.getKeyId())) {
                        orderhistory.setKeyId(id);
                        orderhistory.setUpdateDate(now);
                        orderhistoryService.updateHistory(orderhistory);
                    }
                } else {
                    //1.1-2该人员的历史数据不存在就新增一条数据保存
                    Orderhistory orderhistory2 = new Orderhistory();
                    orderhistory2.setKeyId(id);
                    orderhistory2.setKeyword(openid);
                    orderhistory2.setUpdateDate(now);
                    orderhistory2.setCreateDate(now);
                    orderhistory2.setKeyType(new Short("2"));
                    orderhistoryService.insertHistory(orderhistory2);
                }
            } /*else {
                //1.2不存在openid那就别看了
                //return new ModelAndView(new RedirectView(WXPayConfig.mainUrl));
            }*/
        } catch (Exception e) {
            log.error("*********************保存搜索历史失败 " + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/terminal/requester/scanQrcode", map);
    }


    /**
     * 查询委托单位二维码
     *
     * @param request
     * @param response
     * @param ids
     * @return
     */
    @RequestMapping("/requesterQrcode")
    @ResponseBody
    public AjaxJson requesterQrcode(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson aj = new AjaxJson();
        try {
            String[] ida = ids.split(",");

            String rootPath = WebConstant.res.getString("resources") + WebConstant.res.getString("requesterQr");
            DyFileUtil.createFolder(rootPath);//判断该目录是否存在，不存在则进行创建

            RequesterUnit unit = null;
            List qrcodes = new ArrayList();    //二维码
            for (String unitId : ida) {
                Map<String, Object> map = new HashMap<String, Object>();
                unit = requesterUnitService.queryById(Integer.parseInt(unitId));
                if (unit == null) {
                    throw new Exception("查看委托单位二维码失败，委托单位不存在！");
                }

                if (StringUtil.isNotEmpty(unit.getQrcode())) {
                    //读取二维码
                    File qrFile = new File(rootPath + unit.getQrcode());
                    if (!qrFile.exists()) {
                        QrcodeUtil.generateSamplingQrcode(request, unit.getQrcode(), WebConstant.res.getString("requesterUnitPath") + unit.getId(), rootPath);
                    }
                } else {
                    //生成二维码
                    String qrcodeName = UUIDGenerator.generate() + ".png";
                    QrcodeUtil.generateSamplingQrcode(request, qrcodeName, WebConstant.res.getString("requesterUnitPath") + unit.getId(), rootPath);
                    unit.setQrcode(qrcodeName);
                    requesterUnitService.updateBySelective(unit);
                }
                map.put("qrcodeSrc", "/resources/" + WebConstant.res.getString("requesterQr") + unit.getQrcode());
                map.put("qrcodeName", unit.getRequesterName());
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
     * 委托单位导入页面 huht 2019-8-15
     *
     * @param request
     * @param type
     * @return
     * @throws JSONException
     */
    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request, Integer type) throws JSONException {
        request.setAttribute("type", type);
        return new ModelAndView("/terminal/requester/toImport");
    }


    /**
     * @param file
     * @return
     */
    @RequestMapping("/importData")
    @ResponseBody
    public AjaxJson importData(@RequestParam("file") MultipartFile file) {
        AjaxJson jsonObject = new AjaxJson();
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String path = resources + "object/";
        int successCount = 0;
        int failCount = 0;
        List<ImportBaseData> errList = new ArrayList<ImportBaseData>();
        try {
            TSUser user = PublicUtil.getSessionUser();
            fos = FileUtils.openOutputStream(new File(path + "/" + fileName));
            IOUtils.copy(file.getInputStream(), fos);
            org.apache.poi.ss.usermodel.Workbook workBook = WorkbookFactory.create(new FileInputStream(new File(path + "/" + fileName)));
            Sheet sheet = workBook.getSheetAt(0);
            Row row = null;

            int totalRow = sheet.getLastRowNum();
            TBImportHistory t = new TBImportHistory();
            List<RequesterUnitType> list = requesterTypeService.queryAllType();
            for (int i = 1; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (null == row) continue;
                if (isEmptyRow(row)) continue;
                String requesterName = getCellValue(row.getCell(0));// 单位名称,必填
                String requesterOtherName = getCellValue(row.getCell(1));// 单位别称
                String creditCode = getCellValue(row.getCell(2));// 统一社会信用代码
                String legalPerson = getCellValue(row.getCell(3));//法人名称
                String unitType = getCellValue(row.getCell(4));//单位类型 （营业 停业）
                String linkUser = getCellValue(row.getCell(5));//联系人
                String linkPhone = getCellValue(row.getCell(6));//联系方式
                String state = getCellValue(row.getCell(7));//单位状态（0 营业，1 停业）
                String checked = getCellValue(row.getCell(8));//审核状态（0 未审核，1 已审核）
                String serviceLicense = getCellValue(row.getCell(9));//服务许可证
                String companyAddress = getCellValue(row.getCell(10));//通讯地址
                String scope = getCellValue(row.getCell(11));//用餐人数
                String checkNum = getCellValue(row.getCell(12));//日检测量
                String businessCope = getCellValue(row.getCell(13));//经营范围
                String reamrk = getCellValue(row.getCell(14));//备注
                if (i == 1) {
                    if (!requesterName.equals("单位名称") || !requesterOtherName.equals("单位别称") || !unitType.equals("单位类型") || !creditCode.equals("统一社会信用代码")) {
                        t.setRemark("导入数据的模板不正确");
                        jsonObject.setSuccess(false);
                        break;
                    }
                } else {
                    if (StringUtil.isEmpty(requesterName)) {
                        addToErrList(errList, state, checkNum, serviceLicense, requesterName, requesterOtherName, creditCode, legalPerson, unitType, linkUser, linkPhone, companyAddress, scope, businessCope, "单位名称不能为空");
                        failCount++;
                        continue;
                    }
                    /*if (StringUtil.isEmpty(creditCode)) {
                        addToErrList(errList, state, checkNum, serviceLicense, requesterName, requesterOtherName, creditCode, legalPerson, unitType, linkUser, linkPhone, companyAddress, scope, businessCope, "统一社会信用代码");
                        failCount++;
                        continue;
                    }*/
                    if (StringUtil.isEmpty(legalPerson)) {
                        addToErrList(errList, state, checkNum, serviceLicense, requesterName, requesterOtherName, creditCode, legalPerson, unitType, linkUser, linkPhone, companyAddress, scope, businessCope, "法人不能为空");
                        failCount++;
                        continue;
                    }
                    RequesterUnit unit = new RequesterUnit();

                    boolean c = false;
                    int typeid = 0;
                    unitType = StringUtil.isEmpty(unitType) ? "食堂" : unitType;
                    for (RequesterUnitType type : list) {
                        if (unitType.equals(type.getUnitType())) {
                            c = true;
                            typeid = type.getId();
                            break;
                        }
                    }

                    if (c) {//判断类型是否存在
                        unit.setUnitType(typeid);
                    } else {
                        typeid = list.get(list.size() - 1).getId();
                        unit.setUnitType(typeid);
                    }
                    //校验委托单位名称
                    int name = requesterUnitService.queryIsExist(requesterName, null);
                    if (name > 0) {
                        addToErrList(errList, state, checkNum, serviceLicense, requesterName, requesterOtherName, creditCode, legalPerson, unitType, linkUser, linkPhone, companyAddress, scope, businessCope, requesterName + "已存在");
                        failCount++;
                        continue;
                    }
                    //校验社会统一编码
                    /*int name1 = requesterUnitService.queryIsExist(null, creditCode);
                    if (name1 > 0) {
                        addToErrList(errList, state, checkNum, serviceLicense, requesterName, requesterOtherName, creditCode, legalPerson, unitType, linkUser, linkPhone, companyAddress, scope, businessCope, creditCode + "已存在，请查看是否已存在该单位!");
                        failCount++;
                        continue;
                    }*/

                    unit.setRequesterName(requesterName);
                    if (!StringUtil.isEmpty(requesterName)) {
                        unit.setRequesterOtherName(requesterOtherName);
                    }
                    unit.setCreditCode(creditCode);
                    unit.setLegalPerson(legalPerson);
                    unit.setLinkUser(linkUser);
                    unit.setLinkPhone(linkPhone);
                    unit.setCompanyAddress(companyAddress);

                    unit.setBusinessCope(businessCope);
                    unit.setScope(scope);
                   /* delete by xiaoyl 2020-03-26 将就餐人数修改为一个范围
                    * if (StringUtil.isEmpty(scope)) {
                        unit.setScope(0);
                    } else {
                        unit.setScope(Integer.parseInt(scope));
                    }*/
                    if (StringUtil.isEmpty(state) || "营业".equals(state)) {
                        unit.setState(new Short("0"));
                    } else if ("停业".equals(state)) {
                        unit.setState(new Short("1"));
                    }

                    if (StringUtil.isEmpty(checked) || "未审核".equals(checked)) {
                        unit.setChecked(0);
                    } else if ("已审核".equals(checked)) {
                        unit.setChecked(1);
                    }
                    if (StringUtil.isEmpty(checkNum)) {
                        unit.setCheckNum(0);
                    } else {
                        unit.setCheckNum(Integer.valueOf(checkNum));
                    }

                    unit.setServiceLicense(serviceLicense);
                    unit.setRemark(reamrk);
                    PublicUtil.setCommonForTable(unit, true);
                    requesterUnitService.insertSelective(unit);
                    successCount++;
                }
            }
            String errFile = null;
            if (errList.size() > 0) {
                errFile = fileName.substring(0, fileName.indexOf(".")) + "_err.xlsx";
                SXSSFWorkbook wb = new SXSSFWorkbook(100);
                Excel.outputExcelFile(wb, ImportBaseData.headers, ImportBaseData.fields, errList, path + errFile, "1","");
                FileOutputStream fOut = new FileOutputStream(path + "/" + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
                jsonObject.setSuccess(false);
            }

            t.setDepartId(1);
            t.setDepartCode("01");
            t.setDepartName("通用委托单位数据");
            t.setUsername(user.getRealname());
            t.setUserId(user.getId());
            t.setSourceFile("/object/" + fileName);
            t.setErrFile(errFile == null ? null : "/object/" + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(stamp);
            t.setImportType(5);
            t.setEndDate(new Date());
            importHistoryService.insertSelective(t);
            jsonObject.setMsg("/object/" + errFile);
        } catch (Exception e) {
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

    private void addToErrList(List<ImportBaseData> errList, String state, String checkNum, String serviceLicense, String requesterName, String requesterOtherName, String creditCode, String legalPerson, String unitType, String linkUser, String linkPhone, String companyAddress, String scope,
                              String businessCope, String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setRequesterName(requesterName);
        d.setRequesterOtherName(requesterOtherName);
        d.setCreditCode(creditCode);
        d.setLegalPerson(legalPerson);
        d.setUnitType(unitType);
        d.setLinkUser(linkUser);
        d.setLinkPhone(linkPhone);
        d.setCompanyAddress(companyAddress);
        d.setScope(scope);
        d.setBusinessCope(businessCope);
        d.setState(state);
        d.setCheckNum(checkNum);
        d.setServiceLicense(serviceLicense);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    public static class ImportBaseData {
        public static String[] headers = {"单位名称", "单位别称", "", "统一社会信用代码", "法人名称", "单位类型", "联系人", "联系方式", "单位状态", "服务许可证", "通讯地址", "用餐人数", "用餐人数", "经营范围", "导入失败原因"};
        public static String[] fields = {"requesterName", "requesterOtherName", "creditCode", "legalPerson", "unitType", "linkUser", "linkPhone", "companyAddress", "scope", "businessCope", "errMsg"};
        String requesterName;       //单位名称,必填
        String requesterOtherName;  //单位别称
        String creditCode;          //统一社会信用代码
        String legalPerson;         //法人名称
        String unitType;            //单位类型(1：餐饮  2：学校  3：食堂  4：供应商)
        String linkUser;            //联系人
        String linkPhone;           //联系方式
        String state;               //单位状态（0 营业，1 停业）
        String serviceLicense;      //服务许可证
        String companyAddress;      //通讯地址
        String scope;               //用餐人数
        String checkNum;            //日检测量
        String businessCope;        //经营范围
        String errMsg;              //导入失败原因

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

        public String getRequesterName() {
            return requesterName;
        }

        public void setRequesterName(String requesterName) {
            this.requesterName = requesterName;
        }

        public String getRequesterOtherName() {
            return requesterOtherName;
        }

        public void setRequesterOtherName(String requesterOtherName) {
            this.requesterOtherName = requesterOtherName;
        }

        public String getCreditCode() {
            return creditCode;
        }

        public void setCreditCode(String creditCode) {
            this.creditCode = creditCode;
        }

        public String getLegalPerson() {
            return legalPerson;
        }

        public void setLegalPerson(String legalPerson) {
            this.legalPerson = legalPerson;
        }

        public String getUnitType() {
            return unitType;
        }

        public void setUnitType(String unitType) {
            this.unitType = unitType;
        }

        public String getLinkUser() {
            return linkUser;
        }

        public void setLinkUser(String linkUser) {
            this.linkUser = linkUser;
        }

        public String getLinkPhone() {
            return linkPhone;
        }

        public void setLinkPhone(String linkPhone) {
            this.linkPhone = linkPhone;
        }

        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }

        public String getServiceLicense() {
            return serviceLicense;
        }

        public void setServiceLicense(String serviceLicense) {
            this.serviceLicense = serviceLicense;
        }

        public String getCompanyAddress() {
            return companyAddress;
        }

        public void setCompanyAddress(String companyAddress) {
            this.companyAddress = companyAddress;
        }

        public String getScope() {
            return scope;
        }

        public void setScope(String scope) {
            this.scope = scope;
        }

        public String getCheckNum() {
            return checkNum;
        }

        public void setCheckNum(String checkNum) {
            this.checkNum = checkNum;
        }

        public String getBusinessCope() {
            return businessCope;
        }

        public void setBusinessCope(String businessCope) {
            this.businessCope = businessCope;
        }

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }
    }

    /**
     * 委托单位编辑界面数据回显
     *
     * @param id 项目ID
     * @return
     */
    @RequestMapping("/edit_echo")
    @ResponseBody
    public AjaxJson editEcho(Integer id) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            RequesterUnit requesterUnit = requesterUnitService.queryById(id);
            ajaxJson.setObj(requesterUnit);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("操作失败");
        }
        return ajaxJson;
    }


    @RequestMapping("/download")
    public HttpServletResponse download(String path, HttpServletRequest request, HttpServletResponse response) {
        try {
            // path是指欲下载的文件的路径。
            String path2 = resources + path;
            // 以流的形式下载文件。
            File file = new File(path2);
            if (!file.exists()) {//当文件不存在的情况下跳转界面
                response.sendRedirect(request.getContextPath() + "/requester/unit/nofile");
                return null;
            } else {
                InputStream fis = new BufferedInputStream(new FileInputStream(path2));
                byte[] buffer = new byte[fis.available()];
                fis.read(buffer);
                fis.close();
                response.reset();
                String title = tbFileService.selectNameByPath(path);
                title = URLEncoder.encode(title, "UTF-8");
                title = title.replace("+", "%20");//解决空格变为+号的问题
                response.addHeader("Content-Disposition", "attachment;filename=" + title);
                response.addHeader("Content-Length", "" + file.length());
                OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
                response.setContentType("application/octet-stream");
                toClient.write(buffer);
                toClient.flush();
                toClient.close();
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return response;
    }

    @RequestMapping("/nofile")
    public String nofile() {
        return "/common/nofile";
    }

}
