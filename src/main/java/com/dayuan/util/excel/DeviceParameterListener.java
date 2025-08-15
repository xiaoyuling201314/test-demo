package com.dayuan.util.excel;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.excel.write.style.column.LongestMatchColumnWidthStyleStrategy;
import com.alibaba.fastjson.JSON;
import com.dayuan.bean.data.BaseDeviceParameter;
import com.dayuan.bean.data.BaseDevicesItem;
import com.dayuan.bean.data.TBImportHistory;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.model.data.DeviceParameterExportModel;
import com.dayuan.model.data.DeviceParameterFaildModel;
import com.dayuan.service.data.BaseDeviceParameterService;
import com.dayuan.service.data.BaseDeviceService;
import com.dayuan.service.data.BaseDevicesItemService;
import com.dayuan.service.data.TBImportHistoryService;
import com.dayuan.util.StringUtil;
import com.dayuan.util.UUIDGenerator;
import cn.hutool.core.util.IdUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
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
public class DeviceParameterListener extends AnalysisEventListener<DeviceParameterFaildModel> {
    private static final Logger log = LoggerFactory.getLogger(DeviceParameterListener.class);
    private static final int BATCH_COUNT = 100;// 每隔N条存储数据库，实际使用中可以3000条，然后清理list ，方便内存回收
    //暂时存储检测项目集合
    List<BaseDeviceParameter> list = new ArrayList<BaseDeviceParameter>();
    //验证不通过的检测数据对象集合：使用DeviceParameterFaildModel子类，增加“导入失败原因”列
    List<DeviceParameterFaildModel> problems = new ArrayList<DeviceParameterFaildModel>();
    int headerNumber = 0;
    String description="";//第一行描述信息
    private Integer importHistoryId;//导入记录ID
    private String fName;//原文件名
    private String rootPath;//文件存储根路径
    private  String deviceTypeId;//仪器类型ID
    private int successCount = 0;
    private int failCount = 0;
    private Boolean rightTemplate = true;//导入模板是否正确
    private TBImportHistoryService importHistoryService;
    private BaseDeviceParameterService baseDeviceParameterService;
    private BaseDeviceService baseDeviceService;
    private BaseDevicesItemService baseDevicesItemService;
    //查询所有检测项目
    private Map<String, Map<String, Object>> itemListMap;
    public DeviceParameterListener() {

    }
    public DeviceParameterListener(TBImportHistoryService importHistoryService, BaseDeviceParameterService baseDeviceParameterService,
                             BaseDeviceService baseDeviceService,BaseDevicesItemService baseDevicesItemService,
                                   String deviceTypeId,Integer importHistoryId, String fName, String rootPath,Map<String, Map<String, Object>> itemListMap) {
        this.importHistoryService = importHistoryService;
        this.baseDeviceParameterService = baseDeviceParameterService;
        this.baseDeviceService=baseDeviceService;
        this.baseDevicesItemService=baseDevicesItemService;
        this.importHistoryId = importHistoryId;
        this.deviceTypeId=deviceTypeId;
        this.fName = fName;
        this.rootPath = rootPath;
        this.itemListMap = itemListMap;
    }

    @Override
    public void invoke(DeviceParameterFaildModel data, AnalysisContext context) {
        try {
            if (rightTemplate) {//导入模板正确，进行下一步处理
                if (StringUtil.isEmpty(data.getItemName())) {
                    data.setErrMsg("[检测项目]不能为空");
                    problems.add(data);
                    failCount++;
                    return;
                } else if (StringUtil.isNotEmpty(data.getItemName()) && data.getItemName().length() > 50) {
                    data.setErrMsg("[检测项目]超出长度，最大长度为50");
                    problems.add(data);
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getProjectType())) {
                    data.setErrMsg("[检测模块]不能为空");
                    problems.add(data);
                    failCount++;
                    return;
                }
                if (StringUtil.isEmpty(data.getDetectMethod())) {
                    data.setErrMsg("[检测方法]不能为空");
                    problems.add(data);
                    failCount++;
                    return;
                }
                Map<String, Object> iMap = itemListMap.get(data.getItemName());
                if (null == iMap) {
                    data.setErrMsg("["+data.getItemName()+"]检测项目不存在");
                    problems.add(data);
                    failCount++;
                    return;
                }
                BaseDeviceParameter model = new BaseDeviceParameter();
                model.setItemId(iMap.get("id").toString());
                model.setProjectType(data.getProjectType());
                model.setDetectMethod(data.getDetectMethod());
                model.setDeviceTypeId(deviceTypeId);
                model.setReserved3(data.getReserved3());
                //根据检测项目、检测模块、检测方法组合校验是否已配置该检测项目
                BaseDeviceParameter baseBean = baseDeviceParameterService.queryByUniqueDeviceItem(model);
               if(baseBean!=null){
                   data.setErrMsg("["+data.getItemName()+"]检测项目已配置，请勿重复配置");
                   problems.add(data);
                   failCount++;
                   return;
               }
                baseBean = new BaseDeviceParameter(IdUtil.fastSimpleUUID(), deviceTypeId, iMap.get("id").toString(), data.getProjectType(), data.getDetectMethod(), data.getDetectUnit(), null, null,
                        data.getInvalidValue(), null, null, data.getWavelength(), data.getPreTime(), data.getDecTime(),
                        data.getStda(), data.getStda0(), data.getStda1(), data.getStda2(), data.getStda3(),
                        data.getStdb(), data.getStdb0(), data.getStdb1(), data.getStdb2(), data.getStdb3(),
                        data.getNationalStdmin(), data.getNationalStdmax(), data.getYinMin(), data.getYinMax(), data.getYangMin(), data.getYangMax(),
                        data.getYint(), data.getYangt(), data.getAbsx(), data.getCtabsx().intValue(), data.getDivision(),
                        data.getParameter().intValue(), data.getTrailingedgec(), data.getTrailingedget(), data.getSuspiciousmin(), data.getSuspiciousmax(),
                        data.getReserved1(), data.getReserved2(), data.getReserved3(), null, null,
                        null, 0, null, null, null, null, null, null);
                list.add(baseBean);
                successCount++;
                if (list.size() >= BATCH_COUNT) {
                    saveData(null);
                    list.clear();
                }
            }
        } catch (Exception e) {
            log.error("******************************检测项目导入异常" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
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
        log.info("所有数据解析完成！");
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
                if (!"检测项目".equals(headMap.get(1).trim()) || !"检测模块".equals(headMap.get(2).trim()) || !"检测方法".equals(headMap.get(3).trim())
                        || !"检测无效值".equals(headMap.get(4).trim()) || !"阴性T".equals(headMap.get(5).trim()) || !"阳性T".equals(headMap.get(6).trim())
                        || !"预留字段1".equals(headMap.get(7).trim()) || !"预留字段2".equals(headMap.get(8).trim()) || !"预留字段3".equals(headMap.get(9).trim())) {
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
        log.info("解析到一条头数据:{}", JSON.toJSONString(headMap));

    }

    /**
     * 加上存储数据库
     */
    private void saveData(TBImportHistory importHistory) throws Exception {
        try {
            if (list.size() > 0) {
                //使用统一新增检测数据方法，判断数据有效性  --Dz 20220622
                TSUser user = PublicUtil.getSessionUser();
                for (BaseDeviceParameter baseBean : list) {
                    baseBean.setId(UUIDGenerator.generate());
                    PublicUtil.setCommonForTable(baseBean, true);
                    baseDeviceParameterService.save(baseBean);
                    //同步仪器检测项目:1.查询所有已注册好的仪器，遍历增加对应的检测项目
                    List<String> deviceList = baseDeviceService.queryByDeviceType(baseBean.getDeviceTypeId());
                    BaseDevicesItem bdi = null;
                    for (String deviceId : deviceList) {
                        bdi = new BaseDevicesItem();
                        bdi.setId(UUIDGenerator.generate());
                        bdi.setDeviceId(deviceId);
                        bdi.setDeviceParameterId(baseBean.getId());
                        bdi.setPriority((short) 0);
                        bdi.setChecked((short) 1);
                        PublicUtil.setCommonForTable(bdi, true);
                        baseDevicesItemService.insert(bdi);
                    }
                }

                log.info("存储数据库成功！");
            }
            if (null != importHistory) {
                String errFile = null;
                if (problems.size() > 0) {
                    errFile = fName.substring(0, fName.lastIndexOf(".")) + "_err.xlsx";
                    String outPath = rootPath + File.separator + errFile;
                    EasyExcel.write(new FileOutputStream(outPath), DeviceParameterFaildModel.class)
                            .sheet()
                            .registerWriteHandler(new LongestMatchColumnWidthStyleStrategy())// 设置单元格宽度自适应
                            .registerWriteHandler(ExcelUtil.getHeightAndFontStrategy()) // 设置单元格高度和字体
                            .doWrite(problems);
                }
                importHistory = importHistoryService.queryById(importHistoryId);
                importHistory.setSuccessCount(successCount);
                importHistory.setFailCount(failCount);
                importHistory.setEndDate(new Date());
                importHistory.setErrFile(errFile == null ? null : "/deviceParameter/" + errFile);
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
}
