package com.dayuan.bean.sampling;

import com.baomidou.mybatisplus.annotation.*;
import com.dayuan.bean.BaseBean2;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
@TableName(value ="tb_sampling_detail_code")
@Data
@NoArgsConstructor
public class TbSamplingDetailCode implements Serializable {

    public TbSamplingDetailCode(Integer samplingDetailId, String sampleCode, Date sampleCodeTime,Integer deleteFlag) {
        this.samplingDetailId = samplingDetailId;
        this.sampleCode = sampleCode;
        this.sampleCodeTime = sampleCodeTime;
        this.deleteFlag=deleteFlag;
    }

    /**
     *  ID
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 样品明细ID
     */
    private Integer samplingDetailId;

    /**
     * 样品条码
     */
    private String sampleCode;

    /**
     * 试管码1
     */
    private String tubeCode1;

    /**
     * 扫描试管码1时间
     */
    private Date tubeCodeTime1;

    /**
     * 试管码2
     */
    private String tubeCode2;

    /**
     * 扫描试管码2时间
     */
    private Date tubeCodeTime2;

    /**
     * 试管码3
     */
    private String tubeCode3;

    /**
     * 扫描试管码3时间
     */
    private Date tubeCodeTime3;

    /**
     * 试管码4
     */
    private String tubeCode4;

    /**
     * 扫描试管码4时间
     */
    private Date tubeCodeTime4;

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
     * 删除状态：0_未删除,1_已删除
     */
    @TableLogic
    private Integer deleteFlag;

    /**
     * 创建人ID
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createDate;

    /**
     * 修改人ID
     */
    private String updateBy;

    /**
     * 修改时间
     */
    private Date updateDate;

    /************** 非数据库字段 **************/
    @TableField(exist = false)
    private Date sampleCodeTime;  //收样时间
    @TableField(exist = false)
    private String orderNumber;//订单号
    @TableField(exist = false)
    private String foodName;    //样品名称
    @TableField(exist = false)
    private String itemName;    //检测项目名称
    @TableField(exist = false)
    private Date orderTime;
    @TableField(exist = false)
    private String iuName;
    @TableField(exist = false)
    private Date samplingTime;

}