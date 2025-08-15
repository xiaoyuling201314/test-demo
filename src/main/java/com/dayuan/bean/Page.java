package com.dayuan.bean;

import com.dayuan.common.WebConstant;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 分页模型
 * @author Dz
 *
 */
public class Page {
	
	private int rowTotal = 0;	//记录总数
	private int pageSize = 10;	//每页数量
	private int pageNo = 1;	//当前页序号
	private int pageCount = 1; // 总页数
	private int rowOffset = 0;// 当前页起始记录(从0开始读取)
	private int rowTail = 0;// 当前页到达的记录(从0开始读取)
	private String order = "desc"; //排序
	private Object obj;	//条件对象
	private List<?> results; //查询结果
	private Map<String, String> dateMap; //时间范围查询条件
	
	private String db= WebConstant.res.getString("db1");
	
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
	public int getRowTotal() {
		return rowTotal;
	}
	public void setRowTotal(int rowTotal) {
		this.rowTotal = rowTotal;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getRowOffset() {
		this.rowOffset = (this.pageNo - 1) * this.pageSize < 0 ? 0 : (this.pageNo - 1) * this.pageSize;
		return rowOffset;
	}
	public void setRowOffset(int rowOffset) {
		this.rowOffset = rowOffset;
	}
	public int getRowTail() {
		this.rowTail = this.rowOffset + this.pageSize - 1;
		if ((this.rowOffset + this.pageSize) > this.rowTotal - 1) {
			this.rowTail = this.rowTotal - 1;
		}
		return rowTail;
	}
	public void setRowTail(int rowTail) {
		this.rowTail = rowTail;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public List<?> getResults() {
		return results;
	}
	public void setResults(List<?> results) {
		this.results = results;
	}
	public Map<String, String> getDateMap() {
		return dateMap;
	}
	public void setDateMap(Map<String, String> dateMap) {
		this.dateMap = dateMap;
	}

}
