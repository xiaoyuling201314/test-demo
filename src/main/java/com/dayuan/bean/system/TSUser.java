package com.dayuan.bean.system;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统用户表
 * @TableName t_s_user
 */
@TableName(value ="t_s_user")
@Data
public class TSUser implements Serializable {
    /**
     * ID
     */
    @TableId
    private String id;

    /**
     *  基本信息
     */
    private String workersId;

    /**
     * 用户账号
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    /**
     * 上次修改密码时间
     */
    private Date editPwTime;

    /**
     * 昵称
     */
    private String realname;

    /**
     * 用户对应的角色id
     */
    private String roleId;

    /**
     * 有效状态
     */
    private Integer status;

    /**
     * 排序
     */
    private Integer sorting;

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
     * 删除状态
     */
    @TableLogic
    private Integer deleteFlag;

    /**
     * 登录次数
     */
    private Integer loginCount;

    /**
     * 登录时间
     */
    private Date loginTime;

    /**
     * 所属组织机构ID
     */
    private Integer departId;

    /**
     * 检测点ID
     */
    private Integer pointId;

    /**
     *
     */
    private Integer regId;

    /**
     * 备注
     */
    private String remark;

    /**
     * 电子签名文件
     */
    private String signatureFile;

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

    /**
     * 微信openid
     */
    private String wxOpenid;

    /**
     * 微信用户昵称
     */
    private String wxNickname;

    /**
     * 微信用户头像
     */
    private String wxImage;

    /**
     * 绑定时间
     */
    private Date bindTime;

    /**
     * 解绑时间
     */
    private Date relieveTime;

    /***** 非数据库字段 *****/
    @TableField(exist = false)
    private String departName;  //组织机构名称

    @TableField(exist = false)
    private String pointName;  //检测点名称

    @TableField(exist = false)
    private Integer[] functionId;  //菜单

    @TableField(exist = false)
    private String[] operationCode;  //权限


}