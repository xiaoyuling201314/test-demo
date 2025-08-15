package com.dayuan.bean.task;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Date;

import com.dayuan.bean.BaseBean;
/**
 * 
 * Description: 任务明细表 tb_task_detail
 * @Company: 食安科技
 * @author zhongdz
 * @date 2017年8月7日
 */
public class TbTaskDetail{
	
    private Integer taskId;   //主任务
   
    private String detailCode;   //任务明细编号
    
    private String sampleId;  //检测样品ID
    
    private String sample;  //检测样品
    
    private String itemId;  //检测项目ID
    
    private String item;  //检测项目
    
    private Date taskFdate;  //完成日期
    
    private Integer receivePointid;  //接收机构ID
    
    private String receivePoint;  //接收机构名称
    
    private Integer receiveNodeid;  //接收检测点ID
    
    private String receiveNode;  //接收检测点名称
    
    private String receiveUserid;  //任务接收人ID
    
    private String receiveUsername;  //任务接收人名称
    
    private Short receiveStatus;  //接收状态
    
    private Integer taskTotal;  //任务数量总数
    
    private Integer sampleNumber;  //已抽检数量
    
    private Integer id; // 主键：id

    private String remark; // 备注
    
    protected Short deleteFlag = 0; // 删除状态；0未删除，1删除

    /**************非数据库字段****************************/
    private String taskTitle;	//主任务标题
    
    private String taskType;	//主任务类型
    
    private String taskDepart;	//主任务发布组织
    
    private String taskStatus;	//主任务状态
    
    private Date taskCdate;	//主任务发布日期
    
    private Date taskSdate;  //主任务起始日期
    
    private Date taskEdate;   //主任务结束日期
    
    public Short getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Short deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

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

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getDetailCode() {
        return detailCode;
    }

    public void setDetailCode(String detailCode) {
        this.detailCode = detailCode == null ? null : detailCode.trim();
    }

    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(String sampleId) {
        this.sampleId = sampleId == null ? null : sampleId.trim();
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId == null ? null : itemId.trim();
    }

    public Date getTaskFdate() {
        return taskFdate;
    }

    public void setTaskFdate(Date taskFdate) {
        this.taskFdate = taskFdate;
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
        this.receivePoint = receivePoint == null ? null : receivePoint.trim();
    }

    public String getReceiveUserid() {
        return receiveUserid;
    }

    public void setReceiveUserid(String receiveUserid) {
        this.receiveUserid = receiveUserid == null ? null : receiveUserid.trim();
    }

    public String getReceiveUsername() {
        return receiveUsername;
    }

    public void setReceiveUsername(String receiveUsername) {
        this.receiveUsername = receiveUsername == null ? null : receiveUsername.trim();
    }

    public Short getReceiveStatus() {
        return receiveStatus;
    }

    public void setReceiveStatus(Short receiveStatus) {
        this.receiveStatus = receiveStatus;
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

	public String getSample() {
		return sample;
	}

	public void setSample(String sample) {
		this.sample = sample;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
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

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public String getTaskDepart() {
		return taskDepart;
	}

	public void setTaskDepart(String taskDepart) {
		this.taskDepart = taskDepart;
	}

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public Date getTaskCdate() {
		return taskCdate;
	}

	public void setTaskCdate(Date taskCdate) {
		this.taskCdate = taskCdate;
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
	
	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	/**
	 * 检测任务完成度%
	 */
	public String getSchedule() {
		if(sampleNumber == null || taskTotal == null){
			return "0.00";
		}else{
			DecimalFormat df = new DecimalFormat("#0.00");
			df.setRoundingMode(RoundingMode.FLOOR);
			return df.format((double)this.sampleNumber/this.taskTotal*100.0);
		}
	}

}