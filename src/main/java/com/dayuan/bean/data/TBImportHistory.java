package com.dayuan.bean.data;

import java.util.Date;

public class TBImportHistory {
	public TBImportHistory() {
	}

	public TBImportHistory(String userId,Integer departId, String departCode, String departName, String username, String sourceFile, Date importDate, Integer importType) {
		this.userId = userId;
		this.departId = departId;
		this.departCode = departCode;
		this.departName = departName;
		this.username = username;
		this.sourceFile = sourceFile;
		this.importDate = importDate;
		this.importType = importType;
	}

	/**
	 * PK主键
	 */
	private Integer id;
	/**
	 * 导入部门ID
	 */
	private Integer departId;
	/**
	 * 导入部门Code
	 */
	private String departCode;
	/**
	 * 导入部门
	 */
	private String departName;
	/**
	 * 导入人ID
	 */
	private String userId;
	/**
	 * 导入人realname
	 */
	private String username;

	/**
	 * 源文件地址
	 */
	private String sourceFile;

	/**
	 * 导入失败记录的文件地址
	 */
	private String errFile;

	/**
	 * 导入成功数量
	 */
	private Integer successCount;

	/**
	 * 导入失败数量
	 */
	private Integer failCount;

	/**
	 * 导入时间
	 */
	private Date importDate;

	/**
	 * 导入类型：1检测数据导入      
	 *   新增委托单位导入，编号为5 ；2019-8-15 huht 
	 */
	private Integer importType;
	/**
	 * 完成导入时间
	 */
	private Date endDate;
	
	private String remark;//备注
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * Getter PK主键
	 * @return tb_import_history.id PK主键
	 *
	 * @mbg.generated
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * SetterPK主键
	 * @param idtb_import_history.id
	 *
	 * @mbg.generated
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDepartId() {
		return departId;
	}

	public void setDepartId(Integer departId) {
		this.departId = departId;
	}
	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	/**
	 * Getter 导入人ID
	 * @return tb_import_history.user_id 导入人ID
	 *
	 * @mbg.generated
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * Setter导入人ID
	 * @param userIdtb_import_history.user_id
	 *
	 * @mbg.generated
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * Getter 源文件地址
	 * @return tb_import_history.source_file 源文件地址
	 *
	 * @mbg.generated
	 */
	public String getSourceFile() {
		return sourceFile;
	}

	/**
	 * Setter源文件地址
	 * @param sourceFiletb_import_history.source_file
	 *
	 * @mbg.generated
	 */
	public void setSourceFile(String sourceFile) {
		this.sourceFile = sourceFile == null ? null : sourceFile.trim();
	}

	/**
	 * Getter 导入失败记录的文件地址
	 * @return tb_import_history.err_file 导入失败记录的文件地址
	 *
	 * @mbg.generated
	 */
	public String getErrFile() {
		return errFile;
	}

	/**
	 * Setter导入失败记录的文件地址
	 * @param errFiletb_import_history.err_file
	 *
	 * @mbg.generated
	 */
	public void setErrFile(String errFile) {
		this.errFile = errFile == null ? null : errFile.trim();
	}

	/**
	 * Getter 导入成功数量
	 * @return tb_import_history.success_count 导入成功数量
	 *
	 * @mbg.generated
	 */
	public Integer getSuccessCount() {
		return successCount;
	}

	/**
	 * Setter导入成功数量
	 * @param successCounttb_import_history.success_count
	 *
	 * @mbg.generated
	 */
	public void setSuccessCount(Integer successCount) {
		this.successCount = successCount;
	}

	/**
	 * Getter 导入失败数量
	 * @return tb_import_history.fail_count 导入失败数量
	 *
	 * @mbg.generated
	 */
	public Integer getFailCount() {
		return failCount;
	}

	/**
	 * Setter导入失败数量
	 * @param failCounttb_import_history.fail_count
	 *
	 * @mbg.generated
	 */
	public void setFailCount(Integer failCount) {
		this.failCount = failCount;
	}

	/**
	 * Getter 导入时间
	 * @return tb_import_history.import_date 导入时间
	 *
	 * @mbg.generated
	 */
	public Date getImportDate() {
		return importDate;
	}

	/**
	 * Setter导入时间
	 * @param importDatetb_import_history.import_date
	 *
	 * @mbg.generated
	 */
	public void setImportDate(Date importDate) {
		this.importDate = importDate;
	}

	/**
	 * Getter 导入类型：1检测数据导入
	 * @return tb_import_history.import_type 导入类型：1检测数据导入
	 *
	 * @mbg.generated
	 */
	public Integer getImportType() {
		return importType;
	}

	/**
	 * Setter导入类型：1检测数据导入
	 * @param importTypetb_import_history.import_type
	 *
	 * @mbg.generated
	 */
	public void setImportType(Integer importType) {
		this.importType = importType;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
}