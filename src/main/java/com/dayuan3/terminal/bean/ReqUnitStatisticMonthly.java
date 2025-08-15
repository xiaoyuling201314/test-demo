package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class ReqUnitStatisticMonthly extends BaseBean2 {

    private Date date;

    private Integer insUintId;

    private String insUintName;

    private Integer checkNumber;

    private Integer unqualifiedNumber;

    private String unqualifiedStatistic;

    private String param1;

    private String param2;

    private String param3;

    private Integer checkNumberMonthly;


    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getInsUintId() {
        return insUintId;
    }

    public void setInsUintId(Integer insUintId) {
        this.insUintId = insUintId;
    }

    public String getInsUintName() {
        return insUintName;
    }

    public void setInsUintName(String insUintName) {
        this.insUintName = insUintName == null ? null : insUintName.trim();
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

    public String getUnqualifiedStatistic() {
        return unqualifiedStatistic;
    }

    public void setUnqualifiedStatistic(String unqualifiedStatistic) {
        this.unqualifiedStatistic = unqualifiedStatistic == null ? null : unqualifiedStatistic.trim();
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

    public Integer getCheckNumberMonthly() {
        return checkNumberMonthly;
    }

    public void setCheckNumberMonthly(Integer checkNumberMonthly) {
        this.checkNumberMonthly = checkNumberMonthly;
    }
}