package com.dayuan3.terminal.bean;

import com.dayuan.bean.BaseBean2;
import com.dayuan.bean.data.TbFile;

import java.util.ArrayList;
import java.util.List;

/**
 * 委托单位
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class RequesterUnit extends BaseBean2 {

    /**
     * 所属组织机构ID
     */
    private Integer departId;

    /**
     * 注册号
     */
    private String regNumber;

    /**
     * 统一社会信用代码
     */
    private String creditCode;

    /**
     * 委托单位名称
     */
    private String requesterName;

    /**
     * 委托单位别名
     */
    private String requesterOtherName;

    /**
     * 单位类型
     */
    private Integer unitType;

    /**
     * 详细地址
     */
    private String companyAddress;

    /**
     * 法定代表人
     */
    private String legalPerson;

    /**
     * 法人联系方式
     */
    private String legalPhone;

    /**
     * 经营范围
     */
    private String businessCope;

    /**
     * 二维码图片名称
     */
    private String qrcode;

    /**
     * 就餐人员数量
     */
    private String scope;

    /**
     * 状态（0 开业，1 停业）
     */
    private Short state;

    /**
     * 附件名称
     */
    private String fileName;

    /**
     * 附件地址
     */
    private String filePath;

    /**
     * 联系人
     */
    private String linkUser;

    /**
     * 联系电话
     */
    private String linkPhone;

    /**
     * 坐标X,经度
     */
    private String longitude;

    /**
     * 坐标y，纬度
     */
    private String latitude;

    /**
     * 预留参数1
     */
    private String param1;

    /**
     * 预留参数2
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;

    /**
     * 扫描二维码次数
     */
    private Short scanNum;

    /**
     * 非数据库字段，用于界面展示，包含ID
     * 展示方式如：黔西市场监督管理局（1）
     */
    private String departName;
    /**
     * 非数据库字段，用于界面展示,不包含ID
     * 展示方式如：黔西市场监督管理局
     */
    private String departName2;

    /**
     * 委托单位首字母
     */
    private String requesterFirstLetter;

    /**
     * 委托单位全拼音
     */
    private String requesterFullLetter;

    /**
     * 服务许可证
     */
    private String serviceLicense;
    /**
     * 日检测量
     */
    private Integer checkNum = 1;

    private Integer[] deleteFileIds = new Integer[]{};//要删除的文件ID数组

    private List<TbFile> tbFiles = new ArrayList<>();//用于文件回显

    private String samplingNo;
    
    private Integer haveServiceLicense;//是否有许可证:0 否，1 是'
    
    private Integer employeesNumber;//从业人数'
    
    private Integer haveHealthCertificate;//是否有健康证:0 否，1 是'
    
    private Integer checked;//审核状态

    private Short weekendWork;//周末是否上班 0 否， 1 是

    /**
     * 	非数据库字段，用于前段展示
     * 	机构名称，
     */
    private String departNameForList;
    /**
     * 委托单位类型名称
     */
    private String unitTypeName;
    
    public List<TbFile> getTbFiles() {
        return tbFiles;
    }

    public void setTbFiles(List<TbFile> tbFiles) {
        this.tbFiles = tbFiles;
    }

    public Integer[] getDeleteFileIds() {
        return deleteFileIds;
    }

    public void setDeleteFileIds(Integer[] deleteFileIds) {
        this.deleteFileIds = deleteFileIds;
    }

    public Short getScanNum() {
        return scanNum;
    }

    public void setScanNum(Short scanNum) {
        this.scanNum = scanNum;
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getRegNumber() {
        return regNumber == null ? "" : regNumber;
    }

    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber == null ? null : regNumber.trim();
    }

    public String getCreditCode() {
        return creditCode == null ? "" : creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode == null ? null : creditCode.trim();
    }

    public String getRequesterName() {
        return requesterName == null ? "" : requesterName;
    }

    public void setRequesterName(String requesterName) {
        this.requesterName = requesterName == null ? null : requesterName.trim();
    }

    public String getRequesterOtherName() {
        return requesterOtherName == null ? "" : requesterOtherName;
    }

    public void setRequesterOtherName(String requesterOtherName) {
        this.requesterOtherName = requesterOtherName == null ? null : requesterOtherName.trim();
    }

    public Integer getUnitType() {
        return unitType;
    }

    public void setUnitType(Integer unitType) {
        this.unitType = unitType;
    }

    public String getCompanyAddress() {
        return companyAddress == null ? "" : companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress == null ? null : companyAddress.trim();
    }

    public String getLegalPerson() {
        return legalPerson == null ? "" : legalPerson;
    }

    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson == null ? null : legalPerson.trim();
    }

    public String getLegalPhone() {
        return legalPhone == null ? "" : legalPhone;
    }

    public void setLegalPhone(String legalPhone) {
        this.legalPhone = legalPhone == null ? null : legalPhone.trim();
    }

    public String getBusinessCope() {
        return businessCope == null ? "" : businessCope;
    }

    public void setBusinessCope(String businessCope) {
        this.businessCope = businessCope == null ? null : businessCope.trim();
    }

    public Short getState() {
        return state;
    }

    public void setState(Short state) {
        this.state = state;
    }

    public String getFileName() {
        return fileName == null ? "" : fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public String getFilePath() {
        return filePath == null ? "" : filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    public String getLinkUser() {
        return linkUser == null ? "" : linkUser;
    }

    public void setLinkUser(String linkUser) {
        this.linkUser = linkUser == null ? null : linkUser.trim();
    }

    public String getLinkPhone() {
        return linkPhone == null ? "" : linkPhone;
    }

    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone == null ? null : linkPhone.trim();
    }

    public String getLongitude() {
        return longitude == null ? "" : longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    public String getLatitude() {
        return latitude == null ? "" : latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    public String getParam1() {
        return param1 == null ? "" : param1;
    }

    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    public String getParam2() {
        return param2 == null ? "" : param2;
    }

    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    public String getParam3() {
        return param3 == null ? "" : param3;
    }

    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

    public String getDepartName() {
        return departName == null ? "" : departName+"("+this.departId+")";
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getRequesterFirstLetter() {
        return requesterFirstLetter == null ? "" : requesterFirstLetter;
    }

    public void setRequesterFirstLetter(String requesterFirstLetter) {
        this.requesterFirstLetter = requesterFirstLetter;
    }

    public String getRequesterFullLetter() {
        return requesterFullLetter == null ? "" : requesterFullLetter;
    }

    public void setRequesterFullLetter(String requesterFullLetter) {
        this.requesterFullLetter = requesterFullLetter;
    }

    public String getQrcode() {
        return qrcode == null ? "" : qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode;
    }

    public String getScope() {
        return scope == null ? "0" : scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

    public String getServiceLicense() {
        return serviceLicense == null ? "" : serviceLicense;
    }

    public void setServiceLicense(String serviceLicense) {
        this.serviceLicense = serviceLicense;
    }

    public Integer getCheckNum() {
        return checkNum == null ? 1 : checkNum;
    }

    public void setCheckNum(Integer checkNum) {
        this.checkNum = checkNum;
    }

	public String getSamplingNo() {
		return samplingNo;
	}

	public void setSamplingNo(String samplingNo) {
		this.samplingNo = samplingNo;
	}

	public Integer getHaveServiceLicense() {
		return haveServiceLicense;
	}

	public void setHaveServiceLicense(Integer haveServiceLicense) {
		this.haveServiceLicense = haveServiceLicense;
	}

	public Integer getEmployeesNumber() {
		return employeesNumber;
	}

	public void setEmployeesNumber(Integer employeesNumber) {
		this.employeesNumber = employeesNumber;
	}
	
	

	public Integer getChecked() {
		return checked;
	}

	public void setChecked(Integer checked) {
		this.checked = checked;
	}

	public Integer getHaveHealthCertificate() {
		return haveHealthCertificate;
	}

	public void setHaveHealthCertificate(Integer haveHealthCertificate) {
		this.haveHealthCertificate = haveHealthCertificate;
	}

	public String getDepartNameForList() {
		return departNameForList;
	}

	public void setDepartNameForList(String departNameForList) {
		this.departNameForList = departNameForList;
	}

	public String getUnitTypeName() {
		return unitTypeName;
	}

	public void setUnitTypeName(String unitTypeName) {
		this.unitTypeName = unitTypeName;
	}

    public String getDepartName2() {
        return this.departName;
    }

    public void setDepartName2(String departName2) {
        this.departName2 = departName2;
    }

    public Short getWeekendWork() {
        return weekendWork;
    }

    public void setWeekendWork(Short weekendWork) {
        this.weekendWork = weekendWork;
    }
}