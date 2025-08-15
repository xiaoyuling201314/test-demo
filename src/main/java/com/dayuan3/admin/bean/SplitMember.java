package com.dayuan3.admin.bean;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;

import lombok.*;

/**
 * <p>
 * 分账子商户编号管理
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-21
 */
@Data
@TableName("tb_split_member")
@NoArgsConstructor
@AllArgsConstructor
public class SplitMember implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 分账方子商户编号
     */
    private String mbUserId;

    /**
     * 分账方名称
     */
    private String mbUserName;

    /**
     * 分账比例
     */
    private Integer splitRate;

    /**
     * 备注
     */
    private String remark;

    /**
     * 是否删除
     */
    @TableLogic
    private Short deleteFlag;

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
     * 预留参数1
     */
    private String param1;

    /**
     * 预留参数2
     */
    private String param2;

    /**
     * 预留参数3
     */
    private String param3;
}
