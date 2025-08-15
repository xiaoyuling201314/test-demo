package com.dayuan.model.data;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2023/5/25 16:34
 */
@ExcelIgnoreUnannotated
public class DeviceParameterExportModel {
    @ExcelProperty(value = {"仪器检测项目","编号"}, index = 0)
    private Integer seralNumber;//导出编号
    @ExcelProperty(value = {"仪器检测项目","检测项目"}, index = 1)
    private String itemName;            //检测项目名称

    private String itemId;                //检测项目id
    @ExcelProperty(value ={"仪器检测项目", "检测模块"}, index = 2)
    private String projectType;            //检测模块

    @ExcelProperty(value = {"仪器检测项目","检测方法"}, index = 3)
    private String detectMethod;        //检测方法名称

    @ExcelProperty(value = {"仪器检测项目","检测无效值"}, index = 4)
    private Double invalidValue;        //检测无效值

    @ExcelProperty(value = {"仪器检测项目","阴性T"}, index = 5)
    private Double yint;                //阴性T>

    @ExcelProperty(value = {"仪器检测项目","阳性T"}, index = 6)
    private Double yangt;                //阳性T<=

    @ExcelProperty(value = {"仪器检测项目","预留字段1"}, index = 7)
    private String reserved1;            //预留字段1

    @ExcelProperty(value = {"仪器检测项目","预留字段2"}, index = 8)
    private String reserved2;            //预留字段2

    @ExcelProperty(value = {"仪器检测项目","预留字段3"}, index = 9)
    private String reserved3;            //预留字段3

    @ExcelProperty(value = {"仪器检测项目","检测时间"}, index = 10)
    private Integer decTime;            //检测时间

    @ExcelProperty(value = {"仪器检测项目","选择波长"}, index = 11)
    private Integer wavelength;            //选择波长

    @ExcelProperty(value = {"仪器检测项目","预热时间"}, index = 12)
    private Integer preTime;            //预热时间

    @ExcelProperty(value ={"仪器检测项目", "检测值单位"}, index = 13)
    private String detectUnit;            //检测值单位

    @ExcelProperty(value ={"仪器检测项目", "检测曲线1A0"}, index = 14)
    private Double stda0;                //检测曲线1A0

    @ExcelProperty(value ={"仪器检测项目", "检测曲线1A1"}, index = 15)
    private Double stda1;                //检测曲线1A1

    @ExcelProperty(value ={"仪器检测项目", "检测曲线1A2"}, index = 16)
    private Double stda2;                //检测曲线1A2

    @ExcelProperty(value = {"仪器检测项目","检测曲线1A3"}, index = 17)
    private Double stda3;                //检测曲线1A3

    @ExcelProperty(value ={"仪器检测项目", "标准曲线2B0"}, index = 18)
    private Double stdb0;                //标准曲线2B0

    @ExcelProperty(value = {"仪器检测项目","标准曲线2B1"}, index = 19)
    private Double stdb1;                //标准曲线2B1

    @ExcelProperty(value ={"仪器检测项目", "标准曲线2B2"}, index = 20)
    private Double stdb2;                //标准曲线2B2

    @ExcelProperty(value ={"仪器检测项目", "标准曲线2B3"}, index = 21)
    private Double stdb3;                //标准曲线2B3

    @ExcelProperty(value ={"仪器检测项目", "矫正曲线A"}, index = 22)
    private Double stda;                //矫正曲线A

    @ExcelProperty(value = {"仪器检测项目","矫正曲线B"}, index = 23)
    private Double stdb;                //矫正曲线B

    @ExcelProperty(value = {"仪器检测项目","国标值下限"}, index = 24)
    private Double nationalStdmin;        //国标值下限

    @ExcelProperty(value ={"仪器检测项目", "国标值上限"}, index = 25)
    private Double nationalStdmax;        //国标值上限

    @ExcelProperty(value ={"仪器检测项目", "阴性范围下限"}, index = 26)
    private Double yinMin;                //阴性范围下限

    @ExcelProperty(value = {"仪器检测项目","阴性范围上限"}, index = 27)
    private Double yinMax;                //阴性范围上限

    @ExcelProperty(value = {"仪器检测项目","阳性范围下限"}, index = 28)
    private Double yangMin;                //阳性范围下限

    @ExcelProperty(value ={"仪器检测项目", "阳性范围上限"}, index = 29)
    private Double yangMax;                //阳性范围上限

    @ExcelProperty(value ={"仪器检测项目", "AbsX"}, index = 30)
    private Double absx;                //AbsX

    @ExcelProperty(value ={"仪器检测项目", "|C-T|>AbsX"}, index = 31)
    private Short ctabsx;                //|C-T|>AbsX;0：阴性，1：阳性

    @ExcelProperty(value = {"仪器检测项目","分界值"}, index = 32)
    private Double division;            //分界值

    @ExcelProperty(value = {"仪器检测项目","带入参数"}, index = 33)
    private Short parameter;            //带入参数0:A ,1:B,2:C ,3D

    @ExcelProperty(value = {"仪器检测项目","连续下降沿点数C"}, index = 34)
    private Double trailingedgec;        //连续下降沿点数C

    @ExcelProperty(value = {"仪器检测项目","连续下降沿点数T"}, index = 35)
    private Double trailingedget;        //连续下降沿点数T

    @ExcelProperty(value ={"仪器检测项目", "数据可疑Min"}, index = 36)
    private Double suspiciousmin;        //数据可疑Min

    @ExcelProperty(value = {"仪器检测项目","数据可疑Max"}, index = 37)
    private Double suspiciousmax;        //数据可疑Max

    public Integer getSeralNumber() {
        return seralNumber;
    }

    public void setSeralNumber(Integer seralNumber) {
        this.seralNumber = seralNumber;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getProjectType() {
        return projectType;
    }

    public void setProjectType(String projectType) {
        this.projectType = projectType;
    }

    public String getDetectMethod() {
        return detectMethod;
    }

    public void setDetectMethod(String detectMethod) {
        this.detectMethod = detectMethod;
    }

    public String getDetectUnit() {
        return detectUnit;
    }

    public void setDetectUnit(String detectUnit) {
        this.detectUnit = detectUnit;
    }

    public Double getInvalidValue() {
        return invalidValue;
    }

    public void setInvalidValue(Double invalidValue) {
        this.invalidValue = invalidValue;
    }

    public Integer getWavelength() {
        return wavelength;
    }

    public void setWavelength(Integer wavelength) {
        this.wavelength = wavelength;
    }

    public Integer getPreTime() {
        return preTime;
    }

    public void setPreTime(Integer preTime) {
        this.preTime = preTime;
    }

    public Integer getDecTime() {
        return decTime;
    }

    public void setDecTime(Integer decTime) {
        this.decTime = decTime;
    }

    public Double getStda0() {
        return stda0;
    }

    public void setStda0(Double stda0) {
        this.stda0 = stda0;
    }

    public Double getStda1() {
        return stda1;
    }

    public void setStda1(Double stda1) {
        this.stda1 = stda1;
    }

    public Double getStda2() {
        return stda2;
    }

    public void setStda2(Double stda2) {
        this.stda2 = stda2;
    }

    public Double getStda3() {
        return stda3;
    }

    public void setStda3(Double stda3) {
        this.stda3 = stda3;
    }

    public Double getStdb0() {
        return stdb0;
    }

    public void setStdb0(Double stdb0) {
        this.stdb0 = stdb0;
    }

    public Double getStdb1() {
        return stdb1;
    }

    public void setStdb1(Double stdb1) {
        this.stdb1 = stdb1;
    }

    public Double getStdb2() {
        return stdb2;
    }

    public void setStdb2(Double stdb2) {
        this.stdb2 = stdb2;
    }

    public Double getStdb3() {
        return stdb3;
    }

    public void setStdb3(Double stdb3) {
        this.stdb3 = stdb3;
    }

    public Double getStda() {
        return stda;
    }

    public void setStda(Double stda) {
        this.stda = stda;
    }

    public Double getStdb() {
        return stdb;
    }

    public void setStdb(Double stdb) {
        this.stdb = stdb;
    }

    public Double getNationalStdmin() {
        return nationalStdmin;
    }

    public void setNationalStdmin(Double nationalStdmin) {
        this.nationalStdmin = nationalStdmin;
    }

    public Double getNationalStdmax() {
        return nationalStdmax;
    }

    public void setNationalStdmax(Double nationalStdmax) {
        this.nationalStdmax = nationalStdmax;
    }

    public Double getYinMin() {
        return yinMin;
    }

    public void setYinMin(Double yinMin) {
        this.yinMin = yinMin;
    }

    public Double getYinMax() {
        return yinMax;
    }

    public void setYinMax(Double yinMax) {
        this.yinMax = yinMax;
    }

    public Double getYangMin() {
        return yangMin;
    }

    public void setYangMin(Double yangMin) {
        this.yangMin = yangMin;
    }

    public Double getYangMax() {
        return yangMax;
    }

    public void setYangMax(Double yangMax) {
        this.yangMax = yangMax;
    }

    public Double getYint() {
        return yint;
    }

    public void setYint(Double yint) {
        this.yint = yint;
    }

    public Double getYangt() {
        return yangt;
    }

    public void setYangt(Double yangt) {
        this.yangt = yangt;
    }

    public Double getAbsx() {
        return absx;
    }

    public void setAbsx(Double absx) {
        this.absx = absx;
    }

    public Short getCtabsx() {
        return ctabsx;
    }

    public void setCtabsx(Short ctabsx) {
        this.ctabsx = ctabsx;
    }

    public Double getDivision() {
        return division;
    }

    public void setDivision(Double division) {
        this.division = division;
    }

    public Short getParameter() {
        return parameter;
    }

    public void setParameter(Short parameter) {
        this.parameter = parameter;
    }

    public Double getTrailingedgec() {
        return trailingedgec;
    }

    public void setTrailingedgec(Double trailingedgec) {
        this.trailingedgec = trailingedgec;
    }

    public Double getTrailingedget() {
        return trailingedget;
    }

    public void setTrailingedget(Double trailingedget) {
        this.trailingedget = trailingedget;
    }

    public Double getSuspiciousmin() {
        return suspiciousmin;
    }

    public void setSuspiciousmin(Double suspiciousmin) {
        this.suspiciousmin = suspiciousmin;
    }

    public Double getSuspiciousmax() {
        return suspiciousmax;
    }

    public void setSuspiciousmax(Double suspiciousmax) {
        this.suspiciousmax = suspiciousmax;
    }

    public String getReserved1() {
        return reserved1;
    }

    public void setReserved1(String reserved1) {
        this.reserved1 = reserved1;
    }

    public String getReserved2() {
        return reserved2;
    }

    public void setReserved2(String reserved2) {
        this.reserved2 = reserved2;
    }

    public String getReserved3() {
        return reserved3;
    }

    public void setReserved3(String reserved3) {
        this.reserved3 = reserved3;
    }


    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

}
