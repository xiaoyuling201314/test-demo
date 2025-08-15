package com.dayuan3.admin.bean.chain;

import com.dayuan.bean.BaseBean2;

import java.util.Date;

public class ColdChainUnit extends BaseBean2 {


    private Integer id;//ID
    private String regName;//单位名称
    private Integer departId;//所属组织机构ID
    private Integer regType;//单位类型：0 企业，1 个人'
    private String creditCode;//统一社会信用代码
    private String companyName;//企业名称
    private String legalPerson;//法人名称
    private String legalPhone;//法人联系方式
    private String linkUser;//联系人
    private String linkPhone;//联系方式
    private String linkIdcard;//联系人身份证
    private Double regionId;//所属区域id
    private String regAddress;//详细地址
    private String placeX;//坐标x，经度
    private String placeY;//坐标y，纬度
    private String qrcode;//二维码
    private String filePath;//附件
    private String remark;//备注
    private Short checked;//审核状态
    private Short deleteFlag;//删除状态
    private Short sorting;//排序
    private String createBy;//创建人id
    private Date createDate;//创建时间',
    private String updateBy;//修改人id
    private Date updateDate;//修改时间
    private String param1;//预留参数1
    private String param2;//预留参数2
    private String param3;//预留参数3

    private String departName;
    private int businessNumber; //经营户数量
    private Integer unqualifiedNumber;//监管对象当天的不合格检测数
    private String username;//监管对象登录微信账号
    private String pwd;//监管对象登录微信密码
    private String regTypeName;//监管对象类型名称s
    private Short showBusiness;//显示经营者,0隐藏,1展示 add by xiaoyl 2020/10/12


    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getRegName() {return regName;}
    public void setRegName(String regName) {
        this.regName = regName == null ? null : regName.trim();
    }

    public Integer getDepartId() {
        return departId;
    }
    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public Integer getRegType() {return regType;}
    public void setRegType(Integer regType) {
        this.regType = regType;
    }

    public String getCreditCode() {
        return creditCode;
    }
    public void setCreditCode(String creditCode) {
        this.creditCode = creditCode == null ? null : creditCode.trim();
    }

    public String getCompanyName() {
        return companyName;
    }
    public void setCompanyName(String companyName) {
        this.companyName = companyName == null ? null : companyName.trim();
    }

    public String getLegalPerson() {
        return legalPerson;
    }
    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson;
    }

    public String getLegalPhone() {
        return legalPhone;
    }
    public void setLegalPhone(String legalPhone) {
        this.legalPhone = legalPhone == null ? null : legalPhone.trim();
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
        this.linkPhone = linkPhone == null ? null : linkPhone.trim();
    }

    public String getLinkIdcard() {
        return linkIdcard;
    }
    public void setLinkIdcard(String linkIdcard) {
        this.linkIdcard = linkIdcard == null ? null : linkIdcard.trim();
    }


    public Double getRegionId() {return regionId;}
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

    public String getQrcode() {
        return qrcode;
    }
    public void setQrcode(String qrcode) {this.qrcode = qrcode == null ? null : qrcode.trim();}

    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Short getChecked() {
        return checked;
    }
    public void setChecked(Short checked) {
        this.checked = checked;
    }

    public Short getDeleteFlag() {
        return deleteFlag;
    }
    public void setDeleteFlag(Short deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public Short getSorting() {
        return sorting;
    }
    public void setSorting(Short sorting) {
        this.sorting = sorting;
    }

    public String getCreateBy() {
        return createBy;
    }
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
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
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getParam1() {return param1;}
    public void setParam1(String param1) {this.param1 = param1;}

    public String getParam2() {return param2;}
    public void setParam2(String param2) {this.param2= param2;}

    public String getParam3() {return param3;}
    public void setParam3(String param3) {this.param3 = param3;}

    public String getDepartName() {
        return departName;
    }
    public void setDepartName(String departName) {
        this.departName = departName;
    }


    public int getBusinessNumber() {
        return businessNumber;
    }
    public void setBusinessNumber(int businessNumber) {
        this.businessNumber = businessNumber;
    }

    public Integer getUnqualifiedNumber() {
        return unqualifiedNumber;
    }
    public void setUnqualifiedNumber(Integer unqualifiedNumber) {
        this.unqualifiedNumber = unqualifiedNumber;
    }


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

}