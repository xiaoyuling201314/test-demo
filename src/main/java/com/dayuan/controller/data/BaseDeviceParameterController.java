package com.dayuan.controller.data;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.style.column.LongestMatchColumnWidthStyleStrategy;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.data.*;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.regulatory.BaseRegulatoryBusinessController;
import com.dayuan.model.data.DeviceParameterExportModel;
import com.dayuan.model.data.DeviceParameterFaildModel;
import com.dayuan.service.data.*;
import com.dayuan.util.*;
import com.dayuan.util.excel.DeviceParameterListener;
import com.dayuan.util.excel.ExcelUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.common.PublicUtil;
import com.dayuan.controller.BaseController;
import com.dayuan.model.data.BaseDeviceParameterModel;

/**
 * 仪器检测项目参数管理 Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月17日
 */
@Controller
@RequestMapping("/data/deviceSeries/detectParameter")
public class BaseDeviceParameterController extends BaseController {
    private final Logger log = Logger.getLogger(BaseDeviceParameterController.class);
    @Autowired
    private BaseDeviceParameterService baseDeviceParameterService;
    @Autowired
    private BaseDeviceTypeService baseDeviceTypeService;

    @Autowired
    private BaseDevicesItemService baseDevicesItemService;

    @Autowired
    private BaseDeviceService baseDeviceService;

    @Autowired
    private BaseDetectItemService detectItemService;
    @Autowired
    private TBImportHistoryService importHistoryService;

    @Value("${resources}")
    private String resources;
    @Value("${storageDirectory}")
    private String storageDirectory;

    /**
     * 进入页面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response, String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            BaseDeviceType bean = baseDeviceTypeService.queryById(id);
            map.put("deviceType", bean);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
        }
        return new ModelAndView("/data/deviceSeries/detectParameter/list", map);
    }

    /**
     * 数据列表
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(BaseDeviceParameterModel model, Page page, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page = baseDeviceParameterService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * @param bean
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(BaseDeviceParameter bean, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        try {
            BaseDeviceParameter baseBean = baseDeviceParameterService.queryByUniqueDeviceItem(bean);
            // 新增数据
            if (StringUtils.isBlank(bean.getId())) {
                if (baseBean == null) {
                    bean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(bean, true);
                    baseDeviceParameterService.save(bean);
                    //同步仪器检测项目:1.查询所有已注册好的仪器，遍历增加对应的检测项目
                    List<String> deviceList = baseDeviceService.queryByDeviceType(bean.getDeviceTypeId());
                    BaseDevicesItem bdi = null;
                    for (String deviceId : deviceList) {
                        bdi = new BaseDevicesItem();
                        bdi.setId(UUIDGenerator.generate());
                        bdi.setDeviceId(deviceId);
                        bdi.setDeviceParameterId(bean.getId());
                        bdi.setPriority((short) 0);
                        bdi.setChecked((short) 1);
                        PublicUtil.setCommonForTable(bdi, true);
                        baseDevicesItemService.insert(bdi);
                    }
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该项目已存在，请重新输入.");
                }

                // 修改数据
            } else {
                if (baseBean == null || bean.getId().equals(baseBean.getId())) {
                    PublicUtil.setCommonForTable(bean, false);
                    baseDeviceParameterService.updateById(bean);
                } else {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("该项目已存在，请重新输入.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
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
    public ModelAndView queryById(@RequestParam(required = false) String type, String id, HttpServletResponse response) {
        AjaxJson jsonObject = new AjaxJson();
        Map<String, Object> map = new HashMap<>();
        BaseDeviceType deviceType = null;
        try {
            if (StringUtils.isNotBlank(type) && type.equals("add")) {
                deviceType = baseDeviceTypeService.queryById(id);
            } else {
                BaseDeviceParameter bean = baseDeviceParameterService.getById(id);
                if (bean == null) {
                    jsonObject.setSuccess(false);
                    jsonObject.setMsg("没有找到对应的记录!");
                } else {
                    deviceType = baseDeviceTypeService.queryById(bean.getDeviceTypeId());
                }
                jsonObject.setObj(bean);
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("操作异常.");
        }
        map.put("deviceType", deviceType);
        map.put("data", jsonObject);
        return new ModelAndView("/data/deviceSeries/detectParameter/edit", map);
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
            for (String id : ida) {
                //删除仪器与检测项目关联信息
                baseDevicesItemService.deleteByDeviceParameterId(id);
                baseDeviceParameterService.removeById(id);
            }
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping("/toImport")
    private ModelAndView toImport(HttpServletRequest request, String deviceTypeId) throws Exception {
        BaseDeviceType deviceType = baseDeviceTypeService.queryById(deviceTypeId);
        request.setAttribute("deviceType", deviceType);
        return new ModelAndView("/data/deviceSeries/detectParameter/toImport");
    }

    /**
     * 1.统一增加字段长度验证，特别是字符串型数据，必须验证数据表的字段长度，防止字段过长导入失败。
     * 2.必填字段超出长度，该条记录报错，非必填字段超出长度字段截取最大长度。
     * 3.非必填字段如果数据值错误，可丢弃值，或取默认值，不建议报错(大家可以讨论一下再确定)
     * 4.尽量做到报错准确，最大程度获取真实的错误提示
     *
     * @return
     * @Param
     */
    @RequestMapping("/importData")
    public @ResponseBody
    AjaxJson importData(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response,
                        HttpSession session, String deviceTypeId) {
        AjaxJson jsonObject = new AjaxJson();
        Timestamp stamp = new Timestamp(System.currentTimeMillis());
        String fileName = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS") + ".xlsx";
        FileOutputStream fos = null;
        String path = resources + "deviceParameter/";
        TSUser user = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        try {
            fos = FileUtils.openOutputStream(new File(path + "/" + fileName));
            IOUtils.copy(file.getInputStream(), fos);
            //1.写入导入记录：不管失败与否都有记录可查
            TBImportHistory t = new TBImportHistory(user.getId(),user.getDepartId(),PublicUtil.getSessionUserDepart().getDepartCode(),user.getDepartName(),user.getRealname(),"/deviceParameter/" + fileName,new Date(),7);
            importHistoryService.insert(t);
            //2.查询所有的检测项目
            Map<String, Map<String, Object>> itemMap=initAllItem();
            EasyExcel.read(file.getInputStream(), DeviceParameterFaildModel.class, new DeviceParameterListener(importHistoryService,baseDeviceParameterService,baseDeviceService,baseDevicesItemService,deviceTypeId,t.getId(),fileName,path,itemMap)).sheet().headRowNumber(2).doRead();
           //3.查询导入结果
            t=importHistoryService.queryById(t.getId());
            jsonObject.setObj(JSONObject.toJSONString(t));
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("导入失败");
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            }
        }
        return jsonObject;
    }

    //初始化查询所有的样品信息，并封装成Map对象
    private  Map<String, Map<String, Object>> initAllItem(){
        Map<String, Map<String, Object>> itemMap = new HashMap<String, Map<String, Object>>();
        List<Map<String, Object>> itemListMap = detectItemService.queryItemMap();
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
        return itemMap;
    }

    private void addToErrList(List<BaseRegulatoryBusinessController.ImportBaseData> errList, String departName, String regName, String opeShopCode, String opeShopName, String opeName, String opeIdcard,
                              String creditCode, String contacts, String opePhone, String creditRatings, String monitoringLevels, String businessCope, String type, String checkeds, String errMsg) {
        BaseRegulatoryBusinessController.ImportBaseData d = new BaseRegulatoryBusinessController.ImportBaseData();
        d.setDepartName(departName);
        d.setRegName(regName);
        d.setOpeShopName(opeShopName);
        d.setOpeShopCode(opeShopCode);
        d.setOpeName(opeName);
        d.setOpeIdcard(opeIdcard);
        d.setCreditCode(creditCode);
        d.setContacts(contacts);
        d.setOpePhone(opePhone);
        d.setCreditRatings(creditRatings);
        d.setMonitoringLevel(monitoringLevels);
        d.setBusinessCope(businessCope);
        d.setType(type);
        d.setCheckeds(checkeds);
        d.setErrMsg(errMsg);
        errList.add(d);
    }

    /**
     * @return
     * @Description 仪器检测项目导出
     * @Date 2023/05/25 13:15
     * @Author xiaoyl
     * @Param
     */
    @RequestMapping(value = "/exportFile")
    private ResponseEntity<byte[]> exportFile(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                                              BaseDeviceParameterModel model, String ids, String deviceName) {
        ResponseEntity<byte[]> responseEntity = null;
        TSUser tsUser = (TSUser) session.getAttribute(WebConstant.SESSION_USER);
        String fileName = deviceName + "-" + DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
        try {
            StringBuffer rootPath = new StringBuffer(resources + storageDirectory);
            List<DeviceParameterExportModel> list = null;
            if (ids != null && !"".equals(ids.trim()) && ids.split(",").length > 0) {
                String[] idsStr = ids.split(",");
                List<String> listIds = Arrays.asList(idsStr);
                list = baseDeviceParameterService.queryListForExport(model, listIds);
            } else {
                list = baseDeviceParameterService.queryListForExport(model, null);
            }
            String xlsName = fileName + ".xlsx";
            rootPath.append("deviceParameter/");
            File logoSaveFile = new File(rootPath.toString());
            if (!logoSaveFile.exists()) {
                logoSaveFile.mkdirs();
            }
          /*  String[] names = null;
            String[] attributes = null;
            String title = "";//标题
            if (null != SystemConfigUtil.EXPORT_CONFIG) {
                names = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("DEVICE_ITEM_DATA").getString("names").split(",");
                attributes = SystemConfigUtil.EXPORT_CONFIG.getJSONObject("DEVICE_ITEM_DATA").getString("attributes").split(",");
                title = deviceName + "-" + SystemConfigUtil.EXPORT_CONFIG.getJSONObject("DEVICE_ITEM_DATA").getString("title");
            } else {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("请先前往【系统管理】的【参数配置】中配置要导出的数据内容，如有疑问请联系管理员！<a href='" + request.getContextPath() + "/data/deviceSeries/detectParameter/list.do?id=" + model.getBaseBean().getDeviceTypeId() + "'><i class='icon iconfont icon-fanhui'></i>返回</a>");

            }
             Excel.outputDeviceParameterExcelFile(names, attributes, list, title, outPath);
            */
            String outPath = rootPath + File.separator + xlsName;
            EasyExcel.write(new FileOutputStream(outPath), DeviceParameterExportModel.class)
                    .sheet()
                    .registerWriteHandler(new LongestMatchColumnWidthStyleStrategy())// 设置单元格宽度自适应
                    .registerWriteHandler(ExcelUtil.getHeightAndFontStrategy()) // 设置单元格高度和字体
                    .doWrite(list);
            responseEntity = DyFileUtil.download(request, response, rootPath.toString(), xlsName);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("*****" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }
        return responseEntity;
    }
    /**
     * 设置Excel头
     * @param headList  Excel头信息
     * @return
     */
    public static List<List<String>> head(List<String> headList) {
        List<List<String>> list = new ArrayList<>();
        for (String value : headList) {
            List<String> head = new ArrayList<>();
            head.add(value);
            list.add(head);
        }
        return list;
    }
}
