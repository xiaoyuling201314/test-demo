package com.dayuan.model.task;

public class TaskProgressModel {

	//主任务-ID
	private Integer id;
	//主任务-上级任务ID
	private Integer pid;
	//主任务-标题
	private String title;
	//主任务-状态
	private Integer status;
	//主任务-任务数量
	private Integer total;
	//主任务-已检测数量
	private Integer number;

	//任务明细-ID
	private Integer tdId;
	//任务明细-样品ID
	private Integer foodId;
	//任务明细-样品
	private String foodName;
	//任务明细-检测项目ID
	private String itemId;
	//任务明细-检测项目
	private String itemName;
	//任务明细-任务数量
	private Integer tdTotal;
	//任务明细-已检测数量
	private Integer tdNumber;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getTdId() {
		return tdId;
	}

	public void setTdId(Integer tdId) {
		this.tdId = tdId;
	}

	public Integer getFoodId() {
		return foodId;
	}

	public void setFoodId(Integer foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getTdTotal() {
		return tdTotal;
	}

	public void setTdTotal(Integer tdTotal) {
		this.tdTotal = tdTotal;
	}

	public Integer getTdNumber() {
		return tdNumber;
	}

	public void setTdNumber(Integer tdNumber) {
		this.tdNumber = tdNumber;
	}
}
