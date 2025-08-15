package com.dayuan.model.wx.inspection;

import com.dayuan.common.WebConstant;
import com.dayuan.model.BaseModel;

import java.util.Date;

/**
 * 抽样信息
 * Description:
 *
 * @author dy
 * @Company: 食安科技
 * @date 2018年08月08日
 */
public class WxTbSamplingModel extends BaseModel {
    private Integer id;

    private String samplingNO;           //抽样单号

    private Integer foodId;              //样品ID

    private String foodName;             //样品名称

    private Date samplingDate;           //送检时间

    private String itemId;               //抽检项目ID

    private String itemName;             //抽检项目名称

    private String conclusion;           //检测结果

    private String qrcode;               //二维码图片

    private String samplingUsername;     //抽样人

    private String regName;              //送检人

    private String pointName;            //抽样单位

    private String opeShopName;          //地址

    private String opePhone;             //微信

    private String regLinkPhone;         //联系电话

    private String inspectionStatus;     //检测状态

    private Integer total;               //总批次

    private Integer completionNum;       //已经完成批次

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getCompletionNum() {
        return completionNum;
    }

    public void setCompletionNum(Integer completionNum) {
        this.completionNum = completionNum;
    }

    public String getInspectionStatus() {
        return inspectionStatus;
    }

    public void setInspectionStatus(String inspectionStatus) {
        this.inspectionStatus = inspectionStatus;
    }

    public String getOpeShopName() {
        return opeShopName;
    }

    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName;
    }

    public String getOpePhone() {
        return opePhone;
    }

    public void setOpePhone(String opePhone) {
        this.opePhone = opePhone;
    }

    public String getRegLinkPhone() {
        return regLinkPhone;
    }

    public void setRegLinkPhone(String regLinkPhone) {
        this.regLinkPhone = regLinkPhone;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public Date getSamplingDate() {
        return samplingDate;
    }

    public void setSamplingDate(Date samplingDate) {
        this.samplingDate = samplingDate;
    }

    public String getSamplingUsername() {
        return samplingUsername;
    }

    public void setSamplingUsername(String samplingUsername) {
        this.samplingUsername = samplingUsername;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        String rootPath = "/resources" + WebConstant.res.getString("samplingQr");
        this.qrcode = rootPath + qrcode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSamplingNO() {
        return samplingNO;
    }

    public void setSamplingNO(String samplingNO) {
        this.samplingNO = samplingNO;
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

    public String getConclusion() {
        return conclusion;
    }

    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }
}