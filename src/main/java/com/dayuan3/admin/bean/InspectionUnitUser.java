package com.dayuan3.admin.bean;

import com.dayuan.bean.BaseBean2;
import com.dayuan.util.StringUtil;
import io.swagger.annotations.ApiModelProperty;

import java.util.Date;

/**
 * 送检账号管理
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class InspectionUnitUser extends BaseBean2 {

    @ApiModelProperty(value = "用户ID", example = "")
    private Integer id;

    /**
     * 用户类型： 0 普通用户,1 抽样人员,2 监管方,3取样人员,4财务统计
     */
    @ApiModelProperty(value = "用户类型： 0 普通用户,1 抽样人员,2 监管方,3取样人员,4财务统计", example = "")
    private Integer type;
    /**
     * 手机号码
     */
    @ApiModelProperty(value = "手机号码", example = "")
    private String phone;

    /**
     * 账号
     */
    private String userName;
    /**
     * 密码
     */
    @ApiModelProperty(value = "密码", example = "")
    private String password;
    /**
     * 用户号
     */
    private String account;
    /**
     * 姓名
     */
    @ApiModelProperty(value = "姓名", example = "")
    private String realName;
    /**
     * 用户类型： 0 个人，1 企业
     */
    private Short userType;
    /**
     * 用户来源：0 后台注册，1 公众号注册
     */
    @ApiModelProperty(value = "用户来源：0 后台注册，1 公众号注册", example = "")
    private Short sourceType;

    /**
     * 身份证号码
     */
    private String identifiedNumber;
    /**
     * 冷链单位ID
     */
    @ApiModelProperty(value = "冷链单位ID", example = "")
    private Integer coldUnitId;
    /**
     * 经营单位ID
     */
    @ApiModelProperty(value = "经营单位ID", example = "")
    private Integer inspectionId;


    /**
     * 公众号
     */
    @ApiModelProperty(value = "公众号openId", example = "")
    private String openId;

    /**
     * 自助下单小程序OpenId
     */
    private String miniOpenId;

    /**
     * 微信用户昵称-预留
     */
    private String wxNickname;

    /**
     * 微信用户头像-预留
     */
    private String wxImage;


    /**
     * 登录次数
     */
    @ApiModelProperty(value = "登录次数", example = "")
    private Short loginCount;

    /**
     * 登录时间
     */
    @ApiModelProperty(value = "登录时间", example = "")
    private Date loginTime;

    /**
     * 是否允许绑定 0:否 1：是
     */
    private Short status;

    /**
     * 审核状态（0 未审核，1 已审核）
     */
    private Short checked = 0;

    /**
     * 审核时间
     */
    private Date checkedDate;
    /**
     * 附件
     */
    private String filePath;

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


    // ----------外表字段
    // 机构的审核状态
    private Short uintChecked;

    private String inspectionName;// 经营单位名称

    private String creditCode;  //社会信用代码

    private String payPassword;// 支付密码
    private String coldName;// 冷链单位名称

    private Integer departId;  //组织机构id
    private String departName;  //组织机构名称

    private Integer userSessionType;  //用户session类型 0或者空是 微信公众号 1是小程序

    private String inspectionIdStr;//经营单位ID字符串


    public Integer getUserSessionType() {
        return userSessionType;
    }


    public void setUserSessionType(Integer userSessionType) {
        this.userSessionType = userSessionType;
    }


    public String getMiniOpenId() {
        return miniOpenId;
    }


    public void setMiniOpenId(String miniOpenId) {
        this.miniOpenId = miniOpenId;
    }

    /**
     * 是否供应商(1:是 0:否)
     */
    private Short terminalUserType = 0;

    /**
     * 所在区域
     */
    private String area;

    /**
     * 详细地址
     */
    private String address;

    /**
     * 监控类型
     */
    private Integer monitoringType;

    /**
     * 监控类型:监控单位类型，多个用逗号隔开
     * add by xiaoyl 2020/06/29
     */
    private String monitoringUnitType;

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public String getColdName() {
        return coldName;
    }

    public void setColdName(String coldName) {
        this.coldName = coldName;
    }

    public Integer getDepartId() {
        return departId;
    }


    public void setDepartId(Integer departId) {
        this.departId = departId;
    }


    public String getDepartName() {
        if (departId != null && StringUtil.isNotEmpty(departName)) {
            return departName + "(" + this.departId + ")";
        } else {
            return "";
        }
    }


    public void setDepartName(String departName) {
        this.departName = departName;
    }


    public String getPayPassword() {
        return StringUtil.isEmpty(payPassword) ? "" : "你想看支付密码？";
    }

    public void setPayPassword(String payPassword) {
        this.payPassword = payPassword;
    }

    public String getRealName() {
        return realName == null ? "" : realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Short getUintChecked() {
        return uintChecked;
    }

    public void setUintChecked(Short uintChecked) {
        this.uintChecked = uintChecked;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? "" : userName.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getWxNickname() {
        return wxNickname;
    }

    public void setWxNickname(String wxNickname) {
        this.wxNickname = wxNickname == null ? null : wxNickname.trim();
    }

    public String getWxImage() {
        return wxImage;
    }

    public void setWxImage(String wxImage) {
        this.wxImage = wxImage == null ? null : wxImage.trim();
    }

    public Integer getInspectionId() {
        return inspectionId;
    }

    public void setInspectionId(Integer inspectionId) {
        this.inspectionId = inspectionId;
    }

    public Short getLoginCount() {
        return loginCount == null ? 0 : loginCount;
    }

    public void setLoginCount(Short loginCount) {
        this.loginCount = loginCount;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public Date getCheckedDate() {
        return checkedDate;
    }

    public void setCheckedDate(Date checkedDate) {
        this.checkedDate = checkedDate;
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

    public String getInspectionName() {
        return inspectionName;
    }

    public void setInspectionName(String inspectionName) {
        this.inspectionName = inspectionName;
    }

    public Short getUserType() {
        return userType;
    }

    public void setUserType(Short userType) {
        this.userType = userType;
    }

    public String getIdentifiedNumber() {
        return StringUtil.isEmpty(identifiedNumber) ? "" : identifiedNumber;
    }

    public void setIdentifiedNumber(String identifiedNumber) {
        this.identifiedNumber = identifiedNumber;
    }

    public String getCreditCode() {
        return creditCode;
    }

    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode;
    }


    public Short getTerminalUserType() {
        return terminalUserType;
    }

    public void setTerminalUserType(Short terminalUserType) {
        this.terminalUserType = terminalUserType;
    }


    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }


    public Integer getMonitoringType() {
        return monitoringType;
    }


    public void setMonitoringType(Integer monitoringType) {
        this.monitoringType = monitoringType;
    }


    public String getMonitoringUnitType() {
        return monitoringUnitType;
    }

    public void setMonitoringUnitType(String monitoringUnitType) {
        this.monitoringUnitType = monitoringUnitType;
    }

    public Integer getColdUnitId() {
        return coldUnitId;
    }

    public void setColdUnitId(Integer coldUnitId) {
        this.coldUnitId = coldUnitId;
    }

    public Short getSourceType() {
        return sourceType;
    }

    public void setSourceType(Short sourceType) {
        this.sourceType = sourceType;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getInspectionIdStr() {
        return inspectionIdStr;
    }

    public void setInspectionIdStr(String inspectionIdStr) {
        this.inspectionIdStr = inspectionIdStr;
    }
}