package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 检测项目表
 * @TableName base_detect_item
 */
@TableName(value ="base_detect_item")
@Data
public class BaseDetectItem implements Serializable {
    /**
     * 主键
     */
    @TableId
    private String id;

    /**
     * 检测项目名称
     */
    private String detectItemName;

    /**
     * 检测项目类型
     */
    private String detectItemTypeid;

    /**
     * 检测标准ID
     */
    private String standardId;

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
     * 0未审核，1审核
     */
    private Integer checked;

    /**
     * 监控级别
     */
    private Integer cimonitorLevel;

    /**
     * 备注
     */
    private String remark;

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
     * 其他平台检测项目编码
     */
    private String otherCode;

    /**
     * 其他平台检测项目类型
     */
    private String otherType;

    /**
     * 检测项目单价
     */
    private Double price;

    /**
     * 优惠活动表主键id
     */
    private Integer offerId;

    /**
     * 折扣率,保留4位小数
     */
    private Double discount;
    
    /**************非数据库字段，用于页面显示**********************/
    @TableField(exist = false)
    private String detectItemTypeName;//项目类别

    @TableField(exist = false)
    private String stdCode;//检测标准编号

    @TableField(exist = false)
    private String checkStandardValue;//拼接 判定符号+标准值+单位

}