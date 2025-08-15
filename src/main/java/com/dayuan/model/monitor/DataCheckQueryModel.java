package com.dayuan.model.monitor;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2022-07-26 16:02
 */
public class DataCheckQueryModel {
    /**
     *机构ID
     */
    private Integer departId;
    /**
     *检测点ID
     */
    private Integer pointId;
    /**
     *监管对象ID
     */
    private Integer regId;
    /**
     *每页展示数量
     */
    private int pageSize;
    /**
     *当前页
     */
    private int pageNo = 1;
    /**
     *当前页起始记录(从0开始读取)
     */
    private int rowOffset;
    /**
     *查询开始时间
     */
    private String  startDate;
    /**
     *查询结束时间
     */
    private String endDate;

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getPageSize() {
        return pageSize==0 ? 0 : pageSize;
    }
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }
    public int getPageNo() {
        return pageNo==0 ? 1 : pageNo;
    }

    public int getRowOffset() {
        this.rowOffset = (this.pageNo - 1) * this.pageSize < 0 ? 0 : (this.pageNo - 1) * this.pageSize;
        return rowOffset;
    }

    public void setRowOffset(int rowOffset) {
        this.rowOffset = rowOffset;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
}
