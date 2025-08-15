package com.dayuan3.common.bean;

/**
 * 自助终端--所有样品信息
 * @author xiaoyl
 * @date   2019年7月23日
 */
public class TerminalBaseFood {
	private Integer id; //食品id
	
    private String foodName;  //食品种类名称

    private String foodNameEn;  //食品种类英文名称

    private String foodNameOther;  //食品种类别名
    
    private String foodFirstLetter;//样品首字母

    private String foodFullLetter; //样品全拼音

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getFoodNameEn() {
		return foodNameEn;
	}

	public void setFoodNameEn(String foodNameEn) {
		this.foodNameEn = foodNameEn;
	}

	public String getFoodNameOther() {
		return foodNameOther;
	}

	public void setFoodNameOther(String foodNameOther) {
		this.foodNameOther = foodNameOther;
	}

	public String getFoodFirstLetter() {
		return foodFirstLetter;
	}

	public void setFoodFirstLetter(String foodFirstLetter) {
		this.foodFirstLetter = foodFirstLetter;
	}

	public String getFoodFullLetter() {
		return foodFullLetter;
	}

	public void setFoodFullLetter(String foodFullLetter) {
		this.foodFullLetter = foodFullLetter;
	}

	
}