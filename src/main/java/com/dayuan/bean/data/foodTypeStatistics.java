package com.dayuan.bean.data;

import com.dayuan.bean.BaseBean;

public class foodTypeStatistics extends BaseBean{
	private String foodName;
	
	private int num;
	
	private int qualified;
	
	private int unqualified;

	private double purchaseAmount;//抽样基数，汇总抽样明细的进货数量 add by xiaoyl 2020/11/17

	private double destoryNumber;//销毁数量，汇总不合格处理的销毁或下架数量 add by xiaoyl 2020/11/17

	private String unqualifiedFood;//阳性样品 add by xiaoyl 2020/11/17
	
	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getQualified() {
		return qualified;
	}

	public void setQualified(int qualified) {
		this.qualified = qualified;
	}

	public int getUnqualified() {
		return unqualified;
	}

	public void setUnqualified(int unqualified) {
		this.unqualified = unqualified;
	}

	public double getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(double purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}

	public double getDestoryNumber() {
		return destoryNumber;
	}

	public void setDestoryNumber(double destoryNumber) {
		this.destoryNumber = destoryNumber;
	}

	public String getUnqualifiedFood() {
		return unqualifiedFood;
	}

	public void setUnqualifiedFood(String unqualifiedFood) {
		this.unqualifiedFood = unqualifiedFood;
	}
}
