package com.dayuan.model.data;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2023/5/25 16:34
 */
@ExcelIgnoreUnannotated
public class DeviceParameterFaildModel extends DeviceParameterExportModel {

    @ExcelProperty(value = {"仪器检测项目","导入失败原因"}, index = 38)
    private String errMsg;              //导入失败原因

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }
}
