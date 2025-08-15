package com.dayuan.bean.dataCheck;

/**
 * 检测报告扩充表，补充检测报告相关的信息
 * @author xiaoyl
 * @date   2020年3月6日
 */
public class CheckReportData {
	
    public CheckReportData() {
		super();
	}
    

	public CheckReportData(Integer recordingId, String stdCode, String pointAddress, String pointPhone,
			String reviewImage, String approveImage, String signatureImage) {
		super();
		this.recordingId = recordingId;
		this.stdCode = stdCode;
		this.pointAddress = pointAddress;
		this.pointPhone = pointPhone;
		this.reviewImage = reviewImage;
		this.approveImage = approveImage;
		this.signatureImage = signatureImage;
	}


	/**
     * ID
     */
    private Integer id;

    /**
     * 	检测记录ID
     */
    private Integer recordingId;

    /**
     *	 标准编号，例如：GB 10136-2015
     */
    private String stdCode;

    /**
     * 	机构地址
     */
    private String pointAddress;

    /**
     * 	机构联系电话
     */
    private String pointPhone;

    /**
     * 	审核人员签名，base64字符串
     */
    private String reviewImage;

    /**
     * 	批准人员签名，base64字符串
     */
    private String approveImage;

    /**
     *	 电子签章，base64字符串
     */
    private String signatureImage;

    /**
     * 	预留参数1
     */
    private String param1;

    /**
     *	 预留参数2
     */
    private String param2;

    /**
     * 	预留参数3
     */
    private String param3;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRecordingId() {
        return recordingId;
    }

    public void setRecordingId(Integer recordingId) {
        this.recordingId = recordingId;
    }

    public String getStdCode() {
        return stdCode;
    }

    public void setStdCode(String stdCode) {
        this.stdCode = stdCode == null ? null : stdCode.trim();
    }

    public String getPointAddress() {
        return pointAddress;
    }

    public void setPointAddress(String pointAddress) {
        this.pointAddress = pointAddress == null ? null : pointAddress.trim();
    }

    public String getPointPhone() {
        return pointPhone;
    }

    public void setPointPhone(String pointPhone) {
        this.pointPhone = pointPhone == null ? null : pointPhone.trim();
    }

    public String getReviewImage() {
        return reviewImage;
    }

    public void setReviewImage(String reviewImage) {
        this.reviewImage = reviewImage == null ? null : reviewImage.trim();
    }

    public String getApproveImage() {
        return approveImage;
    }

    public void setApproveImage(String approveImage) {
        this.approveImage = approveImage == null ? null : approveImage.trim();
    }

    public String getSignatureImage() {
        return signatureImage;
    }

    public void setSignatureImage(String signatureImage) {
        this.signatureImage = signatureImage == null ? null : signatureImage.trim();
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
}