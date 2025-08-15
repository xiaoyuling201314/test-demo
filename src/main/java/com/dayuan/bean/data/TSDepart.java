package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.*;

/**
 * <p>
 * 快检项目组织机构
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-23
 */
@Data
@TableName("t_s_depart")
@NoArgsConstructor
@AllArgsConstructor
public class TSDepart implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 父级机构ID
     */
    private Integer departPid;

    /**
     * 项目组织机构名称
     */
    private String departName;

    /**
     * 负责人ID
     */
    private String principalId;

    /**
     * 区域id
     */
    private String regionId;

    /**
     * 机构编码
     */
    private String departCode;

    /**
     * 机构类型
     */
    private String departType;

    /**
     * 固话
     */
    private String mobilePhone;

    /**
     * 传真
     */
    private String fax;

    /**
     * 地址
     */
    private String address;

    /**
     * 排序
     */
    private Short sorting;

    /**
     * 删除状态
     */
    @TableLogic
    private Short deleteFlag;

    /**
     * 是否外部项目
     */
    private Short isOutsourcing;

    /**
     * 描述
     */
    private String description;

    /**
     * 创建人id
     */
    private String createBy;

    /**
     * 创建时间
     */
    @TableField(value = "create_date", fill = FieldFill.INSERT)
    private Date createDate;

    /**
     * 修改人id
     */
    private String updateBy;

    /**
     * 修改时间
     */
    @TableField(value = "update_date", fill = FieldFill.INSERT_UPDATE)
    private Date updateDate;

    /**
     * 项目ID
     */
    private String projectId;

    /**
     * 系统名称
     */
    private String systemName;

    /**
     * 系统LOGO
     */
    private String systemLogo;

    /**
     * 系统版权
     */
    private String systemCopyright;

    /********************非数据库字段，仅用于页面显示**********************************/

    @TableField(exist = false)
    private String departPname;	//父机构名称
    @TableField(exist = false)
    private String departNames;//机构名称+(机构id)
    @TableField(exist = false)
    private String departPnames;//父机构名称+(机构id)
    @TableField(exist = false)
    private Integer pointNumbers=0;//检测点数量
    @TableField(exist = false)
    private String childIds;//所有子类的ID集合
}
