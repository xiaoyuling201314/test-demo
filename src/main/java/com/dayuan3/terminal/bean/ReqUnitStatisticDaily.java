package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class ReqUnitStatisticDaily extends BaseBean2 {

    /**
     * 统计日期
     */
    private Date date;

    /**
     * 委托单位ID
     */
    private Integer insUintId;

    /**
     * 委托单位
     */
    private String insUintName;

    /**
     * 检测数量
     */
    private Integer checkNumber;

    /**
     * 不合格数量
     */
    private Integer unqualifiedNumber;

    private String unqualifiedStatistic;

    private String param1;

    private String param2;

    private String param3;

    /**
     * 每天计划检测数量
     */
    private Integer checkNumberDaily;

    /**************************** 非表字段 ****************************/
    /**
     * 检测率
     */
    private Double checkRate;
    /**
     * 合格率
     */
    private Double passRate;

    private Short unitType;//单位类型1:餐饮 2:学校 3:食堂 4:供应商 9:其他 shit添加

    private Short coverageType;////覆盖类型：0日覆盖，1周覆盖、2月覆盖
    public ReqUnitStatisticDaily() {
    }

    public ReqUnitStatisticDaily(Date date, Integer insUintId, String insUintName, Integer checkNumber, Integer unqualifiedNumber, String unqualifiedStatistic, String param1, String param2, String param3, Integer checkNumberDaily) {
        this.date = date;
        this.insUintId = insUintId;
        this.insUintName = insUintName;
        this.checkNumber = checkNumber;
        this.unqualifiedNumber = unqualifiedNumber;
        this.unqualifiedStatistic = unqualifiedStatistic;
        this.param1 = param1;
        this.param2 = param2;
        this.param3 = param3;
        this.checkNumberDaily = checkNumberDaily;
    }

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

    public Integer getCheckNumberDaily() {
        return checkNumberDaily;
    }

    public void setCheckNumberDaily(Integer checkNumberDaily) {
        this.checkNumberDaily = checkNumberDaily;
    }

    public Double getCheckRate() {
        return checkRate;
    }

    public void setCheckRate(Double checkRate) {
        this.checkRate = checkRate;
    }

    public Short getUnitType() {
        return unitType;
    }

    public void setUnitType(Short unitType) {
        this.unitType = unitType;
    }

    public Double getPassRate() {
        return passRate;
    }

    public void setPassRate(Double passRate) {
        this.passRate = passRate;
    }

	public Short getCoverageType() {
		return coverageType;
	}

	public void setCoverageType(Short coverageType) {
		this.coverageType = coverageType;
	}
    
}