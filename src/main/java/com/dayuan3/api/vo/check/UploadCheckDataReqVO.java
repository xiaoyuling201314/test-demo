package com.dayuan3.api.vo.check;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.util.Date;

/**
 * @author Dz
 */
@ApiModel(description = "上传检测数据入参")
@Data
public class UploadCheckDataReqVO {

    @ApiModelProperty(value = "仪器检测ID（32位UUID）", required = true, example = "3be9fa71a3d04ac597a2ded9860609ab")
    @NotBlank(message = "仪器检测ID不能为空")
    @Length(min = 32, max = 32, message = "仪器检测ID长度32位UUID")
    private String uid;

    @ApiModelProperty(value = "订单明细ID", required = true, example = "3725")
    @NotNull(message = "订单明细ID不能为空")
    private Integer samplingDetailId;

    @ApiModelProperty(value = "检测时间", required = true, example = "2025-06-25 23:51:15")
    @NotNull(message = "检测时间不能为空")
    @Past(message = "检测时间不能大于当前时间")
    private Date checkDate;

    @ApiModelProperty(value = "仪器唯一标识", required = true, example = "DY-3500(I)_202506241311520219")
    @NotBlank(message = "仪器唯一标识不能为空")
    private String serialNumber;

    @ApiModelProperty(value = "检测依据", required = false, example = "GB/T 5009.199-2003")
    private String checkAccord;

    @ApiModelProperty(value = "限定值", required = false, example = "≤50")
    private String limitValue;

    @ApiModelProperty(value = "检测结果(检测值)", required = true, example = "23")
    @NotBlank(message = "检测结果不能为空")
    private String checkResult;

    @ApiModelProperty(value = "检测结果单位", required = false, example = "%")
    private String checkUnit;

    @ApiModelProperty(value = "检测结论", required = true, example = "合格")
    @NotBlank(message = "检测结论不能为空")
    private String conclusion;

    @ApiModelProperty(value = "检测模块", required = false, example = "分光光度")
    private String deviceModel;

    @ApiModelProperty(value = "检测方法", required = false, example = "标准曲线法")
    private String deviceMethod;

}
