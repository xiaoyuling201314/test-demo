package com.dayuan3.common.model;

import com.dayuan.model.BaseModel;

/**
 * 	交易明细查询条件Model
 * @author xiaoyl
 * @date   2019年10月31日
 */
public class AccountFlowQueryModel extends BaseModel {
	

	/**
	 * 用户ID
	 */
	private Integer userId;
	/**
	 * 查询类型：0 交易明细，1充值记录
	 */
	private Integer status;
	/**
	 * 分页起始位置
	 */
	private Integer rowStart;
	/**
	 * 分页结束为止
	 */
	private Integer rowEnd;
	/**
	 * 查询日期
	 */
	private String queryDate;
	/**
	 * 查询时间范围开始
	 */
	private String startDate;
	/**
	 * 查询时间范围结束
	 */
	private String endDate;
	
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
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getRowStart() {
		return rowStart;
	}
	public void setRowStart(Integer rowStart) {
		this.rowStart = rowStart;
	}
	public Integer getRowEnd() {
		return rowEnd;
	}
	public void setRowEnd(Integer rowEnd) {
		this.rowEnd = rowEnd;
	}
	public String getQueryDate() {
		return queryDate;
	}
	public void setQueryDate(String queryDate) {
		this.queryDate = queryDate;
	}
	
}