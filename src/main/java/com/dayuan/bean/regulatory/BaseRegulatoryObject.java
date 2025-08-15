package com.dayuan.bean.regulatory;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

public class BaseRegulatoryObject extends BaseBean2 {
	
	//机构ID
    private Integer departId;
    //监管对象名称
    private String regName;
    //监管对象类型
    private String regType;
    //联系人名称
    private String linkUser;
    //联系人电话
    private String linkPhone;
    //联系人身份证
    private String linkIdcard;
    //统一社会信用代码
    private String creditCode;
    //传真
    private String fax;
    //邮编
    private String post;
    //所属区域id
    private Double regionId;
    //详细地址
    private String regAddress;
    //x坐标
    private String placeX;
    //y坐标
    private String placeY;
    //审核状态
    private Short checked;
	//二维码
    private String qrcode;
	//预留参数1
    private String param1;
	//预留参数2
    private String param2;
	//预留参数3
    private String param3;
    //企业名称
    private String companyName;
    //经营范围
    private String businessCope;
    
    /**
     * 	委托单位首字母
     */
    private String regFirstLetter;

    /**
     * 	委托单位全拼音
     */
    private String regFullLetter;
	/**
	 * 	任务类型：0无， 1省任务，2市任务，3区任务，4县任务，5 街道任务
	 */
    private Short taskType;//add by xiaoyl 2021/10/12

    /***********************非数据库字段，用于页面显示*******************************/
    //机构名称
    private String departName;
	//营业执照
	private String regLicence;
	//营业截止日期
	private Date licenseEdate;
	//法人代表
	private String legalPerson;
	//经营户数量
	private int businessNumber;
	private String managementType; //经营单位类型：农贸市场/批发市场 1是农贸市场
	
	private Integer yiwanc;//完成当天台账录入经营户数量
	private String username;//监管对象登录微信账号
	private String pwd;//监管对象登录微信密码
	
	private Integer unqualifiedNumber;//监管对象当天的不合格检测数
	//监管对象类型名称 add by xiaoyl 2020/10/12
	private String regTypeName;
	//显示经营者,0隐藏,1展示 add by xiaoyl 2020/10/12
	private Short showBusiness;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getBusinessCope() {
		return businessCope;
	}
	public void setBusinessCope(String businessCope) {
		this.businessCope = businessCope;
	}
	public Integer getYiwanc() {
		return yiwanc;
	}
	public void setYiwanc(Integer yiwanc) {
		this.yiwanc = yiwanc;
	}

	public String getCreditCode() {
		return creditCode;
	}
	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}
	public String getManagementType() {
		return managementType;
	}
	public void setManagementType(String managementType) {
		this.managementType = managementType;
	}
	public Integer getDepartId() {
		return departId;
	}
	public void setDepartId(Integer departId) {
		this.departId = departId;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getRegType() {
		return regType;
	}
	public void setRegType(String regType) {
		this.regType = regType;
	}
	public String getLinkUser() {
		return linkUser;
	}
	public void setLinkUser(String linkUser) {
		this.linkUser = linkUser;
	}
	public String getLinkPhone() {
		return linkPhone;
	}
	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}
	public String getLinkIdcard() {
		return linkIdcard;
	}
	public void setLinkIdcard(String linkIdcard) {
		this.linkIdcard = linkIdcard;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public Double getRegionId() {
		return regionId;
	}
	public void setRegionId(Double regionId) {
		this.regionId = regionId;
	}
	public String getRegAddress() {
		return regAddress;
	}
	public void setRegAddress(String regAddress) {
		this.regAddress = regAddress;
	}
	public String getPlaceX() {
		return placeX;
	}
	public void setPlaceX(String placeX) {
		this.placeX = placeX;
	}
	public String getPlaceY() {
		return placeY;
	}
	public void setPlaceY(String placeY) {
		this.placeY = placeY;
	}
	public Short getChecked() {
		return checked;
	}
	public void setChecked(Short checked) {
		this.checked = checked;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getRegLicence() {
		return regLicence;
	}
	public void setRegLicence(String regLicence) {
		this.regLicence = regLicence;
	}
	public Date getLicenseEdate() {
		return licenseEdate;
	}
	public void setLicenseEdate(Date licenseEdate) {
		this.licenseEdate = licenseEdate;
	}
	public String getLegalPerson() {
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}
	public int getBusinessNumber() {
		return businessNumber;
	}
	public void setBusinessNumber(int businessNumber) {
		this.businessNumber = businessNumber;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	public String getParam2() {
		return param2;
	}
	public void setParam2(String param2) {
		this.param2 = param2;
	}
	public String getParam3() {
		return param3;
	}
	public void setParam3(String param3) {
		this.param3 = param3;
	}
	public String getRegFirstLetter() {
		return regFirstLetter;
	}
	public void setRegFirstLetter(String regFirstLetter) {
		this.regFirstLetter = regFirstLetter;
	}
	public String getRegFullLetter() {
		return regFullLetter;
	}
	public void setRegFullLetter(String regFullLetter) {
		this.regFullLetter = regFullLetter;
	}
	public Integer getUnqualifiedNumber() {
		return unqualifiedNumber;
	}
	public void setUnqualifiedNumber(Integer unqualifiedNumber) {
		this.unqualifiedNumber = unqualifiedNumber;
	}

	public String getRegTypeName() {
		return regTypeName;
	}

	public void setRegTypeName(String regTypeName) {
		this.regTypeName = regTypeName;
	}

	public Short getShowBusiness() {
		return showBusiness;
	}

	public void setShowBusiness(Short showBusiness) {
		this.showBusiness = showBusiness;
	}

	public Short getTaskType() {
		return taskType;
	}

	public void setTaskType(Short taskType) {
		this.taskType = taskType;
	}
}