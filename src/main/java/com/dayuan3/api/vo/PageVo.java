package com.dayuan3.api.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@ApiModel("分页参数")
@Data
public class PageVo<T> {

    @ApiModelProperty(value = "数据")
    private List<T> records;

    @ApiModelProperty(value = "总记录数")
    private long total;

    @ApiModelProperty(value = "每页显示记录数")
    private long size;

    @ApiModelProperty(value = "当前页码")
    private long current;

    @ApiModelProperty(value = "总页数")
    private long pages;

}
