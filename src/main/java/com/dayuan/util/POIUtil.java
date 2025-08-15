package com.dayuan.util;

import org.apache.poi.xwpf.usermodel.*;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;

import java.math.BigInteger;

/**
 * POI工具类
 * @author Dz
 * @date 2021年07月23日
 */
public class POIUtil {

    /**
     * 设置页面大小间距
     * @param doc   文本对象
     * @param w 页面宽度
     * @param h 页面高度
     * @param top   上边距
     * @param bottom    下边距
     * @param left  左边距
     * @param right 右边距
     */
    public static void  setPageSize(XWPFDocument doc, int w, int h, int top, int bottom, int left, int right){
        // 设置页面大小间距
        CTDocument1 document = doc.getDocument();
        CTBody body = document.getBody();
        if (!body.isSetSectPr()) {
            body.addNewSectPr();
        }
        CTSectPr section = body.getSectPr();
        if(!section.isSetPgSz()) {
            section.addNewPgSz();
        }
        // 设置页面大小  当前A4大小
        CTPageSz pageSize = section.getPgSz();
        pageSize.setW(BigInteger.valueOf(w));
        pageSize.setH(BigInteger.valueOf(h));
        pageSize.setOrient(STPageOrientation.PORTRAIT);
        // 设置 页边间距
        CTSectPr sectPr = body.addNewSectPr();
        CTPageMar pageMar = sectPr.addNewPgMar();
        pageMar.setTop(BigInteger.valueOf(top));
        pageMar.setBottom(BigInteger.valueOf(bottom));
        pageMar.setLeft(BigInteger.valueOf(left));
        pageMar.setRight(BigInteger.valueOf(right));

    }

    /**
     * 设置单元格列宽
     * @param cell 单元格
     * @param width 宽度
     * @param vAlign    垂直对齐
     * @param sEnum  水平对齐
     */
    public static void setCellWidthAndVAlign(XWPFTableCell cell, int width, XWPFTableCell.XWPFVertAlign vAlign, STJc.Enum sEnum) {
        cell.setVerticalAlignment(vAlign);

        CTTc cttc = cell.getCTTc();
        CTTcPr cellPr = cttc.addNewTcPr();
        CTTblWidth tblWidth = cellPr.isSetTcW() ? cellPr.getTcW() : cellPr.addNewTcW();
        tblWidth.setW(BigInteger.valueOf(width));
        tblWidth.setType(STTblWidth.DXA);

        CTP ctp = cttc.getPList().get(0);
        CTPPr ctppr = ctp.getPPr();
        if (ctppr == null) {
            ctppr = ctp.addNewPPr();
        }
        CTJc ctjc = ctppr.getJc();
        if (ctjc == null) {
            ctjc = ctppr.addNewJc();
        }
        ctjc.setVal(sEnum);
    }

    /**
     * @Description: 设置段落的对齐方式
     */
    public static void setParagraphVAlign(XWPFParagraph p) {
        // 设置段落的水平对齐方式
        p.setAlignment(ParagraphAlignment.CENTER);
        // 设置段落的垂直对齐方式
        p.setVerticalAlignment(TextAlignment.CENTER);
    }

}
