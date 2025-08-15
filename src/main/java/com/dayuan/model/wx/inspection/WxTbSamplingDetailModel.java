package com.dayuan.model.wx.inspection;

import com.dayuan.model.BaseModel;

/**
 * 抽样明细
 * Description:
 *
 * @author dy
 * @Company: 食安科技
 * @date 2018年08月08日
 */
public class WxTbSamplingDetailModel extends BaseModel {
    private Integer id;

    private String foodName;             //样品名称

    private String itemName;             //抽检项目名称

    private String conclusion;           //检测结果

    private String opeShopName;           //档口名称

    private String checkResult;  //检测结果(检测值)

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getOpeShopName() {
        return opeShopName;
    }

    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName;
    }

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


    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getConclusion() {
        return conclusion;
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }
}