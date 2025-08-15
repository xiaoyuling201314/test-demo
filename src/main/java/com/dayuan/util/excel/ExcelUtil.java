package com.dayuan.util.excel;

import com.alibaba.excel.write.metadata.style.WriteCellStyle;
import com.alibaba.excel.write.metadata.style.WriteFont;
import com.alibaba.excel.write.style.HorizontalCellStyleStrategy;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2023/5/26 13:25
 */
public  class ExcelUtil {
    /**
     * 自定义Excel导出策略，设置表头和数据行的字体和高度
     *
     * @return Excel导出策略
     */
    public static HorizontalCellStyleStrategy getHeightAndFontStrategy() {
        //设置表头样式
        WriteCellStyle headWriteCellStyle = new WriteCellStyle();
        WriteFont headWriteFont = new WriteFont();
        headWriteFont.setFontHeightInPoints((short) 11);//字体大小
        headWriteFont.setBold(true);//加粗
        headWriteCellStyle.setWriteFont(headWriteFont);
        // 背景设置为白色
        headWriteCellStyle.setFillForegroundColor(IndexedColors.WHITE.index);

        //设置内容样式
        WriteCellStyle contentWriteCellStyle = new WriteCellStyle();
        WriteFont contentWriteFont = new WriteFont();
        contentWriteFont.setFontHeightInPoints((short) 11);
        contentWriteCellStyle.setWriteFont(contentWriteFont);
        contentWriteCellStyle.setHorizontalAlignment(HorizontalAlignment.CENTER);
        return new HorizontalCellStyleStrategy(headWriteCellStyle, contentWriteCellStyle);
    }
}
