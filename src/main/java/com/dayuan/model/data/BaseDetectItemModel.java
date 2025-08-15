package com.dayuan.model.data;

import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.model.BaseModel;
/**
 * 检测标准
 * @author Bill
 *
 * 2017年7月31日
 */
public class BaseDetectItemModel extends BaseModel {
	
    private BaseDetectItem baseDetectItem;

    private String foodId;//食品分类ID，用于查询未选择的检测项目
    
	public BaseDetectItem getBaseDetectItem() {
		return baseDetectItem;
	}

	public void setBaseDetectItem(BaseDetectItem baseDetectItem) {
		this.baseDetectItem = baseDetectItem;
	}

	public String getFoodId() {
		return foodId;
	}

	public void setFoodId(String foodId) {
		this.foodId = foodId;
	}
    
}