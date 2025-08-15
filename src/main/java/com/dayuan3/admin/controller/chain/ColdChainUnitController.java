package com.dayuan3.admin.controller.chain;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aspose.cells.License;
import com.aspose.cells.SaveFormat;
import com.aspose.cells.Workbook;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.BaseController;
import com.dayuan3.admin.model.chain.ColdChainUnitModel;
import com.dayuan.service.data.BasePointService;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.service.detect.TSDepartService;
import com.dayuan.service.regulatory.BaseRegulatoryTypeService;
import com.dayuan.service.system.SystemConfigJsonService;
import com.dayuan.util.*;
import com.dayuan3.admin.bean.chain.ColdChainUnit;
import com.dayuan3.admin.service.chain.ColdChainUnitService;
import com.dayuan3.common.util.SystemConfigUtil;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.util.Units;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xwpf.usermodel.*;
import org.json.JSONException;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.math.BigInteger;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

/**
 * 监管对象管理
 *
 * @author Dz
 * @Description:
 * @Company:食安科技
 * @date 2017年8月15日
 */
@RestController
@RequestMapping("/cold/unit")
public class ColdChainUnitController extends BaseController {

    private final Logger log = Logger.getLogger(ColdChainUnitController.class);

    @Autowired
    private ColdChainUnitService coldChainUnitService;
    @Autowired
    private BaseRegulatoryTypeService baseRegulatoryTypeService;
    @Autowired
    private TSDepartService departService;
    @Autowired
    private BasePointService basePointService;
    @Autowired
    private TBImportHistoryService importHistoryService;
    @Autowired
    private SystemConfigJsonService systemConfigJsonService;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Value("${systemUrl}")
    private String systemUrl;
    @Value("${resources}")
    private String resources;
    @Value("${regObjectQr}")
    private String regObjectQr;

    /**
     * 进入监管对象管理界面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
		//getOperationList(request.getServletPath() + "?regTypeCode=" + regTypeCode, request, tSFunctionService, tSOperationService);
        String regTypeCode = "";
        //BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryByRegTypeCode(regTypeCode);
        String regTypeId = "";
        String regType="";
//        if (regulatoryType != null) {
//            regTypeId = regulatoryType.getId();
//            regType = regulatoryType.getRegType();
//        }

        // 显示经营户
        map.put("showBusiness", true);
        map.put("regTypeCode", regTypeCode);
        map.put("regTypeId",regTypeId);
        map.put("regType",regType);
        return new ModelAndView("/cold/unit/list", map);
    }

    @RequestMapping("/queryUnitById")
    @ResponseBody
    public AjaxJson queryUnitById(Integer id) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            ColdChainUnit col=coldChainUnitService.queryById(id);
            ajaxJson.setObj(col);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("**********************" + e.getMessage() + e.getStackTrace());
            ajaxJson.setSuccess(false);
            ajaxJson.setMsg("操作失败");
        }
        return ajaxJson;
    }
    /**
     * 进入新增/编辑监管对象界面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/goAddRegulatoryObject")
    public ModelAndView goAddRegulatoryObject(HttpServletRequest request, HttpServletResponse response, Integer id,String regTypeCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        ColdChainUnit regulatoryObject = null;
        try {
            if (null != id) {
                //冷链单位
                regulatoryObject = coldChainUnitService.queryById(id);
            }

            // 当前监管对象类型
//            BaseRegulatoryType regulatoryType = baseRegulatoryTypeService.queryByRegTypeCode(regTypeCode);
//            map.put("regulatoryType", regulatoryType);

            // 所有监管对象类型
//            List<BaseRegulatoryType> regulatoryTypes = baseRegulatoryTypeService.queryAll();
//            map.put("regulatoryTypes", regulatoryTypes);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        map.put("regTypeCode", regTypeCode);
        map.put("regulatoryObject", regulatoryObject);
        return new ModelAndView("/cold/unit/addRegulatoryObject", map);
    }




    /**
     * 数据列表
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(HttpServletRequest request, HttpServletResponse response, ColdChainUnitModel model, Page page, Integer did) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TSDepart depart = PublicUtil.getSessionUserDepart();
            if (depart != null) {
                model.setDepartCode(depart.getDepartCode());
            }
            if (did != null && !did.equals(0)) {
                model.setDepartId(did);
                model.setDepartCode(departService.queryByDepartId(did));
            }
            page = coldChainUnitService.loadDatagrid(page,model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 保存监管对象
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxJson save(HttpServletRequest request, HttpServletResponse response, ColdChainUnit obj) {
        AjaxJson aj = new AjaxJson();
        try {
            if (obj.getId() != null) {
                // 更新
                PublicUtil.setCommonForTable(obj, false);
                coldChainUnitService.updateBySelective(obj);
            } else {

                List<ColdChainUnit> ros = coldChainUnitService.queryByDepartId(obj.getDepartId(), null);
                for (ColdChainUnit ro : ros) {
                    if (ro.getRegName().equals(obj.getRegName())) {
                        // 监管对象名称重复
                        aj.setMsg("企业名称已存在");
                        aj.setSuccess(false);
                        return aj;
                    }
                }
                // 新增
                // obj.setId(UUIDGenerator.generate());
                if (obj.getChecked() == null) {
                    obj.setChecked((short) 0);
                }
                if (obj.getDeleteFlag() == null) {
                    obj.setDeleteFlag((short)0);
                }
                PublicUtil.setCommonForTable(obj, true);
                coldChainUnitService.insert(obj);
            }
            aj.setObj(obj);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            aj.setSuccess(false);
            aj.setMsg("保存失败");
        }
        return aj;
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
            String[] ida = null;
            if (StringUtil.isNotEmpty(ids)) {
                ida = ids.split(",");
                Integer[] idas = new Integer[ida.length];
                for (int i = 0; i < ida.length; i++) {
                    idas[i] = Integer.parseInt(ida[i]);
                }
                coldChainUnitService.deleteData(PublicUtil.getSessionUser().getId(), idas);
            } else {
                jsonObj.setSuccess(false);
            }
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 查看监管对象二维码
     *
     * @param ids 监管对象ID
     * @return
     */
    @RequestMapping("/regObjectQrcode")
    @ResponseBody
    public AjaxJson regObjectQrcode(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson aj = new AjaxJson();
        try {
            String[] ida = ids.split(",");

            String rootPath = resources + regObjectQr;
            DyFileUtil.createFolder(rootPath);// 判断该目录是否存在，不存在则进行创建

            ColdChainUnit regObject = null;
            List qrcodes = new ArrayList(); // 二维码
            for (String regObjectId : ida) {
                Map<String, Object> map = new HashMap<String, Object>();
                regObject = coldChainUnitService.queryById(Integer.parseInt(regObjectId));
                if (regObject == null) {
                    throw new Exception("查看监管对象二维码失败，监管对象不存在！");
                }

                if (StringUtil.isNotEmpty(regObject.getQrcode())) {
                    // 读取二维码
                    File qrFile = new File(rootPath + regObject.getQrcode());
                    if (!qrFile.exists()) {
                        QrcodeUtil.generateSamplingQrcode(request, regObject.getQrcode(), systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath);
                    }
                } else {
                    // 生成二维码
                    String qrcodeName = UUIDGenerator.generate() + ".png";
                    QrcodeUtil.generateSamplingQrcode(request, qrcodeName, systemUrl+"iRegulatory/regObjectApp.do?id=" + regObject.getId(), rootPath);
                    regObject.setQrcode(qrcodeName);
                    coldChainUnitService.updateBySelective(regObject);
                }
                map.put("qrcodeSrc", "/resources/" + regObjectQr + regObject.getQrcode());
                map.put("regName", regObject.getRegName());
                qrcodes.add(map);
            }
            aj.setObj(qrcodes);
        } catch (Exception e) {
            aj.setSuccess(false);
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        return aj;
    }

    @RequestMapping("/queryRegByDepartId")
    public AjaxJson queryRegByDepartId(Integer departId, String coldName) {
        AjaxJson json = new AjaxJson();
        List<ColdChainUnit> regs = coldChainUnitService.queryRegByDepartId(departId, coldName);
        json.setObj(regs);
        return json;
    }


    /**
     * select2被检单位数据
     * @param request
     * @param response
     * @param page 页码
     * @param row 每页数量
     * @param regName 被检单位名称
     * @return
     */
    @RequestMapping("/select2RegData")
    @ResponseBody
    public Map select2RegData(HttpServletRequest request, HttpServletResponse response,
                              Integer page, Integer row, String regName) {
        Map map = new HashMap();
        int total = 0;	//总数
        List regs = new ArrayList();	//被检单位

        try {
            if (regName != null){
                regName = regName.replace("'","");
            }
            //使用浏览器缓存数据，后台不查询
            TSUser user = PublicUtil.getSessionUser();
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT id, reg_name name " +
                    " FROM cold_chain_unit  " +
                    "WHERE delete_flag = 0 ");
            if (StringUtil.isNotEmpty(regName)) {
                sql.append(" AND reg_name LIKE '%"+regName+"%' ");
            }
            if (user != null) {
                sql.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"),'%')) ");
            }
            if (page>0 && row>0) {
                sql.append(" LIMIT "+ ((page-1)*row < 0 ? 0 : (page-1)*row) +", "+row);
            }
            jdbcTemplate.query(sql.toString(), new RowCallbackHandler() {
                @Override
                public void processRow(ResultSet rs) throws SQLException {
                    do {
                        Map reg = new HashMap(3);
                        reg.put("id", rs.getInt("id"));	//被检单位ID
                        reg.put("name", rs.getString("name"));	//被检单位名称
                        regs.add(reg);
                    } while (rs.next());
                }
            });

            sql.setLength(0);
            sql.append("SELECT COUNT(1) FROM cold_chain_unit WHERE delete_flag = 0 ");
            if (StringUtil.isNotEmpty(regName)) {
                sql.append(" AND reg_name LIKE '%"+regName+"%' ");
            }
            if (user != null) {
                sql.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE id = "+user.getDepartId()+"),'%')) ");
            }
            total = jdbcTemplate.queryForObject(sql.toString(), Integer.class);
        } catch (Exception e) {
            log.error("*****" + e.getMessage() +"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }
        map.put("coldUnits", regs);
        map.put("total", total);
        return map;
    }

    /**
     * 获取机构下已审核监管对象
     *
     * @param departId
     * @return
     */
    @RequestMapping("/queryCheckedReg")
    @ResponseBody
    public AjaxJson queryCheckedReg(Integer departId) {
        AjaxJson json = new AjaxJson();
        List<ColdChainUnit> regs = coldChainUnitService.queryByDepartId1(departId, "1");
        json.setObj(regs);
        return json;
    }
    /**
     * @Description
     * @Date 2021/11/18 10:50
     * @Author xiaoyl
     * @Param types 导出类型
     * @Param departId 机构ID
     * @Param regName 监管对象名称
     * @Param regType 监管对象类型
     * @Param menuType 菜单类型：0 旧菜单，1新菜单
     * @return
     */
    @RequestMapping(value = "/exportFile")
    private @ResponseBody
    ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response,
                                      HttpSession session, String types, Integer departId, String regName, String regType,
                                      @RequestParam(required = false,defaultValue = "0") Integer menuType) {
        ResponseEntity<byte[]> responseEntity = null;
        String rootPath = resources + WebConstant.res.getString("storageDirectory") + "object/";
        File logoSaveFile = new File(rootPath);
        if (!logoSaveFile.exists()) {
            logoSaveFile.mkdirs();
        }
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        try {
            SXSSFWorkbook workbook = null;
            List<ColdChainUnit> list = null;
            if (menuType ==1) {//新菜单进行数据导出
                list = coldChainUnitService.queryRegByDIdAndRegName2New(departId, regType, regName);
            }else{
                list = coldChainUnitService.queryRegByDIdAndRegName(departId, regType, regName);
            }

            if ("word".equals(types)) {
                String docName = fileName + ".doc";
                /*ItextTools.createDepartWordDocument(rootPath, rootPath + docName, Excel.DEPART_MONTH_HEADERS, list, null, request);*/
                responseEntity = DyFileUtil.download(request, response, rootPath, docName);
                return responseEntity;
            }
            String[] names;
            String[] attributes;
            String title = "";//标题
            if(null!= SystemConfigUtil.EXPORT_CONFIG){
                names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYOBJ").getString("names").split(",");
                attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYOBJ").getString("attributes").split(",");
                title = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("REGULATORYOBJ").getString("title");
            }else{
                names=Excel.OBJECT_HEADERS;
                attributes=Excel.OBJECT_FIELDS;
            }

            String xlsName = fileName + ".xlsx";
            workbook = new SXSSFWorkbook(100);
            Excel.outputExcelFile(workbook, names, attributes, list, rootPath + xlsName, "1",title);
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
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }

        return responseEntity;
    }

    /**
     * 导出监管对象二维码
     *
     * @param request
     * @param response
     * @param regIds 监管对象ID，多个以,隔开
     * @param departId 机构ID
     * @param regName 监管对象名称
     * @param regType 监管对象类型，多个以,隔开
     * @return
     */
    @RequestMapping(value = "/exportQrcode")
    @ResponseBody
    public ResponseEntity<byte[]> exportQrcode(HttpServletRequest request, HttpServletResponse response, String regIds, Integer departId, String regName, String regType) {

        ResponseEntity<byte[]> responseEntity = null;
        try {

            TSUser user = PublicUtil.getSessionUser();
            List<ColdChainUnit> regObjects = new ArrayList<ColdChainUnit>();
            if (StringUtils.hasText(regIds)) {
                String[] regIds0 = regIds.split(",");
                Integer[] regIds1 = (Integer[]) ConvertUtils.convert(regIds0,Integer.class);
                regObjects = coldChainUnitService.queryByIds(regIds1);
            } else {
                StringBuffer sql = new StringBuffer();
                sql.append("SELECT bro.id, bro.reg_name regName FROM cold_chain_unit bro WHERE bro.delete_flag=0 ");

                //查询条件
                if (departId != null) {
                    sql.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ").append(departId).append("),'%')) ");
                } else {
                    sql.append(" AND depart_id IN (SELECT id FROM t_s_depart WHERE delete_flag=0 AND depart_code LIKE CONCAT((SELECT depart_code FROM t_s_depart WHERE delete_flag=0 AND id = ").append(user.getDepartId()).append("),'%')) ");
                }

                //检测室用户
                if (user.getPointId()!=null) {
                    //企业检测室用户只能查看关联的监管对象
                    BasePoint bp = basePointService.queryById(user.getPointId());
                    if (bp != null && bp.getRegulatoryId() != null && !"".equals(bp.getRegulatoryId().trim())){
                        sql.append(" AND id = ").append(bp.getRegulatoryId().trim()).append(" ");
                    }
                }

                if (StringUtils.hasText(regName)) {
                    sql.append(" AND reg_name LIKE '%").append(regName).append("%' ");
                }
                if (StringUtils.hasText(regType)) {
                    String[] rts = regType.split(",");
                    sql.append(" AND reg_type IN (");
                    for (int i=0; i< rts.length; i++) {
                        if (i == rts.length-1) {
                            sql.append("'").append(rts[i]).append("'");
                        } else {
                            sql.append("'").append(rts[i]).append("',");
                        }
                    }
                    sql.append(") ");
                }
                regObjects = (List<ColdChainUnit>) jdbcTemplate.query(sql.toString(), new ResultSetExtractor(){
                    @Override
                    public Object extractData(ResultSet rs) throws SQLException, DataAccessException {
                        List<ColdChainUnit> bros = new ArrayList<ColdChainUnit>();
                        while(rs.next())
                        {
                            ColdChainUnit bro = new ColdChainUnit();
                            bro.setId(rs.getInt(1));
                            bro.setRegName(rs.getString(2));
                            bros.add(bro);
                        }
                        return bros;
                    }
                });
            }

            //二维码风格
            //尺寸
            Integer size = 100;
            //logo
            Integer logoNo = null;
            String logoStr = null;
            //添加文字
            String title = "";
            Integer fontSize = 14;
            JSONObject regQrcodeStyle = systemConfigJsonService.getSystemConfig(SystemConfigJsonService.systemConfigType.REG_QRCODE_STYLE);
            if (regQrcodeStyle != null) {
                if (regQrcodeStyle.getInteger("size") != null) {
                    size = regQrcodeStyle.getInteger("size");
                }
                if (regQrcodeStyle.getInteger("logoNo") != null) {
                    logoNo = regQrcodeStyle.getInteger("logoNo");

                    JSONArray logos = regQrcodeStyle.getJSONArray("logos");
                    if (logos != null && logos.size()>logoNo) {
                        logoStr = logos.getString(logoNo);
                    }
                    if (regQrcodeStyle.getString("title") != null) {
                        title = regQrcodeStyle.getString("title");
                    }
                    if (regQrcodeStyle.getString("fontSize") != null) {
                        fontSize = Integer.parseInt(regQrcodeStyle.getString("fontSize").replaceAll("px",""));
                    }
                }

            }

            //生成Word
            //表格列数
            int colNum = 3;
            //表格列宽
            int tableCellWidth = 3500;
            //单元格内边距 - 上 左 下 右
            int[] cellMargins = new int[]{200, 50, 200, 50};

            //大尺寸二维码
            if (size == 200) {
                colNum = 2;
                tableCellWidth = 5000;
                cellMargins = new int[]{200, 100, 200, 100};
            }

            //创建Word文件
            XWPFDocument doc = new CustomXWPFDocument();

            // 设置页面大小间距 A4大小
            POIUtil.setPageSize(doc,11907,16840,1000,1000,1000,1000);

            //创建表格
            XWPFTable table = doc.createTable(1, colNum);
            //设置单元格边距
            table.setCellMargins(cellMargins[0],cellMargins[1],cellMargins[2],cellMargins[3]);

            XWPFTableRow tableRow = null;
            for (int i = 0; i < regObjects.size(); i++) {
                //获取单元格
                XWPFTableCell tableCell = null;
                if ((i + 1) % colNum == 1) {
                    if (i == 0) {
                        tableRow = table.getRow(0);
                    } else {
                        tableRow = table.createRow();
                    }
                    tableCell = tableRow.getCell(0);
                } else {
                    tableCell = tableRow.getCell(i % colNum);
                }
                //设置单元格宽度
                POIUtil.setCellWidthAndVAlign(tableCell, tableCellWidth, XWPFTableCell.XWPFVertAlign.CENTER, STJc.CENTER);

                //创建段落对象
                XWPFParagraph p1 = tableCell.getParagraphArray(0);
                //设置段落的对齐方式
                setParagraphVAlign(p1);

                //添加文字
                if (StringUtil.isNotEmpty(title)) {
                    XWPFRun run1 = p1.createRun();
                    run1.setFontSize(fontSize);
                    run1.setText(title);
                    //换行
                    run1.addBreak(BreakType.TEXT_WRAPPING);

                }

                //监管对象名称
                XWPFRun run2 = p1.createRun();
                run2.setText(regObjects.get(i).getRegName());
                run2.setFontSize(fontSize);
                //换行
                run2.addBreak(BreakType.TEXT_WRAPPING);

                //设置二维码
                XWPFRun run3 = p1.createRun();
                InputStream qrcode = QrcodeUtil.generateQrcode3(systemUrl+"iRegulatory/regObjectApp.do?id=" + regObjects.get(i).getId(), size, size, logoStr);
                run3.addPicture(qrcode, XWPFDocument.PICTURE_TYPE_PNG, regObjects.get(i).getId()+".png", Units.toEMU(size*0.75) , Units.toEMU(size*0.75));

            }

            //导出监管对象二维码临时文件目录
            String wordTempPath = resources + regObjectQr + "temp/";
            //导出监管对象二维码word
            String tempFile = UUIDGenerator.generate() + ".doc";
            DyFileUtil.createFolder(wordTempPath);

            FileOutputStream out = new FileOutputStream(wordTempPath + tempFile);
            doc.write(out);
            out.close();

            responseEntity = DyFileUtil.download(request, response, wordTempPath, tempFile);
            //删除临时文件
            DyFileUtil.deleteFolder(wordTempPath + tempFile);

        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
        }

        return responseEntity;
    }

    /**
     * @Description: 设置列宽
     */
    private void setCellWidthAndVAlign(XWPFTableCell cell, String width) {
        cell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);    //垂直居中
        CTTc cttc = cell.getCTTc();
        CTTcPr cellPr = cttc.addNewTcPr();
        CTTblWidth tblWidth = cellPr.isSetTcW() ? cellPr.getTcW() : cellPr.addNewTcW();
        if (!StringUtil.isEmpty(width)) {
            tblWidth.setW(new BigInteger(width));
            tblWidth.setType(STTblWidth.DXA);
        }
    }

    /**
     * @Description: 设置段落的对齐方式
     */
    private void setParagraphVAlign(XWPFParagraph p) {
        p.setAlignment(ParagraphAlignment.CENTER);// 设置段落的水平对齐方式
        p.setVerticalAlignment(TextAlignment.CENTER);// 设置段落的垂直对齐方式
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
     * @Description
     * @Date 2020/10/10 11:19
     * @Author xiaoyl
     * @Param isNewMenu 是否从监管对象新菜单进入：可选值：Y，N；默认为N否,
     * @return
     */
    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request, Integer type,@RequestParam(required = false,defaultValue = "N") String isNewMenu) throws JSONException {
        request.setAttribute("type", type);
        request.setAttribute("isNewMenu", isNewMenu);
        return new ModelAndView("/cold/unit/toImport");
    }
    /**
     * @Description
     * 1.统一增加字段长度验证，特别是字符串型数据，必须验证数据表的字段长度，防止字段过长导入失败。
     * 2.必填字段超出长度，该条记录报错，非必填字段超出长度字段截取最大长度。
     * 3.非必填字段如果数据值错误，可丢弃值，或取默认值，不建议报错(大家可以讨论一下再确定)
     * 4.尽量做到报错准确，最大程度获取真实的错误提示
     * @Param
     * @return
     */
    @RequestMapping("/importData")
    public @ResponseBody
    AjaxJson importData(@RequestParam("xlsx") MultipartFile file, HttpServletRequest request, HttpServletResponse response, HttpSession session, Integer departId,
                        String departNames) {
        AjaxJson jsonObject = new AjaxJson();
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String path = resources + "object/";
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
            TSDepart d = departService.getById(departId);
            int totalRow = sheet.getLastRowNum();
            TBImportHistory t = new TBImportHistory();
            String description = getCellValue(sheet.getRow(0).getCell(0));// 获取第一行的备注说明信息
            for (int i = 1; i <= totalRow; i++) {
                row = sheet.getRow(i);
                if (null == row) continue;
                if (isEmptyRow(row)) continue;
                String departName     = getCellValue(row.getCell(0));  // 机构名称,必填,机构名称只是用于查询机构ID使用，因此可以不用校验机构名称的长度
                String companyName    = getCellValue(row.getCell(1));  // 企业名称
                String regName        = getCellValue(row.getCell(2));  // 监管对象名称,必填
                String regAddress     = getCellValue(row.getCell(3));  // 监管对象地址
                String regTypes       = getCellValue(row.getCell(4));  // 监管对象类型,必填,因为最后写入数据表用的是类型ID，所有不用校验类型的长度
                //String managementType = getCellValue(row.getCell(5));  // 市场类型
                String linkUser       = getCellValue(row.getCell(5));  // 联系人名称
                String linkPhone      = getCellValue(row.getCell(6));  // 联系方式
                String legalPerson    = getCellValue(row.getCell(7));  // 法人代表
                String linkIdcard     = getCellValue(row.getCell(8));  // 身份证,长度超出18进行截断处理
                if(StringUtil.isNotEmpty(linkIdcard) && linkIdcard.length()>18){
                    linkIdcard=linkIdcard.substring(0,18);
                }
                String creditCode     = getCellValue(row.getCell(9)); // 统一社会信用代码
                //String businessCope   = getCellValue(row.getCell(11)); // 经营范围
                String checkeds       = getCellValue(row.getCell(10)); // 审核状态，必填

                if (i == 1) {
                    if (!departName.equals("机构名称") || !regName.equals("冷链单位名称") || !regTypes.equals("类型") || !checkeds.equals("状态")) {
                        t.setRemark("导入数据的模板不正确");
                        jsonObject.setSuccess(false);
                        break;
                    }
                } else {
                    if (StringUtil.isEmpty(departName)) {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds,  "[机构名称]不能为空");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(regName)) {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[冷链单位名称]不能为空");
                        failCount++;
                        continue;
                    }else if(StringUtil.isNotEmpty(regName) && regName.length()>100){
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[冷链单位名称]超出长度，最大长度为100");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(regTypes)) {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[类型]不能为空");
                        failCount++;
                        continue;
                    }
                    if (StringUtil.isEmpty(checkeds)) {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[状态]不能为空");
                        failCount++;
                        continue;
                    }
                    //非必填字段首先检验是否为空，不为空进一步校验长度是否超出数据库设置的长度，如果超出则根据数据库设置的长度截取数据 start
                    //监管对象地址
                    if(StringUtil.isNotEmpty(regAddress) && regAddress.length()>200){
                        regAddress=regAddress.substring(0,200);
                    }
                    //联系人名称
                    if(StringUtil.isNotEmpty(linkUser) && regAddress.length()>50){
                        linkUser=linkUser.substring(0,50);
                    }
                    //联系方式
                    if(StringUtil.isNotEmpty(linkPhone) && linkPhone.length()>50){
                        linkPhone=linkPhone.substring(0,50);
                    }
                    //法人代表
                    if(StringUtil.isNotEmpty(legalPerson) && legalPerson.length()>50){
                        legalPerson=legalPerson.substring(0,50);
                    }
                    //身份证
                    if(StringUtil.isNotEmpty(linkIdcard) && linkIdcard.length()>20){
                        linkIdcard=linkIdcard.substring(0,20);
                    }
                    //统一社会信用代码
                    if(StringUtil.isNotEmpty(creditCode) && creditCode.length()>100){
                        creditCode=creditCode.substring(0,100);
                    }

                    //企业名称
                    if(StringUtil.isNotEmpty(companyName) && companyName.length()>100){
                        companyName=companyName.substring(0,100);
                    }
                    //非必填字段校验长度是否超出数据库设置的长度，如果超出则根据数据库设置的长度截取数据 end
                    ColdChainUnit object = new ColdChainUnit();
                    String ImpTypes="";
                    if (regTypes.equals("个人") || regTypes.equals("企业")) {
                        if(regTypes.equals("个人")) {
                            object.setRegType(1);
                            ImpTypes="1";
                        }
                        if(regTypes.equals("企业")) {
                            object.setRegType(0);
                            ImpTypes="0";
                        }
                    } else {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds,  "[类型]不正确");
                        failCount++;
                        continue;
                    }
                    ColdChainUnit object1 = coldChainUnitService.selectByDepartCodeAndRegName(d.getDepartCode(), departName, regName,ImpTypes);
                    if (null == object1) {
                        List<TSDepart> subDeparts = departService.selectByDepartCodeAndDepartName(d.getDepartCode(), departName);
                        if (subDeparts.size() == 0) {
                            addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[" + d.getDepartName() + "]机构下级无[" + departName + "]子机构");
                            failCount++;
                            continue;
                        }

                        object.setRegName(regName);
                        object.setDepartId(subDeparts.get(0).getId());
                        object.setRegAddress(regAddress);
						/*if (("经营单位").equals(regTypes)) {
							object.setRegType("4028935f5e7e898a015e7e89a9490001");
						}
                        //update by xiaoyl 2022/05/20 当[类型]为<经营单位>时，校验[市场类型]的值，且只能是<农贸市场>或<批发市场>，默认为<农贸市场>；否则，不校验
                        if ("经营单位".equals(regTypes) && StringUtil.isNotEmpty(managementType)) {
                            if (("农贸市场").equals(managementType)) {
                                object.setManagementType(1 + "");
                            } else if (("批发市场").equals(managementType)) {
                                object.setManagementType(0 + "");
                            } else {
                                object.setManagementType(1 + "");
                            }
                        } else {
                            object.setManagementType(1 + "");
                        }
                        */

                        object.setLinkUser(linkUser);
                        object.setLinkPhone(linkPhone);
                        object.setLinkIdcard(linkIdcard);
                        object.setCreditCode(creditCode);
                        object.setCompanyName(companyName);
                        object.setLegalPerson(legalPerson);
                        Short checkedss;//审核状态：未审核、未审核；用户不填写或者填入其他值则默认设置为已审核状态
                        if (StringUtil.isNotEmpty(checkeds)) {
                            if (("未审核").equals(checkeds)) {
                                checkedss = 0;
                            } else if (("已审核").equals(checkeds)) {
                                checkedss = 1;
                            } else {
                                checkedss = 1;
                            }
                        } else {
                            checkedss = 1;
                        }
                        object.setChecked(checkedss);
                        PublicUtil.setCommonForTable(object, true);
                        coldChainUnitService.insertSelective(object);
                        successCount++;
                    } else {
                        addToErrList(errList, departName, companyName, regName, regAddress, regTypes, linkUser, linkPhone, legalPerson, linkIdcard, creditCode, checkeds, "[冷链单位名称]已存在");
                        failCount++;
                        continue;
                    }
                }
            }
            String errFile = null;
            if (errList.size() > 0) {
                errFile = fileName.substring(0, fileName.indexOf(".")) + "_err.xlsx";
                SXSSFWorkbook wb = new SXSSFWorkbook(100);
                Excel.outputExcelFileForDescription(wb, ImportBaseData.headers, ImportBaseData.fields, errList, path + errFile, "1","",description);
                FileOutputStream fOut = new FileOutputStream(path + "/" + errFile);
                wb.write(fOut);
                fOut.flush();
                fOut.close();
            }

            t.setDepartId(departId);
            t.setDepartCode(PublicUtil.getSessionUserDepart().getDepartCode());
            t.setDepartName(departNames);
            t.setUsername(user.getRealname());
            t.setUserId(user.getId());
            t.setSourceFile("/object/" + fileName);
            t.setErrFile(errFile == null ? null : "/object/" + errFile);
            t.setSuccessCount(successCount);
            t.setFailCount(failCount);
            t.setImportDate(stamp);
            t.setImportType(2);
            t.setEndDate(new Date());
            importHistoryService.insertSelective(t);
            jsonObject.setMsg("/object/" + errFile);
        } catch (Exception e) {
            log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("导入失败");
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            }
        }
        return jsonObject;
    }

    private void addToErrList(List<ImportBaseData> errList, String departName, String companyName, String regName, String regAddress, String regTypes, String linkUser, String linkPhone, String legalPerson,
                              String linkIdcard, String creditCode, String checkeds, String errMsg) {
        ImportBaseData d = new ImportBaseData();
        d.setDepartName(departName);
        d.setCompanyName(companyName);
        d.setRegName(regName);
        d.setRegAddress(regAddress);
        d.setRegTypes(regTypes);
        d.setLinkUser(linkUser);
        d.setLinkPhone(linkPhone);
        d.setLegalPerson(legalPerson);
        d.setLinkIdcard(linkIdcard);
        d.setCreditCode(creditCode);
        d.setCheckeds(checkeds);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    public static class ImportBaseData {
        public static String[] headers = {"机构名称", "企业名称", "监管对象名称", "监管对象地址", "类型", "市场类型", "联系人名称", "联系方式", "法人代表", "身份证", "统一社会信用代码", "经营范围", "状态", "导入失败原因"};
        public static String[] fields = {"departName", "companyName", "regName", "regAddress", "regTypes", "managementType", "linkUser", "linkPhone", "legalPerson", "linkIdcard", "creditCode", "businessCope", "checkeds", "errMsg"};
        String departName;// 机构名称
        String companyName;//企业名称
        String regName;// 监管对象名称
        String regAddress;// 监管对象地址
        String regTypes;// 类型
        String managementType;// 市场类型
        String linkUser;// 联系人名称
        String linkPhone;// 联系方式
        String legalPerson;//法人代表
        String linkIdcard;// 身份证
        String creditCode;//统一社会信用代码
        String businessCope;//经营范围
        String checkeds;// 状态
        String errMsg;// 导入失败原因

        public String getCompanyName() {
            return companyName;
        }

        public void setCompanyName(String companyName) {
            this.companyName = companyName;
        }

        public String getLegalPerson() {
            return legalPerson;
        }

        public void setLegalPerson(String legalPerson) {
            this.legalPerson = legalPerson;
        }

        public String getBusinessCope() {
            return businessCope;
        }

        public void setBusinessCope(String businessCope) {
            this.businessCope = businessCope;
        }

        public String getCreditCode() {
            return creditCode;
        }

        public void setCreditCode(String creditCode) {
            this.creditCode = creditCode;
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

        public String getManagementType() {
            return managementType;
        }

        public void setManagementType(String managementType) {
            this.managementType = managementType;
        }

        public String getDepartName() {
            return departName;
        }

        public void setDepartName(String departName) {
            this.departName = departName;
        }

        public String getRegName() {
            return regName;
        }

        public void setRegName(String regName) {
            this.regName = regName;
        }

        public String getRegAddress() {
            return regAddress;
        }

        public void setRegAddress(String regAddress) {
            this.regAddress = regAddress;
        }

        public String getRegTypes() {
            return regTypes;
        }

        public void setRegTypes(String regTypes) {
            this.regTypes = regTypes;
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

        public String getLinkIdcard() {
            return linkIdcard;
        }

        public void setLinkIdcard(String linkIdcard) {
            this.linkIdcard = linkIdcard;
        }

        public String getCheckeds() {
            return checkeds;
        }

        public void setCheckeds(String checkeds) {
            this.checkeds = checkeds;
        }

        public String getErrMsg() {
            return errMsg;
        }

        public void setErrMsg(String errMsg) {
            this.errMsg = errMsg;
        }
    }
}
