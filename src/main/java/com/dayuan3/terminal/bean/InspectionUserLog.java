package com.dayuan3.terminal.bean;

import java.util.Date;

/**
 * Author: shit
 * Date: 2020-05-06 10:39
 * Content: 送检用户操作日志类
 */
public class InspectionUserLog {
    private Integer id;//主键id
    private Short type;//日志类型0新增 1编辑
    private Short result = 0;//操作结果 0成功1 失败
    private String description;//操作内容
    private Date createDate;//创建时间
    private String createBy;//创建人ID
    private String param1;//预留参数1
    private String param2;//预留参数2
    private String param3;//预留参数3

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public Short getResult() {
        return result;
    }

    public void setResult(Short result) {
        this.result = result;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getParam1() {
        return param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1;
    }

    public String getParam2() {
        return param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2;
    }

    public String getParam3() {
        return param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3;
    }
}
