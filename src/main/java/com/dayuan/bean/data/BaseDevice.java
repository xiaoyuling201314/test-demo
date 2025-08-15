package com.dayuan.bean.data;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.dayuan.bean.BaseBean;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * 仪器基础表
 * @TableName base_device
 */
@TableName(value ="base_device")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BaseDevice implements Serializable {

    /**
     * 主键
     */
    @TableId
    private String id;

    /**
     * 出厂编号
     */
    private String deviceCode;

    /**
     * 仪器名称
     */
    private String deviceName;

    /**
     * 辅助设备	| 仪器设备 | 检测箱
     */
    private String deviceStyle;

    /**
     * 系列id，base_device_type.id
     */
    private String deviceTypeId;

    /**
     * 负责人 base_user.id
     */
    private String baseUserId;

    /**
     * 出厂日期
     */
    private Date useDate;

    /**
     * 保修有效期(月)
     */
    private Integer month;

    /**
     * 保修期
     */
    private Date warrantyPeriod;

    /**
     * 排序
     */
    private Integer sorting;

    /**
     * 功能描述
     */
    private String description;

    /**
     * 状态(0:启用,1:停用)
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 仪器mac地址
     */
    private String macAddress;

    /**
     * 仪器唯一标识(由仪器系列series+yyyyMMdd+4位随机数)
     */
    private String serialNumber;

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
     * 辅助设备、检测箱品牌
     */
    private String brand;

    /**
     * 所属组织机构ID
     */
    private Integer departId;

    /**
     * 检测点ID
     */
    private Integer pointId;

    /**
     * 物联网平台主键id
     */
    private Integer yunId;

    /**
     * 注册时间
     */
    private Date registerDate;

    /**
     * 累计上传检测数据数量
     */
    private Integer uploadNumbers;

    /**
     * 最后使用时间/最后上传数据时间
     */
    private Date lastUploadDate;

    /**
     * 解绑时间
     */
    private Date unbindingDate;
    /**
     * 仪器系列
     */
    @TableField(exist = false)
    private String deviceSeries;
}