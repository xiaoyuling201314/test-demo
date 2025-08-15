package com.dayuan.model.sampling;

import com.dayuan.bean.sampling.TbSamplingDetail;

import java.util.Date;

/**
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年9月16日
 */
public class TbSamplingDetailReport extends TbSamplingDetail {

     private Integer id; //主键ID

    /*
     *
     * private String foodName; //样品名称
     *
     * private BigDecimal sampleNumber; //抽样数量（公斤）
     *
     * private BigDecimal purchaseAmount; //进货数量（公斤）
     */
    private String purchaseAmountStr; //进货数量（公斤）

    private Date checkDate; // 检测时间

    private String checkUsername; // 检测人员

    private String itemNames; // 抽检项目名称

    private String limitValue; // 限定值

    private String checkResult; // 检测结果(检测值)

    private String checkUnit; // 检测结果单位

    private String conclusion; // 检测结论

    private int samplingCount; // 检测项目统计

    private int detectCount; // 检测记录统计

    private int unqualifiedCount;// 不合格记录统计

    private int recevieCount; // 接收数量统计

    private Short scanNum; // 查看报告次数

    private String stdCode;//标准号

    /*************************检测数据所对应的检测点名称、地址、电话信息，用于打印送检报告使用***********************************************/

    private String pointName;//检测点名称

    private String pointAddress;//检测点地址

    private String pointPhone;//检测点电话

    private String reviewImage;//	审核人员签名，base64字符串

    private String approveImage;//批准人员签名，base64字符串

    private String signatureImage;// 电子签章，base64字符串

    private Integer rdataId;//数据报告关联ID

    private Integer isCustomItem = 0;//是否自定义检测项目：0 否，1 是

    private Integer itemNumber;//自定义检测项目数量

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public String getCheckUsername() {
        return checkUsername;
    }

    public void setCheckUsername(String checkUsername) {
        this.checkUsername = checkUsername;
    }

    public String getItemNames() {
        return itemNames;
    }

    public void setItemNames(String itemNames) {
        this.itemNames = itemNames;
    }

    public String getLimitValue() {
        return limitValue;
    }

    public void setLimitValue(String limitValue) {
        this.limitValue = limitValue;
    }

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getCheckUnit() {
        return checkUnit;
    }

    public void setCheckUnit(String checkUnit) {
        this.checkUnit = checkUnit;
    }

    @Override
    public String getConclusion() {
        return conclusion;
    }

    @Override
    public void setConclusion(String conclusion) {
        this.conclusion = conclusion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getSamplingCount() {
        return samplingCount;
    }

    public void setSamplingCount(int samplingCount) {
        this.samplingCount = samplingCount;
    }

    public int getDetectCount() {
        return detectCount;
    }

    public void setDetectCount(int detectCount) {
        this.detectCount = detectCount;
    }

    public int getUnqualifiedCount() {
        return unqualifiedCount;
    }

    public void setUnqualifiedCount(int unqualifiedCount) {
        this.unqualifiedCount = unqualifiedCount;
    }

    public int getRecevieCount() {
        return recevieCount;
    }

    public void setRecevieCount(int recevieCount) {
        this.recevieCount = recevieCount;
    }

    public Short getScanNum() {
        return scanNum;
    }

    public void setScanNum(Short scanNum) {
        this.scanNum = scanNum;
    }

    public String getStdCode() {
        return stdCode;
    }

    public void setStdCode(String stdCode) {
        this.stdCode = stdCode;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getPointAddress() {
        return pointAddress;
    }

    public void setPointAddress(String pointAddress) {
        this.pointAddress = pointAddress;
    }

    public String getPointPhone() {
        return pointPhone;
    }

    public void setPointPhone(String pointPhone) {
        this.pointPhone = pointPhone;
    }

    public String getReviewImage() {
        return reviewImage;
    }

    public void setReviewImage(String reviewImage) {
        this.reviewImage = reviewImage;
    }

    public String getApproveImage() {
        return approveImage;
    }

    public void setApproveImage(String approveImage) {
        this.approveImage = approveImage;
    }

    public String getSignatureImage() {
        return signatureImage;
    }

    public void setSignatureImage(String signatureImage) {
        this.signatureImage = signatureImage;
    }

    public Integer getRdataId() {
        return rdataId;
    }

    public void setRdataId(Integer rdataId) {
        this.rdataId = rdataId;
    }

    public Integer getIsCustomItem() {
        return isCustomItem;
    }

    public void setIsCustomItem(Integer isCustomItem) {
        this.isCustomItem = isCustomItem;
    }

    public Integer getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(Integer itemNumber) {
        this.itemNumber = itemNumber;
    }

    public String getPurchaseAmountStr() {
        return this.getPurchaseAmount() == null ? "" : this.getPurchaseAmount().toString();
    }

    public void setPurchaseAmountStr(String purchaseAmountStr) {
        this.purchaseAmountStr = purchaseAmountStr;
    }
}
