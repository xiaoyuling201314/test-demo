package com.dayuan3.terminal.bean;

import java.util.Date;

public class InspectionUserDetail {
    /**
     *ID
     */
    private Integer id;

    /**
     *inspection_unit_user 主键id
     */
    private Integer userId;

    /**
     *送检单位名称
     */
    private String companyName;

    /**
     *送检单位类型：0企业，1个人
     */
    private Short companyType;

    /**
     *注册号
     */
    private String regNumber;

    /**
     *社会信用代码
     */
    private String creditCode;

    /**
     *法定代表人
     */
    private String legalPerson;

    /**
     *法人联系方式
     */
    private String legalPhone;

    /**
     *详细地址
     */
    private String companyAddress;

    /**
     *成立日期
     */
    private Date setupDate;

    /**
     *登记机关
     */
    private String regAuthority;

    /**
     *审核状态（0 未审核，1 已审核）
     */
    private Short checked;

    /**
     *审核时间
     */
    private Date checkedDate;

    /**
     *默认送检单位：0否 1是
     */
    private Short isdefault;

    /**
     *状态（0 开业，1 停业）
     */
    private Short state;

    /**
     *附件名称
     */
    private String fileName;

    /**
     *附件地址
     */
    private String filePath;

    /**
     *坐标X,经度
     */
    private String longitude;

    /**
     *坐标y，纬度
     */
    private String latitude;

    /**
     *备注
     */
    private String remark;

    /**
     *删除状态
     */
    private Short deleteFlag;

    /**
     *排序
     */
    private Short sorting;

    /**
     *创建人id
     */
    private String createBy;

    /**
     *创建时间
     */
    private Date createDate;

    /**
     *修改人id
     */
    private String updateBy;

    /**
     *修改时间
     */
    private Date updateDate;

    /**
     *联系人
     */
    private String linkUser;

    /**
     *联系方式
     */
    private String linkPhone;

    /**
     *预留参数1
     */
    private String param1;

    /**
     *预留参数2
     */
    private String param2;

    /**
     *预留参数3
     */
    private String param3;

    /**
     *二维码图片名称
     */
    private String qrcode;

    /**
     *扫描二维码次数
     */
    private Short scanNum;

    /** 
     * Getter ID
	 * @return inspection_user_detail.id ID
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * SetterID
	 * @param idinspection_user_detail.id
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter inspection_unit_user 主键id
	 * @return inspection_user_detail.user_id inspection_unit_user 主键id
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Integer getUserId() {
        return userId;
    }

    /** 
     * Setterinspection_unit_user 主键id
	 * @param userIdinspection_user_detail.user_id
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /** 
     * Getter 送检单位名称
	 * @return inspection_user_detail.company_name 送检单位名称
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getCompanyName() {
        return companyName;
    }

    /** 
     * Setter送检单位名称
	 * @param companyNameinspection_user_detail.company_name
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    /** 
     * Getter 送检单位类型：0企业，1个人
	 * @return inspection_user_detail.company_type 送检单位类型：0企业，1个人
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getCompanyType() {
        return companyType;
    }

    /** 
     * Setter送检单位类型：0企业，1个人
	 * @param companyTypeinspection_user_detail.company_type
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCompanyType(Short companyType) {
        this.companyType = companyType;
    }

    /** 
     * Getter 注册号
	 * @return inspection_user_detail.reg_number 注册号
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getRegNumber() {
        return regNumber;
    }

    /** 
     * Setter注册号
	 * @param regNumberinspection_user_detail.reg_number
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber == null ? null : regNumber.trim();
    }

    /** 
     * Getter 社会信用代码
	 * @return inspection_user_detail.credit_code 社会信用代码
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getCreditCode() {
        return creditCode;
    }

    /** 
     * Setter社会信用代码
	 * @param creditCodeinspection_user_detail.credit_code
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode == null ? null : creditCode.trim();
    }

    /** 
     * Getter 法定代表人
	 * @return inspection_user_detail.legal_person 法定代表人
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLegalPerson() {
        return legalPerson;
    }

    /** 
     * Setter法定代表人
	 * @param legalPersoninspection_user_detail.legal_person
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson == null ? null : legalPerson.trim();
    }

    /** 
     * Getter 法人联系方式
	 * @return inspection_user_detail.legal_phone 法人联系方式
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLegalPhone() {
        return legalPhone;
    }

    /** 
     * Setter法人联系方式
	 * @param legalPhoneinspection_user_detail.legal_phone
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLegalPhone(String legalPhone) {
        this.legalPhone = legalPhone == null ? null : legalPhone.trim();
    }

    /** 
     * Getter 详细地址
	 * @return inspection_user_detail.company_address 详细地址
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getCompanyAddress() {
        return companyAddress;
    }

    /** 
     * Setter详细地址
	 * @param companyAddressinspection_user_detail.company_address
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress == null ? null : companyAddress.trim();
    }

    /** 
     * Getter 成立日期
	 * @return inspection_user_detail.setup_date 成立日期
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Date getSetupDate() {
        return setupDate;
    }

    /** 
     * Setter成立日期
	 * @param setupDateinspection_user_detail.setup_date
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setSetupDate(Date setupDate) {
        this.setupDate = setupDate;
    }

    /** 
     * Getter 登记机关
	 * @return inspection_user_detail.reg_authority 登记机关
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getRegAuthority() {
        return regAuthority;
    }

    /** 
     * Setter登记机关
	 * @param regAuthorityinspection_user_detail.reg_authority
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setRegAuthority(String regAuthority) {
        this.regAuthority = regAuthority == null ? null : regAuthority.trim();
    }

    /** 
     * Getter 审核状态（0 未审核，1 已审核）
	 * @return inspection_user_detail.checked 审核状态（0 未审核，1 已审核）
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getChecked() {
        return checked;
    }

    /** 
     * Setter审核状态（0 未审核，1 已审核）
	 * @param checkedinspection_user_detail.checked
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setChecked(Short checked) {
        this.checked = checked;
    }

    /** 
     * Getter 审核时间
	 * @return inspection_user_detail.checked_date 审核时间
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Date getCheckedDate() {
        return checkedDate;
    }

    /** 
     * Setter审核时间
	 * @param checkedDateinspection_user_detail.checked_date
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCheckedDate(Date checkedDate) {
        this.checkedDate = checkedDate;
    }

    /** 
     * Getter 默认送检单位：0否 1是
	 * @return inspection_user_detail.isdefault 默认送检单位：0否 1是
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getIsdefault() {
        return isdefault;
    }

    /** 
     * Setter默认送检单位：0否 1是
	 * @param isdefaultinspection_user_detail.isdefault
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setIsdefault(Short isdefault) {
        this.isdefault = isdefault;
    }

    /** 
     * Getter 状态（0 开业，1 停业）
	 * @return inspection_user_detail.state 状态（0 开业，1 停业）
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getState() {
        return state;
    }

    /** 
     * Setter状态（0 开业，1 停业）
	 * @param stateinspection_user_detail.state
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setState(Short state) {
        this.state = state;
    }

    /** 
     * Getter 附件名称
	 * @return inspection_user_detail.file_name 附件名称
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getFileName() {
        return fileName;
    }

    /** 
     * Setter附件名称
	 * @param fileNameinspection_user_detail.file_name
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    /** 
     * Getter 附件地址
	 * @return inspection_user_detail.file_path 附件地址
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getFilePath() {
        return filePath;
    }

    /** 
     * Setter附件地址
	 * @param filePathinspection_user_detail.file_path
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    /** 
     * Getter 坐标X,经度
	 * @return inspection_user_detail.longitude 坐标X,经度
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLongitude() {
        return longitude;
    }

    /** 
     * Setter坐标X,经度
	 * @param longitudeinspection_user_detail.longitude
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    /** 
     * Getter 坐标y，纬度
	 * @return inspection_user_detail.latitude 坐标y，纬度
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLatitude() {
        return latitude;
    }

    /** 
     * Setter坐标y，纬度
	 * @param latitudeinspection_user_detail.latitude
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    /** 
     * Getter 备注
	 * @return inspection_user_detail.remark 备注
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getRemark() {
        return remark;
    }

    /** 
     * Setter备注
	 * @param remarkinspection_user_detail.remark
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /** 
     * Getter 删除状态
	 * @return inspection_user_detail.delete_flag 删除状态
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlaginspection_user_detail.delete_flag
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 排序
	 * @return inspection_user_detail.sorting 排序
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getSorting() {
        return sorting;
    }

    /** 
     * Setter排序
	 * @param sortinginspection_user_detail.sorting
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

    /** 
     * Getter 创建人id
	 * @return inspection_user_detail.create_by 创建人id
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createByinspection_user_detail.create_by
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return inspection_user_detail.create_date 创建时间
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDateinspection_user_detail.create_date
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return inspection_user_detail.update_by 修改人id
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateByinspection_user_detail.update_by
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return inspection_user_detail.update_date 修改时间
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDateinspection_user_detail.update_date
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 联系人
	 * @return inspection_user_detail.link_user 联系人
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLinkUser() {
        return linkUser;
    }

    /** 
     * Setter联系人
	 * @param linkUserinspection_user_detail.link_user
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLinkUser(String linkUser) {
        this.linkUser = linkUser == null ? null : linkUser.trim();
    }

    /** 
     * Getter 联系方式
	 * @return inspection_user_detail.link_phone 联系方式
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getLinkPhone() {
        return linkPhone;
    }

    /** 
     * Setter联系方式
	 * @param linkPhoneinspection_user_detail.link_phone
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone == null ? null : linkPhone.trim();
    }

    /** 
     * Getter 预留参数1
	 * @return inspection_user_detail.param1 预留参数1
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1inspection_user_detail.param1
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return inspection_user_detail.param2 预留参数2
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2inspection_user_detail.param2
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return inspection_user_detail.param3 预留参数3
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3inspection_user_detail.param3
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    /** 
     * Getter 二维码图片名称
	 * @return inspection_user_detail.qrcode 二维码图片名称
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public String getQrcode() {
        return qrcode;
    }

    /** 
     * Setter二维码图片名称
	 * @param qrcodeinspection_user_detail.qrcode
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setQrcode(String qrcode) {
        this.qrcode = qrcode == null ? null : qrcode.trim();
    }

    /** 
     * Getter 扫描二维码次数
	 * @return inspection_user_detail.scan_num 扫描二维码次数
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public Short getScanNum() {
        return scanNum;
    }

    /** 
     * Setter扫描二维码次数
	 * @param scanNuminspection_user_detail.scan_num
     *
     * @mbg.generated Thu Nov 07 15:35:10 CST 2019
     */
    public void setScanNum(Short scanNum) {
        this.scanNum = scanNum;
    }
}