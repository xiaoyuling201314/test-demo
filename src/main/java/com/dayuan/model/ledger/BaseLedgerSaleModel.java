package com.dayuan.model.ledger;

import java.util.Date;

import com.dayuan.model.BaseModel;

public class BaseLedgerSaleModel extends BaseModel {
    /**
     *销售台账主键id
     */
    private Integer id;

    /**
     *经营户名称
     */
    private String businessName;

    /**
     *经营户id
     */
    private String businessId;

    /**
     *所在市场名称
     */
    private String regName;

    /**
     *所在市场主键id
     */
    private String regId;

    /**
     *销售食品名称
     */
    private String foodName;

    /**
     *销售时间
     */
    private Date saleDate;

    /**
     *规格
     */
    private String size;

    /**
     *销售数量
     */
    private String saleCount;

    /**
     *备用(销售对象id)
     */
    private String customerId;

    /**
     *销售对象所在市场
     */
    private String cusRegName;

    /**
     *销售对象联系方式
     */
    private String cusPhone;

    /**
     *销售对象所在档口名称
     */
    private String cusName;

    /**
     *销售对象档口号
     */
    private String cusCode;

    /**
     *销售对象
     */
    private String customer;

    /**
     *备注信息
     */
    private String memo;

    /**
     *删除状态1为删除
     */
    private Short delete_flag;

    /**
     *创建人
     */
    private String create_by;

    /**
     *创建时间
     */
    private Date create_date;

    /**
     *更新人
     */
    private String update_by;

    /**
     *更新时间
     */
    private Date update_date;

    /**
     *备用字段1
     */
    private String param1;

    /**
     *
     */
    private String param2;

    /**
     *备用字段3
     */
    private String param3;
    private String startDate;//微信上传查询时间
    
    private Integer allCount;//台账统计报表查询 市场下全部经营户数量
    private Integer yiwanc;//已完成数量
    private String reg_name;//所在市场
    private String reg_id;//市场id
    private String opeShopCode;//档口编号
    private String search;
    private String saleDateStartDate;//高级查询中的起始时间
    
    private String saleDateEndDate;//高级查询中的结束时间
    private String regtype;//监管对象类型
    

	public String getRegtype() {
		return regtype;
	}

	public void setRegtype(String regtype) {
		this.regtype = regtype;
	}

 

	public String getSaleDateStartDate() {
		return saleDateStartDate;
	}

	public void setSaleDateStartDate(String saleDateStartDate) {
		this.saleDateStartDate = saleDateStartDate;
	}

 

	public String getSaleDateEndDate() {
		return saleDateEndDate;
	}

	public void setSaleDateEndDate(String saleDateEndDate) {
		this.saleDateEndDate = saleDateEndDate;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
	public String getOpeShopCode() {
		return opeShopCode;
	}

	public void setOpeShopCode(String opeShopCode) {
		this.opeShopCode = opeShopCode;
	}

	public Integer getAllCount() {
		return allCount;
	}

	public void setAllCount(Integer allCount) {
		this.allCount = allCount;
	}

	public Integer getYiwanc() {
		return yiwanc;
	}

	public void setYiwanc(Integer yiwanc) {
		this.yiwanc = yiwanc;
	}

	public String getReg_name() {
		return reg_name;
	}

	public void setReg_name(String reg_name) {
		this.reg_name = reg_name;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getStartDate() {
  		return startDate;
  	}

  	public void setStartDate(String startDate) {
  		this.startDate = startDate;
  	}

    /** 
     * Getter 销售台账主键id
	 * @return base_ledger_sale.id 销售台账主键id
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter销售台账主键id
	 * @param idbase_ledger_sale.id
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 经营户名称
	 * @return base_ledger_sale.businessName 经营户名称
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getBusinessName() {
        return businessName;
    }

    /** 
     * Setter经营户名称
	 * @param businessNamebase_ledger_sale.businessName
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setBusinessName(String businessName) {
        this.businessName = businessName == null ? null : businessName.trim();
    }

    /** 
     * Getter 经营户id
	 * @return base_ledger_sale.businessId 经营户id
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getBusinessId() {
        return businessId;
    }

    /** 
     * Setter经营户id
	 * @param businessIdbase_ledger_sale.businessId
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setBusinessId(String businessId) {
        this.businessId = businessId == null ? null : businessId.trim();
    }

    /** 
     * Getter 所在市场名称
	 * @return base_ledger_sale.regName 所在市场名称
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getRegName() {
        return regName;
    }

    /** 
     * Setter所在市场名称
	 * @param regNamebase_ledger_sale.regName
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setRegName(String regName) {
        this.regName = regName == null ? null : regName.trim();
    }

    /** 
     * Getter 所在市场主键id
	 * @return base_ledger_sale.regId 所在市场主键id
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getRegId() {
        return regId;
    }

    /** 
     * Setter所在市场主键id
	 * @param regIdbase_ledger_sale.regId
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setRegId(String regId) {
        this.regId = regId == null ? null : regId.trim();
    }

    /** 
     * Getter 销售食品名称
	 * @return base_ledger_sale.foodName 销售食品名称
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getFoodName() {
        return foodName;
    }

    /** 
     * Setter销售食品名称
	 * @param foodNamebase_ledger_sale.foodName
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setFoodName(String foodName) {
        this.foodName = foodName == null ? null : foodName.trim();
    }

    /** 
     * Getter 销售时间
	 * @return base_ledger_sale.saleDate 销售时间
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public Date getSaleDate() {
        return saleDate;
    }

    /** 
     * Setter销售时间
	 * @param saleDatebase_ledger_sale.saleDate
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    /** 
     * Getter 规格
	 * @return base_ledger_sale.size 规格
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getSize() {
        return size;
    }

    /** 
     * Setter规格
	 * @param sizebase_ledger_sale.size
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setSize(String size) {
        this.size = size == null ? null : size.trim();
    }

    /** 
     * Getter 销售数量
	 * @return base_ledger_sale.saleCount 销售数量
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getSaleCount() {
        return saleCount;
    }

    /** 
     * Setter销售数量
	 * @param saleCountbase_ledger_sale.saleCount
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setSaleCount(String saleCount) {
        this.saleCount = saleCount == null ? null : saleCount.trim();
    }

    /** 
     * Getter 备用(销售对象id)
	 * @return base_ledger_sale.customerId 备用(销售对象id)
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCustomerId() {
        return customerId;
    }

    /** 
     * Setter备用(销售对象id)
	 * @param customerIdbase_ledger_sale.customerId
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCustomerId(String customerId) {
        this.customerId = customerId == null ? null : customerId.trim();
    }

    /** 
     * Getter 销售对象所在市场
	 * @return base_ledger_sale.cusRegName 销售对象所在市场
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCusRegName() {
        return cusRegName;
    }

    /** 
     * Setter销售对象所在市场
	 * @param cusRegNamebase_ledger_sale.cusRegName
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCusRegName(String cusRegName) {
        this.cusRegName = cusRegName == null ? null : cusRegName.trim();
    }

    /** 
     * Getter 销售对象联系方式
	 * @return base_ledger_sale.cusPhone 销售对象联系方式
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCusPhone() {
        return cusPhone;
    }

    /** 
     * Setter销售对象联系方式
	 * @param cusPhonebase_ledger_sale.cusPhone
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCusPhone(String cusPhone) {
        this.cusPhone = cusPhone == null ? null : cusPhone.trim();
    }

    /** 
     * Getter 销售对象所在档口名称
	 * @return base_ledger_sale.cusName 销售对象所在档口名称
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCusName() {
        return cusName;
    }

    /** 
     * Setter销售对象所在档口名称
	 * @param cusNamebase_ledger_sale.cusName
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCusName(String cusName) {
        this.cusName = cusName == null ? null : cusName.trim();
    }

    /** 
     * Getter 销售对象档口号
	 * @return base_ledger_sale.cusCode 销售对象档口号
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCusCode() {
        return cusCode;
    }

    /** 
     * Setter销售对象档口号
	 * @param cusCodebase_ledger_sale.cusCode
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCusCode(String cusCode) {
        this.cusCode = cusCode == null ? null : cusCode.trim();
    }

    /** 
     * Getter 销售对象
	 * @return base_ledger_sale.customer 销售对象
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCustomer() {
        return customer;
    }

    /** 
     * Setter销售对象
	 * @param customerbase_ledger_sale.customer
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCustomer(String customer) {
        this.customer = customer == null ? null : customer.trim();
    }

    /** 
     * Getter 备注信息
	 * @return base_ledger_sale.memo 备注信息
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getMemo() {
        return memo;
    }

    /** 
     * Setter备注信息
	 * @param memobase_ledger_sale.memo
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    /** 
     * Getter 删除状态1为删除
	 * @return base_ledger_sale.delete_flag 删除状态1为删除
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public Short getDelete_flag() {
        return delete_flag;
    }

    /** 
     * Setter删除状态1为删除
	 * @param delete_flagbase_ledger_sale.delete_flag
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setDelete_flag(Short delete_flag) {
        this.delete_flag = delete_flag;
    }

    /** 
     * Getter 创建人
	 * @return base_ledger_sale.create_by 创建人
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getCreate_by() {
        return create_by;
    }

    /** 
     * Setter创建人
	 * @param create_bybase_ledger_sale.create_by
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCreate_by(String create_by) {
        this.create_by = create_by == null ? null : create_by.trim();
    }

    /** 
     * Getter 创建时间
	 * @return base_ledger_sale.create_date 创建时间
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public Date getCreate_date() {
        return create_date;
    }

    /** 
     * Setter创建时间
	 * @param create_datebase_ledger_sale.create_date
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    /** 
     * Getter 更新人
	 * @return base_ledger_sale.update_by 更新人
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getUpdate_by() {
        return update_by;
    }

    /** 
     * Setter更新人
	 * @param update_bybase_ledger_sale.update_by
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setUpdate_by(String update_by) {
        this.update_by = update_by == null ? null : update_by.trim();
    }

    /** 
     * Getter 更新时间
	 * @return base_ledger_sale.update_date 更新时间
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public Date getUpdate_date() {
        return update_date;
    }

    /** 
     * Setter更新时间
	 * @param update_datebase_ledger_sale.update_date
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    /** 
     * Getter 备用字段1
	 * @return base_ledger_sale.param1 备用字段1
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter备用字段1
	 * @param param1base_ledger_sale.param1
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 
	 * @return base_ledger_sale.param2 
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter
	 * @param param2base_ledger_sale.param2
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 备用字段3
	 * @return base_ledger_sale.param3 备用字段3
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter备用字段3
	 * @param param3base_ledger_sale.param3
     *
     * @mbg.generated Tue May 08 13:11:49 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }
}