package com.dayuan.bean.statistics;

import com.dayuan.bean.BaseBean2;

public class DataMonthlyStatistics extends BaseBean2 {

    private String yyyyMm;

    private Integer departId;

    private Integer samplingNumber;

    private Integer checkNumber;

    private Integer unqualifiedNumber;

    private String param1;

    private String param2;

    private String param3;

    public String getYyyyMm() {
        return yyyyMm;
    }

    public void setYyyyMm(String yyyyMm) {
        this.yyyyMm = yyyyMm == null ? null : yyyyMm.trim();
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getSamplingNumber() {
        return samplingNumber;
    }

    public void setSamplingNumber(Integer samplingNumber) {
        this.samplingNumber = samplingNumber;
    }

    public Integer getCheckNumber() {
        return checkNumber;
    }

    public void setCheckNumber(Integer checkNumber) {
        this.checkNumber = checkNumber;
    }

    public Integer getUnqualifiedNumber() {
        return unqualifiedNumber;
    }

    public void setUnqualifiedNumber(Integer unqualifiedNumber) {
        this.unqualifiedNumber = unqualifiedNumber;
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}