package com.dayuan.bean.dataCheck;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.dayuan.bean.BaseBean;
import lombok.Data;

/**
 * 检测数据历史表
 * @TableName data_check_history_recording
 */
@TableName(value ="data_check_history_recording")
@Data
public class DataCheckHistoryRecording implements Serializable {
	/**
	 * 主键
	 */
	@TableId(type = IdType.AUTO)
	private Integer id;

	/**
	 * 检测数据ID
	 */
	private Integer checkRecordingId;

	/**
	 * 仪器检测ID（32位UUID）
	 */
	private String uid;

	/**
	 * 检测编号
	 */
	private String checkCode;

	/**
	 * 样品名称ID
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
	 * 被检单位ID
	 */
	private Integer regId;

	/**
	 * 被检单位名称
	 */
	private String regName;

	/**
	 * 经营户ID
	 */
	private Integer regUserId;

	/**
	 * 经营户
	 */
	private String regUserName;

	/**
	 * 抽样单ID
	 */
	private Integer samplingId;

	/**
	 * 抽样明细ID
	 */
	private String samplingDetailId;

	/**
	 * 所属机构ID
	 */
	private Integer departId;

	/**
	 * 所属机构名称
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
	 * 重传数据序号(第N次上传)
	 */
	private Integer reloadFlag;

	/**
	 * 数据来源0检测工作站，2监管通app，1.仪器上传,3平台上传，4导入
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

}