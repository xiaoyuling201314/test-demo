package com.dayuan.bean.data;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 检测标准
 * @TableName base_standard
 */
@TableName(value ="base_standard")
@Data
public class BaseStandard implements Serializable {
    /**
     * 主键自增
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 标准编号
     */
    private String stdCode;

    /**
     * 标准名称
     */
    private String stdName;

    /**
     * 标题
     */
    private String stdTitle;

    /**
     * 发布单位
     */
    private String stdUnit;

    /**
     * 标准类型
     */
    private String stdType;

    /**
     * 标准状态
     */
    private String stdStatus;

    /**
     * 实时日期
     */
    private Date impTime;

    /**
     * 发布日期
     */
    private Date relTime;

    /**
     * 下载路径
     */
    private String urlPath;

    /**
     * 项目状态：0未使用，1:使用
     */
    private Integer useStatus;

    /**
     * 删除状态
     */
    @TableLogic
    private Integer deleteFlag;

    /**
     * 备用ID
     */
    private String stdId;

    /**
     * 排序
     */
    private Integer sorting;

    /**
     * 备注
     */
    private String remark;

    /**
     * 创建人员
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 更新人员
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateDate;

}