package com.dayuan.util.excel;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.excel.exception.ExcelAnalysisException;
import com.alibaba.excel.exception.ExcelAnalysisStopException;
import com.alibaba.excel.exception.ExcelDataConvertException;
import com.alibaba.fastjson.JSON;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.dataCheck.DataCheckRecording;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.model.dataCheck.ImportDataCheckModel;
import com.dayuan.service.DataCheck.DataCheckRecordingService;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.Excel;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2021-10-25 16:54
 */
public class DataCheckListener extends AnalysisEventListener<ImportDataCheckModel> {
    private static final Logger LOGGER = LoggerFactory.getLogger(DataCheckListener.class);
    private static final int BATCH_COUNT = 1000;// 每隔1000条存储数据库，实际使用中可以3000条，然后清理list ，方便内存回收
    //暂时存储检测数据集合
    List<DataCheckRecording> list = new ArrayList<DataCheckRecording>();
    //验证不通过的检测数据对象集合
    List<ImportDataCheckRecording> problems = new ArrayList<ImportDataCheckRecording>();
    int headerNumber = 0;
    String description="";//第一行描述信息
    private String departCode;//导入机构code
    private Integer importHistoryId;//导入记录ID
    private String userId;//用户ID
    private String fName;//原文件名
    private String section;//文件存储根路径
    private int successCount = 0;
    private int failCount = 0;
    private Boolean rightTemplate = true;//导入模板是否正确
    //查询出机构下所有的检测点及数量
    private Map<String, Map<String, Object>> pointListMap;
    //查询机构下的市场
    private Map<String, Map<String, Object>> regListMap;
    //查询机构下的经营户
    private Map<String, Map<String, Object>> busListMap;
    //查询所有的样品
    private Map<String, Map<String, Object>> foodListMap;
    //查询所有检测项目
    private Map<String, Map<String, Object>> itemListMap;
    private TBImportHistoryService importHistoryService;
    private DataCheckRecordingService dataCheckRecordingService;

    public DataCheckListener() {

    }

    public DataCheckListener(TBImportHistoryService importHistoryService, DataCheckRecordingService dataCheckRecordingService,
                             String departCode, Integer importHistoryId, String userId, String fName, String section,
                             Map<String, Map<String, Object>> pointListMap, Map<String, Map<String, Object>> regListMap,
                             Map<String, Map<String, Object>> busListMap, Map<String, Map<String, Object>> foodListMap, Map<String, Map<String, Object>> itemListMap) {
        this.importHistoryService = importHistoryService;
        this.dataCheckRecordingService = dataCheckRecordingService;
        this.departCode = departCode;
        this.importHistoryId = importHistoryId;
        this.userId = userId;
        this.fName = fName;
        this.section = section;
        this.pointListMap = pointListMap;
        this.regListMap = regListMap;
        this.busListMap = busListMap;
        this.foodListMap = foodListMap;
        this.itemListMap = itemListMap;
    }

    @Override
    public void invoke(ImportDataCheckModel data, AnalysisContext context) {
        try {
            if (rightTemplate) {//导入模板正确，进行下一步处理
                String msg = "";
                if (StringUtil.isEmpty(data.getPointName())) {
                    addToProblems(problems, data, "[检测点名称]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getPointName()) && data.getPointName().length() > 50) {
                    addToProblems(problems, data, "[检测点名称]超出长度，最大长度为50");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getRegName())) {
                    addToProblems(problems, data, "[被检单位]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getRegName()) && data.getRegName().length() > 200) {
                    addToProblems(problems, data, "[被检单位]超出长度，最大长度为200");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getFoodName())) {
                    addToProblems(problems, data, "[样品名称]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getFoodName()) && data.getFoodName().length() > 200) {
                    addToProblems(problems, data, "[样品名称]超出长度，最大长度为200");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getCkItem())) {
                    addToProblems(problems, data, "[检测项目]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getCkItem()) && data.getCkItem().length() > 50) {
                    addToProblems(problems, data, "[检测项目]超出长度，最大长度为50");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getCkResult())) {
                    addToProblems(problems, data, "[检测值]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getCkResult()) && data.getCkResult().length() > 50) {
                    addToProblems(problems, data, "[检测值]超出长度，最大长度为50");
                    failCount++;
                    return;
                }
                if ((!"合格".equals(data.getConclusion()) && !"不合格".equals(data.getConclusion()))) {
                    addToProblems(problems, data, StringUtil.isEmpty(data.getConclusion()) ? "检测结论不能为空" : "检测结论只能是合格或不合格");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getCkUser())) {
                    addToProblems(problems, data, "[检测人员]不能为空");
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getCkUser()) && data.getCkUser().length() > 50) {
                    addToProblems(problems, data, "[检测人员]超出长度，最大长度为50");
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getCkDate())) {
                    addToProblems(problems, data, "[检测时间]不能为空");
                    failCount++;
                    return;
                }
                Date checkDate = null;
                Date now = new Date();
                try {
                    if (DateUtil.checkDate(data.getCkDate())) {
                        checkDate = DateUtil.datetimeFormat.parse(data.getCkDate());
                    } else if (DateUtil.checkDates(data.getCkDate())) {
                        checkDate = DateUtil.datetimeFormat2.parse(data.getCkDate());
                    } else {
                        addToProblems(problems, data, "[检测时间]格式不正确");
                        failCount++;
                        return;
                    }

                } catch (Exception e) {
                    addToProblems(problems, data, "[检测时间]格式不正确");
                    failCount++;
                    return;
                }

                if (checkDate.after(now)) {
                    addToProblems(problems, data, "[检测时间]不能大于当前时间");
                    failCount++;
                    return;
                }
                Map<String, Object> pMap = pointListMap.get(data.getPointName());
                if (null == pMap || (Long) pMap.get("count") > 1) {
                    msg = null == pMap ? "导入机构下查询不到[" + data.getPointName() + "]检测点" : "导入机构下有多个检测点：[" + data.getPointName() + "]";
                    addToProblems(problems, data, msg);
                    failCount++;
                    return;
                }
                Map<String, Object> rMap = regListMap.get(data.getRegName());
                if (null == rMap || (Long) rMap.get("count") > 1) {
                    msg = null == rMap ? "导入机构下查询不到[" + data.getRegName() + "]监管对象" : "导入机构下有多个监管对象：[" + data.getRegName() + "]";
                    addToProblems(problems, data, msg);
                    failCount++;
                    return;
                }

                Map<String, Object> bMap = null;
                //档口编号不为空，验证是否正确
                if (StringUtil.isNotEmpty(data.getRegUserName())) {
                    bMap = busListMap.get(data.getRegUserName() + data.getRegName());
                    //不校验档口 -Dz 20220329
//                    if (null == bMap) {
//                        msg = "监管对象：[" + data.getRegName() + "]下查询不到档口：[" + data.getRegUserName() + "]的经营户";
//                        addToProblems(problems, data, msg);
//                        failCount++;
//                        return;
//                    } else if ((Long) bMap.get("count") > 1) {
//                        msg = "监管对象：[" + data.getRegName() + "]下有多个档口为：[" + data.getRegUserName() + "]的经营户";
//                        addToProblems(problems, data, msg);
//                        failCount++;
//                        return;
//                    }
                }

                Map<String, Object> fMap = foodListMap.get(data.getFoodName());
                if (null == fMap) {
                    msg = null == fMap ? "食品种类中查询不到名为：[" + data.getFoodName() + "]的食品" : "食品种类中有多个名为：[" + data.getFoodName() + "]的食品";
                    addToProblems(problems, data, msg);
                    failCount++;
                    return;
                }
                Map<String, Object> iMap = itemListMap.get(data.getCkItem());
                if (null == iMap) {
                    msg = null == iMap ? "查询不到[" + data.getCkItem() + "]检测项目" : "查询到有多个名为:[" + data.getCkItem() + "]的检测项目";
                    addToProblems(problems, data, msg);
                    failCount++;
                    return;
                }
                //校验非必填字段是否超出数据库设置的长度
                String regUserName = data.getRegUserName();//档口编号
                if (StringUtil.isNotEmpty(regUserName) && regUserName.length() > 50) {
                    regUserName = regUserName.substring(0, 50);
                }
                String auditor = data.getAuditor();//审核人员名称
                if (StringUtil.isNotEmpty(auditor) && auditor.length() > 50) {
                    auditor = auditor.substring(0, 50);
                }
                String upUser = data.getUpUser();//上报人员名称
                if (StringUtil.isNotEmpty(upUser) && upUser.length() > 50) {
                    upUser =upUser.substring(0, 50);
                }
                String deviceName = data.getDeviceName();//检测仪器名称
                if (StringUtil.isNotEmpty(deviceName) && deviceName.length() > 50) {
                    deviceName =deviceName.substring(0, 50);
                }
                String modul = data.getModul();//检测模块
                if (StringUtil.isNotEmpty(modul) && modul.length() > 50) {
                    modul = modul.substring(0, 50);
                }
                String method = data.getMethod();//检测方法
                if (StringUtil.isNotEmpty(method) && method.length() > 50) {
                    method = method.substring(0, 50);
                }
                String deviceComp = data.getDeviceComp();//仪器厂家
                if (StringUtil.isNotEmpty(deviceComp) && deviceComp.length() > 50) {
                    deviceComp = deviceComp.substring(0, 50);
                }
                String remark = data.getRemark();//备注
                if (StringUtil.isNotEmpty(remark) && remark.length() > 200) {
                    remark = remark.substring(0, 200);
                }
                Integer regUserId = null == bMap ? null : (Integer) bMap.get("id");
//                DataCheckRecording checkData = new DataCheckRecording(UUIDGenerator.generate(),
//                        (Integer) fMap.get("typeId"), (String) fMap.get("typeName"), (Integer) fMap.get("id"), data.getFoodName(),//设置 食品种类 和名称
//                        (Integer) rMap.get("id"), data.getRegName(), regUserId, regUserName,//设置 市场 和档口
//                        (Integer) pMap.get("departId"), (String) pMap.get("departName"), (Integer) pMap.get("id"), data.getPointName(), //设置部门 和 检测点
//                        (String) iMap.get("id"), data.getCkItem(), String.valueOf(iMap.get("stdId")), (String) iMap.get("stdCode"), (String) iMap.get("valueUnit"),// 设置检测项目和 检测标准(依据)
//                        data.getLiValue(), data.getCkResult(), data.getConclusion(), checkDate, data.getCkUser(), auditor, upUser, now, deviceName,//设置 其他不用验证的值
//                        deviceComp, modul, method, (short) 1, (short) 4, (short) 1, (short) 0, userId, userId, now, now, fName);
//                checkData.setRemark(remark);
//                list.add(checkData);
                successCount++;
                if (list.size() >= BATCH_COUNT) {
                    saveData(null);
                    list.clear();
                }
            }
        } catch (Exception e) {
            LOGGER.error("******************************检测数据导入异常" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
        }

    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        try {
            TBImportHistory importHistory = importHistoryService.queryById(importHistoryId);
            saveData(importHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("所有数据解析完成！");
    }

    @Override
    public void invokeHeadMap(Map<Integer, String> headMap, AnalysisContext context) {
        headerNumber++;
        try {
            if(headerNumber==1){//第一行描述信息
                // 获取第一行的备注说明信息, //暂未使用：调用strip剥离map前后的{},StringUtils.strip(headMap.toString(),"{}")
                description = headMap.get(0);
            }
            if (headerNumber == 2) {
                if (!"检测点名称".equals(headMap.get(0).trim()) || !"被检单位".equals(headMap.get(1).trim()) || !"档口编号".equals(headMap.get(2).trim())
                        || !"样品名称".equals(headMap.get(3).trim()) || !"检测项目".equals(headMap.get(4).trim()) || !"检测值".equals(headMap.get(6).trim())
                        || !"检测结论".equals(headMap.get(7).trim())) {
                    rightTemplate = false;
                    TBImportHistory importHistory = importHistoryService.queryById(importHistoryId);
                    importHistory.setEndDate(new Date());
                    importHistory.setRemark("导入数据模板不正确,请从平台下载模板！！！");
                    importHistoryService.updateBySelective(importHistory);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOGGER.info("解析到一条头数据:{}", JSON.toJSONString(headMap));

    }

    /**
     * 加上存储数据库
     */
    private void saveData(TBImportHistory importHistory) throws Exception {
        try {
            if (list.size() > 0) {
//                dataCheckRecordingService.bathInsertDataCheck(list);

                //使用统一新增检测数据方法，判断数据有效性  --Dz 20220622
                TSUser user = PublicUtil.getSessionUser();
                for (DataCheckRecording d : list) {
                    dataCheckRecordingService.saveOrUpdateDataChecking(d, user);
                }

                LOGGER.info("存储数据库成功！");
            }
            if (null != importHistory) {
                String errFile = null;
                if (problems.size() > 0) {
                    errFile = fName.substring(0, fName.lastIndexOf(".")) + "_err.xlsx";
                    SXSSFWorkbook wb = new SXSSFWorkbook(500);
                    Excel.outputExcelFileForDescription(wb, ImportDataCheckRecording.headers, ImportDataCheckRecording.fields, problems, section + errFile, "1", "",description);
                    FileOutputStream fOut = new FileOutputStream(section + errFile);
                    wb.write(fOut);
                    fOut.flush();
                    fOut.close();
                }
                importHistory = importHistoryService.queryById(importHistoryId);
                importHistory.setSuccessCount(successCount);
                importHistory.setFailCount(failCount);
                importHistory.setEndDate(new Date());
                importHistory.setErrFile(errFile == null ? null : "/checkdata/" + errFile);
                importHistoryService.updateBySelective(importHistory);
            }
        } catch (Exception e) {
            importHistory.setEndDate(new Date());
            importHistory.setRemark("导入失败！" + (e == null || e.getMessage() == null ? "" : e.getMessage().substring(0, 200)));
            importHistoryService.updateBySelective(importHistory);
            System.out.println("******************************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
        }
    }

    public String getDepartCode() {
        return departCode;
    }

    public void setDepartCode(String departCode) {
        this.departCode = departCode;
    }

    public Integer getImportHistoryId() {
        return importHistoryId;
    }

    public void setImportHistoryId(Integer importHistoryId) {
        this.importHistoryId = importHistoryId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public int getSuccessCount() {
        return successCount;
    }

    public void setSuccessCount(int successCount) {
        this.successCount = successCount;
    }

    public int getFailCount() {
        return failCount;
    }

    public void setFailCount(int failCount) {
        this.failCount = failCount;
    }


    public TBImportHistoryService getImportHistoryService() {
        return importHistoryService;
    }

    public void setImportHistoryService(TBImportHistoryService importHistoryService) {
        this.importHistoryService = importHistoryService;
    }

    public Map<String, Map<String, Object>> getPointListMap() {
        return pointListMap;
    }

    public void setPointListMap(Map<String, Map<String, Object>> pointListMap) {
        this.pointListMap = pointListMap;
    }

    public Map<String, Map<String, Object>> getRegListMap() {
        return regListMap;
    }

    public void setRegListMap(Map<String, Map<String, Object>> regListMap) {
        this.regListMap = regListMap;
    }

    public Map<String, Map<String, Object>> getBusListMap() {
        return busListMap;
    }

    public void setBusListMap(Map<String, Map<String, Object>> busListMap) {
        this.busListMap = busListMap;
    }

    public Map<String, Map<String, Object>> getFoodListMap() {
        return foodListMap;
    }

    public void setFoodListMap(Map<String, Map<String, Object>> foodListMap) {
        this.foodListMap = foodListMap;
    }

    public Map<String, Map<String, Object>> getItemListMap() {
        return itemListMap;
    }

    public void setItemListMap(Map<String, Map<String, Object>> itemListMap) {
        this.itemListMap = itemListMap;
    }

    public DataCheckRecordingService getDataCheckRecordingService() {
        return dataCheckRecordingService;
    }

    public void setDataCheckRecordingService(DataCheckRecordingService dataCheckRecordingService) {
        this.dataCheckRecordingService = dataCheckRecordingService;
    }

    private void addToProblems(List<ImportDataCheckRecording> problems, ImportDataCheckModel data, String errMsg) {
        ImportDataCheckRecording r = new ImportDataCheckRecording();
        r.setPointName(data.getPointName());
        r.setRegName(data.getRegName());
        r.setRegUserName(data.getRegUserName());
        r.setFoodName(data.getFoodName());
        r.setCkItem(data.getCkItem());
        r.setCkResult(data.getCkResult());
        r.setLiValue(data.getLiValue());
        r.setConclusion(data.getConclusion());
        r.setCkUser(data.getCkUser());
        r.setCkDate(data.getCkDate());
        r.setAuditor(data.getAuditor());
        r.setUpUser(data.getUpUser());
        r.setDeviceName(data.getDeviceName());
        r.setModul(data.getModul());
        r.setMethod(data.getMethod());
        r.setDeviceComp(data.getDeviceComp());
        r.setRemark(data.getRemark());
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
        //样品名称(必填)
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
