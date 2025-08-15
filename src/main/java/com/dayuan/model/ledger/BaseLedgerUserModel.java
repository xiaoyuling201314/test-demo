package com.dayuan.model.ledger;

import java.util.Date;

import com.dayuan.model.BaseModel;

public class BaseLedgerUserModel extends BaseModel {
    /**
     *主键id
     */
    private Integer id;

    /**
     *账号
     */
    private String username;

    /**
     *密码
     */
    private String pwd;

    /**
     *微信id
     */
    private String openid;

    /**
     *手机号
     */
    private String phone;

    /**
     *机构名称
     */
    private String departName;

    /**
     *机构id
     */
    private Integer departId;

    /**
     *机构编码
     */
    private String departCode;

    /**
     *市场名称
     */
    private String regName;

    /**
     *市场id
     */
    private Integer regId;

    /**
     *档口/店面编号
     */
    private String opeShopCode;

    /**
     *经营户名称
     */
    private String opeShopName;

    /**
     *经营户id
     */
    private Integer opeId;

    /**
     *0经营户‘1’是市场方
     */
    private Short type;

    /**
     *状态0停用1启用
     */
    private Short status;

    /**
     *删除状态0是未删除1是已删除
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

    /** 
     * Getter 主键id
	 * @return base_ledger_user.id 主键id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter主键id
	 * @param idbase_ledger_user.id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 账号
	 * @return base_ledger_user.username 账号
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getUsername() {
        return username;
    }

    /** 
     * Setter账号
	 * @param usernamebase_ledger_user.username
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /** 
     * Getter 密码
	 * @return base_ledger_user.pwd 密码
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getPwd() {
        return pwd;
    }

    /** 
     * Setter密码
	 * @param pwdbase_ledger_user.pwd
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }

    /** 
     * Getter 微信id
	 * @return base_ledger_user.openid 微信id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getOpenid() {
        return openid;
    }

    /** 
     * Setter微信id
	 * @param openidbase_ledger_user.openid
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setOpenid(String openid) {
        this.openid = openid == null ? null : openid.trim();
    }

    /** 
     * Getter 手机号
	 * @return base_ledger_user.phone 手机号
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getPhone() {
        return phone;
    }

    /** 
     * Setter手机号
	 * @param phonebase_ledger_user.phone
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    /** 
     * Getter 机构名称
	 * @return base_ledger_user.depart_name 机构名称
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getDepartName() {
        return departName;
    }

    /** 
     * Setter机构名称
	 * @param departNamebase_ledger_user.depart_name
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setDepartName(String departName) {
        this.departName = departName == null ? null : departName.trim();
    }

    /** 
     * Getter 机构id
	 * @return base_ledger_user.depart_id 机构id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Integer getDepartId() {
        return departId;
    }

    /** 
     * Setter机构id
	 * @param departIdbase_ledger_user.depart_id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    /** 
     * Getter 机构编码
	 * @return base_ledger_user.depart_code 机构编码
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getDepartCode() {
        return departCode;
    }

    /** 
     * Setter机构编码
	 * @param departCodebase_ledger_user.depart_code
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setDepartCode(String departCode) {
        this.departCode = departCode == null ? null : departCode.trim();
    }

    /** 
     * Getter 市场名称
	 * @return base_ledger_user.reg_name 市场名称
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getRegName() {
        return regName;
    }

    /** 
     * Setter市场名称
	 * @param regNamebase_ledger_user.reg_name
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setRegName(String regName) {
        this.regName = regName == null ? null : regName.trim();
    }

    /** 
     * Getter 市场id
	 * @return base_ledger_user.reg_id 市场id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Integer getRegId() {
        return regId;
    }

    /** 
     * Setter市场id
	 * @param regIdbase_ledger_user.reg_id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    /** 
     * Getter 档口/店面编号
	 * @return base_ledger_user.ope_shop_code 档口/店面编号
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getOpeShopCode() {
        return opeShopCode;
    }

    /** 
     * Setter档口/店面编号
	 * @param opeShopCodebase_ledger_user.ope_shop_code
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setOpeShopCode(String opeShopCode) {
        this.opeShopCode = opeShopCode == null ? null : opeShopCode.trim();
    }

    /** 
     * Getter 经营户名称
	 * @return base_ledger_user.ope_shop_name 经营户名称
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getOpeShopName() {
        return opeShopName;
    }

    /** 
     * Setter经营户名称
	 * @param opeShopNamebase_ledger_user.ope_shop_name
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName == null ? null : opeShopName.trim();
    }

    /** 
     * Getter 经营户id
	 * @return base_ledger_user.ope_id 经营户id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Integer getOpeId() {
        return opeId;
    }

    /** 
     * Setter经营户id
	 * @param opeIdbase_ledger_user.ope_id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setOpeId(Integer opeId) {
        this.opeId = opeId;
    }

    /** 
     * Getter 0经营户‘1’是市场方
	 * @return base_ledger_user.type 0经营户‘1’是市场方
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Short getType() {
        return type;
    }

    /** 
     * Setter0经营户‘1’是市场方
	 * @param typebase_ledger_user.type
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setType(Short type) {
        this.type = type;
    }

    /** 
     * Getter 状态0停用1启用
	 * @return base_ledger_user.status 状态0停用1启用
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Short getStatus() {
        return status;
    }

    /** 
     * Setter状态0停用1启用
	 * @param statusbase_ledger_user.status
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setStatus(Short status) {
        this.status = status;
    }

    /** 
     * Getter 删除状态0是未删除1是已删除
	 * @return base_ledger_user.delete_flag 删除状态0是未删除1是已删除
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Short getDeleteFlag() {
        return deleteFlag;
    }

    /** 
     * Setter删除状态0是未删除1是已删除
	 * @param deleteFlagbase_ledger_user.delete_flag
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    /** 
     * Getter 创建人id
	 * @return base_ledger_user.create_by 创建人id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getCreateBy() {
        return createBy;
    }

    /** 
     * Setter创建人id
	 * @param createBybase_ledger_user.create_by
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /** 
     * Getter 创建时间
	 * @return base_ledger_user.create_date 创建时间
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Date getCreateDate() {
        return createDate;
    }

    /** 
     * Setter创建时间
	 * @param createDatebase_ledger_user.create_date
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    /** 
     * Getter 修改人id
	 * @return base_ledger_user.update_by 修改人id
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getUpdateBy() {
        return updateBy;
    }

    /** 
     * Setter修改人id
	 * @param updateBybase_ledger_user.update_by
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    /** 
     * Getter 修改时间
	 * @return base_ledger_user.update_date 修改时间
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public Date getUpdateDate() {
        return updateDate;
    }

    /** 
     * Setter修改时间
	 * @param updateDatebase_ledger_user.update_date
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /** 
     * Getter 预留参数1
	 * @return base_ledger_user.param1 预留参数1
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数1
	 * @param param1base_ledger_user.param1
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 预留参数2
	 * @return base_ledger_user.param2 预留参数2
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter预留参数2
	 * @param param2base_ledger_user.param2
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 预留参数3
	 * @return base_ledger_user.param3 预留参数3
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter预留参数3
	 * @param param3base_ledger_user.param3
     *
     * @mbg.generated Mon Jun 11 10:34:07 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}