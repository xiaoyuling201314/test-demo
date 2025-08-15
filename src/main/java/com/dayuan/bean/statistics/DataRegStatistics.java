package com.dayuan.bean.statistics;

import com.dayuan.bean.BaseBean2;

public class DataRegStatistics extends BaseBean2 {

    private String yyyyMm;

    private Integer regId;

    private String regName;

    private Integer rCheckNum;

    private Integer rUnqualifiedNum;

    private String rUnqualifiedRate;

    private Integer stallAllNum;

    private Integer stallCheckNum;

    private Integer stallUncheckNum;

    private String stallCheckRate;
    
    private String stallStatistics;

    private Integer foodAllNum;

    private Integer foodCheckNum;

    private Integer foodUncheckNum;

    private String foodCheckRate;

    private String foodStatistics;

    private String param1;

    private String param2;

    private String param3;

    public String getYyyyMm() {
        return yyyyMm;
    }

    public void setYyyyMm(String yyyyMm) {
        this.yyyyMm = yyyyMm == null ? null : yyyyMm.trim();
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName == null ? null : regName.trim();
    }

    public Integer getrCheckNum() {
        return rCheckNum;
    }

    public void setrCheckNum(Integer rCheckNum) {
        this.rCheckNum = rCheckNum;
    }

    public Integer getrUnqualifiedNum() {
        return rUnqualifiedNum;
    }

    public void setrUnqualifiedNum(Integer rUnqualifiedNum) {
        this.rUnqualifiedNum = rUnqualifiedNum;
    }

    public String getrUnqualifiedRate() {
        return rUnqualifiedRate;
    }

    public void setrUnqualifiedRate(String rUnqualifiedRate) {
        this.rUnqualifiedRate = rUnqualifiedRate == null ? null : rUnqualifiedRate.trim();
    }

    public Integer getStallAllNum() {
        return stallAllNum;
    }

    public void setStallAllNum(Integer stallAllNum) {
        this.stallAllNum = stallAllNum;
    }

    public Integer getStallCheckNum() {
        return stallCheckNum;
    }

    public void setStallCheckNum(Integer stallCheckNum) {
        this.stallCheckNum = stallCheckNum;
    }

    public Integer getStallUncheckNum() {
        return stallUncheckNum;
    }

    public void setStallUncheckNum(Integer stallUncheckNum) {
        this.stallUncheckNum = stallUncheckNum;
    }

    public String getStallCheckRate() {
        return stallCheckRate;
    }

    public void setStallCheckRate(String stallCheckRate) {
        this.stallCheckRate = stallCheckRate == null ? null : stallCheckRate.trim();
    }

    public Integer getFoodAllNum() {
        return foodAllNum;
    }

    public void setFoodAllNum(Integer foodAllNum) {
        this.foodAllNum = foodAllNum;
    }

    public Integer getFoodCheckNum() {
        return foodCheckNum;
    }

    public void setFoodCheckNum(Integer foodCheckNum) {
        this.foodCheckNum = foodCheckNum;
    }

    public Integer getFoodUncheckNum() {
        return foodUncheckNum;
    }

    public void setFoodUncheckNum(Integer foodUncheckNum) {
        this.foodUncheckNum = foodUncheckNum;
    }

    public String getFoodCheckRate() {
        return foodCheckRate;
    }

    public void setFoodCheckRate(String foodCheckRate) {
        this.foodCheckRate = foodCheckRate == null ? null : foodCheckRate.trim();
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
    
    public String getStallStatistics() {
        return stallStatistics;
    }

    public void setStallStatistics(String stallStatistics) {
        this.stallStatistics = stallStatistics == null ? null : stallStatistics.trim();
    }

    public String getFoodStatistics() {
        return foodStatistics;
    }

    public void setFoodStatistics(String foodStatistics) {
        this.foodStatistics = foodStatistics == null ? null : foodStatistics.trim();
    }
    
}