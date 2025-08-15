package com.dayuan.bean.wxAccount;

import java.util.Date;

public class wxAccount {
    /**
     *
     */
    private Integer id;

    /**
     *公众号名称
     */
    private String accountName;

    /**
     *公众号appid
     */
    private String accountAppid;

    /**
     *公众号密码
     */
    private String accountAppsecret;

    /**
     *机构id
     */
    private Integer departId;

    /**
     *公众号负责人
     */
    private String accountUser;

    /**
     *负责人联系方式
     */
    private String accountUserPhone;

    /**
     *
     */
    private Integer accountCount;

    /**
     *重定向地址
     */
    private String redirectUrl;

    /**
     *短信签名
     */
    private String signName;

    /**
     *短信模板ID
     */
    private String templateCode;

    /**
     *访问密钥ID
     */
    private String accessKeyid;

    /**
     *访问密钥
     */
    private String accessKeysecret;

    /**
     *
     */
    private String remark;

    /**
     *有效状态0是启用1是停用
     */
    private Short status;

    /**
     *删除状态
     */
    private Short deleteFlag;

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
    
    private String count;//关注公众号数量
    private String departName;//机构名称
    

    public String getDepartName() {
		return departName;
	}
    private String samNum;//送检数量
    private String samUserNum;//送检人数
    private String recordingNum;//检测批次

    
    public String getSamNum() {
 	return samNum;
 }

 public void setSamNum(String samNum) {
 	this.samNum = samNum;
 }

 public String getSamUserNum() {
 	return samUserNum;
 }

 public void setSamUserNum(String samUserNum) {
 	this.samUserNum = samUserNum;
 }

 public String getRecordingNum() {
 	return recordingNum;
 }

 public void setRecordingNum(String recordingNum) {
 	this.recordingNum = recordingNum;
 }
	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

    /** 
     * Getter 
	 * @return wx_account.id 
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idwx_account.id
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 公众号名称
	 * @return wx_account.account_name 公众号名称
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccountName() {
        return accountName;
    }

    /** 
     * Setter公众号名称
	 * @param accountNamewx_account.account_name
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountName(String accountName) {
        this.accountName = accountName == null ? null : accountName.trim();
    }

    /** 
     * Getter 公众号appid
	 * @return wx_account.account_appid 公众号appid
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccountAppid() {
        return accountAppid;
    }

    /** 
     * Setter公众号appid
	 * @param accountAppidwx_account.account_appid
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountAppid(String accountAppid) {
        this.accountAppid = accountAppid == null ? null : accountAppid.trim();
    }

    /** 
     * Getter 公众号密码
	 * @return wx_account.account_appsecret 公众号密码
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccountAppsecret() {
        return accountAppsecret;
    }

    /** 
     * Setter公众号密码
	 * @param accountAppsecretwx_account.account_appsecret
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountAppsecret(String accountAppsecret) {
        this.accountAppsecret = accountAppsecret == null ? null : accountAppsecret.trim();
    }

    /** 
     * Getter 机构id
	 * @return wx_account.depart_id 机构id
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Integer getDepartId() {
        return departId;
    }

    /** 
     * Setter机构id
	 * @param departIdwx_account.depart_id
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    /** 
     * Getter 公众号负责人
	 * @return wx_account.account_user 公众号负责人
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccountUser() {
        return accountUser;
    }

    /** 
     * Setter公众号负责人
	 * @param accountUserwx_account.account_user
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountUser(String accountUser) {
        this.accountUser = accountUser == null ? null : accountUser.trim();
    }

    /** 
     * Getter 负责人联系方式
	 * @return wx_account.account_user_phone 负责人联系方式
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccountUserPhone() {
        return accountUserPhone;
    }

    /** 
     * Setter负责人联系方式
	 * @param accountUserPhonewx_account.account_user_phone
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountUserPhone(String accountUserPhone) {
        this.accountUserPhone = accountUserPhone == null ? null : accountUserPhone.trim();
    }

    /** 
     * Getter 
	 * @return wx_account.account_count 
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Integer getAccountCount() {
        return accountCount;
    }

    /** 
     * Setter
	 * @param accountCountwx_account.account_count
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccountCount(Integer accountCount) {
        this.accountCount = accountCount;
    }

    /** 
     * Getter 重定向地址
	 * @return wx_account.redirect_url 重定向地址
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getRedirectUrl() {
        return redirectUrl;
    }

    /** 
     * Setter重定向地址
	 * @param redirectUrlwx_account.redirect_url
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl == null ? null : redirectUrl.trim();
    }

    /** 
     * Getter 短信签名
	 * @return wx_account.sign_name 短信签名
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getSignName() {
        return signName;
    }

    /** 
     * Setter短信签名
	 * @param signNamewx_account.sign_name
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setSignName(String signName) {
        this.signName = signName == null ? null : signName.trim();
    }

    /** 
     * Getter 短信模板ID
	 * @return wx_account.template_code 短信模板ID
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getTemplateCode() {
        return templateCode;
    }

    /** 
     * Setter短信模板ID
	 * @param templateCodewx_account.template_code
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setTemplateCode(String templateCode) {
        this.templateCode = templateCode == null ? null : templateCode.trim();
    }

    /** 
     * Getter 访问密钥ID
	 * @return wx_account.access_keyid 访问密钥ID
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccessKeyid() {
        return accessKeyid;
    }

    /** 
     * Setter访问密钥ID
	 * @param accessKeyidwx_account.access_keyid
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccessKeyid(String accessKeyid) {
        this.accessKeyid = accessKeyid == null ? null : accessKeyid.trim();
    }

    /** 
     * Getter 访问密钥
	 * @return wx_account.access_keysecret 访问密钥
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getAccessKeysecret() {
        return accessKeysecret;
    }

    /** 
     * Setter访问密钥
	 * @param accessKeysecretwx_account.access_keysecret
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setAccessKeysecret(String accessKeysecret) {
        this.accessKeysecret = accessKeysecret == null ? null : accessKeysecret.trim();
    }

    /** 
     * Getter 
	 * @return wx_account.remark 
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getRemark() {
        return remark;
    }

    /** 
     * Setter
	 * @param remarkwx_account.remark
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /** 
     * Getter 有效状态0是启用1是停用
	 * @return wx_account.status 有效状态0是启用1是停用
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Short getStatus() {
        return status;
    }

    /** 
     * Setter有效状态0是启用1是停用
	 * @param statuswx_account.status
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setStatus(Short status) {
        this.status = status;
    }

    /** 
     * Getter 删除状态
	 * @return wx_account.delete_flag 删除状态
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态
	 * @param deleteFlagwx_account.delete_flag
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人id
	 * @return wx_account.create_by 创建人id
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createBywx_account.create_by
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return wx_account.create_date 创建时间
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatewx_account.create_date
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return wx_account.update_by 修改人id
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateBywx_account.update_by
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return wx_account.update_date 修改时间
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatewx_account.update_date
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 预留参数1
	 * @return wx_account.param1 预留参数1
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1wx_account.param1
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return wx_account.param2 预留参数2
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2wx_account.param2
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return wx_account.param3 预留参数3
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3wx_account.param3
     *
     * @mbg.generated Thu Nov 08 15:10:08 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}