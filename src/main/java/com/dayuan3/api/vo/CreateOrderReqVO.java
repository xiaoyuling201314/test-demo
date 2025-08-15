package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.*;
import java.util.List;

/**
 * @author Dz
 */
@ApiModel(description = "创建订单参数")
@Data
public class CreateOrderReqVO {

    @ApiModelProperty(value = "*电子单号", required = true, example = "A5200000001")
    @NotBlank(message = "请输入电子单号")
    private String orderNumber;

    @ApiModelProperty(value = "车牌号码", required = false, example = "粤A00001")
    private String carNumber;

    @ApiModelProperty(value = "司机姓名", required = false, example = "张三")
    private String driverName;

    @ApiModelProperty(value = "司机手机号码", required = false, example = "13509876787")
    private String driverPhone;

    @ApiModelProperty(value = "冷库ID", required = true, example = "221134")
//    @NotNull(message = "请输入冷库ID")
    private Integer ccuId;

    @ApiModelProperty(value = "冷库名称", required = true, example = "壹号冷库")
//    @NotBlank(message = "请输入冷库名称")
    private String ccuName;

    @ApiModelProperty(value = "仓号ID", required = true, example = "367821")
//    @NotNull(message = "请输入仓号ID")
    private Integer iuId;

    @ApiModelProperty(value = "仓号名称", required = true, example = "A1")
//    @NotBlank(message = "请输入仓号名称")
    private String iuName;

    @ApiModelProperty(value = "*订单项目", required = true)
    @NotNull(message = "请选择订单项目")
    @Size(min = 1, message = "请选择订单项目")
    private List<orderItem> orderItems;

    /**
     * 订单项目
     */
    @Data
    public static class orderItem {
        @ApiModelProperty(value = "*检测项目ID", required = true, example = "0be23435970e69e0b36ae62113b149ff")
        @NotBlank(message = "请输入检测项目ID")
        private String itemId;

        @ApiModelProperty(value = "*检测项目名称", required = true, example = "克百威")
        @NotBlank(message = "请输入检测项目名称")
        private String itemName;

        @ApiModelProperty(value = "*食品种类ID", required = true, example = "25")
        @NotNull(message = "请输入食品种类ID")
        private Integer foodId;

        @ApiModelProperty(value = "*食品种类名称", required = true, example = "白菜")
        @NotBlank(message = "请输入食品种类名称")
        private String foodName;

        @ApiModelProperty(value = "进货数量(KG)", required = false, example = "20.5")
        @Min(value = 0, message = "进货数量不能小于0")
        @Digits(integer = 8, fraction = 2, message = "进货数量格式错误，整数位上限为8位，小数位上限为2位")
        private Float purchaseQuantity;
    }

}
