package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 检测计划
 * @TableName tb_check_plan
 */
@TableName(value ="tb_check_plan")
@Data
public class TbCheckPlan implements Serializable {
    /**
     * 主键ID
     */
    @TableId
    private Integer id;

    /**
     * 第几周
     */
    private Integer weekNum;

    /**
     * 样品ID
     */
    private Integer foodId;

    /**
     * 星期一项目
     */
    private String itemIdMon;

    /**
     * 星期二项目
     */
    private String itemIdTue;

    /**
     * 星期三项目
     */
    private String itemIdWeb;

    /**
     * 星期四项目
     */
    private String itemIdThu;

    /**
     * 星期五项目
     */
    private String itemIdFri;

    /**
     * 星期六项目
     */
    private String itemIdSat;

    /**
     * 星期日项目
     */
    private String itemIdSun;

    /**
     * 删除状态 1是已删除 0是未删除
     */
    @TableLogic
    private Integer deleteFlag;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 创建人id
     */
    private String createBy;

    /**
     * 修改时间
     */
    private Date updateDate;

    /**
     * 修改人id
     */
    private String updateBy;

    @TableField(exist = false)
    private String foodName;
    /**
     * 星期一检测项目名称
     */
    @TableField(exist = false)
    private String itemName1;
    /**
     * 星期二检测项目名称
     */
    @TableField(exist = false)
    private String itemName2;
    /**
     * 星期三检测项目名称
     */
    @TableField(exist = false)
    private String itemName3;
    /**
     * 星期四检测项目名称
     */
    @TableField(exist = false)
    private String itemName4;
    /**
     * 星期五检测项目名称
     */
    @TableField(exist = false)
    private String itemName5;
    /**
     * 星期六检测项目名称
     */
    @TableField(exist = false)
    private String itemName6;

    /**
     * 星期日检测项目名称
     */
    @TableField(exist = false)
    private String itemName7;
}