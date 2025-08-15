package com.dayuan.bean.regulatory;

import com.dayuan.bean.BaseBean;

public class BaseRegulatoryType extends BaseBean {

	//监管对象类型
    private String regType;
    
    //监管对象类型编码
    private String regTypeCode;

    //审核状态
    private Short checked;
    
    //显示经营户
    private Short showBusiness;
    private Short  stockType;//2018-12-25 新增台账录入类型0：针对经营户录入台账1：针对市场录入台账
    //监管对象数量
    private int regNumbers;//add by xiaoyl 2022/08/24 微信端检测总览页面使用
    
    public Short getStockType() {
		return stockType;
	}

	public void setStockType(Short stockType) {
		this.stockType = stockType;
	}

	public String getRegType() {
        return regType;
    }

    public void setRegType(String regType) {
        this.regType = regType == null ? null : regType.trim();
    }


    public Short getChecked() {
        return checked;
    }

    public void setChecked(Short checked) {
        this.checked = checked;
    }

	public Short getShowBusiness() {
		return showBusiness;
	}

	public void setShowBusiness(Short showBusiness) {
		this.showBusiness = showBusiness;
	}

	public String getRegTypeCode() {
		return regTypeCode;
	}

	public void setRegTypeCode(String regTypeCode) {
		this.regTypeCode = regTypeCode;
	}

    public int getRegNumbers() {
        return regNumbers;
    }

    public void setRegNumbers(int regNumbers) {
        this.regNumbers = regNumbers;
    }
}