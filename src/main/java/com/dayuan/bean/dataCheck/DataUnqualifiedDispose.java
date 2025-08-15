package com.dayuan.bean.dataCheck;


import com.dayuan.bean.BaseBean2;
/**
 * 不合格处置
 * @author wangzhenxiong
 *
 * 2017年9月5日
 */
public class DataUnqualifiedDispose  extends BaseBean2 {
	
    private Integer unid;  //不合格处理ID

    private Integer checkRecordingId;  //检测数据ID

    private Integer disposeId;  //处置id

    private String disposeValue;  //处置内容

    private Double disposeValue1;  //值

    private String disposeType;  //单位


    public Integer getUnid() {
        return unid;
    }

    public void setUnid(Integer unid) {
        this.unid = unid;
    }

    public Integer getCheckRecordingId() {
        return checkRecordingId;
    }

    public void setCheckRecordingId(Integer checkRecordingId) {
        this.checkRecordingId = checkRecordingId;
    }

    public Integer getDisposeId() {
        return disposeId;
    }

    public void setDisposeId(Integer disposeId) {
        this.disposeId = disposeId;
    }

    public String getDisposeValue() {
        return disposeValue;
    }

    public void setDisposeValue(String disposeValue) {
        this.disposeValue = disposeValue == null ? null : disposeValue.trim();
    }

    public Double getDisposeValue1() {
        return disposeValue1;
    }

    public void setDisposeValue1(Double disposeValue1) {
        this.disposeValue1 = disposeValue1;
    }

    public String getDisposeType() {
        return disposeType;
    }

    public void setDisposeType(String disposeType) {
        this.disposeType = disposeType == null ? null : disposeType.trim();
    }
}