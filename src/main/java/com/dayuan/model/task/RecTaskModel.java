package com.dayuan.model.task;

import java.io.Serializable;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Date;

import com.dayuan.model.BaseModel;

/**
 * 接收任务列表数据模型
 * @author Dz
 *
 */
public class RecTaskModel extends BaseModel implements Serializable {
	/**主任务信息**/
    //任务编码
    private String taskCode;
    //任务标题
    private String taskTitle;
    //任务内容
    private String taskContent;
    //分发任务父ID
    private String taskDetailPid;
    //归属项目ID
    private String projectId;
    //任务类型
    private String taskType;
    //任务来源
    private String taskSource;
    //任务状态
    private Short taskStatus;
    //起始日期
    private Date taskSdate;
    //结束日期
    private Date taskEdate;
    //警报日期
    private Date taskPdate;
    //任务发布组织ID
    private Integer taskDepartid;
    //任务发布组织
    private String depart;
    //任务发布人ID
    private String taskAnnouncer;
    //任务发布人
    private String announcer;
    //任务发布日期
    private Date taskCdate;
    //备注
    private String taskRemark;
    //查看状态
    private Short viewFlag;
    //删除状态
    private Short deleteFlag;
    //创建日期
    private Date createDate;
    //附件
    private String filePath;
    
    
	/**任务明细信息**/
    //主键
    private String id;
    //主任务ID
    private String taskId;
    //任务明细编号
    private String detailCode;
    //检测样品ID
    private String sampleId;
    //检测样品
    private String sample;
    //检测项目ID
    private String itemId;
    //检测项目
    private String item;
    //完成日期
    private Date detailFdate;
    //接收机构ID
    private Integer receivePointid;
    //接收机构名称
    private String receivePoint;
    //接收检测点ID
    private Integer receiveNodeid;
    //接收检测点名称
    private String receiveNode;
    //任务接收人ID
    private String receiveUserid;
    //任务接收人名称
    private String receiveUsername;
    //接收状态(0未接收,1已接收)
    private Short receiveStatus;
    //任务数量总数
    private Integer detailTotal;
    //已抽检数量
    private Integer sampleNumber;
    //备注
    private String detailRemark;
    
	public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
	public String getTaskTitle() {
		return taskTitle;
	}
	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}
	public String getTaskContent() {
		return taskContent;
	}
	public void setTaskContent(String taskContent) {
		this.taskContent = taskContent;
	}
	public String getTaskType() {
		return taskType;
	}
	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}
	public Short getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(Short taskStatus) {
		this.taskStatus = taskStatus;
	}
	public Date getTaskSdate() {
		return taskSdate;
	}
	public void setTaskSdate(Date taskSdate) {
		this.taskSdate = taskSdate;
	}
	public Date getTaskEdate() {
		return taskEdate;
	}
	public void setTaskEdate(Date taskEdate) {
		this.taskEdate = taskEdate;
	}
	public Date getTaskPdate() {
		return taskPdate;
	}
	public void setTaskPdate(Date taskPdate) {
		this.taskPdate = taskPdate;
	}
	public Integer getTaskDepartid() {
		return taskDepartid;
	}
	public void setTaskDepartid(Integer taskDepartid) {
		this.taskDepartid = taskDepartid;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public String getTaskAnnouncer() {
		return taskAnnouncer;
	}
	public void setTaskAnnouncer(String taskAnnouncer) {
		this.taskAnnouncer = taskAnnouncer;
	}
	public String getAnnouncer() {
		return announcer;
	}
	public void setAnnouncer(String announcer) {
		this.announcer = announcer;
	}
	public Date getTaskCdate() {
		return taskCdate;
	}
	public void setTaskCdate(Date taskCdate) {
		this.taskCdate = taskCdate;
	}
	public String getTaskRemark() {
		return taskRemark;
	}
	public void setTaskRemark(String taskRemark) {
		this.taskRemark = taskRemark;
	}
	public Short getViewFlag() {
		return viewFlag;
	}
	public void setViewFlag(Short viewFlag) {
		this.viewFlag = viewFlag;
	}
	public Short getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getDetailCode() {
		return detailCode;
	}
	public void setDetailCode(String detailCode) {
		this.detailCode = detailCode;
	}
	public String getSampleId() {
		return sampleId;
	}
	public void setSampleId(String sampleId) {
		this.sampleId = sampleId;
	}
	public String getSample() {
		return sample;
	}
	public void setSample(String sample) {
		this.sample = sample;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public Date getDetailFdate() {
		return detailFdate;
	}
	public void setDetailFdate(Date detailFdate) {
		this.detailFdate = detailFdate;
	}
	public Integer getReceivePointid() {
		return receivePointid;
	}
	public void setReceivePointid(Integer receivePointid) {
		this.receivePointid = receivePointid;
	}
	public String getReceivePoint() {
		return receivePoint;
	}
	public void setReceivePoint(String receivePoint) {
		this.receivePoint = receivePoint;
	}
	public String getReceiveUserid() {
		return receiveUserid;
	}
	public void setReceiveUserid(String receiveUserid) {
		this.receiveUserid = receiveUserid;
	}
	public String getReceiveUsername() {
		return receiveUsername;
	}
	public void setReceiveUsername(String receiveUsername) {
		this.receiveUsername = receiveUsername;
	}
	public Short getReceiveStatus() {
		return receiveStatus;
	}
	public void setReceiveStatus(Short receiveStatus) {
		this.receiveStatus = receiveStatus;
	}
	public Integer getDetailTotal() {
		return detailTotal;
	}
	public void setDetailTotal(Integer detailTotal) {
		this.detailTotal = detailTotal;
	}
	public Integer getSampleNumber() {
		return sampleNumber;
	}
	public void setSampleNumber(Integer sampleNumber) {
		this.sampleNumber = sampleNumber;
	}
	public String getDetailRemark() {
		return detailRemark;
	}
	public void setDetailRemark(String detailRemark) {
		this.detailRemark = detailRemark;
	}
	public String getTaskSource() {
		return taskSource;
	}
	public void setTaskSource(String taskSource) {
		this.taskSource = taskSource;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getTaskDetailPid() {
		return taskDetailPid;
	}
	public void setTaskDetailPid(String taskDetailPid) {
		this.taskDetailPid = taskDetailPid;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public Integer getReceiveNodeid() {
		return receiveNodeid;
	}
	public void setReceiveNodeid(Integer receiveNodeid) {
		this.receiveNodeid = receiveNodeid;
	}
	public String getReceiveNode() {
		return receiveNode;
	}
	public void setReceiveNode(String receiveNode) {
		this.receiveNode = receiveNode;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	/**
	 * 检测任务完成度%
	 */
	public String getSchedule() {
		if(sampleNumber == null || detailTotal == null){
			return "0.00";
		}else{
			DecimalFormat df = new DecimalFormat("#0.00");
			df.setRoundingMode(RoundingMode.FLOOR);
			return df.format((double)this.sampleNumber/this.detailTotal*100.0);
		}
	}
    
}
