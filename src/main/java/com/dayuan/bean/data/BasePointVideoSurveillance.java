package com.dayuan.bean.data;

import java.util.Date;

/**
 * 监控摄像头实体类
 * @author LuoYX
 * @date 2018年5月8日
 */
public class BasePointVideoSurveillance {
	/**
	 * PK
	 */
	private Integer id;
	/**
	 * 机构ID
	 */
	private Integer departId;
	/**
	 * 机构部门名称
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
	 * 摄像头名称
	 */
	private String surveillanceName;

	/**
	 * 摄像头IP
	 */
	private String ip;

	/**
	 * 摄像头用户名/萤石云AppKey
	 */
	private String userName;

	/**
	 * 摄像头密码/萤石云Secret
	 */
	private String pwd;

	/**
	 * 摄像头标识
	 */
	private String dev;
	 /**
     * 乐橙账号--手机号
     */
    private String accountPhone;

	/**
	 * 摄像头注册时间
	 */
	private Date registerDate;

	/**
	 * 删除状态
	 */
	private Short deleteFlag;

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

	
	private Integer departPid;
	
	private Short videoType;//视频连接类型，0 乐橙API，1 乐橙云
	
	private Short autostart;//视频是否自动播放，0不播放，1播放
	
	private String videoUrl;//乐橙视频URL

	private Short sorting;//排序
	/**
     * 设备通道号
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
	 * 在线状态：0 离线，1在线，-1设备号异常
	 */
    private Short onlineStatus;
	/**
	 * 最后一次状态的同步时间
	 */
    private Date syncStatusDate;
	/**
	 *存储类型：0 无，1 TF内存卡，2 云存储
	 */
    private Short storageType;


	/**
	 * 萤石云平台接口TOKEN（非表字段）
	 */
	private String token;

	public Short getVideoType() {
		return videoType;
	}

	public void setVideoType(Short videoType) {
		this.videoType = videoType;
	}

	public Short getAutostart() {
		return autostart;
	}

	public void setAutostart(Short autostart) {
		this.autostart = autostart;
	}

	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName == null ? null : departName.trim();
	}

	public Integer getPointId() {
		return pointId;
	}

	public void setPointId(Integer pointId) {
		this.pointId = pointId;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName == null ? null : pointName.trim();
	}

	public String getSurveillanceName() {
		return surveillanceName;
	}

	public void setSurveillanceName(String surveillanceName) {
		this.surveillanceName = surveillanceName == null ? null : surveillanceName.trim();
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip == null ? null : ip.trim();
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName == null ? null : userName.trim();
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd == null ? null : pwd.trim();
	}

	public String getDev() {
		return dev;
	}

	public void setDev(String dev) {
		this.dev = dev == null ? null : dev.trim();
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy == null ? null : createBy.trim();
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy == null ? null : updateBy.trim();
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Integer getDepartPid() {
		return departPid;
	}

	public void setDepartPid(Integer departPid) {
		this.departPid = departPid;
	}

	public Short getSorting() {
		return sorting;
	}

	public void setSorting(Short sorting) {
		this.sorting = sorting;
	}

	public String getAccountPhone() {
		return accountPhone;
	}

	public void setAccountPhone(String accountPhone) {
		this.accountPhone = accountPhone;
	}

	public String getParam1() {
		return param1 ==null ? "0" : param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}

	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2;
	}

	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Short getOnlineStatus() {
		return onlineStatus;
	}

	public void setOnlineStatus(Short onlineStatus) {
		this.onlineStatus = onlineStatus;
	}

	public Date getSyncStatusDate() {
		return syncStatusDate;
	}

	public void setSyncStatusDate(Date syncStatusDate) {
		this.syncStatusDate = syncStatusDate;
	}

	public Short getStorageType() {
		return storageType;
	}

	public void setStorageType(Short storageType) {
		this.storageType = storageType;
	}
}