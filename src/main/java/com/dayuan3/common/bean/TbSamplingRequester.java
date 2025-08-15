package com.dayuan3.common.bean;

import java.util.Date;

/**
 * 订单与委托单位关联表
 * @author xiaoyl
 * @date   2019年12月28日
 */
public class TbSamplingRequester {
	
    public TbSamplingRequester() {
		super();
	}

	public TbSamplingRequester(Integer samplingId, Integer requestId, String requestName, String createBy,
			Date createDate, String updateBy, Date updateDate,String param1,String param2) {
		super();
		this.samplingId = samplingId;
		this.requestId = requestId;
		this.requestName = requestName;
		this.createBy = createBy;
		this.createDate = createDate;
		this.updateBy = updateBy;
		this.updateDate = updateDate;
		this.param1=param1;
		this.param2=param2;
	}

	/**
     * 
     */
    private Integer id;

    /**
     * 订单ID
     */
    private Integer samplingId;

    /**
     * 委托单位ID
     */
    private Integer requestId;

    /**
     * 委托单位名称
     */
    private String requestName;

    /**
     * 预留参数1：委托单位联系电话
     */
    private String param1;

    /**
     * 预留参数2：委托单位地址
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;

    /**
     * 删除状态：0_未删除,1_已删除
     */
    private Short deleteFlag=0;

    /**
     * 创建人ID
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改人ID
     */
    private String updateBy;

    /**
     * 修改时间
     */
    private Date updateDate;
    /***************************非数据库字段*************************************/
    /**
     * 	委托单位打印记录表ID
     */
    private Integer printId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(Integer samplingId) {
        this.samplingId = samplingId;
    }

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public String getRequestName() {
        return requestName;
    }

    public void setRequestName(String requestName) {
        this.requestName = requestName == null ? null : requestName.trim();
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

    public Short getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

	public Integer getPrintId() {
		return printId;
	}

	public void setPrintId(Integer printId) {
		this.printId = printId;
	}
    
}