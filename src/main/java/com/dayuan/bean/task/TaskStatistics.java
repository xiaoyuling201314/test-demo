package com.dayuan.bean.task;

import com.dayuan.bean.BaseBean;

/**
 * 任务统计 2018-05-14
 * @author xyl
 *
 */
public class TaskStatistics extends BaseBean {

	private String taskDate; // 时间 年月

	private int missionNum; // 下发任务数量

	private int missionFinish;// 下发完成数量

	private int missionUnqualified;// 下发未完成数量

	private double mCompletionRate;// 下发完成率

	private int receivedNum; // 接收任务数量

	private int receivedFinish;// 接收完成数量

	private int receivedUnqualified;// 接收未完成数量

	private double rCompletionRate;// 接收完成率

	public String getTaskDate() {
		return taskDate;
	}

	public void setTaskDate(String taskDate) {
		this.taskDate = taskDate;
	}

	public int getMissionNum() {
		return missionNum;
	}

	public void setMissionNum(int missionNum) {
		this.missionNum = missionNum;
	}

	public int getMissionFinish() {
		return missionFinish;
	}

	public void setMissionFinish(int missionFinish) {
		this.missionFinish = missionFinish;
	}

	public int getMissionUnqualified() {
		return missionUnqualified;
	}

	public void setMissionUnqualified(int missionUnqualified) {
		this.missionUnqualified = missionUnqualified;
	}

	public double getmCompletionRate() {
		return mCompletionRate;
	}

	public void setmCompletionRate(double mCompletionRate) {
		this.mCompletionRate = mCompletionRate;
	}

	public int getReceivedNum() {
		return receivedNum;
	}

	public void setReceivedNum(int receivedNum) {
		this.receivedNum = receivedNum;
	}

	public int getReceivedFinish() {
		return receivedFinish;
	}

	public void setReceivedFinish(int receivedFinish) {
		this.receivedFinish = receivedFinish;
	}

	public int getReceivedUnqualified() {
		return receivedUnqualified;
	}

	public void setReceivedUnqualified(int receivedUnqualified) {
		this.receivedUnqualified = receivedUnqualified;
	}

	public double getrCompletionRate() {
		return rCompletionRate;
	}

	public void setrCompletionRate(double rCompletionRate) {
		this.rCompletionRate = rCompletionRate;
	}

	
}
