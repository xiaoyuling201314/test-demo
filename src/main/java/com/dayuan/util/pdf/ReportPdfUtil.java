package com.dayuan.util.pdf;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.qrcode.QrCodeUtil;
import cn.hutool.extra.qrcode.QrConfig;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.dromara.pdf.fop.core.doc.Document;
import org.dromara.pdf.fop.core.doc.component.image.Image;
import org.dromara.pdf.fop.core.doc.component.table.Table;
import org.dromara.pdf.fop.core.doc.component.table.TableBody;
import org.dromara.pdf.fop.core.doc.component.table.TableCell;
import org.dromara.pdf.fop.core.doc.component.table.TableRow;
import org.dromara.pdf.fop.core.doc.component.text.Text;
import org.dromara.pdf.fop.core.doc.page.Page;
import org.dromara.pdf.fop.handler.TemplateHandler;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Dz
 * @Description 电子报告PDF工具类
 */
@Slf4j
public class ReportPdfUtil {

    /**
     * 报告标题
     */
    private static final String REPORT_TITLE = "食品安全快速检测报告";
    /**
     * 报告机构
     */
    private static final String REPORT_ORG = "云南绿通联检技术有限公司";
    /**
     * 印章图片路径
     */
    public static final String REPORT_SEAL_PATH = "img/report/seal.png";

    // 默认字体
    private static final String DEFAULT_FONT_FAMILY = "宋体";
    // 标题字体大小
    private static final String TITLE_FONT_SIZE = "16px";
    // 内容字体大小
    private static final String DEFAULT_FONT_SIZE = "11px";
    // 字体水平居中
    private static final String CENTER_HORIZONTAL = "center";
    // 字体加粗
    private static final String FONT_WEIGHT_BOLD = "bold";


    // 表格边框
    private static final String CELL_BORDER = "1px solid black";
    // 表格行高1
    private static final String CELL_HEIGHT_1 = "40px";
    // 表格行间距1
    private static final String CELL_LINE_SPACING_1 = "1.5";
    // 表格行间距2
    private static final String CELL_LINE_SPACING_2 = "2";
    // 表格行间距3
    private static final String CELL_LINE_SPACING_3 = "3";
    // 表格文本垂直居中
    private static final String CELL_VERTICAL_CENTER = "center";

    /**
     * 生成pdf
     * @param reportData  报告数据
     * @param outputPath 输出路径
     */
    public static void generate(ReportData reportData, String outputPath) {
        log.info("开始生成电子报告pdf");

        // 临时二维码图片
        File qrCodeTempFile = null;

        // 定义输出路径   例：D:\\快检新模式\202501\A5200000001.pdf
//        String outputPath = resources + reportDirPath +
//                DateUtil.format(reportData.getReportDate(), "yyyyMM") + "/" +
//                reportData.getOrderNumber() + ".pdf";

        // 创建文档
        Document document = TemplateHandler.Document.build();
        // 创建页面（空白页）
        Page page = TemplateHandler.Page.build();
        page.setMarginTop("20px").setMarginBottom("20px").setMarginLeft("50px").setMarginRight("50px");


        // 创建title
        Text title = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(TITLE_FONT_SIZE)
                .setHorizontalStyle(CENTER_HORIZONTAL)
                .setText(REPORT_TITLE);
        // 创建文本1
        Text orderNumber = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(DEFAULT_FONT_SIZE)
                // 保留空格
                .setWhiteSpaceCollapse("pre").setWhiteSpaceCollapse("false")
                .setText(String.format("单号：%s                                                    送检日期：%s",
                    reportData.getOrderNumber(), DateUtil.format(reportData.getSamplingTime(), "yyyy-MM-dd"))
                );
        // 添加标题、单号信息
        page.addBodyComponent(title, orderNumber);


        // 表格1单元格宽度
        String[] table1ColWidths = {"90px", "180px", "70px", "80px"};
        // 表格1数据
        List<String[]> table1Rows = new ArrayList<>(2);
        String[] table1Row1 = new String[]{"冷库名称/个人", reportData.getCcuName(), "手机号码", reportData.getOrderUserPhone()};
        table1Rows.add(table1Row1);
        String[] table1Row2 = new String[]{"冷库仓号", reportData.getIuName(), "车牌号码", reportData.getCarNumber()};
        table1Rows.add(table1Row2);
        // 创建表格
        Table table1 = TemplateHandler.Table.build();
        // 创建表格体
        TableBody tableBody1 = TemplateHandler.Table.Body.build();
        // 循环创建表格行
        for (int i = 0; i < table1Rows.size(); i++) {
            // 创建表格行
            TableRow row = TemplateHandler.Table.Row.build();
            // 行数据
            String[] rowData = table1Rows.get(i);
            // 循环创建表格单元格
            for (int j = 0; j < rowData.length; j++) {
                // 创建表格单元格
                TableCell cell = TemplateHandler.Table.Cell.build();
                // 设置单元格宽度
                cell.setWidth(table1ColWidths[j])
                        // 设置单元格高度
                        .setHeight(CELL_HEIGHT_1)
                        // 设置单元格边框
                        .setBorder(CELL_BORDER)
                        // 设置单元格文本垂直居中
                        .setVerticalStyle(CELL_VERTICAL_CENTER);
                // 创建文本
                Text text = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(DEFAULT_FONT_SIZE)
                        .setHorizontalStyle(CENTER_HORIZONTAL).setLeading(CELL_LINE_SPACING_1)
                        .setText(rowData[j]);
                // 添加文本
                cell.addComponent(text);
                // 添加单元格
                row.addCell(cell);

                // 二维码单元格
                if (i==0 && j==rowData.length-1 && StrUtil.isNotBlank(reportData.getQrCode())) {
                    // 二维码单元格，第一行最后一列合并单元格
                    // 创建表格单元格
                    TableCell cell2 = TemplateHandler.Table.Cell.build();
                    // 设置单元格宽度
//                    cell.setWidth("80px");
                    // 设置单元格边框
                    cell2.setBorder(CELL_BORDER);

                    // 生成二维码
                    // 临时二维码图片路径
                    String qrCodeTempFilePath = outputPath.substring(0, outputPath.lastIndexOf("/")) + "/temp/" + IdUtil.fastSimpleUUID() + ".png";
                    qrCodeTempFile = FileUtil.file(qrCodeTempFilePath);
                    // 生成指定url对应的二维码到文件，宽和高都是300像素
                    QrCodeUtil.generate(reportData.getQrCode(), 300, 300, qrCodeTempFile);

                    // 添加二维码图片
                    Image qrImage = TemplateHandler.Image.build()
                            // 设置图像路径（绝对路径）
                            .setPath("/"+qrCodeTempFilePath)
                            // 设置图像宽度
                            .setWidth("60px")
                            // 设置图像高度
                            .setHeight("60px")
                            // 设置水平居中
                            .setHorizontalStyle("center")
                            .setMarginTop("2px");
                    // 提示
                    Text tips = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize("10px")
                            .setHorizontalStyle(CENTER_HORIZONTAL).setMarginBottom("2px")
                            .setText("扫码查看");
                    // 添加二维码
                    cell2.addComponent(qrImage, tips);
                    // 设置单元格行数
                    cell2.setRowSpan(2);
                    // 添加单元格
                    row.addCell(cell2);
                }
            }
            // 添加行
            tableBody1.addRow(row);
        }
        // 设置表格体
        table1.setBody(tableBody1);
        // 添加表格
        page.addBodyComponent(table1);



        // 表格1单元格宽度
        String[] table2ColWidths = {"50px", "180px", "180px"};
        // 表格2数据
        List<String[]> table2Rows = new ArrayList<>();
        table2Rows.add(new String[]{"编号", "样品名称", "检测项目", "检测结果"});
        for (int i = 0; i < reportData.getDetails().size(); i++) {
            String[] table2Row = new String[]{(i+1)+"", reportData.getDetails().get(i).getFoodName(),
                    reportData.getDetails().get(i).getItemName(), reportData.getDetails().get(i).getConclusion()};
            table2Rows.add(table2Row);
        }
        // 添加横杆
        Boolean barFlag = true;
        // 表格2行数不足19行，则添加空行
        while (table2Rows.size() <= 19) {
            if (barFlag) {
                table2Rows.add(new String[]{table2Rows.size()+"", "——", "——", "——"});
                barFlag = false;
            } else {
                table2Rows.add(new String[]{table2Rows.size()+"", "", "", ""});
            }
        }

        // 创建表格
        Table table2 = TemplateHandler.Table.build();
        // 创建表格体
        TableBody tableBody2 = TemplateHandler.Table.Body.build();
        // 循环创建表格行
        for (int i = 0; i < table2Rows.size(); i++) {
            // 创建表格行
            TableRow row = TemplateHandler.Table.Row.build();
            // 行数据
            String[] rowData = table2Rows.get(i);
            // 循环创建表格单元格
            for (int j = 0; j < rowData.length; j++) {
                // 创建表格单元格
                TableCell cell = TemplateHandler.Table.Cell.build();
                // 设置单元格边框
                cell.setBorder(CELL_BORDER);
                // 标题行设置单元格背景色
                if (i==0) {
                    cell.setBackgroundColor("#e0e0e0");
                    cell.setFontWeight(FONT_WEIGHT_BOLD);
                }
                // 设置单元格宽度
                if (j!=rowData.length-1) {
                    cell.setWidth(table2ColWidths[j]);
                }
                // 创建文本
                Text text = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(DEFAULT_FONT_SIZE)
                        .setHorizontalStyle(CENTER_HORIZONTAL).setLeading(CELL_LINE_SPACING_2)
                        .setText(rowData[j]);
                // 添加文本
                cell.addComponent(text);
                // 添加单元格
                row.addCell(cell);
            }
            // 添加行
            tableBody2.addRow(row);
        }


        // 创建表格行
        TableRow sealRow = TemplateHandler.Table.Row.build();
        // 创建表格单元格
        TableCell cell = TemplateHandler.Table.Cell.build();
        // 获取类路径下的资源地址
        String resourcesPath = ReportPdfUtil.class.getClassLoader().getResource( "").getPath();
        // 假设resources位于WEB-INF/classes下，则向上两级目录为项目根目录
        resourcesPath = resourcesPath.substring(0, resourcesPath.lastIndexOf("WEB-INF/classes/"));
        // 公章图片地址  //例： /D:\\IdeaWorkspace\\dykjfw_new\\src\\main\\webapp\\img\\report\\seal.png
        String sealImage = resourcesPath + REPORT_SEAL_PATH;
        // 设置单元格背景图片
        cell.setBackgroundImage(sealImage)
//        .setBackgroundImageWidth("600px")
//        .setBackgroundImageHeight("600px")
                .setBackgroundPosition("150px,10px")
                .setBackgroundRepeat("no-repeat")
                // 设置高度
                .setHeight("140px")
                // 设置单元格边框
                .setBorder(CELL_BORDER)
                // 设置单元格文本垂直居中
                .setVerticalStyle(CELL_VERTICAL_CENTER)
                // 设置合并列数
                .setColumnSpan(4);
        // 检测单位
        Text org = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(DEFAULT_FONT_SIZE)
                .setLeading(CELL_LINE_SPACING_3).setMarginLeft("10px")
                .setText("检测单位："+REPORT_ORG);
        // 报告日期
        Text reportDate = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize(DEFAULT_FONT_SIZE)
                .setLeading(CELL_LINE_SPACING_3).setMarginLeft("10px")
                .setText("报告日期："+DateUtil.format(reportData.getReportTime(), "yyyy-MM-dd"));
        // 添加文本
        cell.addComponent(org, reportDate);
        // 添加单元格
        sealRow.addCell(cell);
        // 添加行
        tableBody2.addRow(sealRow);

        // 设置表格体
        table2.setBody(tableBody2);
        // 添加表格
        page.addBodyComponent(table2);



        // 报告注释
        Text exegesis = TemplateHandler.Text.build().setFontFamily(DEFAULT_FONT_FAMILY).setFontSize("8px")
                .setText("注：检测结果仅对本次样品有效，手写无效。");
        // 添加文本
        page.addBodyComponent(exegesis);

        // 添加页面
        document.addPage(page);
        // 转换pdf
        document.transform(outputPath);

        // 删除临时二维码图片
        if (qrCodeTempFile != null) {
            FileUtils.deleteQuietly(qrCodeTempFile);
        }

        log.info("生成电子报告pdf成功");
    }

//    public static void main(String[] args){
//
//        List<ReportData.Detail> details = new ArrayList<>();
//
//        int count = RandomUtil.randomInt(1,40);
//        log.info("生成pdf数据条数：" + count);
//        for (int i = 1; i <= count; i++) {
//            details.add(new ReportData.Detail("样品名称"+i, "检测项目"+i, RandomUtil.randomInt()%3 == 0 ? "不合格" : "合格"));
//        }
//
//        DateTime dateTime =  RandomUtil.randomDate(new Date(), DateField.DAY_OF_MONTH, -100, 0);
//        ReportData reportData = new ReportData("A52"+RandomUtil.randomNumbers(8), dateTime,
//                "冷库"+RandomUtil.randomNumbers(3), "C-"+RandomUtil.randomNumbers(3),
//                "135"+RandomUtil.randomNumbers(8), "粤A"+RandomUtil.randomNumbers(5),
//                "http://", details, dateTime);
//
//        // 定义输出路径   例：D:\\快检新模式\202501\A5200000001.pdf
//        String outputPath = "D:/resources/dykjfw/report/" +
//                DateUtil.format(reportData.getReportTime(), "yyyyMM") + "/" +
//                reportData.getOrderNumber() + ".pdf";
//
//        ReportPdfUtil.generate(reportData, outputPath);
//        log.info("pdf输出路径：" + outputPath);
//
//        log.info("url：" + ReportPdfUtil.class.getClassLoader().getResource( "").getPath());
//    }

}
