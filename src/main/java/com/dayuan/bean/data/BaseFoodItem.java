package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 食品种类检测项目表
 * @TableName base_food_item
 */
@TableName(value ="base_food_item")
@Data
public class BaseFoodItem implements Serializable {
	/**
	 * 主键
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * 食品种类ID
	 */
	private Integer foodId;

	/**
	 * 检测项目ID
	 */
	private String itemId;

	/**
	 * 检测标准判定符号
	 */
	private String detectSign;

	/**
	 * 检测标准值
	 */
	private String detectValue;

	/**
	 * 检测标准值单位
	 */
	private String detectValueUnit;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 是否使用默认值,0:是 1:否
	 */
	private Integer useDefault;

	/**
	 * 有效状态(0:无效,1:有效)
	 */
	private Integer checked;

	/**
	 * 删除状态
	 */
	@TableLogic
	private Integer deleteFlag;

	/**
	 * 创建人id
	 */
	private String createBy;

	/**
	 * 创建时间
	 */
	private Date createDate;

	/**
	 * 修改人id
	 */
	private String updateBy;

	/**
	 * 修改时间
	 */
	private Date updateDate;
    
    /********************非数据库字段，仅用于页面显示**********************************/

	@TableField(exist = false)
    private String detectName;			//检测项目

	@TableField(exist = false)
    private String standardName;		//检测标准

	@TableField(exist = false)
    private String detectStandardValue;	//检测标准值

	@TableField(exist = false)
    private String detectSignStr;		//检测标准判定符号

	@TableField(exist = false)
    private String detectValueStr;		//检测标准值

	@TableField(exist = false)
    private String detectValueUnitStr;	//检测标准值单位

	@TableField(exist = false)
    private double price;				//检测费用

	@TableField(exist = false)
    private double discount;			//折扣率

	@TableField(exist = false)
    private Integer offerId;			//优惠活动表主键id

}