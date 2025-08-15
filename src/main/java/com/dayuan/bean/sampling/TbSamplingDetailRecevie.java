package com.dayuan.bean.sampling;

import com.dayuan.bean.BaseBean2;
/**
 * 抽检明细任务接收状态
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年9月14日
 */
public class TbSamplingDetailRecevie extends BaseBean2 {

    private Integer sdId;			//抽样明细ID

    private String recevieSerialNumber;	//接收设备唯一标识

    private Short recevieStatus = 0;	//接收状态：0未接收;1接收;2拒绝;3仪器未接收,任务被平台下发到其他仪器

    private Short priority;		//优先级

    public Integer getSdId() {
        return sdId;
    }

    public void setSdId(Integer sdId) {
        this.sdId = sdId;
    }

    public String getRecevieSerialNumber() {
		return recevieSerialNumber;
	}

	public void setRecevieSerialNumber(String recevieSerialNumber) {
		this.recevieSerialNumber = recevieSerialNumber;
	}

	public Short getRecevieStatus() {
        return recevieStatus;
    }

    public void setRecevieStatus(Short recevieStatus) {
        this.recevieStatus = recevieStatus;
    }

    public Short getPriority() {
        return priority;
    }

    public void setPriority(Short priority) {
        this.priority = priority;
    }
}