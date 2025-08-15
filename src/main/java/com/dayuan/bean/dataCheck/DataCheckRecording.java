package com.dayuan.bean.dataCheck;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 检测数据表
 * @TableName data_check_recording
 */
@TableName(value ="data_check_recording")
@Data
public class DataCheckRecording implements Serializable {
	/**
	 * ID
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * 仪器检测ID（32位UUID）
	 */
	private String uid;

	/**
	 * 检测编号
	 */
	private String checkCode;

	/**
	 * 样品ID
	 */
	private Integer foodId;

	/**
	 * 样品名称
	 */
	private String foodName;

	/**
	 * 检测项目ID
	 */
	private String itemId;

	/**
	 * 检测项目
	 */
	private String itemName;

	/**
	 * 冷库ID
	 */
	private Integer regId;

	/**
	 * 冷库名称
	 */
	private String regName;

	/**
	 * 仓口ID
	 */
	private Integer regUserId;

	/**
	 * 仓口名称
	 */
	private String regUserName;

	/**
	 * 机构ID
	 */
	private Integer departId;

	/**
	 * 机构名称
	 */
	private String departName;

	/**
	 * 检测点ID
	 */
	private Integer pointId;

	/**
	 * 检测点名称
	 */
	private String pointName;

	/**
	 * 抽样单ID
	 */
	private Integer samplingId;

	/**
	 * 抽样单明细ID
	 */
	private Integer samplingDetailId;

	/**
	 * 检测人员ID
	 */
	private String checkUserid;

	/**
	 * 检测人员名称
	 */
	private String checkUsername;

	/**
	 * 检测人员签名
	 */
	private String checkUserSignature;

	/**
	 * 检测时间
	 */
	private Date checkDate;

	/**
	 * 上报时间
	 */
	private Date uploadDate;

	/**
	 * 检测依据ID
	 */
	private String checkAccordId;

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
	 * 检测结论
	 */
	private String conclusion;

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

	/**
	 * 上传次数
	 */
	private Integer reloadFlag;

	/**
	 * 数据来源:0检测工作站,1达元仪器上传,2监管通app,3平台上传,4导入,5其他仪器上传
	 */
	private Integer dataSource;

	/**
	 * 状态：0为未审核，1为已审核
	 */
	private Integer statusFalg;

	/**
	 * 删除状态
	 */
	@TableLogic
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

	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 经营户编号
	 */
	@TableField(exist = false)
	private String regUserCode;
	/**
	 *抽样明细编号
	 */
	@TableField(exist = false)
	private String samplingDetailCode;
	/**
	 *抽样时间
	 */
	@TableField(exist = false)
	private Date samplingDate;
	/**
	 *抽样人姓名
	 */
	@TableField(exist = false)
	private String samplingUsername;
	/**
	 *收样时间
	 */
	@TableField(exist = false)
	private String sampleTubeTime;
	/**
	 *试管码1
	 */
	@TableField(exist = false)
	private String tubeCode1;
	/**
	 *试管码2
	 */
	@TableField(exist = false)
	private String tubeCode2;

}