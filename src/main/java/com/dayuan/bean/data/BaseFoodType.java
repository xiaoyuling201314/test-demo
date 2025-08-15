package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 食品种类表
 * @TableName base_food_type
 */
@TableName(value ="base_food_type")
@Data
public class BaseFoodType implements Serializable {
	/**
	 * 自增
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * 食品种类名称
	 */
	private String foodName;

	/**
	 * 食品种类英文名称
	 */
	private String foodNameEn;

	/**
	 * 食品种类别名
	 */
	private String foodNameOther;

	/**
	 * 食品编码
	 */
	private String foodCode;

	/**
	 * 食品种类父id
	 */
	private Integer parentId;

	/**
	 * 监控等级
	 */
	private Integer cimonitorLevel;

	/**
	 * 是否是具体食品：0是类别，1是食品名称
	 */
	private Integer isfood;

	/**
	 * 排序
	 */
	private Integer sorting;

	/**
	 * 是否继承上级检测项目,0不继承,1继承
	 */
	private Integer isextends;

	/**
	 * 0未审核，1审核
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

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 其他平台样品编码
	 */
	private String otherCode;

	/**
	 * 其他平台样品种类父ID
	 */
	private Integer otherParentId;

	/**
	 * 其他平台样品种类
	 */
	private String otherType;

	/**
	 * 样品首字母
	 */
	private String foodFirstLetter;

	/**
	 * 样品全拼音
	 */
	private String foodFullLetter;

    /***********************非数据库字段，用于页面显示*******************************/
	@TableField(exist = false)
    private String parentName;//父类名称

	@TableField(exist = false)
    private String realName;//更新人名称


}