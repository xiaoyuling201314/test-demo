package com.dayuan3.api.vo.check;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 保存检测数据DTO
 * @author Dz
 */
@Data
public class SaveCheckDataDTO {

    /**
     * 仪器检测ID（32位UUID）
     */
    private String uid;

    @ApiModelProperty(value = "", required = true, example = "3725")
    /**
     * 订单明细ID
     */
    private Integer samplingDetailId;

    /**
     * 检测时间
     */
    private Date checkDate;

    /**
     * 检测依据
     */
    private String checkAccord;

    /**
     * 限定值
     */
    private String limitValue;

    /**
     * 检测结果(检测值)
     */
    private String checkResult;

    /**
     * 检测结果单位
     */
    private String checkUnit;

    /**
     * 检测结论 合格 不合格
     */
    private String conclusion;

    /**
     * 检测人员ID
     */
    private String checkUserid;

    /**
     * 检测人员名称
     */
    private String checkUsername;

    /**
     * 检测设备ID
     */
    private String deviceId;

    /**
     * 检测仪器名称
     */
    private String deviceName;

    /**
     * 检测模块
     */
    private String deviceModel;

    /**
     * 检测方法
     */
    private String deviceMethod;

    /**
     * 仪器厂家
     */
    private String deviceCompany;

}
