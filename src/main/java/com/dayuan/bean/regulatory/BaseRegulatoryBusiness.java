package com.dayuan.bean.regulatory;

import java.util.Date;

import com.dayuan.bean.BaseBean2;

public class BaseRegulatoryBusiness extends BaseBean2 {
	//监管对象ID
    private Integer regId;
    //档口/店面名称
    private String opeShopName;
    //档口/店面编号
    private String opeShopCode;
    //经营户名称
    private String opeName;
    //经营户身份证
    private String opeIdcard;
    //统一社会信用代码
    private String creditCode;
    //经营户联系方式
    private String opePhone;
    //信用等级
    private Short creditRating;
    //监控级别
    private Short monitoringLevel;
    //二维码
    private String qrcode;
    //审核状态
    private Short checked;
    //经营范围
    private String businessCope;
    //联系人
    private String contacts;
    //地址
    private String address;
    
    private String username;//经营户账号
    private Integer yiwanc;//经营户当天完成录入数量
    
    private String regName;//市场名称
    
    private String departName;//机构名称
	//类型:0:经营户;1:车辆
    private Integer type;
    
    /**
             *   委托单位首字母
     */
    private String businessFirstLetter;

    /**
             *     委托单位全拼音
     */
    private String businessFullLetter;
    
    public String getBusinessCope() {
		return businessCope;
	}
	public void setBusinessCope(String businessCope) {
		this.businessCope = businessCope;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getCreditCode() {
		return creditCode;
	}
    public Integer getYiwanc() {
		return yiwanc;
	}

	public void setYiwanc(Integer yiwanc) {
		this.yiwanc = yiwanc;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRegId() {
        return regId;
    }

    public void setRegId(Integer regId) {
        this.regId = regId;
    }

    public String getOpeShopName() {
        return opeShopName;
    }

    public void setOpeShopName(String opeShopName) {
        this.opeShopName = opeShopName == null ? null : opeShopName.trim();
    }

    public String getOpeShopCode() {
        return opeShopCode;
    }

    public void setOpeShopCode(String opeShopCode) {
        this.opeShopCode = opeShopCode == null ? null : opeShopCode.trim();
    }

    public String getOpeName() {
        return opeName;
    }

    public void setOpeName(String opeName) {
        this.opeName = opeName == null ? null : opeName.trim();
    }

    public String getOpeIdcard() {
        return opeIdcard;
    }

    public void setOpeIdcard(String opeIdcard) {
        this.opeIdcard = opeIdcard == null ? null : opeIdcard.trim();
    }

    public String getOpePhone() {
        return opePhone;
    }

    public void setOpePhone(String opePhone) {
        this.opePhone = opePhone == null ? null : opePhone.trim();
    }

    public Short getCreditRating() {
        return creditRating;
    }

    public void setCreditRating(Short creditRating) {
        this.creditRating = creditRating;
    }

    public Short getMonitoringLevel() {
        return monitoringLevel;
    }

    public void setMonitoringLevel(Short monitoringLevel) {
        this.monitoringLevel = monitoringLevel;
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode == null ? null : qrcode.trim();
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBusinessFirstLetter() {
		return businessFirstLetter;
	}
	public void setBusinessFirstLetter(String businessFirstLetter) {
		this.businessFirstLetter = businessFirstLetter;
	}
	public String getBusinessFullLetter() {
		return businessFullLetter;
	}
	public void setBusinessFullLetter(String businessFullLetter) {
		this.businessFullLetter = businessFullLetter;
	}
	
}