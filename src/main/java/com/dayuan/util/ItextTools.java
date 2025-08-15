package com.dayuan.util;

import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.bean.dataCheck.DataCheckRecording;
//import com.dayuan2.model.cost.CCostModel;
//import com.dayuan2.model.cost.CWagesModel;
//import com.dayuan2.model.project.PProjectModel;
import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.List;


public class ItextTools {
    @SuppressWarnings({"unused", "deprecation"})
    public static void createWordDocument(String rootPath, String realPath, String[] titleArray, List<DataCheckRecording> items,
                                          String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
        document.open();
//		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
        document.setMargins(30f, 30f, 30f, 30f);
        // 设置PDF支持中文 
//		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);

        String root = request.getSession().getServletContext().getRealPath("/");
        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 标题字体风格
        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
        Table table = new Table(titleArray.length + 1);
        table.setWidth(100);//占页面宽度
        table.setAutoFillEmptyCells(true);
        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
        // Paragraph par=new Paragraph();
        // par.add(image);
        // document.add(par);
        // 正文字体风格
        Font font = setChineseFont(root, Color.black);
        Paragraph title = new Paragraph(wordTitle, titleFont);
        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setFont(titleFont);
        table.setPadding(2f);// 设置间距
//		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        document.add(title);

        // 设置表格title
        Cell cell = null;
        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        cell.setHeader(true);
        cell.setBackgroundColor(Color.GRAY);
        table.addCell(cell);
        for (int i = 0; i < titleArray.length; i++) {
            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
            cell.setHeader(true);
            cell.setBackgroundColor(Color.GRAY);
            table.addCell(cell);
        }
        // table.endHeaders();//设置每页显示表格title
        DataCheckRecording d = null;
        for (int i = 0; i < items.size(); i++) {
            d = items.get(i);
            cell = new Cell((i + 1) + "");
            table.addCell(cell);

            cell = new Cell(d.getDepartName());
            table.addCell(cell);
            cell = new Cell(d.getPointName());
            table.addCell(cell);
            cell = new Cell(d.getRegName());
            table.addCell(cell);
            cell = new Cell(d.getRegUserName());
            table.addCell(cell);
//            cell = new Cell(d.getFoodTypeName());
            table.addCell(cell);
            cell = new Cell(d.getFoodName());
            table.addCell(cell);
            cell = new Cell(d.getItemName());
            table.addCell(cell);
            cell = new Cell(d.getLimitValue());
            table.addCell(cell);
            cell = new Cell(d.getCheckResult());
            table.addCell(cell);
            cell = new Cell(d.getConclusion());
            table.addCell(cell);
            cell = new Cell(d.getCheckAccord());
            table.addCell(cell);
            String checkDate = d.getCheckDate() == null ? "" : DateUtil.formatDate(d.getCheckDate(), "yyyy-MM-dd HH:mm:ss");
            cell = new Cell(checkDate);
            table.addCell(cell);
            cell = new Cell(d.getCheckUsername());
            table.addCell(cell);
            //cell = new Cell(d.getCheckCode());
            /*d.setCheckCode((i+1)+"");
            cell = new Cell(d.getCheckCode());
			table.addCell(cell);*/
//			d = items.get(i);
//			cell = new Cell(d.getSysCode());
//			table.addCell(cell);
//			cell = new Cell(d.getPlanCode());
//			table.addCell(cell);
//			cell = new Cell(d.getSampingNO());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckPointName());
//			table.addCell(cell);
//			String checkDate = d.getCheckDate()==null?"":DateUtil.formatDate(d.getCheckDate(), "yyyy-MM-dd HH:mm:ss");
//			cell = new Cell(checkDate);
//			table.addCell(cell);
//			cell = new Cell(d.getSysOrgName());
//			table.addCell(cell);
//			cell = new Cell(d.getCkcName());
//			table.addCell(cell);
//			cell = new Cell(d.getFoodType());
//			table.addCell(cell);
//			cell = new Cell(d.getFoodName());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckDevice());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckItemName());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckResult());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckUnit());
//			table.addCell(cell);
//			cell = new Cell(d.getLimitValue());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckConclusion());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckAccord());
//			table.addCell(cell);
//			cell = new Cell(d.getCheckUser());
//			table.addCell(cell);
//			Short source = d.getDataSource();
//			String dataSource = "";
//			if(source == null || source == 0) dataSource="工作站";
//			else if(source == 1) dataSource="监管通APP";
//			else if(source == 2) dataSource="仪器上传";
//			else if(source == 3) dataSource="平台上传";
//			else if(source == 4) dataSource="导入";
//			cell = new Cell(dataSource);
//			table.addCell(cell);
//			cell = new Cell(d.getDataUploadUser());
//			table.addCell(cell);
//			String uploadDate = d.getDataUpdateDate()==null?"":DateUtil.formatDate(d.getDataUpdateDate(), "yyyy-MM-dd HH:mm:ss");
//			cell = new Cell(uploadDate);
//			table.addCell(cell);
//			String reupload = d.getIsReUpload()==null||d.getIsReUpload()==0?"未重传":"重传";
//			cell = new Cell(reupload);
//			table.addCell(cell);
//			Short deal = d.getDealType();
//			String dealType = "";
//			if(deal==null || deal == 0) dealType = "未处理";
//			else if(deal == 1) dealType = "后处理";
//			else if(deal == 2) dealType = "复检";
//			cell = new Cell(dealType);
//			table.addCell(cell);
//			
//			cell = new Cell(d.getVerifyUser());
//			table.addCell(cell);
//			String uDate = d.getuDate()==null?"":DateUtil.formatDate(d.getuDate(), "yyyy-MM-dd HH:mm:ss");
//			cell = new Cell(uDate);
//			table.addCell(cell);

        }
        document.add(table);
        document.close();
    }


//    @SuppressWarnings({"unused", "deprecation"})
//    public static void createCostWordDocument(String rootPath, String realPath, String[] titleArray, List<CCostModel> items,
//                                              String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
//        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
//        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
//        document.open();
////		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
//        document.setMargins(30f, 30f, 30f, 30f);
//        // 设置PDF支持中文 
////		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
//
//        String root = request.getSession().getServletContext().getRealPath("/");
//        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//
//        // 标题字体风格
//        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
//        Table table = new Table(titleArray.length + 1);
//        table.setWidth(100);//占页面宽度
//        table.setAutoFillEmptyCells(true);
//        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
//        // Paragraph par=new Paragraph();
//        // par.add(image);
//        // document.add(par);
//        // 正文字体风格
//        Font font = setChineseFont(root, Color.black);
//        Paragraph title = new Paragraph(wordTitle, titleFont);
//        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        title.setFont(titleFont);
//        table.setPadding(2f);// 设置间距
////		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
////		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        document.add(title);
//
//        // 设置表格title
//        Cell cell = null;
//        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
//        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        cell.setHeader(true);
//        cell.setBackgroundColor(Color.GRAY);
//        table.addCell(cell);
//        for (int i = 0; i < titleArray.length; i++) {
//            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
//            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//            cell.setHeader(true);
//            cell.setBackgroundColor(Color.GRAY);
//            table.addCell(cell);
//        }
//        // table.endHeaders();//设置每页显示表格title
//        CCostModel d = null;
//        for (int i = 0; i < items.size(); i++) {
//            d = items.get(i);
//            cell = new Cell((i + 1) + "");
//            table.addCell(cell);
//
//            cell = new Cell(d.getNumber());
//            table.addCell(cell);
//            if (d.getIncome() != null) {
//                cell = new Cell(d.getIncome().toString());
//            } else {
//                cell = new Cell("");
//            }
//            table.addCell(cell);
//            cell = new Cell(d.getCost().toString());
//            table.addCell(cell);
//            if (d.getBalance() != null) {
//                cell = new Cell(d.getBalance().toString());
//            } else {
//                cell = new Cell("");
//            }
//            table.addCell(cell);
//            cell = new Cell(d.getPtypeName());
//            table.addCell(cell);
//            cell = new Cell(d.getTypeName());
//            table.addCell(cell);
//            cell = new Cell(d.getDetail());
//            table.addCell(cell);
//            cell = new Cell(d.getRealname());
//            table.addCell(cell);
//            cell = new Cell(d.getNoReason());
//            table.addCell(cell);
//            cell = new Cell(d.getReimRemark());
//            table.addCell(cell);
//            String checkDate = d.getReimDate() == null ? "" : DateUtil.formatDate(d.getReimDate(), "yyyy-MM-dd HH:mm:ss");
//            cell = new Cell(checkDate);
//            table.addCell(cell);
//            cell = new Cell(d.getExamine());
//            table.addCell(cell);
//            String happenDate = d.getHappenDate() == null ? "" : DateUtil.formatDate(d.getHappenDate(), "yyyy-MM-dd HH:mm:ss");
//            cell = new Cell(happenDate);
//            table.addCell(cell);
//            String checked = null;
//            if (d.getChecked() == 0) {
//                checked = "草稿";
//            } else if (d.getChecked() == 1) {
//                checked = "未审核";
//            } else if (d.getChecked() == 2) {
//                checked = "通过";
//            } else if (d.getChecked() == 3) {
//                checked = "未通过";
//            }
//            cell = new Cell(checked);
//            table.addCell(cell);
//        }
//        document.add(table);
//        document.close();
//    }
//
//    @SuppressWarnings({"unused", "deprecation"})
//    public static void createCostsWordDocument(String rootPath, String realPath, String[] titleArray, List<PProjectModel> items,
//                                               String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
//        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
//        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
//        document.open();
////		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
//        document.setMargins(30f, 30f, 30f, 30f);
//        // 设置PDF支持中文 
////		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
//
//        String root = request.getSession().getServletContext().getRealPath("/");
//        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//
//        // 标题字体风格
//        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
//        Table table = new Table(titleArray.length + 1);
//        table.setWidth(100);//占页面宽度
//        table.setAutoFillEmptyCells(true);
//        // 正文字体风格
//        Font font = setChineseFont(root, Color.black);
//        Paragraph title = new Paragraph(wordTitle, titleFont);
//        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        title.setFont(titleFont);
//        table.setPadding(2f);// 设置间距
//        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        document.add(title);
//
//        // 设置表格title
//        Cell cell = null;
//        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
//        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        cell.setHeader(true);
//        cell.setBackgroundColor(Color.GRAY);
//        table.addCell(cell);
//        for (int i = 0; i < titleArray.length; i++) {
//            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
//            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//            cell.setHeader(true);
//            cell.setBackgroundColor(Color.GRAY);
//            table.addCell(cell);
//        }
//        // table.endHeaders();//设置每页显示表格title
//        PProjectModel d = null;
//        for (int i = 0; i < items.size(); i++) {
//            d = items.get(i);
//            cell = new Cell((i + 1) + "");
//            table.addCell(cell);
//
//            cell = new Cell(d.getProjectName());
//            table.addCell(cell);
//
//            cell = new Cell(d.getCcsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getNosum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getCashsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getInsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getBbsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getRealname().toString());
//            table.addCell(cell);
//            String state = null;
//            if (d.getState() == 0) {
//                state = "启动";
//            } else if (d.getChecked() == 1) {
//                state = "暂停";
//            } else if (d.getChecked() == 2) {
//                state = "停止";
//            } else if (d.getChecked() == 3) {
//                state = "完成";
//            } else if (d.getChecked() == 4) {
//                state = "存档";
//            }
//            cell = new Cell(state);
//            table.addCell(cell);
//        }
//        document.add(table);
//        document.close();
//    }

    @SuppressWarnings({"unused", "deprecation"})
    public static void createWorkesWordDocument(String rootPath, String realPath, String[] titleArray, List<BaseWorkers> items,
                                                String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
        document.open();
//		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
        document.setMargins(30f, 30f, 30f, 30f);
        // 设置PDF支持中文 
//		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);

        String root = request.getSession().getServletContext().getRealPath("/");
        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 标题字体风格
        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
        Table table = new Table(titleArray.length + 1);
        table.setWidth(100);//占页面宽度
        table.setAutoFillEmptyCells(true);
        // 正文字体风格
        Font font = setChineseFont(root, Color.black);
        Paragraph title = new Paragraph(wordTitle, titleFont);
        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setFont(titleFont);
        table.setPadding(2f);// 设置间距
        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        document.add(title);

        // 设置表格title
        Cell cell = null;
        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        cell.setHeader(true);
        cell.setBackgroundColor(Color.GRAY);
        table.addCell(cell);
        for (int i = 0; i < titleArray.length; i++) {
            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
            cell.setHeader(true);
            cell.setBackgroundColor(Color.GRAY);
            table.addCell(cell);
        }
        // table.endHeaders();//设置每页显示表格title
        BaseWorkers d = null;
        for (int i = 0; i < items.size(); i++) {
            d = items.get(i);
            cell = new Cell((i + 1) + "");
            table.addCell(cell);

            cell = new Cell(d.getWorkerName());
            table.addCell(cell);


            String gender = null;
            if (d.getGender().equals(0)) {
                gender = "男";
            } else if (d.getGender().equals(1)) {
                gender = "女";
            }
            cell = new Cell(gender);
            table.addCell(cell);

            cell = new Cell(d.getMobilePhone());
            table.addCell(cell);
            cell = new Cell(d.getPosition());
            table.addCell(cell);
            cell = new Cell(d.getJobState());
            table.addCell(cell);
            String state = null;
            if (d.getStatus().equals(0)) {
                state = "在职";
            } else if (d.getStatus().equals(1)) {
                state = "离职";
            }
            cell = new Cell(state);
            table.addCell(cell);
        }
        document.add(table);
        document.close();
    }

//    @SuppressWarnings({"unused", "deprecation"})
//    public static void createCWagesWordDocument(String rootPath, String realPath, String[] titleArray, List<PProjectModel> items,
//                                                String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
//        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
//        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
//        document.open();
////		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
//        document.setMargins(30f, 30f, 30f, 30f);
//        // 设置PDF支持中文 
////		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
//
//        String root = request.getSession().getServletContext().getRealPath("/");
//        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//
//        // 标题字体风格
//        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
//        Table table = new Table(titleArray.length + 1);
//        table.setWidth(100);//占页面宽度
//        table.setAutoFillEmptyCells(true);
//        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
//        // Paragraph par=new Paragraph();
//        // par.add(image);
//        // document.add(par);
//        // 正文字体风格
//        Font font = setChineseFont(root, Color.black);
//        Paragraph title = new Paragraph(wordTitle, titleFont);
//        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        title.setFont(titleFont);
//        table.setPadding(2f);// 设置间距
////		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
////		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        document.add(title);
//
//        // 设置表格title
//        Cell cell = null;
//        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
//        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        cell.setHeader(true);
//        cell.setBackgroundColor(Color.GRAY);
//        table.addCell(cell);
//        for (int i = 0; i < titleArray.length; i++) {
//            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
//            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//            cell.setHeader(true);
//            cell.setBackgroundColor(Color.GRAY);
//            table.addCell(cell);
//        }
//        // table.endHeaders();//设置每页显示表格title
//        PProjectModel d = null;
//        for (int i = 0; i < items.size(); i++) {
//            d = items.get(i);
//            cell = new Cell((i + 1) + "");
//            table.addCell(cell);
//
//            cell = new Cell(d.getProjectName());
//            table.addCell(cell);
//
//            cell = new Cell(d.getWsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getCsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getBsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getDsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getOsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getSum().toString());
//            table.addCell(cell);
//            String state = null;
//            if (d.getState() == 0) {
//                state = "启动";
//            } else if (d.getChecked() == 1) {
//                state = "暂停";
//            } else if (d.getChecked() == 2) {
//                state = "停止";
//            } else if (d.getChecked() == 3) {
//                state = "完成";
//            } else if (d.getChecked() == 4) {
//                state = "存档";
//            }
//            cell = new Cell(state);
//            table.addCell(cell);
//        }
//        document.add(table);
//        document.close();
//    }

    @SuppressWarnings({"unused", "deprecation"})
    public static void createDepartWordDocument(String rootPath, String realPath, String[] titleArray, List<TSDepart> items,
                                                String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
        document.open();
//		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
        document.setMargins(30f, 30f, 30f, 30f);
        // 设置PDF支持中文 
//		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);

        String root = request.getSession().getServletContext().getRealPath("/");
        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 标题字体风格
        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
        Table table = new Table(titleArray.length + 1);
        table.setWidth(100);//占页面宽度
        table.setAutoFillEmptyCells(true);
        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
        // Paragraph par=new Paragraph();
        // par.add(image);
        // document.add(par);
        // 正文字体风格
        Font font = setChineseFont(root, Color.black);
        Paragraph title = new Paragraph(wordTitle, titleFont);
        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setFont(titleFont);
        table.setPadding(2f);// 设置间距
//		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        document.add(title);

        // 设置表格title
        Cell cell = null;
        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        cell.setHeader(true);
        cell.setBackgroundColor(Color.GRAY);
        table.addCell(cell);
        for (int i = 0; i < titleArray.length; i++) {
            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
            cell.setHeader(true);
            cell.setBackgroundColor(Color.GRAY);
            table.addCell(cell);
        }
        // table.endHeaders();//设置每页显示表格title
        TSDepart d = null;
        for (int i = 0; i < items.size(); i++) {
            d = items.get(i);
            cell = new Cell((i + 1) + "");
            table.addCell(cell);

            cell = new Cell(d.getDepartName());
            table.addCell(cell);

            cell = new Cell(d.getAddress());
            table.addCell(cell);
            cell = new Cell(d.getDescription());
            table.addCell(cell);
        }
        document.add(table);
        document.close();
    }

//    @SuppressWarnings({"unused", "deprecation"})
//    public static void createCWagesMonthWordDocument(String rootPath, String realPath, String[] titleArray, List<CWagesModel> items,
//                                                     String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
//        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
//        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
//        document.open();
////		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
//        document.setMargins(30f, 30f, 30f, 30f);
//        // 设置PDF支持中文 
////		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
//
//        String root = request.getSession().getServletContext().getRealPath("/");
//        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//
//        // 标题字体风格
//        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
//        Table table = new Table(titleArray.length + 1);
//        table.setWidth(100);//占页面宽度
//        table.setAutoFillEmptyCells(true);
//        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
//        // Paragraph par=new Paragraph();
//        // par.add(image);
//        // document.add(par);
//        // 正文字体风格
//        Font font = setChineseFont(root, Color.black);
//        Paragraph title = new Paragraph(wordTitle, titleFont);
//        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        title.setFont(titleFont);
//        table.setPadding(2f);// 设置间距
////		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
////		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        document.add(title);
//
//        // 设置表格title
//        Cell cell = null;
//        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
//        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        cell.setHeader(true);
//        cell.setBackgroundColor(Color.GRAY);
//        table.addCell(cell);
//        for (int i = 0; i < titleArray.length; i++) {
//            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
//            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//            cell.setHeader(true);
//            cell.setBackgroundColor(Color.GRAY);
//            table.addCell(cell);
//        }
//        // table.endHeaders();//设置每页显示表格title
//        CWagesModel d = null;
//        for (int i = 0; i < items.size(); i++) {
//            d = items.get(i);
//            cell = new Cell((i + 1) + "");
//            table.addCell(cell);
//
//            cell = new Cell(d.getMonth().toString());
//            table.addCell(cell);
//
//            cell = new Cell(d.getWages().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getCommission().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getBonus().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getDebit().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getOther().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getXsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getRemark());
//            table.addCell(cell);
//            String checked = null;
//            if (d.getChecked() == 0) {
//                checked = "草稿";
//            } else if (d.getChecked() == 1) {
//                checked = "提交";
//            }
//            cell = new Cell(checked);
//            table.addCell(cell);
//        }
//        document.add(table);
//        document.close();
//    }
//
//    @SuppressWarnings({"unused", "deprecation"})
//    public static void createFinanceWordDocument(String rootPath, String realPath, String[] titleArray, List<CCostModel> items,
//                                                 String wordTitle, HttpServletRequest request) throws DocumentException, IOException {
//        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
//        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
//        document.open();
////		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
//        document.setMargins(30f, 30f, 30f, 30f);
//        // 设置PDF支持中文 
////		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
//
//        String root = request.getSession().getServletContext().getRealPath("/");
//        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//
//        // 标题字体风格
//        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
//        Table table = new Table(titleArray.length + 1);
//        table.setWidth(100);//占页面宽度
//        table.setAutoFillEmptyCells(true);
//        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
//        // Paragraph par=new Paragraph();
//        // par.add(image);
//        // document.add(par);
//        // 正文字体风格
//        Font font = setChineseFont(root, Color.black);
//        Paragraph title = new Paragraph(wordTitle, titleFont);
//        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        title.setFont(titleFont);
//        table.setPadding(2f);// 设置间距
////		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
////		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        document.add(title);
//
//        // 设置表格title
//        Cell cell = null;
//        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
//        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//        cell.setHeader(true);
//        cell.setBackgroundColor(Color.GRAY);
//        table.addCell(cell);
//        for (int i = 0; i < titleArray.length; i++) {
//            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(root, Color.white)));
//            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
//            cell.setHeader(true);
//            cell.setBackgroundColor(Color.GRAY);
//            table.addCell(cell);
//        }
//        // table.endHeaders();//设置每页显示表格title
//        CCostModel d = null;
//        for (int i = 0; i < items.size(); i++) {
//            d = items.get(i);
//            cell = new Cell((i + 1) + "");
//            table.addCell(cell);
//
//            cell = new Cell(d.getProjectName());
//            table.addCell(cell);
//            String state = null;
//            if (d.getState() == 0) {
//                state = "启动";
//            } else if (d.getChecked() == 1) {
//                state = "暂停";
//            } else if (d.getChecked() == 2) {
//                state = "停止";
//            } else if (d.getChecked() == 3) {
//                state = "完成";
//            } else if (d.getChecked() == 4) {
//                state = "存档";
//            }
//            cell = new Cell(state);
//            table.addCell(cell);
//            cell = new Cell(d.getBmoney().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getFcost().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getDevice().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getAuxiliary().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getBox().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getReagent().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getSum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getTaxation().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getCashsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getInsum().toString());
//            table.addCell(cell);
//            cell = new Cell(d.getBbsum().toString());
//            table.addCell(cell);
//        }
//        document.add(table);
//        document.close();
//    }

    // public static void createPdfDocument(String rootPath,String
    // realPath,String[] titleArray,List<DataCheckRecording> items,String
    // titleName) throws DocumentException, IOException{
    // Document document=new Document(PageSize.A4,10,10,10,10);//设置页边距：左、右、上、下
    // PdfWriter write=PdfWriter.getInstance(document, new
    // FileOutputStream(realPath));
    // document.open();
    // //设置PDF支持中文 
    // BaseFont
    // bfChinese=BaseFont.createFont("STSongStd-Light","UniGB-UCS2-H",false);
    // //标题字体风格
    // Font titleFont=new Font(bfChinese, 20,Font.BOLD);
    // Table table=new Table(titleArray.length);
    // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
    // Paragraph par=new Paragraph();
    // par.add(image);
    // document.add(par);
    // Paragraph title=new Paragraph(titleName,titleFont);
    // title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // title.setFont(titleFont);
    // table.setPadding(2f);//设置间距
    // table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // document.add(title);
    // Font font=setChineseFont(rootPath);
    // //设置表格title
    // Cell cell=null;
    // for (int i = 0; i < titleArray.length; i++) {
    // cell=new Cell(new Paragraph(titleArray[i],font));
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // cell.setHeader(true);
    // cell.setBackgroundColor(Color.GRAY);
    // table.addCell(cell);
    // }
    // //table.endHeaders();//设置每页显示表格title
    // DataCheckRecording p=null;
    // for (int i = 0; i <items.size(); i++) {
    // p=items.get(i);
    // cell=new Cell(String.valueOf(i+1));
    // cell.setWidth(90);
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // table.addCell(cell);
    // cell=new Cell(p.getMaterielNo());
    // table.addCell(cell);
    // cell=new Cell(new Paragraph(p.getMaterielName(),font));
    // table.addCell(cell);
    // cell=new Cell(p.getModelSpecification());
    // table.addCell(cell);
    // String quantity=p.getQuantity()!=null ? p.getQuantity().toString() : "0";
    // cell=new Cell(String.valueOf(quantity));
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // table.addCell(cell);
    // cell=new Cell(p.getComment());
    // table.addCell(cell);
    // }
    // document.add(table);
    // document.close();
    //
    // }
    // /**
    // * 维修报告
    // * @param rootPath
    // * @param realPath
    // * @param titleArray
    // * @param items
    // * @param titleName
    // * @throws DocumentException
    // * @throws IOException
    // */
    // public static void createRepairPdfDocument(String rootPath,String
    // realPath,String[] titleArray,ExportRepairRecorder repairRecorder,String
    // titleName) throws DocumentException, IOException{
    // Document document=new Document(PageSize.A4,10,10,10,10);//设置页边距：左、右、上、下
    // PdfWriter write=PdfWriter.getInstance(document, new
    // FileOutputStream(realPath));
    // document.open();
    // //设置PDF支持中文 
    // BaseFont
    // bfChinese=BaseFont.createFont("STSongStd-Light","UniGB-UCS2-H",false);
    // //标题字体风格
    // Font titleFont=new Font(bfChinese, 20,Font.BOLD);
    // Table table=new Table(4);
    // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
    // //image.scaleAbsolute(100, 100);控制图片大小
    // Paragraph par=new Paragraph();
    // par.add(image);
    // document.add(par);
    // Paragraph title=new Paragraph(titleName,titleFont);
    // title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // title.setFont(titleFont);
    // table.setPadding(2f);//设置间距
    // table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // document.add(title);
    // //设置报告编号
    // title=new Paragraph("报告编号："+repairRecorder.getRepairOrderNumber());
    // document.add(title);
    // Font font=setChineseFont(rootPath);
    // //设置表格title
    // Cell cell=null;
    // for (int i = 0; i < titleArray.length; i++) {
    // cell=new Cell(new Paragraph(titleArray[i],font));
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // cell.setHeader(true);
    // cell.setBackgroundColor(Color.GRAY);
    // table.addCell(cell);
    // cell=new Cell(new Paragraph(""));
    // table.addCell(cell);
    // }
    // //table.endHeaders();//设置每页显示表格title
    // DataCheckRecording p=null;
    //// for (int i = 0; i <items.size(); i++) {
    //// p=items.get(i);
    //// cell=new Cell(String.valueOf(i+1));
    //// cell.setWidth(90);
    //// cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    //// cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    //// table.addCell(cell);
    //// cell=new Cell(p.getMaterielNo());
    //// table.addCell(cell);
    //// cell=new Cell(new Paragraph(p.getMaterielName(),font));
    //// table.addCell(cell);
    //// cell=new Cell(p.getModelSpecification());
    //// table.addCell(cell);
    //// String quantity=p.getQuantity()!=null ? p.getQuantity().toString() :
    // "0";
    //// cell=new Cell(String.valueOf(quantity));
    //// cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    //// cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    //// table.addCell(cell);
    //// cell=new Cell(p.getComment());
    //// table.addCell(cell);
    //// }
    // document.add(table);
    // document.close();
    //
    // }
    // public static void createCircuitPdfDocument(String rootPath,String
    // realPath,String[] titleArray,List<DataCheckRecording> items,String
    // titleName) throws DocumentException, IOException{
    // Document document=new Document(PageSize.A4,10,10,10,10);//设置页边距：左、右、上、下
    // PdfWriter write=PdfWriter.getInstance(document, new
    // FileOutputStream(realPath));
    // document.open();
    // //设置PDF支持中文 
    // BaseFont
    // bfChinese=BaseFont.createFont("STSongStd-Light","UniGB-UCS2-H",false);
    // //标题字体风格
    // Font titleFont=new Font(bfChinese, 20,Font.BOLD);
    // Table table=new Table(titleArray.length);
    // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
    // Paragraph par=new Paragraph();
    // par.add(image);
    // document.add(par);
    // Paragraph title=new Paragraph(titleName,titleFont);
    // title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // title.setFont(titleFont);
    // table.setPadding(2f);//设置间距
    // table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // document.add(title);
    // Font font=setChineseFont(rootPath);
    // //设置表格title
    // Cell cell=null;
    // for (int i = 0; i < titleArray.length; i++) {
    // cell=new Cell(new Paragraph(titleArray[i],font));
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // cell.setHeader(true);
    // cell.setBackgroundColor(Color.GRAY);
    // table.addCell(cell);
    // }
    // //table.endHeaders();//设置每页显示表格title
    // DataCheckRecording p=null;
    // for (int i = 0; i <items.size(); i++) {
    // p=items.get(i);
    // cell=new Cell(String.valueOf(i+1));
    // cell.setWidth(90);
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // table.addCell(cell);
    // cell=new Cell(p.getMaterielNo());
    // table.addCell(cell);
    // cell=new Cell(new Paragraph(p.getMaterielName(),font));
    // table.addCell(cell);
    // cell=new Cell(p.getModelSpecification());
    // table.addCell(cell);
    // cell=new Cell(p.getFootprint());
    // table.addCell(cell);
    // cell=new Cell(p.getLocationNo());
    // table.addCell(cell);
    // String quantity=p.getQuantity()!=null ? p.getQuantity().toString() : "0";
    // cell=new Cell(String.valueOf(quantity));
    // cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
    // cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
    // table.addCell(cell);
    // cell=new Cell(p.getComment());
    // table.addCell(cell);
    // }
    // document.add(table);
    // document.close();
    //
    // }
    // public static void readPdfDocument(List<DataCheckRecording> items,String
    // realPath) throws IOException{
    ////
    //// PdfReader reader=new PdfReader(realPath);
    //// List list=SimpleBookmark.getBookmark(reader);
    //// for (java.util.Iterator i=list.iterator() ; i.hasNext();) {
    //// ItextTools.showBookmark((Map) i.next());
    //// }
    //// FileInputStream in=new FileInputStream(realPath);
    //// POIFSFileSystem pfs=new POIFSFileSystem(in);
    //// HWPFDocument hwpf=new HWPFDocument(pfs);
    //// Range range=hwpf.getRange();//获取文档的读取范围
    //// TableIterator it=new TableIterator(range);
    //// while(it.hasNext()){
    //// org.apache.poi.hwpf.usermodel.Table tb=it.next();
    //// for (int i = 0; i < tb.numRows(); i++) {//迭代行
    //// TableRow tr=tb.getRow(i);
    //// for (int j = 0; j < tr.numCells(); j++) {//迭代列
    //// TableCell td=tr.getCell(j);
    //// //System.out.println(td.text());
    //// for (int k = 0; k < td.numParagraphs(); k++) {
    //// org.apache.poi.hwpf.usermodel.Paragraph para=td.getParagraph(k);
    //// String s=para.text();
    //// //System.out.println(s.replaceAll("\r", "").replaceAll(" ","" ));
    //// }
    //// }
    //// }
    //// }
    //
    //
    // }
    // /**
    // * 导出维修报告，采用读取模板的方式
    // * @param rootPath 项目根目录
    // * @param realPath 新文档生成路径
    // * @param picturePath 图片路径
    // * @param repair
    // * @throws DocumentException
    // * @throws IOException
    // */
    // public static void createRepairPdfDocument(String rootPath,String
    // realPath,String picturePath ,Map<String, String> map) throws
    // DocumentException, IOException {
    // String templatePath=rootPath+"dist/repairTemplate.pdf";
    // String newPDFPath=realPath;
    // PdfReader reader;
    // FileOutputStream out;
    // ByteArrayOutputStream bos;
    // PdfStamper stamper;
    // try {
    // out=new FileOutputStream(newPDFPath);
    // reader=new PdfReader(templatePath);//读取模板
    // bos=new ByteArrayOutputStream();
    // stamper=new PdfStamper(reader, bos);
    // AcroFields form=stamper.getAcroFields();
    // //设置中文
    // BaseFont font= BaseFont.createFont(rootPath+"dist/STSONG.TTF",
    // BaseFont.IDENTITY_H, BaseFont.EMBEDDED);//C:\\Windows\\Fonts\\STSONG.TTF
    // ArrayList<BaseFont> fontList = new ArrayList<BaseFont>();
    // fontList.add(font);
    // form.setSubstitutionFonts(fontList);
    // Iterator<String> it= form.getFields().keySet().iterator();
    // int i=0;
    // while(it.hasNext()){
    // String name=it.next().toString();
    // switch (name) {
    // case "faultPicture1":
    // case "faultPicture2":
    // case "faultPicture3":
    // case "faultPicture4":
    // case "processingPicture1":
    // case "processingPicture2":
    // case "processingPicture3":
    // case "processingPicture4":
    // String fileName=map.get(name);
    // if(fileName!=null && StringUtils.isNotBlank(fileName)){
    // Image pic=Image.getInstance(picturePath+"/"+map.get(name));
    // float[] list = form.getFieldPositions(name);
    // PdfContentByte under=stamper.getOverContent(1);
    // float x=list[1];
    // float y=list[2];
    // pic.scaleAbsolute(100, 70);//图片大小 90,70
    // pic.setAbsolutePosition(x+5, y+5);
    // under.addImage(pic);
    // }
    //
    // break;
    //
    // default:
    // form.setField(name, map.get(name));
    // break;
    // }
    //
    // }
    //
    // stamper.setFormFlattening(true);//设置不可编辑
    // stamper.close();
    // Document doc=new Document();
    // PdfCopy copy=new PdfCopy(doc, out);
    // doc.open();
    // PdfImportedPage importedPage=copy.getImportedPage(new
    // PdfReader(bos.toByteArray()), 1);
    // copy.addPage(importedPage);
    // doc.close();
    // System.out.println("生成成功！！！！！！！");
    // } catch (FileNotFoundException e) {
    // e.printStackTrace();
    // } catch (IOException e) {
    // e.printStackTrace();
    // } catch (DocumentException e) {
    // e.printStackTrace();
    // }
    // }
    // public static void showBookmark(Map markBook){
    // ArrayList kids=(ArrayList) markBook.get("Kids");
    // if(kids==null){
    // return;
    // }
    // for(java.util.Iterator i=kids.iterator();i.hasNext();){
    // ItextTools.showBookmark((Map) i.next());
    // }
    // }
    public static Font setChineseFont(String rootPath, Color color) {
        BaseFont bf = null;
        Font font = null;
        try {/// dymanager/WebRoot/dist/STSONG.TTF
            bf = BaseFont.createFont(rootPath + "css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);// C:\\Windows\\Fonts\\STSONG.TTF
            font = new Font(bf, 12, Font.NORMAL);
            font.setColor(color);
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return font;
    }
    //
    //
    // public static void main(String[] args) throws IOException {
    // // ItextTools.readPdfDocument(null,"E:\\xyl\\学习资料\\pack_List.docx");
    //// try {
    //// ItextTools.createWordDocument("F:\\test.doc", null, null);
    //// System.out.println("生成成功");
    //// } catch (FileNotFoundException e) {
    //// // TODO Auto-generated catch block
    //// e.printStackTrace();
    //// } catch (DocumentException e) {
    //// // TODO Auto-generated catch block
    //// e.printStackTrace();
    //// }
    // }

    public static void createOptLogWordDocument(String rootPath, String realPath, String[] titleArray, String wordTitle) throws Exception {
        Document document = new Document(PageSize.A4.rotate());// 设置页边距：左、右、上、下
        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
        document.open();
//		document.setMargins(72f, 42f, 72f, 72f);// 设置页边距，上、下25.4毫米，即为72f，左、右31.8毫米，即为90f
        document.setMargins(30f, 30f, 30f, 30f);
        // 设置PDF支持中文 
//		BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "宋体", false);
        BaseFont bfChinese = BaseFont.createFont(rootPath + "css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        // 标题字体风格
        Font titleFont = new Font(bfChinese, 20, Font.BOLD);
        Table table = new Table(titleArray.length);
        table.setWidth(100);//占页面宽度
        table.setAutoFillEmptyCells(true);
        // Image image=Image.getInstance(rootPath+"dist/img/login_logo.png");
        // Paragraph par=new Paragraph();
        // par.add(image);
        // document.add(par);
        // 正文字体风格
        Font font = setChineseFont(rootPath, Color.black);
        Paragraph title = new Paragraph(wordTitle, titleFont);
        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setFont(titleFont);
        table.setPadding(2f);// 设置间距
//		table.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
//		table.setAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        table.setDefaultHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        table.setDefaultVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        document.add(title);

        // 设置表格title
        Cell cell = null;
        for (int i = 0; i < titleArray.length; i++) {
            cell = new Cell(new Paragraph(titleArray[i], setChineseFont(rootPath, Color.white)));
            cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
            cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
            cell.setHeader(true);
            cell.setBackgroundColor(Color.GRAY);
            table.addCell(cell);
        }
        // table.endHeaders();//设置每页显示表格title
        /*SysUserOperationLog d = null;
        for (int i = 0; i < items.size(); i++) {
			d = items.get(i);
			cell = new Cell(d.getUserName());
			table.addCell(cell);
			cell = new Cell(d.getType());
			table.addCell(cell);
			cell = new Cell(d.getModule());
			table.addCell(cell);
			cell = new Cell(d.getFunc());
			table.addCell(cell);
			cell = new Cell(d.getMethod());
			table.addCell(cell);
			cell = new Cell(d.getRemoteIP());
			table.addCell(cell);
			String optTime = DateUtil.formatDate(d.getOperateTime(), "yyyy-MM-dd HH:mm:ss");
			cell = new Cell(optTime);
			table.addCell(cell);
			cell = new Cell(d.getException());
			table.addCell(cell);
		}*/

        document.add(table);
        document.close();
    }

    public static void exportCode(String realPath, String wordTitle, HttpServletRequest request, String codeJsonArr,Integer codeState) throws Exception {
        int  fontSize = 14;
        if(codeState ==1){
            fontSize =14;
        }else if(codeState ==2){
            fontSize =18;
        }else if(codeState ==3){
            fontSize =22;
        }
        Document document = new Document(PageSize.A4);
        RtfWriter2.getInstance(document, new FileOutputStream(realPath));
        document.open();
        // 设置PDF支持中文 
        String root = request.getSession().getServletContext().getRealPath("/");
        BaseFont bfChinese = BaseFont.createFont(root + "/css/STSONG.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 标题字体风格
        Font titleFont = new Font(bfChinese, 25, Font.BOLD);
        // 正文字体风格
        Paragraph title = new Paragraph(wordTitle, titleFont);

        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.add("\n\r\n\r");
        document.add(title);

        //段落的创建
        Paragraph imageAll = new Paragraph();//创建段落
        imageAll.setAlignment(Paragraph.ALIGN_CENTER);//设置段落剧中
        Font titleFont2 = new Font(bfChinese, fontSize, Font.BOLD);//设置字体样式大小
        //base64编码与图片的转换
        BASE64Decoder decoder = new BASE64Decoder();
        JSONArray json = JSONArray.fromObject(codeJsonArr);
        JSONObject jsonOne = null;
        for (int i = 0; i < json.length(); i++) {// 1.保存所有一级节点并返回新ID
            jsonOne = json.getJSONObject(i);
            String src = jsonOne.getString("src");//二维码base64码
            String name = jsonOne.getString("name");//二维码对应名称
            src = src.replace("data:image/png;base64,", "");//去掉头部
            byte[] decoderBytes = decoder.decodeBuffer(src);//转byte数组
            Image image = Image.getInstance(decoderBytes);//创建图片对象
            image.setDpi(2,5);
            imageAll.add(image);//添加图片进入段落
            imageAll.add("\n\r\n\r");//添加空行
            Paragraph phName = new Paragraph(name, titleFont2);
            imageAll.add(phName);
            imageAll.add("\n\r\n\r\n\r");//添加空行
        }
        document.add(imageAll);
        // 设置表格title
        Cell cell = null;
        cell = new Cell(new Paragraph("序号", setChineseFont(root, Color.white)));
        cell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        cell.setVerticalAlignment(com.lowagie.text.Element.ALIGN_MIDDLE);
        cell.setHeader(true);
        cell.setBackgroundColor(Color.GRAY);
        document.close();
    }
}
