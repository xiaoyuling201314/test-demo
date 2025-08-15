package com.dayuan3.terminal.bean;

public class SpecialOfferItem {
    /**
     *
     */
    private Integer id;

    /**
     *检测项目id
     */
    private String itemId;

    /**
     *活动id
     */
    private Integer offerId;
    
    
    private String itemName;//检测项目名称
    private String typeName;//类型名称
    private String typeId;//类型名称
    private double price;//检测单价
    

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

    /** 
     * Getter 
	 * @return special_offer_item.id 
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public Integer getId() {
        return id;
    }

    /** 
     * Setter
	 * @param idspecial_offer_item.id
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /** 
     * Getter 检测项目id
	 * @return special_offer_item.item_id 检测项目id
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public String getItemId() {
        return itemId;
    }

    /** 
     * Setter检测项目id
	 * @param itemIdspecial_offer_item.item_id
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public void setItemId(String itemId) {
        this.itemId = itemId == null ? null : itemId.trim();
    }

    /** 
     * Getter 活动id
	 * @return special_offer_item.offer_id 活动id
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public Integer getOfferId() {
        return offerId;
    }

    /** 
     * Setter活动id
	 * @param offerIdspecial_offer_item.offer_id
     *
     * @mbg.generated Wed Aug 28 13:23:54 CST 2019
     */
    public void setOfferId(Integer offerId) {
        this.offerId = offerId;
    }
}