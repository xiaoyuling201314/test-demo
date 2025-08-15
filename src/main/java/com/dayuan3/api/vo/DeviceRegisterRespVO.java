package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author Dz
 */
@ApiModel(description = "设备注册出参")
@Data
public class DeviceRegisterRespVO {

    @ApiModelProperty(value = "设备ID", example = "2c922b9d6df256b5016df73e181300f1")
    private String id;

    @ApiModelProperty(value = "仪器名称", example = "DY-35000(I)食品综合分析仪")
    private String deviceName;

    @ApiModelProperty(value = "仪器唯一标识", example = "DY-3500(I)_20200302111656")
    private String serialNumber;

}
