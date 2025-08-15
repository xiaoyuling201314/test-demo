package com.dayuan.bean.sampling;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 检测报告表
 * @TableName tb_sampling_report_print_log
 */
@TableName(value ="tb_sampling_report_print_log")
@Data
public class TbSamplingReportPrintLog implements Serializable {
    /**
     * ID
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 订单ID
     */
    private Integer samplingId;

    /**
     * 冷库ID
     */
    private Integer ccuId;

    /**
     * 仓口ID
     */
    private Integer iuId;

    /**
     * pdf报告地址
     */
    private String filePath;

    /**
     * pdf报告生成时间
     */
    private Date generatorTime;

    /**
     * 下载次数
     */
    private Integer downloadNumber;

    /**
     * 浏览次数
     */
    private Integer scanNumber;

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
     * 删除状态：0_未删除，1_已删除
     */
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

}