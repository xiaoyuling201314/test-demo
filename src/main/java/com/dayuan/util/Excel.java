package com.dayuan.util;

import com.dayuan.bean.dataCheck.DataCheckRecording;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.*;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.*;

import java.io.*;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 描述:生成Excel文件和下载
 *
 * @author LuoYX
 */
@SuppressWarnings("deprecation")
public class Excel {

    private final static Logger logger = Logger.getLogger(Excel.class);


    /**
     * 导出检测数据列名
     */
    public static final String[] DATACHECKRECORDING_HEADERS = {
            /*"编号",*/
            "检测机构", "检测点名称", "被检单位", "档口编号", "样品种类", "样品名称", "检测项目",
            "限定值", "检测值", "检测结论", "检测人员",
            "检测时间", "检测标准",
    };
    /**
     * 导出检测数据属性名
     */
    public static final String[] DATACHECKRECORDING_FIELDS = {
            /*"checkCode",*/
            "departName", "pointName", "regName", "regUserName", "foodTypeName", "foodName", "itemName",
            "limitValue", "checkResult", "conclusion", "checkUsername",
            "checkDate", "checkAccord",
    };

    public static final String[] DATACHECKRECORDINGS_HEADERS = {
            /*"编号",*/
            "检测机构", "检测点名称", "送检人", "样品种类", "样品名称", "检测项目",
            "限定值", "检测值", "检测结论", "检测人员",
            "检测时间", "检测标准",

    };

    public static final String[] DATACHECKRECORDINGS_FIELDS = {
            /*"checkCode",*/
            "departName", "pointName", "regName", "foodTypeName", "foodName", "itemName",
            "limitValue", "checkResult", "conclusion", "checkUsername",
            "checkDate", "checkAccord",
    };

    public static final String[] COST_HEADERS = {
            "编号", "发生日期", "资金类型", "费用类型名称", "科目名称", "入账", "支出", "余额", "明细",
            "经手人", "备注", "无发票原因", "审核意见", "审核备注", "审核时间", "审批意见", "审批备注", "审批时间",
    };

    public static final String[] COST_FIELDS = {
            "number", "happenDate", "flag", "ptypeName", "typeName", "income", "cost", "balance", "detail",
            "realname", "noReason", "remark", "checked", "examine", "updateDate", "reimState", "reimRemark", "reimDate",
    };

    public static final String[] COSTS_HEADERS = {
            "项目名称", "总支出", "非现金流", "现金流", "借资", "余额", "负责人", "状态",

    };

    public static final String[] COSTS_FIELDS = {
            "projectName", "ccsum", "nosum", "cashsum", "insum", "bbsum", "realname", "state",

    };

    public static final String[] FINANCE_HEADERS = {
            "项目名称", "状态", "项目预算", "开销总额", "仪器费用", "辅助设备", "检测箱", "试剂耗材",
            "人员工资", "税费", "支出流水", "总借款", "余额",

    };

    public static final String[] FINANCE_FIELDS = {
            "projectName", "state", "bmoney", "fcost", "device", "auxiliary", "box", "reagent",
            "sum", "taxation", "cashsum", "insum", "bbsum",

    };

    public static final String[] CWAGES_HEADERS = {
            "项目名称", "工资(元)", "社保(元)", "公积金(元)", "绩效奖金(元)", "其他(元)", "总计(元)", "状态",

    };

    public static final String[] CWAGES_FIELDS = {
            "projectName", "wsum", "csum", "bsum", "dsum", "osum", "sum", "state",

    };

    public static final String[] CWAGES_MONTH_HEADERS = {
            "月份", "工资(元)", "社保(元)", "公积金(元)", "绩效奖金(元)", "其他(元)", "小计(元)", "备注", "状态",

    };

    public static final String[] CWAGES_MONTH_FIELDS = {
            "month", "wages", "commission", "bonus", "debit", "other", "xsum", "remark", "checked",

    };

    public static final String[] DEPART_MONTH_HEADERS = {
            "机构名称", "上级机构", "地址", "描述",

    };

    public static final String[] DEPART_MONTH_FIELDS = {
            "departName", "departPname", "address", "description",

    };

    public static final String[] WORKE_HEADERS = {
            "人员名称", "性别", "手机号码", "职位", "人员状态", "状态",

    };

    public static final String[] WORKE_FIELDS = {
            "workerName", "gender", "mobilePhone", "position", "jobState", "status",

    };

    public static final String[] BUSINESS_HEADERS = {
            "机构名称", "监管对象名称", "档口编号", "经营户名称", "经营者", "经营户身份证", "统一社会信用代码", "联系人",
            "联系方式", "信用等级", "监控级别", "经营范围", "状态"
    };

    public static final String[] BUSINESS_FIELDS = {
            "departName", "regName", "opeShopCode", "opeShopName", "opeName", "opeIdcard", "creditCode", "contacts",
            "opePhone", "creditRating", "monitoringLevel", "businessCope", "checked"
    };

    public static final String[] OBJECT_HEADERS = {
            "机构名称", "企业名称", "监管对象名称", "监管对象地址", "监管对象类型", "市场类型", "联系人名称", "联系方式", "法人代表",
            "身份证", "统一社会信用代码", "经营范围", "状态"
    };

    public static final String[] OBJECT_FIELDS = {
            "departName", "companyName", "regName", "regAddress", "regType", "managementType", "linkUser", "linkPhone", "legalPerson",
            "linkIdcard", "creditCode", "businessCope", "checked"
    };

    public static final String[] PROJECT_HEADERS = {
            "项目名称", "开始日期", "预计结束", "项目批次", "检测点", "负责人", "人数", "项目金额", "预算", "状态"
    };

    public static final String[] PROJECT_FIELDS = {
            "projectName", "startDate", "endDate", "taskNumber", "pointnum", "realname", "workernum", "money", "bmoney", "state"
    };

    public static final String[] PROJECT2_HEADERS = {
            "项目名称", "开始日期", "预计结束", "项目批次", "检测点", "负责人", "人数", "预算", "状态"
    };

    public static final String[] PROJECT2_FIELDS = {
            "projectName", "startDate", "endDate", "taskNumber", "pointnum", "realname", "workernum", "bmoney", "state"
    };

    public static final String[] PROGRESS_HEADERS = {
            "项目名称", "开始日期", "预计结束", "时间进度", "项目批次", "完成批次", "任务进度", "项目预算", "实际开销", "开销进度", "状态", "实际结束"
    };

    public static final String[] PROGRESS_FIELDS = {
            "projectName", "startDate", "endDate", "timeProgress", "taskNumber", "checkCompleteCount", "planProgress", "budget",
            "overhead", "overheadProgress", "state", "actualDate"
    };
    //考勤管理导出
    public static final String[] p_attendances_HEADERS = {
            "人员名称", "月份", "应出勤", "实际出勤", "在岗(天)", "外勤(天)", "迟到(次)", "请假(小时)", "休假(小时)", "加班(小时)", "缺勤",

    };
    public static final String[] p_attendances_FIELDS = {
            "userName", "month", "dutyWorkday", "actualAttendance", "punchCardDay", "sginDay", "lateNumber", "leaveTime", "offTime", "overTime", "absenceDuty"
    };
    //微信用户导出
    public static final String[] wx_user_HEADERS = {
            "微信账号", "姓名", "管理/签到人员", "绑定平台用户", "是否绑定微信", "状态"

    };
    public static final String[] wx_user_FIELDS = {
            "userName", "nickName", "param1", "realname", "openid", "param2"
    };
    //单个用户打卡导出
    public static final String[] p_attendances_card_HEADERS = {
            "人员名称", "打卡时间", "打卡地点"

    };
    public static final String[] p_attendances_card_FIELDS = {
            "userName", "brusHCardTime", "place"
    };
    //单个用户签到记录
    public static final String[] p_WxsignIn_HEADERS = {
            "人员名称", "签到时间", "签到地点"

    };
    public static final String[] p_WxsignIn_FIELDS = {
            "param1", "createDate", "address"
    };

    //单个用户请假
    public static final String[] p_attendances_leave_HEADERS = {
            "人员名称", "录入时间", "录入人", "请假类型", "开始时间", "结束时间", "时长", "请假原因"

    };
    public static final String[] p_attendances_leave_FIELDS = {
            "userName", "createDate", "createBy", "vacation", "startTime", "endTime", "lengthTime", "remark"
    };
    //单个用户休假/加班
    public static final String[] p_attendances_vacation_HEADERS = {
            "人员名称", "录入时间", "录入人", "开始时间", "结束时间", "时长", "请假原因"

    };
    public static final String[] p_attendances_vacation_FIELDS = {
            "userName", "createDate", "createBy", "startTime", "endTime", "lengthTime", "remark"
    };
    //市场报表导出
    public static final String[] OBJ_REPORT_HEADERS = {
            "市场名称", "快检批次", "不合格批次", "合格率", "处理数量"

    };
    public static final String[] OBJ_REPORT_FIELDS = {
            "regName", "checkCount", "unCount", "rate", "destroyCount"
    };

    //食品分类导出
    public static final String[] FOOD_HEADERS = {
            "fid", "food_name", "food_name_en", "food_name_other", "parent_id", "cimonitor_level", "sorting", "checked", "delete_flag", "create_by", "create_date", "update_by", "update_date", "isFood"
    };
    public static final String[] FOOD_REPORT_HEADERS = {
            "fid", "food_name", "food_name_en", "food_name_other", "parent_id", "cimonitor", "sorting", "checked2", "delete_flag", "create_by", "create_date", "update_by", "update_date", "isFood"
    };

    //检测项目
    public static final String[] DETECT_ITEM_HEADERS = {
            "cid", "detect_item_name", "detect_item_typeid", "standard_id", "detect_sign", "detect_value", "detect_value_unit",
            "checked", "cimonitor_level", "remark", "delete_flag", "create_by", "create_date", "update_by", "update_date",
            "t_id", "t_item_name", "t_sorting", "t_remark", "t_delete_flag", "t_create_by", "t_create_date", "t_update_by", "t_update_date"
    };
    public static final String[] DETECT_ITEM_REPORT_HEADERS = {
            "cid", "detect_item_name", "detect_item_typeid", "standard_id", "detect_sign", "detect_value", "detect_value_unit",
            "checked2", "cimonitor_level", "remark", "delete_flag", "create_by", "create_date", "update_by", "update_date",
            "t_id", "t_item_name", "t_sorting", "t_remark", "t_delete_flag", "t_create_by", "t_create_date", "t_update_by", "t_update_date"
    };
    //检测项目和食品类别中间表
    public static final String[] FOOD_ITEM_HEADERS = {
            "sid", "food_id", "food_id1", "item_id", "detect_sign", "detect_value", "detect_value_unit",
            "remark", "use_default", "checked", "delete_flag", "create_by", "create_date", "update_by", "update_date"
    };
    public static final String[] FOOD_ITEM_REPORT_HEADERS = {
            "sid", "food_id", "food_id1", "item_id", "detect_sign", "detect_value", "detect_value_unit",
            "remark", "use_default", "checked2", "delete_flag", "create_by", "create_date", "update_by", "update_date"
    };

    //仪器检测项目
    public static final String[] MACHINE_ITEM_HEADERS = {
            "mid", "device_type_id", "item_id", "project_type", "detect_method", "detect_unit", "operation_password",
            "food_code", "invalid_value", "check_hole1", "check_hole2", "wavelength", "pre_time", "dec_time", "stdA0",
            "stdA1", "stdA2", "stdA3", "stdB0", "stdB1", "stdB2", "stdB3", "stdA", "stdB", "national_stdmin", "national_stdmax",
            "yin_min", "yin_max", "yang_min", "yang_max", "yinT", "yangT", "absX", "ctAbsX", "division", "parameter", "trailingEdgeC",
            "trailingEdgeT", "suspiciousMin", "suspiciousMax", "reserved1", "reserved2", "reserved3", "reserved4", "reserved5", "remark",
            "delete_flag", "create_by", "create_date", "update_by", "update_date"
    };
    public static final String[] MACHINE_ITEM_REPORT_HEADERS = {
            "mid", "device_type_id", "item_id", "project_type", "detect_method", "detect_unit", "operation_password",
            "food_code", "invalid_value", "check_hole1", "check_hole2", "wavelength", "pre_time", "dec_time", "stdA0",
            "stdA1", "stdA2", "stdA3", "stdB0", "stdB1", "stdB2", "stdB3", "stdA", "stdB", "national_stdmin", "national_stdmax",
            "yin_min", "yin_max", "yang_min", "yang_max", "yinT", "yangT", "absX", "ctAbsX", "division", "parameter", "trailingEdgeC",
            "trailingEdgeT", "suspiciousMin", "suspiciousMax", "reserved1", "reserved2", "reserved3", "reserved4", "reserved5",
            "remark", "delete_flag", "create_by", "create_date", "update_by", "update_date"
    };
    //购样管理汇总
    public static final String[] SCOSTS_MANAGER_HEADERS = {
            "项目名称", "购样预算(元)", "实际费用（元）", "费用进度", "项目批次", "完成批次", "完成进度", "抽样人数",

    };

    public static final String[] SCOSTS_MANAGER_FIELDS = {
            "projectName", "budget", "cost", "costProcess", "taskNumber", "finishNumber", "taskProcess", "samplerNumber",

    };


    public static final String[] INSPECTION_UNIT_HEADERS1 = {
            "单位类型", "单位名称", "注册号", "社会信用代码", "法定代表人", "法人联系方式", "送检用户",
            "联系人", "手机号码", "审核状态", "营业状态","是否供应商","成立日期", "登记机关", "详细地址", "备注信息"
    };

    public static final String[] INSPECTION_UNIT_FIELDS1 = {
            "companyType", "companyName", "regNumber", "creditCode", "legalPerson", "legalPhone", "userNumber",
            "linkUser", "linkPhone", "checked", "state","supplier", "setupDate", "regAuthority", "companyAddress", "remark"
    };
    public static final String[] INSPECTION_UNIT_HEADERS2 = {
            "单位类型", "姓名", "身份证号码", "手机号码", "送检用户", "审核状态", "备注信息"
    };

    public static final String[] INSPECTION_UNIT_FIELDS2 = {
            "companyType", "companyName", "creditCode", "linkPhone", "userNumber", "checked", "remark"
    };

    public static final String[] INSPECTION_UNIT_HEADERS3 = {
            "冷链单位ID","类型", "名称", "仓库编号","社会信用代码/身份证", "法定代表人", "法人联系方式",
            "联系人", "联系方式", "审核状态",  "详细地址", "备注信息"
    };

    public static final String[] INSPECTION_UNIT_FIELDS3 = {
            "coldUnitId","companyType", "companyName","companyCode" ,"creditCode", "legalPerson", "legalPhone",
            "linkUser", "linkPhone", "checked","companyAddress", "remark"
    };

    // 数据分析：食品安全预警导出
/*	public static final String [] WARNHEADERS= {"样品名称","抽样总数","平均合格率"};
    public static final String [] WARNFIELDS = {"foodName","ckCount","rate"};

	// 数据分析：食品安全追溯导出
	public static final String [] TRACEHEADERS = {"样品名称","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] TRACEFIELDS = {"foodName","ckCount","qualifiedTotal","unqualifiedTotal","rate","unqualifiedRate"};
	
	//监管对象- 快检结果信息 导出
	public static final String [] DETECT_RESULT_HEADERS = {"样品名称","检测项目","受检人/单位","标准值","检测值"};
	public static final String [] DETECT_RESULT_FIELDS = {"foodName","checkItemName","ckcName","limitValue","checkResult"};

	//检测数据- 月报表信息 导出
	public static final String [] DETECT_MonReport_HEADERS = {"月份","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_MonReport_FIELDS = {"month","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 快检车报表信息 导出
	public static final String [] DETECT_CarReport_HEADERS = {"快检车","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_CarReport_FIELDS = {"carName","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 季度报表信息 导出
	public static final String [] DETECT_SeaReport_HEADERS = {"季度","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_SeaReport_FIELDS = {"quarter","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 报表信息 导出
	public static final String [] DETECT_YearReport_HEADERS = {"年份","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_YearReport_FIELDS = {"year","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 检测单位报表信息 导出
	public static final String [] DETECT_ckcNameReport_HEADERS = {"被检单位","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_ckcNameReport_FIELDS = {"ckcName","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 辖区报表信息 导出
	public static final String [] DETECT_ckcCodeReport_HEADERS = {"辖区","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_ckcCodeReport_FIELDS = {"ckcCode","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 检测项目报表信息 导出
	public static final String [] DETECT_checkItemNamerReport_HEADERS = {"检测项目","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_checkItemNameReport_FIELDS = {"checkItemName","allCount","rsum","fsum","rcount","fcount"};
	//检测数据- 食品种类报表信息 导出
	public static final String [] DETECT_foodTypeReport_HEADERS = {"食品种类","总数","合格数","不合格数","合格率","不合格率"};
	public static final String [] DETECT_foodTypeReport_FIELDS = {"foodType","allCount","rsum","fsum","rcount","fcount"};
	
	public static final String [] OPTLOG_HEADER = {"操作人","操作结果","操作内容","操作类型","请求方式","请求IP","操作时间","异常信息"};
	public static final String [] OPTLOG_FIELDS = {"userName","type","module","func","method","remoteIP","operateTime","exception"};*/


    private static Method[] methods = null;

    /**
     * 生成Excel文件
     *
     * @param totalDate            --统计日期(为null时不输出)
     * @param tableTitle           --表格标题(为null时不输出)
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param totalFieldNameArray  --需要合计的实体字段名数组(为null时不输出)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputExcelFile(SXSSFWorkbook workbook, final String[] titleArray,
                                          final String[] entityFieldNameArray, final List list, final String outputFilePath, final String exportType,String tableTitle) {

        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        boolean mark = true;
        int rowIndex = 0; // 行索引
        int cellIndex = 0; // 列索引
        try {
            Sheet sheet = workbook.createSheet();
            Row row = null;
            Cell cell = null;
            CellStyle style = null;
            // 输出表格抬头
            //cellIndex = 0;
            short rowHeight=600;//标题的行高
            if(tableTitle != null && !"".equals(tableTitle)) {
                row = sheet.createRow(rowIndex);
                row.setHeight(rowHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                Font font = workbook.createFont();
                font.setBold(true);
                style=getColumnTopStyle(workbook,(short)20,true,false);
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue(tableTitle);   //输出表格标题
                rowIndex++;
            }


            if (exportType.equals("1")) {//导出检测数据，设置列宽
                sheet.setDefaultColumnWidth(20);
                sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(7, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(8, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(9, (int) ((10 + 0.72) * 256));
//				sheet.setColumnWidth(0, (int)((50 + 0.72) * 256));
//				sheet.setColumnWidth(7, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(8, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(11, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(12, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(13, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(14, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(16, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(17, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(18, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(20, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(21, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(22, (int)((10 + 0.72) * 256));
            }
            row = sheet.createRow(rowIndex);

//			cell = row.createCell(0);
//			cell.setCellType(CellType.STRING);
            Font font = workbook.createFont();
//            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            font.setBold(true);
            style = workbook.createCellStyle();
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
            style.setBorderTop(BorderStyle.THIN);
//			cell.setCellStyle(style);
//			cell.setCellValue("序号");

            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style = workbook.createCellStyle();
                style.setFont(font);
                style.setBorderBottom(BorderStyle.THIN);
                style.setBorderLeft(BorderStyle.THIN);
                style.setBorderRight(BorderStyle.THIN);
                style.setBorderTop(BorderStyle.THIN);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }
            if (list != null && list.size() > 0) {
                // 输出列表数据
                CellStyle style1 = workbook.createCellStyle();
                style1.setBorderBottom(BorderStyle.THIN);
                style1.setBorderLeft(BorderStyle.THIN);
                style1.setBorderRight(BorderStyle.THIN);
                style1.setBorderTop(BorderStyle.THIN);


                style1.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                style1.setWrapText(true);
                style1.setVerticalAlignment(VerticalAlignment.TOP);
                for (Object entity : list) {
                    /*rowIndex++;
                    row = sheet.createRow(rowIndex);
					cellIndex = 1;
					methods = entity.getClass().getDeclaredMethods();*/

                    rowIndex++;
                    cellIndex = 0;

                    row = sheet.createRow(rowIndex);
                    cell = row.createCell(cellIndex);
                    cell.setCellValue(rowIndex);

                    methods = entity.getClass().getDeclaredMethods();

                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);

                        cell.setCellStyle(style1);

                        if (value instanceof Date) {
                            String date = value == null ? "" : sdf.format((Date) value);
                            cell.setCellValue(date);
                        } else if (entityFieldName.equals("isSendCheck")) {
                            cell.setCellValue((((short) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("ckSystemIsReupload")) {
                            cell.setCellValue((((Integer) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("rate") || entityFieldName.equals("unqualifiedRate")) {
                            cell.setCellValue((String) value + "%");
                        } else if (entityFieldName.equals("dataSource")) {
                            if (((Short) value) == null || ((short) value) == 0) cell.setCellValue("工作站");
                            else if (((Short) value) == 1) cell.setCellValue("监管通APP");
                            else if (((Short) value) == 2) cell.setCellValue("仪器上传");
                            else if (((Short) value) == 3) cell.setCellValue("平台上传");
                            else if (((Short) value) == 4) cell.setCellValue("导入");
                        } else if (entityFieldName.equals("isReUpload")) {
                            cell.setCellValue(((((Short) value) == null || ((Short) value) == 0) ? "未重传" : "重传"));
                        } else if (entityFieldName.equals("dealType")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("未处理");
                            else if (((Short) value) == 1) cell.setCellValue("后处理");
                            else if (((Short) value) == 2) cell.setCellValue("复检");
                        } else if (entityFieldName.equals("cdId")) {
                            Object value1 = null;
                            if (StringUtil.isEmpty((String) value)) {
                                Method method1 = getMethodByFieldName("ckcName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            } else {
                                Method method1 = getMethodByFieldName("cdName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            }
                            cell.setCellValue((String) value1);
                        } else if (entityFieldName.equals("gender")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("男");
                            else if (((Short) value) == 1) cell.setCellValue("女");
                        } else if (entityFieldName.equals("status")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("在职");
                            else if (((Short) value) == 1) cell.setCellValue("离职");
                        } else if (entityFieldName.equals("creditRating") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("A");
                            else if (((Short) value) == 2) cell.setCellValue("B");
                            else if (((Short) value) == 3) cell.setCellValue("C");
                            else if (((Short) value) == 4) cell.setCellValue("D");
                        } else if (entityFieldName.equals("monitoringLevel") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("安全");
                            else if (((Short) value) == 2) cell.setCellValue("轻微");
                            else if (((Short) value) == 3) cell.setCellValue("警惕");
                            else if (((Short) value) == 4) cell.setCellValue("严重");
                        } else if (entityFieldName.equals("checked")) {
                            if (((Short) value) == 0) cell.setCellValue("未审核");
                            else if (((Short) value) == 1) cell.setCellValue("已审核");
                        } else if (entityFieldName.equals("regType")) {
                            if (value.equals("2c922b9a622c772401622ca07bfd00a8")) cell.setCellValue("药店");
                            else if (value.equals("2c922b9a622c772401622ca2bb6800ba")) cell.setCellValue("超市");
                            else if (value.equals("2c922b9a622c772401622ca2f72d00bd")) cell.setCellValue("其他");
                            else if (value.equals("4028935f5e7e898a015e7e898adb0000")) cell.setCellValue("生产单位");
                            else if (value.equals("4028935f5e7e898a015e7e89a9490001")) cell.setCellValue("经营单位");
                            else if (value.equals("4028935f5e7edbe2015e7eeca4b60009")) cell.setCellValue("餐饮单位");
                        } else if (entityFieldName.equals("managementType") && value != null) {
                            if (value.equals("0")) cell.setCellValue("批发市场");
                            else if (value.equals("1")) cell.setCellValue("农贸市场");
                        }else if (entityFieldName.equals("param6") && value!=null) {//检测数据有效性字段
                            Integer param6=(Integer)value;
                           if(param6!=0){//无效数据：设置字体颜色和边框样式
                               CellStyle style2 = workbook.createCellStyle();
                               style2.setBorderBottom(BorderStyle.THIN);
                               style2.setBorderLeft(BorderStyle.THIN);
                               style2.setBorderRight(BorderStyle.THIN);
                               style2.setBorderTop(BorderStyle.THIN);
                               style2.setWrapText(true);
                               style2.setVerticalAlignment(VerticalAlignment.TOP);
                               Font font2 = workbook.createFont();
                               font2.setColor((short) 10);//设置颜色为红色
                               style2.setFont(font2);
                               cell.setCellStyle(style2);
                           }//设置颜色为红色
                            switch (param6){
                                case 0:
                                    cell.setCellValue("有效");
                                break;
                                case 1:
                                    cell.setCellValue("无效(上传超时)");
                                    break;
                                case 2:
                                    cell.setCellValue("无效(无附件)");
                                    break;
                                case 3:
                                    cell.setCellValue("无效(超时且无附件)");
                                    break;
                                case 4:
                                    cell.setCellValue("无效(人工审核无效数据)");
                                    break;
                                case 5:
                                    cell.setCellValue("其他");
                                    break;
                                case 9:
                                    cell.setCellValue("无效(造假数据)");
                                    break;
                                default:
                                    cell.setCellValue("其他");
                                    break;
                            }
                        } else if (entityFieldName.equals("errMsg") && value != null) {
                            CellStyle style2 = workbook.createCellStyle();
                            style2.setBorderBottom(BorderStyle.THIN);
                            style2.setBorderLeft(BorderStyle.THIN);
                            style2.setBorderRight(BorderStyle.THIN);
                            style2.setBorderTop(BorderStyle.THIN);
                            style2.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                            style2.setWrapText(true);
                            style2.setVerticalAlignment(VerticalAlignment.TOP);
                            Font font2 = workbook.createFont();
                            font2.setColor((short) 10);//设置颜色为红色
                            style2.setFont(font2);
                            cell.setCellStyle(style2);
                            cell.setCellValue((value != null ? value.toString() : ""));
                        } else {
                            cell.setCellValue((value != null ? value.toString() : ""));
                        }
                        cellIndex++;
                    }
                }
            }
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }

    /**
     * 生成多表Excel文件
     *
     * @param totalDate            --统计日期(为null时不输出)
     * @param tableTitle           --表格标题(为null时不输出)
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param totalFieldNameArray  --需要合计的实体字段名数组(为null时不输出)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputExcelFiles(SXSSFWorkbook workbook, final String[] titleArray,
                                           final String[] entityFieldNameArray, final List list, final String outputFilePath, final String exportType, Sheet sheet) {

        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        boolean mark = true;
        int rowIndex = 1; // 行索引
        int cellIndex = 0; // 列索引
        try {
            /*HSSFSheet sheet = workbook.createSheet();*/
            //开始处理数据
            //Sheet sheet=workbook.createSheet();

            Row row = null;
            Cell cell = null;
            CellStyle style = null;
            // 输出表格抬头
            //cellIndex = 0;
            if (exportType.equals("1")) {//导出检测数据，设置列宽
                sheet.setDefaultColumnWidth(20);
                sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(7, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(8, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(9, (int) ((10 + 0.72) * 256));
//				sheet.setColumnWidth(0, (int)((50 + 0.72) * 256));
//				sheet.setColumnWidth(7, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(8, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(11, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(12, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(13, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(14, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(16, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(17, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(18, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(20, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(21, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(22, (int)((10 + 0.72) * 256));
            }
            sheet.setDefaultColumnWidth(20);
            row = sheet.createRow(rowIndex);

//			cell = row.createCell(0);
//			cell.setCellType(CellType.STRING);
            Font font = workbook.createFont();
            font.setBold(true);
            style = workbook.createCellStyle();
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
            style.setBorderTop(BorderStyle.THIN);
//			cell.setCellStyle(style);
//			cell.setCellValue("序号");

            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style = workbook.createCellStyle();
                style.setFont(font);
                style.setBorderBottom(BorderStyle.THIN);
                style.setBorderLeft(BorderStyle.THIN);
                style.setBorderRight(BorderStyle.THIN);
                style.setBorderTop(BorderStyle.THIN);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }
            if (list != null && list.size() > 0) {
                // 输出列表数据
                CellStyle style1 = workbook.createCellStyle();
                style1.setBorderBottom(BorderStyle.THIN);
                style1.setBorderLeft(BorderStyle.THIN);
                style1.setBorderRight(BorderStyle.THIN);
                style1.setBorderTop(BorderStyle.THIN);


                style1.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                style1.setWrapText(true);
                style1.setVerticalAlignment(VerticalAlignment.TOP);
                for (Object entity : list) {
                    /*rowIndex++;
                    row = sheet.createRow(rowIndex);
					cellIndex = 1;
					methods = entity.getClass().getDeclaredMethods();*/

                    rowIndex++;
                    cellIndex = 0;

                    row = sheet.createRow(rowIndex);
                    cell = row.createCell(cellIndex);
                    cell.setCellValue(rowIndex);

                    methods = entity.getClass().getDeclaredMethods();

                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);

                        cell.setCellStyle(style1);

                        if (value instanceof Date) {
                            String date = value == null ? "" : sdf.format((Date) value);
                            cell.setCellValue(date);
                        } else if (entityFieldName.equals("isSendCheck")) {
                            cell.setCellValue((((short) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("ckSystemIsReupload")) {
                            cell.setCellValue((((Integer) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("rate") || entityFieldName.equals("unqualifiedRate")) {
                            cell.setCellValue((String) value + "%");
                        } else if (entityFieldName.equals("dataSource")) {
                            if (((Short) value) == null || ((short) value) == 0) cell.setCellValue("工作站");
                            else if (((Short) value) == 1) cell.setCellValue("监管通APP");
                            else if (((Short) value) == 2) cell.setCellValue("仪器上传");
                            else if (((Short) value) == 3) cell.setCellValue("平台上传");
                            else if (((Short) value) == 4) cell.setCellValue("导入");
                        } else if (entityFieldName.equals("isReUpload")) {
                            cell.setCellValue(((((Short) value) == null || ((Short) value) == 0) ? "未重传" : "重传"));
                        } else if (entityFieldName.equals("dealType")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("未处理");
                            else if (((Short) value) == 1) cell.setCellValue("后处理");
                            else if (((Short) value) == 2) cell.setCellValue("复检");
                        } else if (entityFieldName.equals("cdId")) {
                            Object value1 = null;
                            if (StringUtil.isEmpty((String) value)) {
                                Method method1 = getMethodByFieldName("ckcName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            } else {
                                Method method1 = getMethodByFieldName("cdName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            }
                            cell.setCellValue((String) value1);
                        } else if (entityFieldName.equals("gender")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("男");
                            else if (((Short) value) == 1) cell.setCellValue("女");
                        } else if (entityFieldName.equals("status")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("在职");
                            else if (((Short) value) == 1) cell.setCellValue("离职");
                        } else if (entityFieldName.equals("creditRating") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("A");
                            else if (((Short) value) == 2) cell.setCellValue("B");
                            else if (((Short) value) == 3) cell.setCellValue("C");
                            else if (((Short) value) == 4) cell.setCellValue("D");
                        } else if (entityFieldName.equals("monitoringLevel") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("安全");
                            else if (((Short) value) == 2) cell.setCellValue("轻微");
                            else if (((Short) value) == 3) cell.setCellValue("警惕");
                            else if (((Short) value) == 4) cell.setCellValue("严重");
                        } else if (entityFieldName.equals("checked")) {
                            if (((Short) value) == 0) cell.setCellValue("未审核");
                            else if (((Short) value) == 1) cell.setCellValue("已审核");
                        } else if (entityFieldName.equals("regType")) {
                            if (value.equals("2c922b9a622c772401622ca07bfd00a8")) cell.setCellValue("药店");
                            else if (value.equals("2c922b9a622c772401622ca2bb6800ba")) cell.setCellValue("超市");
                            else if (value.equals("2c922b9a622c772401622ca2f72d00bd")) cell.setCellValue("其他");
                            else if (value.equals("4028935f5e7e898a015e7e898adb0000")) cell.setCellValue("生产单位");
                            else if (value.equals("4028935f5e7e898a015e7e89a9490001")) cell.setCellValue("经营单位");
                            else if (value.equals("4028935f5e7edbe2015e7eeca4b60009")) cell.setCellValue("餐饮单位");
                        } else if (entityFieldName.equals("managementType") && value != null) {
                            if (value.equals("0")) cell.setCellValue("批发市场");
                            else if (value.equals("1")) cell.setCellValue("农贸市场");
                        } else {
                            cell.setCellValue((value != null ? value.toString() : ""));
                        }
                        cellIndex++;
                    }
                }
            }
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }

    /**
     * 生成Excel文件
     *
     * @param totalDate            --统计日期(为null时不输出)
     * @param tableTitle           --表格标题(为null时不输出)
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param totalFieldNameArray  --需要合计的实体字段名数组(为null时不输出)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputExcelFile(XSSFWorkbook workbook, final String[] titleArray,
                                          final String[] entityFieldNameArray, final List list, final String outputFilePath, String exportType) {

        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        boolean mark = true;
        int rowIndex = 0; // 行索引
        int cellIndex = 1; // 列索引
        try {
            XSSFSheet sheet = workbook.createSheet();
            XSSFRow row = null;
            XSSFCell cell = null;
            XSSFCellStyle style = null;
            // 输出表格抬头
//			cellIndex = 0;
            if (exportType.equals("1")) {//导出检测数据，设置列宽
                sheet.setDefaultColumnWidth(20);
                sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(7, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(8, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(9, (int) ((10 + 0.72) * 256));
            }
            row = sheet.createRow(rowIndex);
            cell = row.createCell(0);

            cell.setCellType(CellType.STRING);
            XSSFFont font = workbook.createFont();
//            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            font.setBold(true);
            style = workbook.createCellStyle();
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
            style.setBorderTop(BorderStyle.THIN);
            cell.setCellStyle(style);
            cell.setCellValue("序号");
            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }
            if (list != null && list.size() > 0) {
                // 输出列表数据
                XSSFCellStyle style1 = workbook.createCellStyle();
                style1.setBorderBottom(BorderStyle.THIN);
                style1.setBorderLeft(BorderStyle.THIN);
                style1.setBorderRight(BorderStyle.THIN);
                style1.setBorderTop(BorderStyle.THIN);

                style1.setWrapText(true);
                style1.setVerticalAlignment(VerticalAlignment.TOP);
                for (Object entity : list) {

                    rowIndex++;

                    row = sheet.createRow(rowIndex);
                    cell = row.createCell(0);
                    cell.setCellStyle(style1);
                    cell.setCellValue(rowIndex);

                    cellIndex = 1;
                    methods = entity.getClass().getDeclaredMethods();

//					row = sheet.createRow(rowIndex);
                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);

                        cell.setCellStyle(style1);

                        if (value instanceof Date) {
                            String date = value == null ? "" : sdf.format((Date) value);
                            cell.setCellValue(date);
                        } else if (entityFieldName.equals("cdId")) {
                            Object value2 = null;
                            if (StringUtils.isEmpty((String) value)) {
                                method = getMethodByFieldName("ckcName");
                                value2 = method.invoke(entity, (Object[]) null);
                                cell.setCellValue((value2 != null ? value2.toString() : ""));
                            } else {
                                method = getMethodByFieldName("cdName");
                                value2 = method.invoke(entity, (Object[]) null);
                                cell.setCellValue((value2 != null ? value2.toString() : ""));
                            }
                        } else if (entityFieldName.equals("checked")) {
                            if (((short) value) == 0) cell.setCellValue("草稿");
                            else if (((short) value) == 1) cell.setCellValue("未审核");
                            else if (((short) value) == 2) cell.setCellValue("通过");
                            else if (((short) value) == 3) cell.setCellValue("未通过");
                        } else if (entityFieldName.equals("state")) {
                            if (((short) value) == 0) cell.setCellValue("启动");
                            else if (((short) value) == 1) cell.setCellValue("暂停");
                            else if (((short) value) == 2) cell.setCellValue("停止");
                            else if (((short) value) == 3) cell.setCellValue("完成");
                            else if (((short) value) == 4) cell.setCellValue("存档");
                        } else if (entityFieldName.equals("flag")) {
                            if (((short) value) == 0) cell.setCellValue("现金流");
                            else if (((short) value) == 1) cell.setCellValue("非现金流");
                        } else if (entityFieldName.equals("reimState")) {
                            if (((short) value) == 1) cell.setCellValue("已过审批");
                            else if (((short) value) == 2) cell.setCellValue("未过审批");
                        } else if (entityFieldName.equals("state")) {
                            if (((short) value) == 0) cell.setCellValue("启动");
                            else if (((short) value) == 1) cell.setCellValue("暂停");
                            else if (((short) value) == 2) cell.setCellValue("终止");
                            else if (((short) value) == 3) cell.setCellValue("完成");
                            else if (((short) value) == 4) cell.setCellValue("存档");
                        } else if (entityFieldName.equals("timeProgress")) {
                            String val = big2((Double) value);
                            cell.setCellValue(val + "%");
                        } else if (entityFieldName.equals("planProgress")) {
                            String val = big2((Double) value);
                            cell.setCellValue(val + "%");
                        } else if (entityFieldName.equals("overheadProgress")) {
                            String val = big2((Double) value);
                            cell.setCellValue(val + "%");
                        } else if (entityFieldName.equals("costProcess") || entityFieldName.equals("taskProcess")) {
                            String val = big2((Double) value);
                            cell.setCellValue(val + "%");
                        } else {
                            cell.setCellValue((value != null ? value.toString() : ""));
                        }
                        cellIndex++;
                    }
                }
            }
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }

    /**
     * 生成CVS文件
     *
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputCsvFile(String[] titleArray, String[] entityFieldNameArray, List list,
                                        String outputFilePath) {

        logger.info("开始生成CSV文件...");
        // if(list.isEmpty()) {
        // return false;
        // }
        boolean mark = true;
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(new File(outputFilePath)));
            // 输出表格抬头
            String titleString = "";
            for (String title : titleArray) {
                titleString += title + ",";
            }
            if (titleString.length() > 0) {
                titleString = titleString.substring(0, titleString.lastIndexOf(","));
                bw.write(titleString);
                bw.write("\r\n");
            }
            if (list != null && list.size() > 0) {
                StringBuffer sb = null;
                // 输出列表数据
                for (Object entity : list) {
                    sb = new StringBuffer();
                    methods = entity.getClass().getDeclaredMethods();
                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        // logger.info("符合条件的方法名:" + method.getName());
                        Object value = method.invoke(entity, (Object[]) null);
                        sb.append((value != null ? value.toString() : "")).append(",");
                    }
                    if (sb.toString().length() > 0) {
                        bw.write(sb.toString().substring(0, sb.toString().lastIndexOf(",")));
                        bw.write("\r\n");
                    }
                }
            }
            bw.close();
            logger.info("CSV文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成CSV文件失败.");
        }

        return mark;
    }

    // *******************************************************

    /**
     * 生成Excel文件
     *
     * @param totalDate --统计日期(为null时不输出)
     * @param tableTitle --表格标题(为null时不输出)
     * @param titleArray --表格title头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param cellWidthArray --列宽数组
     * @param list --数据实体集合
     * @param outputFilePath --文件输出完整路径
     * @return boolean
     */
    /*@SuppressWarnings({ "deprecation", "rawtypes" })
    public static boolean outputExcelFile(final String totalDate, final String tableTitle, final String[] titleArray,
			final String[] entityFieldNameArray, final int[] cellWidthArray, final List list,
			final String[] totalFieldNameArray, final String outputFilePath) {

		logger.info("开始生成Excel文件...");

		boolean mark = true;
		short rowIndex = -1; // 行索引
		short cellIndex = 0; // 列索引
		try {
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet();
			HSSFRow row = null;
			HSSFCell cell = null;
			HSSFCellStyle style = null;

			if (tableTitle != null && !"".equals(tableTitle)) {
				row = sheet.createRow(++rowIndex); // rowIndex = 0
				sheet.addMergedRegion(new Region(0, (short) 0, 0, (short) (titleArray.length - 1)));
				cell = row.createCell((short) 0);

				HSSFFont font = workbook.createFont();
				font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

				style = workbook.createCellStyle();
				style.setBorderBottom(BorderStyle.THIN);
				style.setBorderLeft(BorderStyle.THIN);
				style.setBorderRight(BorderStyle.THIN);
				style.setBorderTop(BorderStyle.THIN);
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				style.setFont(font);
				cell.setCellStyle(style);
				cell.setCellType(CellType.STRING);
				cell.setCellValue(tableTitle); // 输出表格标题
			}

			// 输出统计日期
			if (totalDate != null && !"".equals(totalDate)) {
				rowIndex++;
				row = sheet.createRow(rowIndex);
				sheet.addMergedRegion(new Region(1, (short) 0, 1, (short) (titleArray.length - 1)));
				cell = row.createCell((short) 0);
				style = workbook.createCellStyle();
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				cell.setCellStyle(style);
				cell.setCellType(CellType.STRING);
				cell.setCellValue(totalDate);
			}

			// 输出表格抬头
			rowIndex++;
			cellIndex = 0;
			for (String title : titleArray) {
				sheet.setColumnWidth(cellIndex, (short) cellWidthArray[cellIndex]);
				row = sheet.createRow(rowIndex);
				cell = row.createCell(cellIndex);
				cell.setCellType(CellType.STRING);
				HSSFFont font = workbook.createFont();
				font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
				style = workbook.createCellStyle();
				style.setBorderBottom(BorderStyle.THIN);
				style.setBorderLeft(BorderStyle.THIN);
				style.setBorderRight(BorderStyle.THIN);
				style.setBorderTop(BorderStyle.THIN);
				style.setFont(font);
				cell.setCellStyle(style);
				cell.setCellValue(title);
				cellIndex++;
			}
			if (list != null && list.size() > 0) {
				// 输出列表数据
				for (Object entity : list) {
					rowIndex++;
					cellIndex = 0;
					methods = entity.getClass().getDeclaredMethods();
					row = sheet.createRow(rowIndex);
					for (String entityFieldName : entityFieldNameArray) {
						Method method = getMethodByFieldName(entityFieldName);
						// logger.info("符合条件的方法名:" + method.getName());
						Object value = method.invoke(entity, (Object[]) null);
						cell = row.createCell(cellIndex);
						cell.setCellType(CellType.STRING);
						style = workbook.createCellStyle();
						style.setBorderBottom(BorderStyle.THIN);
						style.setBorderLeft(BorderStyle.THIN);
						style.setBorderRight(BorderStyle.THIN);
						style.setBorderTop(BorderStyle.THIN);
						style.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
						style.setWrapText(true);
						style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
						cell.setCellStyle(style);
						if (method.getName().equals("getId")) {// add by
																// xiaoyuling
																// 2015-11-24
																// 导出翻译
							value = rowIndex - 1;
						}
						// cell.setCellValue((value!=null?value.toString():""));
						cell.setCellValue(new HSSFRichTextString((value != null ? value.toString() : "")));
						cellIndex++;
					}
				}
				// 输出合计
				if (totalFieldNameArray != null) {
					rowIndex++;
					row = sheet.createRow(rowIndex);
					cell = row.createCell((short) 0);
					cell.setCellType(CellType.STRING);
					cell.setCellValue("合计");

					// cellIndex = 0;
					for (int i = 0; i < totalFieldNameArray.length; i++) {
						cellIndex = (short) indexOfStringArray(totalFieldNameArray[i], entityFieldNameArray);
						cell = row.createCell(cellIndex);
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);

						float totalValue = 0f;
						Method method = null;
						for (Object entity : list) {
							method = getMethodByFieldName(totalFieldNameArray[i]);
							String methodName = method.getName();
							if (methodName.substring(methodName.lastIndexOf(".") + 1, methodName.length())
									.equals("String")) {
								continue;
							}
							totalValue += Float.valueOf(method.invoke(entity, (Object[]) null).toString());
						}
						logger.info(titleArray[indexOfStringArray(totalFieldNameArray[i], entityFieldNameArray)]);
						logger.info("合计:" + totalValue);
						cell.setCellValue(String.valueOf(totalValue));
					}
				}
			}
			FileOutputStream fOut = new FileOutputStream(outputFilePath);
			workbook.write(fOut);
			fOut.flush();
			fOut.close();
			logger.info("Excel文件已生成.");
		} catch (Exception e) {
			mark = false;
			e.printStackTrace();
			logger.error("生成Excel文件失败==>" + e.getMessage());
		}

		return mark;
	}*/

    /**
     * 生成Excel文件
     *
     * @param totalDate            --统计日期(为null时不输出)
     * @param tableTitle           --表格标题(为null时不输出)
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param cellWidthArray       --列宽数组
     * @param list                 --数据实体集合
     * @param totalFieldNameArray  --需要合计的实体字段名数组(为null时不输出)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings({"deprecation", "rawtypes"})
    public static boolean outputExcelFile(final String[] titleArray, final int[] cellWidthArray, final List list,
                                          final String outputFilePath) {

        logger.info("开始生成Excel文件...");

        boolean mark = true;
        short rowIndex = -1; // 行索引
        short cellIndex = 0; // 列索引
        try {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            HSSFRow row = null;
            HSSFCell cell = null;
            HSSFCellStyle style = null;

            // 输出表格抬头
            rowIndex++;
            cellIndex = 0;
            for (String title : titleArray) {
                sheet.setColumnWidth(cellIndex, (short) cellWidthArray[cellIndex]);
                row = sheet.createRow(rowIndex);
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                HSSFFont font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style = workbook.createCellStyle();
                style.setFont(font);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }
            if (list != null && list.size() > 0) {
                // 输出列表数据
                for (Object entity : list) {
                    rowIndex++;
                    cellIndex = 0;
                    methods = entity.getClass().getDeclaredMethods();

                    row = sheet.createRow(rowIndex);
                    // logger.info("符合条件的方法名:" + method.getName());
                    Object value = entity;
                    cell = row.createCell(cellIndex);
                    // if(method.getReturnType().toString().indexOf("String") >
                    // 0) {
                    cell.setCellType(CellType.STRING);
                    // }else {
                    // cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                    // }

                    style = workbook.createCellStyle();
                    style.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                    style.setWrapText(true);
                    style.setVerticalAlignment(VerticalAlignment.TOP);
                    cell.setCellStyle(style);

                    cell.setCellValue((value != null ? value.toString() : ""));
                }
            }
            FileOutputStream fOut = new FileOutputStream(outputFilePath);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }

    /**
     * 生成Excel文件
     *
     * @param InputStream          --模版EXCEL文件流
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param startRowIndex        --开始写入数据的行(从0开始计算)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings({"deprecation", "rawtypes"})
    public static boolean outputExcelFile(final InputStream templateInputStream, final String[] entityFieldNameArray,
                                          final List list, final short startRowIndex, final String outputFilePath) {

        logger.info("开始生成Excel文件...");

        boolean mark = true;
        short rowIndex = startRowIndex; // 行索引
        short cellIndex = 0; // 列索引
        try {
            HSSFWorkbook workbook = new HSSFWorkbook(templateInputStream);
            HSSFSheet sheet = workbook.getSheetAt(0);
            HSSFRow row = null;
            HSSFCell cell = null;
            HSSFCellStyle style = null;

            if (list != null && list.size() > 0) {
                // 输出列表数据
                for (Object entity : list) {
                    cellIndex = 0;
                    methods = entity.getClass().getDeclaredMethods();

                    row = sheet.createRow(rowIndex);
                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        // logger.info("符合条件的方法名:" + method.getName());
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);

                        style = workbook.createCellStyle();
                        style.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                        style.setWrapText(true);
                        style.setVerticalAlignment(VerticalAlignment.TOP);
                        cell.setCellStyle(style);

                        cell.setCellValue((value != null ? value.toString() : ""));
                        cellIndex++;
                    }
                    rowIndex++;
                }
            }
            FileOutputStream fOut = new FileOutputStream(outputFilePath);
            workbook.write(fOut);
            fOut.flush();
            fOut.close();
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }


   /**
   * @Description
   * @Date 2020/10/15 17:14
   * @Author xiaoyl
   * @Param workbook
    *@param tableTitle 一级标题
    *@param  subtitle 二级标题
    *@param titleArray           --表格抬头数组
    *@param entityFieldNameArray --输出数据的实体字段名数组
    *@param list                 --数据实体集合
    *@param outputFilePath       --文件输出完整路径
    * @param pointName 检测点名称
    * @param checkDate 抽样/检测日期
   * @return
   */
    public static boolean outputExcelFileForStandBook(SXSSFWorkbook workbook,final String tableTitle,final String subtitle,final String[] titleArray,
                                          final String[] entityFieldNameArray, final List list, final String outputFilePath,String pointName,String checkDate) {
        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        boolean mark = true;
        int rowIndex = 0; // 行索引
        int cellIndex = 0; // 列索引
        short rowHeight=600;//标题和底部的行高
        short contentHeight=560;//正文行高
        try {
            Sheet sheet = workbook.createSheet();
            Row row = null;
            Cell cell = null;
            CellStyle style = null;
            //设置列宽
            sheet.setDefaultColumnWidth(17);
            sheet.setColumnWidth(0, (int) ((8 + 0.72) * 256));
            sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
            sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
            sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
            // 输出表格一级标题
            if(tableTitle != null && !"".equals(tableTitle)) {
                row = sheet.createRow(rowIndex);
                row.setHeight(rowHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                Font font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style=getColumnTopStyle(workbook,(short)20,true,false);
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue(tableTitle);   //输出表格标题
                rowIndex++;
            }
            // 输出表格二级标题
            if(subtitle != null && !"".equals(subtitle)) {
                row = sheet.createRow(rowIndex);
                row.setHeight(rowHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                Font font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style=getColumnTopStyle(workbook,(short)18,false,false);
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue(subtitle);   //输出表格标题
                rowIndex++;
            }
            //输出检测室
            Date samplingDate=DateUtil.parseDate(checkDate,"");
            String samplingDateFormat=DateUtil.date_sdf_wz.format(samplingDate);//抽样或检测日期
            row = sheet.createRow(rowIndex);
            row.setHeight(rowHeight);
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, 3));
            cell = row.createCell((short) 0);
            style=getColumnTopStyle(workbook,(short)12,false,false);
            style.setAlignment(HorizontalAlignment.LEFT);
            cell.setCellStyle(style);
            cell.setCellType(CellType.STRING);
            cell.setCellValue("检测室："+pointName);
            //输出抽样日期，从第4列单元格开始合并，序号为3
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 4, (short)(titleArray.length-1)));
            cell = row.createCell((short)4);
            style=getColumnTopStyle(workbook,(short)12,false,false);
            style.setAlignment(HorizontalAlignment.CENTER);
            cell.setCellStyle(style);
            cell.setCellType(CellType.STRING);
            cell.setCellValue("抽样日期："+samplingDateFormat);

            //输出表格标题
            rowIndex++;
            row = sheet.createRow(rowIndex);
            row.setHeight(contentHeight);
            style = getColumnTopStyle(workbook,(short)12,false,true);
            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }

            // 输出列表数据
            if (list != null && list.size() > 0) {
                CellStyle style1 = getColumnTopStyle(workbook,(short)12,false,true);
                int serialNumber=1;
                for (Object entity : list) {
                    rowIndex++;
                    cellIndex = 0;
                    row = sheet.createRow(rowIndex);
                    row.setHeight(contentHeight); //设置行高
                    methods = entity.getClass().getMethods();
                    for (String entityFieldName : entityFieldNameArray) {
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);
                        cell.setCellStyle(style1);
                        if(entityFieldName.equals("serialNumber")){//设置编号
                            cell.setCellValue(serialNumber);
                            serialNumber++;
                        }else{
                            Method method = getMethodByFieldName(entityFieldName);
                            Object value = method.invoke(entity, (Object[]) null);
                            if (value instanceof Date) {
                                String date = value == null ? "" : sdf.format((Date) value);
                                cell.setCellValue(date);
                            } else if (entityFieldName.equals("isSendCheck")) {
                                cell.setCellValue((((short) value) == 0 ? "否" : "是"));
                            } else if (entityFieldName.equals("ckSystemIsReupload")) {
                                cell.setCellValue((((Integer) value) == 0 ? "否" : "是"));
                            } else if (entityFieldName.equals("rate") || entityFieldName.equals("unqualifiedRate")) {
                                cell.setCellValue((String) value + "%");
                            } else if (entityFieldName.equals("dataSource")) {
                                if (((Short) value) == null || ((short) value) == 0) cell.setCellValue("工作站");
                                else if (((Short) value) == 1) cell.setCellValue("监管通APP");
                                else if (((Short) value) == 2) cell.setCellValue("仪器上传");
                                else if (((Short) value) == 3) cell.setCellValue("平台上传");
                                else if (((Short) value) == 4) cell.setCellValue("导入");
                            } else if (entityFieldName.equals("isReUpload")) {
                                cell.setCellValue(((((Short) value) == null || ((Short) value) == 0) ? "未重传" : "重传"));
                            } else if (entityFieldName.equals("dealType")) {
                                if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("未处理");
                                else if (((Short) value) == 1) cell.setCellValue("后处理");
                                else if (((Short) value) == 2) cell.setCellValue("复检");
                            } else if (entityFieldName.equals("cdId")) {
                                Object value1 = null;
                                if (StringUtil.isEmpty((String) value)) {
                                    Method method1 = getMethodByFieldName("ckcName");
                                    value1 = method1.invoke(entity, (Object[]) null);
                                } else {
                                    Method method1 = getMethodByFieldName("cdName");
                                    value1 = method1.invoke(entity, (Object[]) null);
                                }
                                cell.setCellValue((String) value1);
                            }else if (entityFieldName.equals("errMsg") && value != null) {
                                CellStyle style2 = workbook.createCellStyle();
                                style2.setBorderBottom(BorderStyle.THIN);
                                style2.setBorderLeft(BorderStyle.THIN);
                                style2.setBorderRight(BorderStyle.THIN);
                                style2.setBorderTop(BorderStyle.THIN);
                                style2.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                                style2.setWrapText(true);
                                style2.setVerticalAlignment(VerticalAlignment.TOP);
                                Font font2 = workbook.createFont();
                                font2.setColor((short) 10);//设置颜色为红色
                                style2.setFont(font2);
                                cell.setCellStyle(style2);
                                cell.setCellValue((value != null ? value.toString() : ""));
                            } else {
                                cell.setCellValue((value != null ? value.toString() : ""));
                            }
                        }
                        cellIndex++;
                    }
                }
            }else{//查询无数据，自动添加10行表格
                rowIndex++;
                row = sheet.createRow(rowIndex);
                row.setHeight(rowHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                style=getColumnTopStyle(workbook,(short)12,false,true);
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue("暂无数据");   //输出表格标题,以下内容为输出空的单元格用于显示合并行的单元格，否则的话只有第一个单元格有边框
                for (int i = 1; i < titleArray.length; i++) {
                    cell = row.createCell(i);
                    cell.setCellType(CellType.STRING);
                    cell.setCellStyle(style);
                    cell.setCellValue("");
                }
            }
            //输出台账结尾：检测员相关信息
            String checkUserName="";//检测人员
            if(list.size()>0){
                DataCheckRecording dcr= (DataCheckRecording) list.get(0);
                checkUserName=dcr.getCheckUsername();
            }
            rowIndex++;
            row = sheet.createRow(rowIndex);   //rowIndex = 0
            row.setHeight(rowHeight);
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, 1));
            cell = row.createCell((short) 0);
            style=getColumnTopStyle(workbook,(short)12,false,false);
            style.setAlignment(HorizontalAlignment.LEFT);
            cell.setCellStyle(style);
            cell.setCellType(CellType.STRING);
            cell.setCellValue("检测员："+checkUserName);   //输出表格标题

            //输出复核，从第4列单元格开始合并，序号为3
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 2, 3));
            cell = row.createCell((short)2);
            style=getColumnTopStyle(workbook,(short)12,false,false);
            style.setAlignment(HorizontalAlignment.CENTER);
            cell.setCellStyle(style);
            cell.setCellType(CellType.STRING);
            cell.setCellValue("复核：" );

            //输出检测日期，从第5列单元格开始合并，序号为4
            sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 4, (short)(titleArray.length-1)));
            cell = row.createCell((short)4);
            style=getColumnTopStyle(workbook,(short)12,false,false);
            style.setAlignment(HorizontalAlignment.CENTER);
            cell.setCellStyle(style);
            cell.setCellType(CellType.STRING);
            cell.setCellValue("检测日期："+samplingDateFormat);

            PrintSetup printSetup=sheet.getPrintSetup();
            //设置打印方向，横向就是true
            printSetup.setLandscape(false);
            printSetup.setHeaderMargin(0);
            printSetup.setFooterMargin(0);
            //设置页眉和页脚边距
            sheet.setMargin(Sheet.HeaderMargin,0);
            sheet.setMargin(Sheet.FooterMargin,0);
            //设置工作表的页边距
            sheet.setMargin(Sheet.TopMargin,0.5);
            sheet.setMargin(Sheet.RightMargin,0.5);
            sheet.setMargin(Sheet.BottomMargin,0.5);
            sheet.setMargin(Sheet.LeftMargin,0.5);
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }
    /*
     * 列头单元格样式
     */
    private static CellStyle getColumnTopStyle(SXSSFWorkbook workbook,short fontSize,boolean boldFont,boolean haveBorder) {
        // 设置字体
        Font font = workbook.createFont();
        // 设置字体大小
        font.setFontHeightInPoints(fontSize);
        // 字体加粗
        font.setBold(boldFont);
        // 设置字体名字
        font.setFontName("宋体");
        // 设置样式;
        CellStyle style = workbook.createCellStyle();
        if(haveBorder){
            // 设置底边框;
            style.setBorderBottom(BorderStyle.THIN);
            // 设置底边框颜色;
            style.setBottomBorderColor(IndexedColors.BLACK.index);
            // 设置左边框;
            style.setBorderLeft(BorderStyle.THIN);
            // 设置左边框颜色;
            style.setLeftBorderColor(IndexedColors.BLACK.index);
            // 设置右边框;
            style.setBorderRight(BorderStyle.THIN);
            // 设置右边框颜色;
            style.setRightBorderColor(IndexedColors.BLACK.index);
            // 设置顶边框;
            style.setBorderTop(BorderStyle.THIN);
            // 设置顶边框颜色;
            style.setTopBorderColor(IndexedColors.BLACK.index);
        }else{
            style.setBorderBottom(BorderStyle.NONE);// 设置底边框;
            style.setBorderLeft(BorderStyle.NONE);// 设置左边框;
            style.setBorderRight(BorderStyle.NONE); // 设置右边框;
            style.setBorderTop(BorderStyle.NONE);// 设置顶边框;

        }

        // 在样式用应用设置的字体;
        style.setFont(font);
        // 设置自动换行;
        style.setWrapText(true);
        // 设置水平对齐的样式为居中对齐;
        style.setAlignment(HorizontalAlignment.CENTER);
        // 设置垂直对齐的样式为居中对齐;
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        return style;

    }
    // util
    // *****************************************************************************************

    /**
     * 根据字段名查找对应的getter方法
     *
     * @param filedName --字段名
     * @return Method
     */
    public static Method getMethodByFieldName(String filedName) {
        Method method = null;
        for (Method _method : methods) {
            if (_method.getName().equalsIgnoreCase("get" + filedName.trim())) {
                method = _method;
                break;
            }
        }
        return method;
    }

    /**
     * 根据字段名查找对应的getter方法
     *
     * @param filedName --字段名
     * @return Method
     */
    public static Method getMethodByFieldName(String filedName, Method[] methods) {
        Method method = null;
        for (Method _method : methods) {
            if (_method.getName().equalsIgnoreCase("get" + filedName)) {
                method = _method;
                break;
            }
        }
        return method;
    }

    /**
     * 在字符串数组中查找字符串索引位置
     *
     * @param findStr  --要查找的字符串
     * @param strArray --字符串数组
     * @return int
     */
    private static int indexOfStringArray(String findStr, String[] strArray) {
        int index = 0;
        for (int i = 0; i < strArray.length; i++) {
            if (strArray[i].equals(findStr)) {
                index = i;
                break;
            }
        }
        return index;
    }

    /**
     * 创建文件并且添加数据
     *
     * @param fileName--文件名
     * @param subject--sheet名
     * @param title--名称
     * @param numbStr--号码列表
     * @return int --1:成功；0:失败
     */
    public static int createFile(String fileName, String subject, String title, String[] numbStr) {
        try {
            File file = new File(fileName);
            WritableWorkbook wwb = Workbook.createWorkbook(file);// 创建xls文件
            WritableSheet ws = wwb.createSheet(subject, 0);
            // 设置标题
            Label title1 = new Label(0, 0, title, getTitle());
            ws.addCell(title1);
            int row = 1;
            for (int i = 0; i < numbStr.length; i++) {
                Label col1 = new Label(0, row, numbStr[i], getNormolCell());
                ws.addCell(col1);
                row++;
            }
            ws.setColumnView(0, 30);
            wwb.write();
            wwb.close();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * 添加数据
     *
     * @param fileName--文件名
     * @param begin--开始
     * @param numbStr--数据数组
     * @return int--1:成功；0:失败
     */
    public static int addData(String fileName, int begin, String[] numbStr) {
        try {
            File file = new File(fileName);
            Workbook wb = Workbook.getWorkbook(file);
            WritableWorkbook wwb = Workbook.createWorkbook(file, wb);// 创建xls文件
            WritableSheet ws = wwb.getSheet(0);
            int row = 1 + begin * 50;
            for (int i = 0; i < numbStr.length; i++) {
                Label col1 = new Label(0, row, numbStr[i], getNormolCell());
                ws.addCell(col1);
                row++;
            }
            wwb.write();
            wwb.close();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * 设置头的样式
     *
     * @return
     */
    public static WritableCellFormat getHeader() {
        WritableFont font = new WritableFont(WritableFont.TIMES, 24, WritableFont.BOLD);// 定义字体
        try {
            font.setColour(Colour.BLUE);// 蓝色字体
        } catch (WriteException e1) {
            e1.printStackTrace();
        }
        WritableCellFormat format = new WritableCellFormat(font);
        try {
            format.setAlignment(jxl.format.Alignment.CENTRE);// 左右居中
            format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);// 上下居中
            format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);// 黑色边框
            format.setBackground(Colour.YELLOW);// 黄色背景
        } catch (WriteException e) {
            e.printStackTrace();
        }
        return format;
    }

    /**
     * 设置标题样式
     *
     * @return
     */
    public static WritableCellFormat getTitle() {
        WritableFont font = new WritableFont(WritableFont.TIMES, 14);
        try {
            font.setColour(Colour.BLUE);// 蓝色字体
        } catch (WriteException e1) {
            e1.printStackTrace();
        }
        WritableCellFormat format = new WritableCellFormat(font);

        try {
            format.setAlignment(jxl.format.Alignment.CENTRE);// 水平
            format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);// 垂直
            format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);// 边框
        } catch (WriteException e) {
            e.printStackTrace();
        }
        return format;
    }

    /**
     * 设置其他单元格样式
     *
     * @return
     */
    public static WritableCellFormat getNormolCell() {// 12号字体,上下左右居中,带黑色边框
        WritableFont font = new WritableFont(WritableFont.TIMES, 12);
        WritableCellFormat format = new WritableCellFormat(font);
        try {
            format.setAlignment(jxl.format.Alignment.LEFT);
            format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
            format.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            format.setWrap(true);// 自动换行当内容过长时
        } catch (WriteException e) {
            e.printStackTrace();
        }
        return format;
    }

    public static boolean isExcel2003(String filePath) {
        return filePath.matches("^.+\\.(?i)(xls)$");
    }

    public static boolean isExcel2007(String filePath) {
        return filePath.matches("^.+\\.(?i)(xlsx)$");
    }


    private static String big2(double d) {
        BigDecimal d1 = new BigDecimal(Double.toString(d));
        BigDecimal d2 = new BigDecimal(Integer.toString(1));
        // 四舍五入,保留2位小数
        return d1.divide(d2, 2, BigDecimal.ROUND_HALF_UP).toString();
    }


    /**
     * 送检单位生成Excel文件
     *
     * @param workbook
     * @param titleArray
     * @param entityFieldNameArray
     * @param list
     * @param exportType
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputExcelFileIU(SXSSFWorkbook workbook, final String[] titleArray,
                                            final String[] entityFieldNameArray, final List list, final String exportType) {
        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        boolean mark = true;
        int rowIndex = 1; // 行索引
        int cellIndex = 0; // 列索引
        try {
            // 图片字节数组
            //byte[] imgByte = null;
            //File file = null;
            //String imgPath;


            Sheet sheet = workbook.createSheet();
            Row row = null;
            Cell cell = null;
            CellStyle style = null;
            // 输出表格抬头
            if (exportType.equals("1")) {//导出检测数据，设置列宽
                sheet.setDefaultColumnWidth(20);
                sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(7, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(8, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(9, (int) ((10 + 0.72) * 256));
            }
            row = sheet.createRow(rowIndex);
            Font font = workbook.createFont();
//            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            font.setBold(true);
            style = workbook.createCellStyle();
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
            style.setBorderTop(BorderStyle.THIN);


            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style = workbook.createCellStyle();
                style.setFont(font);
                style.setBorderBottom(BorderStyle.THIN);
                style.setBorderLeft(BorderStyle.THIN);
                style.setBorderRight(BorderStyle.THIN);
                style.setBorderTop(BorderStyle.THIN);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }

            if (list != null && list.size() > 0) {
                // 输出列表数据
                CellStyle style1 = workbook.createCellStyle();
                style1.setBorderBottom(BorderStyle.THIN);
                style1.setBorderLeft(BorderStyle.THIN);
                style1.setBorderRight(BorderStyle.THIN);
                style1.setBorderTop(BorderStyle.THIN);
                style1.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                style1.setWrapText(true);
                style1.setVerticalAlignment(VerticalAlignment.TOP);
                for (Object entity : list) {
                    rowIndex++;
                    cellIndex = 0;
                    row = sheet.createRow(rowIndex);
                    //row.setHeightInPoints(120);
                    cell = row.createCell(cellIndex);
                    cell.setCellValue(rowIndex);
                    methods = entity.getClass().getDeclaredMethods();
                    //int num = 0;
                    for (String entityFieldName : entityFieldNameArray) {
                        //num++;
                        Method method = getMethodByFieldName(entityFieldName);
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);
                        cell.setCellStyle(style1);
                        if (value instanceof Date) {
                            String date = value == null ? "" : sdf.format((Date) value);
                            cell.setCellValue(date);
                        } else if (entityFieldName.equals("companyType")) {
                            if (value != null) {
                                if (((Short) value) == 0) cell.setCellValue("企业");
                                else if (((Short) value) == 1) cell.setCellValue("个人");
                                //else if (((Short) value) == 2) cell.setCellValue("供应商");
                            }
                        } /*else if (entityFieldName.equals("userNumber")) {
                            cell.setCellValue((value != null ? value.toString() + "个" : ""));
                        } else if (entityFieldName.equals("state")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("开业");
                            else if (((Short) value) == 1) cell.setCellValue("停业");
                        } else if (entityFieldName.equals("supplier")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("否");
                            else if (((Short) value) == 1) cell.setCellValue("是");
                        }  */else if (entityFieldName.equals("checked")) {
                            if (((Short) value) == 0) cell.setCellValue("未审核");
                            else if (((Short) value) == 1) cell.setCellValue("已审核");
                            sheet.setColumnWidth(5, 120 * 80);
                        }/* else if (entityFieldName.equals("remark")) {//存在图片变形问题
                            imgByte = null;
                            // 输出图片
                            imgPath = "D:/upload/fc/inspectionQrcode/4028933f6d151be8016d151be88d0000.png";
                            file = new File(imgPath);
                            if (file.exists()) {
                                // 图片转化为字节数组
                                imgByte = IOUtils.toByteArray(new FileInputStream(imgPath));
                            }

                            if (imgByte != null) {
                                // 图片存在即输出图片
                                int addPicture = workbook.addPicture(imgByte, workbook.PICTURE_TYPE_JPEG);
                                Drawing drawing = sheet.createDrawingPatriarch();
                                CreationHelper helper = workbook.getCreationHelper();
                                ClientAnchor anchor = helper.createClientAnchor();

                                anchor.setRow1(2);
                                anchor.setCol1(3);

                                // 指定我想要的长宽
                                double standardWidth = 80;
                                double standardHeight = 80;

                                System.out.println(standardWidth);

                                // 计算单元格的长宽
                                double cellWidth = sheet.getColumnWidthInPixels(cell.getColumnIndex());
                                double cellHeight = cell.getRow().getHeightInPoints() /  120 * 80;/// 72 * 96
                                //double cellHeight =120;

                                System.out.println("cellWidth: " + cellWidth);
                                System.out.println("cellHeight: " + cellHeight);

                                // 计算需要的长宽比例的系数
                                double a = standardWidth / cellWidth;
                                double b = standardHeight / cellHeight;

                                System.out.println("a: " + a + "  b: " + b);

                                Picture picture = drawing.createPicture(anchor, addPicture);
                                picture.resize(a, b);
                            }
                        } */ else {
                            cell.setCellValue((value != null ? value.toString() : ""));
                        }
                        cellIndex++;
                    }


                }
            }
            logger.info("送检单位Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成送检单位Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }
    /**
     * 生成Excel文件
     *
     * @param totalDate            --统计日期(为null时不输出)
     * @param tableTitle           --表格标题(为null时不输出)
     * @param description          --描述说明(为null时不输出)
     * @param titleArray           --表格抬头数组
     * @param entityFieldNameArray --输出数据的实体字段名数组
     * @param list                 --数据实体集合
     * @param totalFieldNameArray  --需要合计的实体字段名数组(为null时不输出)
     * @param outputFilePath       --文件输出完整路径
     * @return boolean
     */
    @SuppressWarnings("rawtypes")
    public static boolean outputExcelFileForDescription(SXSSFWorkbook workbook, final String[] titleArray,
                                          final String[] entityFieldNameArray, final List list, final String outputFilePath, final String exportType,
                                                       String tableTitle,String description) {

        logger.info("开始生成Excel文件...");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        boolean mark = true;
        int rowIndex = 0; // 行索引
        int cellIndex = 0; // 列索引
        try {
            Sheet sheet = workbook.createSheet();
            Row row = null;
            Cell cell = null;
            CellStyle style = null;
            // 输出表格抬头
            //cellIndex = 0;
            short rowHeight=600;//标题的行高
            if(tableTitle != null && !"".equals(tableTitle)) {
                row = sheet.createRow(rowIndex);
                row.setHeight(rowHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                Font font = workbook.createFont();
                font.setBold(true);
                style=getColumnTopStyle(workbook,(short)20,true,false);
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue(tableTitle);   //输出表格标题
                rowIndex++;
            }
            //增加描述性说明
            if(description != null && !"".equals(description)) {
                row = sheet.createRow(rowIndex);
                //说明：poi中的行高单位和excel中的行高单位是不一样的，excel中的行高单位是pt（point，磅），而poi中的行高单位则是twips（缇）。
                //换算公式是：1pt = 20twips，设置每行数据行高是15pt
                short descHeight= (short) (description.split("\n").length*15*20);
                row.setHeight(descHeight);
                sheet.addMergedRegion(new CellRangeAddress(rowIndex, (short)rowIndex, 0, (short)(titleArray.length-1)));
                cell = row.createCell((short) 0);
                Font font = workbook.createFont();
                font.setBold(false);
                style=getColumnTopStyle(workbook,(short)11,false,false);
                style.setAlignment(HorizontalAlignment.LEFT);
                style.setWrapText(true);//自动换行
                cell.setCellStyle(style);
                cell.setCellType(CellType.STRING);
                cell.setCellValue(description);   //输出表格标题
                rowIndex++;
            }


            if (exportType.equals("1")) {//导出检测数据，设置列宽，POI中Sheet列宽是通过字符个数来确定的，列宽单位为一个字符宽度的1/256；每列可以显示的最大字符数为255。
                sheet.setDefaultColumnWidth(20);
                sheet.setColumnWidth(4, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(5, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(6, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(7, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(8, (int) ((10 + 0.72) * 256));
                sheet.setColumnWidth(9, (int) ((10 + 0.72) * 256));
//				sheet.setColumnWidth(0, (int)((50 + 0.72) * 256));
//				sheet.setColumnWidth(7, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(8, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(11, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(12, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(13, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(14, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(16, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(17, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(18, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(20, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(21, (int)((10 + 0.72) * 256));
//				sheet.setColumnWidth(22, (int)((10 + 0.72) * 256));
            }
            row = sheet.createRow(rowIndex);

//			cell = row.createCell(0);
//			cell.setCellType(CellType.STRING);
            Font font = workbook.createFont();
//            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            font.setBold(true);
            style = workbook.createCellStyle();
            style.setFont(font);
            style.setBorderBottom(BorderStyle.THIN);
            style.setBorderLeft(BorderStyle.THIN);
            style.setBorderRight(BorderStyle.THIN);
            style.setBorderTop(BorderStyle.THIN);
//			cell.setCellStyle(style);
//			cell.setCellValue("序号");

            for (String title : titleArray) {
                cell = row.createCell(cellIndex);
                cell.setCellType(CellType.STRING);
                font = workbook.createFont();
//                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
                style = workbook.createCellStyle();
                style.setFont(font);
                style.setBorderBottom(BorderStyle.THIN);
                style.setBorderLeft(BorderStyle.THIN);
                style.setBorderRight(BorderStyle.THIN);
                style.setBorderTop(BorderStyle.THIN);
                cell.setCellStyle(style);
                cell.setCellValue(title);
                cellIndex++;
            }
            if (list != null && list.size() > 0) {
                // 输出列表数据
                CellStyle style1 = workbook.createCellStyle();
                style1.setBorderBottom(BorderStyle.THIN);
                style1.setBorderLeft(BorderStyle.THIN);
                style1.setBorderRight(BorderStyle.THIN);
                style1.setBorderTop(BorderStyle.THIN);


                style1.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                style1.setWrapText(true);
                style1.setVerticalAlignment(VerticalAlignment.TOP);
                for (Object entity : list) {
                    /*rowIndex++;
                    row = sheet.createRow(rowIndex);
					cellIndex = 1;
					methods = entity.getClass().getDeclaredMethods();*/

                    rowIndex++;
                    cellIndex = 0;

                    row = sheet.createRow(rowIndex);
                    cell = row.createCell(cellIndex);
                    cell.setCellValue(rowIndex);

                    methods = entity.getClass().getDeclaredMethods();

                    for (String entityFieldName : entityFieldNameArray) {
                        Method method = getMethodByFieldName(entityFieldName);
                        Object value = method.invoke(entity, (Object[]) null);
                        cell = row.createCell(cellIndex);
                        cell.setCellType(CellType.STRING);

                        cell.setCellStyle(style1);

                        if (value instanceof Date) {
                            String date = value == null ? "" : sdf.format((Date) value);
                            cell.setCellValue(date);
                        } else if (entityFieldName.equals("isSendCheck")) {
                            cell.setCellValue((((short) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("ckSystemIsReupload")) {
                            cell.setCellValue((((Integer) value) == 0 ? "否" : "是"));
                        } else if (entityFieldName.equals("rate") || entityFieldName.equals("unqualifiedRate")) {
                            cell.setCellValue((String) value + "%");
                        } else if (entityFieldName.equals("dataSource")) {
                            if (((Short) value) == null || ((short) value) == 0) cell.setCellValue("工作站");
                            else if (((Short) value) == 1) cell.setCellValue("监管通APP");
                            else if (((Short) value) == 2) cell.setCellValue("仪器上传");
                            else if (((Short) value) == 3) cell.setCellValue("平台上传");
                            else if (((Short) value) == 4) cell.setCellValue("导入");
                        } else if (entityFieldName.equals("isReUpload")) {
                            cell.setCellValue(((((Short) value) == null || ((Short) value) == 0) ? "未重传" : "重传"));
                        } else if (entityFieldName.equals("dealType")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("未处理");
                            else if (((Short) value) == 1) cell.setCellValue("后处理");
                            else if (((Short) value) == 2) cell.setCellValue("复检");
                        } else if (entityFieldName.equals("cdId")) {
                            Object value1 = null;
                            if (StringUtil.isEmpty((String) value)) {
                                Method method1 = getMethodByFieldName("ckcName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            } else {
                                Method method1 = getMethodByFieldName("cdName");
                                value1 = method1.invoke(entity, (Object[]) null);
                            }
                            cell.setCellValue((String) value1);
                        } else if (entityFieldName.equals("gender")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("男");
                            else if (((Short) value) == 1) cell.setCellValue("女");
                        } else if (entityFieldName.equals("status")) {
                            if (((Short) value) == null || ((Short) value) == 0) cell.setCellValue("在职");
                            else if (((Short) value) == 1) cell.setCellValue("离职");
                        } else if (entityFieldName.equals("creditRating") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("A");
                            else if (((Short) value) == 2) cell.setCellValue("B");
                            else if (((Short) value) == 3) cell.setCellValue("C");
                            else if (((Short) value) == 4) cell.setCellValue("D");
                        } else if (entityFieldName.equals("monitoringLevel") && value != null) {
                            if (((Short) value) == 1) cell.setCellValue("安全");
                            else if (((Short) value) == 2) cell.setCellValue("轻微");
                            else if (((Short) value) == 3) cell.setCellValue("警惕");
                            else if (((Short) value) == 4) cell.setCellValue("严重");
                        } else if (entityFieldName.equals("checked")) {
                            if (((Short) value) == 0) cell.setCellValue("未审核");
                            else if (((Short) value) == 1) cell.setCellValue("已审核");
                        } else if (entityFieldName.equals("regType")) {
                            if (value.equals("2c922b9a622c772401622ca07bfd00a8")) cell.setCellValue("药店");
                            else if (value.equals("2c922b9a622c772401622ca2bb6800ba")) cell.setCellValue("超市");
                            else if (value.equals("2c922b9a622c772401622ca2f72d00bd")) cell.setCellValue("其他");
                            else if (value.equals("4028935f5e7e898a015e7e898adb0000")) cell.setCellValue("生产单位");
                            else if (value.equals("4028935f5e7e898a015e7e89a9490001")) cell.setCellValue("经营单位");
                            else if (value.equals("4028935f5e7edbe2015e7eeca4b60009")) cell.setCellValue("餐饮单位");
                        } else if (entityFieldName.equals("managementType") && value != null) {
                            if (value.equals("0")) cell.setCellValue("批发市场");
                            else if (value.equals("1")) cell.setCellValue("农贸市场");
                        } else if (entityFieldName.equals("errMsg") && value != null) {
                            CellStyle style2 = workbook.createCellStyle();
                            style2.setBorderBottom(BorderStyle.THIN);
                            style2.setBorderLeft(BorderStyle.THIN);
                            style2.setBorderRight(BorderStyle.THIN);
                            style2.setBorderTop(BorderStyle.THIN);
                            style2.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
                            style2.setWrapText(true);
                            style2.setVerticalAlignment(VerticalAlignment.TOP);
                            Font font2 = workbook.createFont();
                            font2.setColor((short) 10);//设置颜色为红色
                            style2.setFont(font2);
                            cell.setCellStyle(style2);
                            cell.setCellValue((value != null ? value.toString() : ""));
                        } else {
                            cell.setCellValue((value != null ? value.toString() : ""));
                        }
                        cellIndex++;
                    }
                }
            }
            logger.info("Excel文件已生成.");
        } catch (Exception e) {
            mark = false;
            e.printStackTrace();
            logger.error("生成Excel文件失败==>" + e.getMessage());
        }

        return mark;
    }
    /**
    * @Description 设置单元格样式和字体颜色
    * @Date 2022/06/30 11:52
    * @Author xiaoyl
    * @Param
    * @return
    */
    private static CellStyle setCellStyle(SXSSFWorkbook workbook,int color){
        CellStyle style2 = workbook.createCellStyle();
        style2.setBorderBottom(BorderStyle.THIN);
        style2.setBorderLeft(BorderStyle.THIN);
        style2.setBorderRight(BorderStyle.THIN);
        style2.setBorderTop(BorderStyle.THIN);
        style2.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
        style2.setWrapText(true);
        style2.setVerticalAlignment(VerticalAlignment.TOP);
        Font font2 = workbook.createFont();
        font2.setColor((short) color);//设置颜色为红色
        style2.setFont(font2);
        return style2;
    }
}
