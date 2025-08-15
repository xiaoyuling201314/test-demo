package com.dayuan.model.ledger;

import java.math.BigDecimal;
import java.util.Date;

import com.dayuan.model.BaseModel;

public class BaseLedgerStockModel  extends BaseModel {
    /**
     *进货台账主键id
     */
    private Integer id;

    private Integer regId;
    /**
     *经营户id
     */
    private Integer businessId;

    /**
     *进货食品名称
     */
    private String foodName;

    /**
     *备用字段，方便以后供应商关联
     */
    private String supplierId;

    /**
     *供应商联系人/负责人
     */
    private String supplierUser;

    /**
     *供货商电话
     */
    private String supplierTel;

    /**
     *供货商
     */
    private String supplier;

    /**
     *批号
     */
    private String batchNumber;

    /**
     *规格
     */
    private String size;

    /**
     *进货日期
     */
    private Date stockDate;

    /**
     *保质期
     */
    private String expirationDate;

    /**
     *进货数量
     */
    private BigDecimal stockCount;

    /**
     *产地
     */
    private String productionPlace;

    /**
     *生产日期
     */
    private Date productionDate;

    /**
     *进货凭证
     */
    private String stockProof;

    /**
     *进货证明图片
     */
    private String stockProof_Img;

    /**
     *检验证明
     */
    private String checkProof;

    /**
     *检验证明图片
     */
    private String checkProof_Img;

    /**
     *检疫证明
     */
    private String quarantineProof;

    /**
     *检疫证明图片
     */
    private String quarantineProof_Img;

    /**
     *备注
     */
    private String memo;

    /**
     *附件
     */
    private String accessory;

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
     *预留参数
     */
    private String param1;

    /**
     *
     */
    private String param2;

    /**
     *
     */
    private String param3;
    
    
    
    private Integer allCount;//台账统计报表查询 市场下全部经营户数量
    private Integer yiwanc;//已完成数量

    private String reg_name;//所在市场
    private String reg_id;//市场id
    private String startDate;//微信上传查询时间
   
    private String opeShopCode;
    private String search;
    
    private String stockDateStartDate;//高级查询中的起始时间
    
    private String stockDateEndDate;//高级查询中的结束时间
    private Integer departId;//机构id
    private String regtype;//监管对象类型
    private String departCode;//监管对象类型
    
	 
	

	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public String getRegtype() {
		return regtype;
	}

	public void setRegtype(String regtype) {
		this.regtype = regtype;
	}

	public String getStockDateStartDate() {
		return stockDateStartDate;
	}

	public void setStockDateStartDate(String stockDateStartDate) {
		this.stockDateStartDate = stockDateStartDate;
	}

	public String getStockDateEndDate() {
		return stockDateEndDate;
	}

	public void setStockDateEndDate(String stockDateEndDate) {
		this.stockDateEndDate = stockDateEndDate;
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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/** 
     * Getter 进货台账主键id
	 * @return base_ledger_stock.id 进货台账主键id
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
 


	public String getReg_name() {
		return reg_name;
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

	public void setReg_name(String reg_name) {
		this.reg_name = reg_name;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	/** 
     * Getter 经营户id
	 * @return base_ledger_stock.businessId 经营户id
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Integer getBusinessId() {
        return businessId;
    }

    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/** 
     * Setter经营户id
	 * @param businessIdbase_ledger_stock.businessId
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setBusinessId(Integer businessId) {
        this.businessId = businessId;
    }

    /** 
     * Getter 进货食品名称
	 * @return base_ledger_stock.foodName 进货食品名称
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getFoodName() {
        return foodName;
    }

    /** 
     * Setter进货食品名称
	 * @param foodNamebase_ledger_stock.foodName
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setFoodName(String foodName) {
        this.foodName = foodName == null ? null : foodName.trim();
    }

    /** 
     * Getter 备用字段，方便以后供应商关联
	 * @return base_ledger_stock.supplierId 备用字段，方便以后供应商关联
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getSupplierId() {
        return supplierId;
    }

    /** 
     * Setter备用字段，方便以后供应商关联
	 * @param supplierIdbase_ledger_stock.supplierId
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId == null ? null : supplierId.trim();
    }

    /** 
     * Getter 供应商联系人/负责人
	 * @return base_ledger_stock.supplierUser 供应商联系人/负责人
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getSupplierUser() {
        return supplierUser;
    }

    /** 
     * Setter供应商联系人/负责人
	 * @param supplierUserbase_ledger_stock.supplierUser
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setSupplierUser(String supplierUser) {
        this.supplierUser = supplierUser == null ? null : supplierUser.trim();
    }

    /** 
     * Getter 供货商电话
	 * @return base_ledger_stock.supplierTel 供货商电话
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getSupplierTel() {
        return supplierTel;
    }

    /** 
     * Setter供货商电话
	 * @param supplierTelbase_ledger_stock.supplierTel
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setSupplierTel(String supplierTel) {
        this.supplierTel = supplierTel == null ? null : supplierTel.trim();
    }

    /** 
     * Getter 供货商
	 * @return base_ledger_stock.supplier 供货商
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getSupplier() {
        return supplier;
    }

    /** 
     * Setter供货商
	 * @param supplierbase_ledger_stock.supplier
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setSupplier(String supplier) {
        this.supplier = supplier == null ? null : supplier.trim();
    }

    /** 
     * Getter 批号
	 * @return base_ledger_stock.batchNumber 批号
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getBatchNumber() {
        return batchNumber;
    }

    /** 
     * Setter批号
	 * @param batchNumberbase_ledger_stock.batchNumber
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber == null ? null : batchNumber.trim();
    }

    /** 
     * Getter 规格
	 * @return base_ledger_stock.size 规格
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getSize() {
        return size;
    }

    /** 
     * Setter规格
	 * @param sizebase_ledger_stock.size
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setSize(String size) {
        this.size = size == null ? null : size.trim();
    }

    /** 
     * Getter 进货日期
	 * @return base_ledger_stock.stockDate 进货日期
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Date getStockDate() {
        return stockDate;
    }

    /** 
     * Setter进货日期
	 * @param stockDatebase_ledger_stock.stockDate
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setStockDate(Date stockDate) {
        this.stockDate = stockDate;
    }

    /** 
     * Getter 保质期
	 * @return base_ledger_stock.expirationDate 保质期
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getExpirationDate() {
        return expirationDate;
    }

    /** 
     * Setter保质期
	 * @param expirationDatebase_ledger_stock.expirationDate
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate == null ? null : expirationDate.trim();
    }

    /** 
     * Getter 进货数量
	 * @return base_ledger_stock.stockCount 进货数量
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public BigDecimal getStockCount() {
        return stockCount;
    }

    /** 
     * Setter进货数量
	 * @param stockCountbase_ledger_stock.stockCount
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setStockCount(BigDecimal stockCount) {
        this.stockCount = stockCount;
    }

    /** 
     * Getter 产地
	 * @return base_ledger_stock.productionPlace 产地
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getProductionPlace() {
        return productionPlace;
    }

    /** 
     * Setter产地
	 * @param productionPlacebase_ledger_stock.productionPlace
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setProductionPlace(String productionPlace) {
        this.productionPlace = productionPlace == null ? null : productionPlace.trim();
    }

    /** 
     * Getter 生产日期
	 * @return base_ledger_stock.productionDate 生产日期
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Date getProductionDate() {
        return productionDate;
    }

    /** 
     * Setter生产日期
	 * @param productionDatebase_ledger_stock.productionDate
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setProductionDate(Date productionDate) {
        this.productionDate = productionDate;
    }

    /** 
     * Getter 进货凭证
	 * @return base_ledger_stock.stockProof 进货凭证
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getStockProof() {
        return stockProof;
    }

    /** 
     * Setter进货凭证
	 * @param stockProofbase_ledger_stock.stockProof
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setStockProof(String stockProof) {
        this.stockProof = stockProof == null ? null : stockProof.trim();
    }

    /** 
     * Getter 进货证明图片
	 * @return base_ledger_stock.stockProof_Img 进货证明图片
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getStockProof_Img() {
        return stockProof_Img;
    }

    /** 
     * Setter进货证明图片
	 * @param stockProof_Imgbase_ledger_stock.stockProof_Img
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setStockProof_Img(String stockProof_Img) {
        this.stockProof_Img = stockProof_Img == null ? null : stockProof_Img.trim();
    }

    /** 
     * Getter 检验证明
	 * @return base_ledger_stock.checkProof 检验证明
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getCheckProof() {
        return checkProof;
    }

    /** 
     * Setter检验证明
	 * @param checkProofbase_ledger_stock.checkProof
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setCheckProof(String checkProof) {
        this.checkProof = checkProof == null ? null : checkProof.trim();
    }

    /** 
     * Getter 检验证明图片
	 * @return base_ledger_stock.checkProof_Img 检验证明图片
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getCheckProof_Img() {
        return checkProof_Img;
    }

    /** 
     * Setter检验证明图片
	 * @param checkProof_Imgbase_ledger_stock.checkProof_Img
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setCheckProof_Img(String checkProof_Img) {
        this.checkProof_Img = checkProof_Img == null ? null : checkProof_Img.trim();
    }

    /** 
     * Getter 检疫证明
	 * @return base_ledger_stock.quarantineProof 检疫证明
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getQuarantineProof() {
        return quarantineProof;
    }

    /** 
     * Setter检疫证明
	 * @param quarantineProofbase_ledger_stock.quarantineProof
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setQuarantineProof(String quarantineProof) {
        this.quarantineProof = quarantineProof == null ? null : quarantineProof.trim();
    }

    /** 
     * Getter 检疫证明图片
	 * @return base_ledger_stock.quarantineProof_Img 检疫证明图片
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getQuarantineProof_Img() {
        return quarantineProof_Img;
    }

    /** 
     * Setter检疫证明图片
	 * @param quarantineProof_Imgbase_ledger_stock.quarantineProof_Img
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setQuarantineProof_Img(String quarantineProof_Img) {
        this.quarantineProof_Img = quarantineProof_Img == null ? null : quarantineProof_Img.trim();
    }

    /** 
     * Getter 备注
	 * @return base_ledger_stock.memo 备注
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getMemo() {
        return memo;
    }

    /** 
     * Setter备注
	 * @param memobase_ledger_stock.memo
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    /** 
     * Getter 附件
	 * @return base_ledger_stock.accessory 附件
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getAccessory() {
        return accessory;
    }

    /** 
     * Setter附件
	 * @param accessorybase_ledger_stock.accessory
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setAccessory(String accessory) {
        this.accessory = accessory == null ? null : accessory.trim();
    }

    /** 
     * Getter 删除状态1为删除
	 * @return base_ledger_stock.delete_flag 删除状态1为删除
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Short getDelete_flag() {
        return delete_flag;
    }

    /** 
     * Setter删除状态1为删除
	 * @param delete_flagbase_ledger_stock.delete_flag
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setDelete_flag(Short delete_flag) {
        this.delete_flag = delete_flag;
    }

    /** 
     * Getter 创建人
	 * @return base_ledger_stock.create_by 创建人
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getCreate_by() {
        return create_by;
    }

    /** 
     * Setter创建人
	 * @param create_bybase_ledger_stock.create_by
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setCreate_by(String create_by) {
        this.create_by = create_by == null ? null : create_by.trim();
    }

    /** 
     * Getter 创建时间
	 * @return base_ledger_stock.create_date 创建时间
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Date getCreate_date() {
        return create_date;
    }

    /** 
     * Setter创建时间
	 * @param create_datebase_ledger_stock.create_date
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    /** 
     * Getter 更新人
	 * @return base_ledger_stock.update_by 更新人
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getUpdate_by() {
        return update_by;
    }

    /** 
     * Setter更新人
	 * @param update_bybase_ledger_stock.update_by
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setUpdate_by(String update_by) {
        this.update_by = update_by == null ? null : update_by.trim();
    }

    /** 
     * Getter 更新时间
	 * @return base_ledger_stock.update_date 更新时间
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public Date getUpdate_date() {
        return update_date;
    }

    /** 
     * Setter更新时间
	 * @param update_datebase_ledger_stock.update_date
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    /** 
     * Getter 预留参数
	 * @return base_ledger_stock.param1 预留参数
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getParam1() {
        return param1;
    }

    /** 
     * Setter预留参数
	 * @param param1base_ledger_stock.param1
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setParam1(String param1) {
        this.param1 = param1 == null ? null : param1.trim();
    }

    /** 
     * Getter 
	 * @return base_ledger_stock.param2 
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getParam2() {
        return param2;
    }

    /** 
     * Setter
	 * @param param2base_ledger_stock.param2
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setParam2(String param2) {
        this.param2 = param2 == null ? null : param2.trim();
    }

    /** 
     * Getter 
	 * @return base_ledger_stock.param3 
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public String getParam3() {
        return param3;
    }

    /** 
     * Setter
	 * @param param3base_ledger_stock.param3
     *
     * @mbg.generated Wed May 02 14:40:58 CST 2018
     */
    public void setParam3(String param3) {
        this.param3 = param3 == null ? null : param3.trim();
    }

	public Integer getRegId() {
		return regId;
	}

	public void setRegId(Integer regId) {
		this.regId = regId;
	}
    
}