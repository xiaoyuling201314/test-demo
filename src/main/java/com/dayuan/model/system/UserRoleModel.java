package com.dayuan.model.system;

import com.dayuan.model.BaseModel;
import com.dayuan.util.StringUtil;
import org.apache.commons.net.util.Base64;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月7日
 */
public class UserRoleModel extends BaseModel {

    /**
     * 系统用户
     */
    private String id; // 主键：id

    private String workersId;  //人员表id

    private String userName;  //账号

    private String password;  //密码

    private String realname;  //姓名

    private Integer departId;  //组织机构id

    private String roleId;  //用户对应的角色id

    private Short status;  //有效状态 0启用,1停用

    private Short sorting;  //排序

    private Short deleteFlag; // 删除状态；0未删除，1删除

    private String createBy; // 创建人id

    private Date createDate; // 创建时间

    private String updateBy; // 修改人id

    private Date updateDate; // 修改时间

    private Short loginCount;  //登录次数

    private Date loginTime;  //登录时间

    private Integer userType;  //用户类型 1：全部 2：机构 3：检测点 4：监管对象


    /**
     * 角色
     */
    private String rolename; //角色名字

    private String remark; // 备注

    /**
     * 机构
     */
    private String departName;  //机构名称

    private String departCode;//机构编号
    /**
     * 检测点
     */
    private Integer pointId;

    private String pointName;

    /**
     * 监管对象
     */
    private Integer regId;

    private String regName;
    private String signatureFile;//用户电子签名文件 add by xiaoyl 2020/10/28

    private String param1;//预留参数1 add by xiaoyl 2020/10/28

    private String param2;//预留参数2 add by xiaoyl 2020/10/28

    private String param3;//预留参数3 add by xiaoyl 2020/10/28

    /**
     * 微信的 openid
     */
    private String openid;
    private Short wxstatus; // 删除状态；0未删除，1删除
    private Short type; // 删除状态；0未删除，1删除
    /**
     * 微信openid
     */
    private String wxOpenid;
    /**
     * 微信用户昵称
     */
    private String wxNickname;

    /**
     * 微信用户昵称-用于界面显示
     */
    private String nickName;

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Short getWxstatus() {
        return wxstatus;
    }

    public void setWxstatus(Short wxstatus) {
        this.wxstatus = wxstatus;
    }

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getWorkersId() {
        return workersId;
    }

    public void setWorkersId(String workersId) {
        this.workersId = workersId;
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

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public Short getSorting() {
        return sorting;
    }

    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

    public Short getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Short getLoginCount() {
        return loginCount;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public Integer getPointId() {
        return pointId;
    }

    public void setPointId(Integer pointId) {
        this.pointId = pointId;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
    }

    public String getDepartCode() {
        return departCode;
    }

    public void setDepartCode(String departCode) {
        this.departCode = departCode;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getSignatureFile() {
        return signatureFile;
    }

    public void setSignatureFile(String signatureFile) {
        this.signatureFile = signatureFile;
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

    public String getWxOpenid() {
        return wxOpenid;
    }

    public void setWxOpenid(String wxOpenid) {
        this.wxOpenid = wxOpenid;
    }

    public String getWxNickname() {
        return wxNickname;
    }

    public void setWxNickname(String wxNickname) {
        this.wxNickname = wxNickname;
    }

    public String getNickName() {
        return StringUtil.isNotEmpty(this.wxNickname) ? new String(Base64.decodeBase64(this.wxNickname.getBytes()), StandardCharsets.UTF_8) : "";
    }
}