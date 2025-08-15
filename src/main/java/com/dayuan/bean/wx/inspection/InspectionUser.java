package com.dayuan.bean.wx.inspection;

import java.util.Date;

/**
 * 查看你送我检信息的用户
 * Created by dy on 2018/8/3.
 */
public class InspectionUser {
    private Integer id;//主键

    private String userName;//用户名称

    private String password;//密码

    private String mobilePhone;//手机号码

    private String openid;//微信用户唯一id

    private String nickName;//用户昵称

    private String sex;//性别：男，女

    private String province;//用户个人资料填写的省份

    private String city;//普通用户个人资料填写的城市

    private String country;//国家

    private String headimgurl;//头像路径（最后一个值表示正方形头像大小0，46，64,96，132可选，0表示大小为640*640

    private String departId;//机构id

    private String verificationCode;//短信验证码

    private Date createDate;//创建时间

    private String createBy;//创建人id

    private Date updateDate;//修改时间

    private String updateBy;//修改人id

    private Integer bindNumber = 0;//绑定的总次数,默认为0，避免数据库为null时导致null+1报错


    private String appId;//微信公众号唯一ID

    private String param1;//预留参数1

    private String param2;//预留参数2

    private String param3;//预留参数3

    private Date bindTime;//绑定时间
    private Date relieveTime;//解绑时间
    private Integer count;//关注数量计算
    private String date;//关注时间统计
    private Integer status;//有效状态0是绑定1未绑定

    private String address;//详细地址

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Date getBindTime() {
        return bindTime;
    }

    public void setBindTime(Date bindTime) {
        this.bindTime = bindTime;
    }

    public Date getRelieveTime() {
        return relieveTime;
    }

    public void setRelieveTime(Date relieveTime) {
        this.relieveTime = relieveTime;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public String getDepartId() {
        return departId;
    }

    public void setDepartId(String departId) {
        this.departId = departId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getHeadimgurl() {
        return headimgurl;
    }

    public void setHeadimgurl(String headimgurl) {
        this.headimgurl = headimgurl;
    }

    public Integer getBindNumber() {
        return bindNumber;
    }

    public void setBindNumber(Integer bindNumber) {
        this.bindNumber = bindNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
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
}
