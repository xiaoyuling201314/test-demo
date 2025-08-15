package com.dayuan.bean.dataCheck;

import com.dayuan.bean.BaseBean2;
/**
 * 不合格处理操作
 * @author wangzhenxiong
 *
 * 2017年9月1日
 */
public class DataUnqualifiedConfig extends BaseBean2 {
   
    private String handleName;  //处置方法

    private Short handleType;  //类型：0：无框、1：文本输入框-无单位、2：数字输入框-单位公斤、3：货币输入框-单位元、4：数字输入框-单位天

    private String valueType;  //单位：元、公斤

    private Short sorting;  //排序

    private Short checked;  //0未审核，1审核
    
    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }
    
    public Short getSorting() {
        return sorting;
    }

    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }
    
    public String getHandleName() {
        return handleName;
    }

    public void setHandleName(String handleName) {
        this.handleName = handleName == null ? null : handleName.trim();
    }

    public Short getHandleType() {
        return handleType;
    }

    public void setHandleType(Short handleType) {
        this.handleType = handleType;
    }

    public String getValueType() {
        return valueType;
    }

    public void setValueType(String valueType) {
        this.valueType = valueType == null ? null : valueType.trim();
    }
}