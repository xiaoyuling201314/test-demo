package com.dayuan.bean.task;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 
 * Description:  任务表tb_task
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class TbTask {
    
    private String taskCode;  //任务编码
   
    private String taskTitle;   //任务标题
    
    private String taskContent;  //任务内容
   
    private String taskDetailPid;   //分发任务父ID
   
    private String projectId;   //归属项目ID
    
    private String taskType;  //任务类型
   
    private String taskSource;   //任务来源
   
    private Short taskStatus;   //任务状态
    
    private Integer taskTotal;  //检测数量
    
    private Integer sampleNumber;  //检测完成数量
    
    private Date taskSdate;  //起始日期
   
    private Date taskEdate;   //结束日期
    
    private Date taskPdate;  //警报日期
    
    private Date taskFdate;  //完成日期
    
    private Integer taskDepartid;  //任务发布组织ID
   
    private String taskAnnouncer;   //任务发布人ID
   
    private Date taskCdate;   //任务发布日期

    private Short viewFlag;   //查看状态
    
    private String filePath;	//附件
    
    private Integer id; // 主键：id

    private String remark; // 备注

    private Short deleteFlag = 0; // 删除状态；0未删除，1删除
	
    private String createBy; // 创建人id

    private Date createDate; // 创建时间

    private String updateBy; // 修改人id

    private Date updateDate; // 修改时间
    /**************非数据库字段****************************/
    //private String schedule;	//检测任务完成度%
    
    private String taskDepartName;	//任务发布机构名称
    
    private String taskAnnouncerName;   //任务发布人名称
    
    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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
		this.createBy = createBy;
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
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getTaskCode() {
        return taskCode;
    }

    public void setTaskCode(String taskCode) {
        this.taskCode = taskCode == null ? null : taskCode.trim();
    }

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle == null ? null : taskTitle.trim();
    }

    public String getTaskContent() {
        return taskContent;
    }

    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent == null ? null : taskContent.trim();
    }

    public String getTaskDetailPid() {
        return taskDetailPid;
    }

    public void setTaskDetailPid(String taskDetailPid) {
        this.taskDetailPid = taskDetailPid == null ? null : taskDetailPid.trim();
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId == null ? null : projectId.trim();
    }

	public String getTaskType() {
        return taskType;
    }

    public void setTaskType(String taskType) {
        this.taskType = taskType == null ? null : taskType.trim();
    }
    
    public String getTaskSource() {
    	return taskSource;
    }
    
    public void setTaskSource(String taskSource) {
    	this.taskSource = taskSource == null ? null : taskSource.trim();
    }

    public Short getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(Short taskStatus) {
        this.taskStatus = taskStatus;
    }

    public Integer getTaskTotal() {
        return taskTotal;
    }

    public void setTaskTotal(Integer taskTotal) {
        this.taskTotal = taskTotal;
    }

    public Integer getSampleNumber() {
        return sampleNumber;
    }

    public void setSampleNumber(Integer sampleNumber) {
        this.sampleNumber = sampleNumber;
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

    public Date getTaskFdate() {
        return taskFdate;
    }

    public void setTaskFdate(Date taskFdate) {
        this.taskFdate = taskFdate;
    }

    public Integer getTaskDepartid() {
        return taskDepartid;
    }

    public void setTaskDepartid(Integer taskDepartid) {
        this.taskDepartid = taskDepartid;
    }

    public String getTaskAnnouncer() {
        return taskAnnouncer;
    }

    public void setTaskAnnouncer(String taskAnnouncer) {
        this.taskAnnouncer = taskAnnouncer == null ? null : taskAnnouncer.trim();
    }

    public Date getTaskCdate() {
        return taskCdate;
    }

    public void setTaskCdate(Date taskCdate) {
        this.taskCdate = taskCdate;
    }


    public Short getViewFlag() {
        return viewFlag;
    }

    public void setViewFlag(Short viewFlag) {
        this.viewFlag = viewFlag;
    }

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public String getTaskDepartName() {
		return taskDepartName;
	}

	public void setTaskDepartName(String taskDepartName) {
		this.taskDepartName = taskDepartName;
	}

	public String getTaskAnnouncerName() {
		return taskAnnouncerName;
	}

	public void setTaskAnnouncerName(String taskAnnouncerName) {
		this.taskAnnouncerName = taskAnnouncerName;
	}

	/**
	 * 检测任务完成度%
	 */
	public String getSchedule() {
		if(sampleNumber == null || taskTotal == null || sampleNumber == 0 || taskTotal == 0){
			return "0.00";
		}else{
			DecimalFormat df = new DecimalFormat("#0.00");
			df.setRoundingMode(RoundingMode.FLOOR);
			return df.format((double)this.sampleNumber/this.taskTotal*100.0);
		}
	}

}