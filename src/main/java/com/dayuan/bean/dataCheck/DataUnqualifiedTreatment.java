package com.dayuan.bean.dataCheck;

import java.util.Date;

import com.dayuan.bean.BaseBean2;
/**
 * 
 * Description:不合格品处理表data_unqualified_treatment
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月7日
 */
public class DataUnqualifiedTreatment extends BaseBean2  {

    private Integer checkRecordingId;  //检测数据id

    private Short dealMethod;  //处理状态 0处理中 1已处理

    private String dealType;  //处理状态  0合格处理 1不合格处理 2有异议合格处理 3有异议不合格处理  

    private String dealImgurl;  //处理图片URL

    private String spersonName;  //送检人名称

    private String spersonPhone;  //送检人联系方式

    private Date sendDate;  //送检日期

    private Date recheckDate;  //复检日期

    private Date endDate;  //处理完毕时间

    private String recheckValue;  //复检检测值

    private String recheckResult;  //复检结果

    private String recheckDepart;  //复检机构

    private String supervisionDepart;  //监督部门

    private String supervisor;  //监督人

    private String supervisorPhone; //监督人联系方式

    private String dealSituation;  //处理情况

    private String param1;			//删除备注信息

    private String param2;			//预留参数2

    private String param3;			////预留参数3

    public Integer getCheckRecordingId() {
        return checkRecordingId;
    }

    public void setCheckRecordingId(Integer checkRecordingId) {
        this.checkRecordingId = checkRecordingId;
    }

    public Short getDealMethod() {
        return dealMethod;
    }

    public void setDealMethod(Short dealMethod) {
        this.dealMethod = dealMethod;
    }

    public String getDealType() {
        return dealType;
    }

    public void setDealType(String dealType) {
        this.dealType = dealType == null ? null : dealType.trim();
    }

    public String getDealImgurl() {
        return dealImgurl;
    }

    public void setDealImgurl(String dealImgurl) {
        this.dealImgurl = dealImgurl == null ? null : dealImgurl.trim();
    }

    public String getSpersonName() {
        return spersonName;
    }

    public void setSpersonName(String spersonName) {
        this.spersonName = spersonName == null ? null : spersonName.trim();
    }

    public String getSpersonPhone() {
        return spersonPhone;
    }

    public void setSpersonPhone(String spersonPhone) {
        this.spersonPhone = spersonPhone == null ? null : spersonPhone.trim();
    }

    public Date getSendDate() {
        return sendDate;
    }

    public void setSendDate(Date sendDate) {
        this.sendDate = sendDate;
    }

    public Date getRecheckDate() {
        return recheckDate;
    }

    public void setRecheckDate(Date recheckDate) {
        this.recheckDate = recheckDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getRecheckValue() {
        return recheckValue;
    }

    public void setRecheckValue(String recheckValue) {
        this.recheckValue = recheckValue == null ? null : recheckValue.trim();
    }

    public String getRecheckResult() {
        return recheckResult;
    }

    public void setRecheckResult(String recheckResult) {
        this.recheckResult = recheckResult == null ? null : recheckResult.trim();
    }

    public String getRecheckDepart() {
        return recheckDepart;
    }

    public void setRecheckDepart(String recheckDepart) {
        this.recheckDepart = recheckDepart == null ? null : recheckDepart.trim();
    }

    public String getSupervisionDepart() {
        return supervisionDepart;
    }

    public void setSupervisionDepart(String supervisionDepart) {
        this.supervisionDepart = supervisionDepart == null ? null : supervisionDepart.trim();
    }

    public String getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(String supervisor) {
        this.supervisor = supervisor == null ? null : supervisor.trim();
    }

    public String getSupervisorPhone() {
        return supervisorPhone;
    }

    public void setSupervisorPhone(String supervisorPhone) {
        this.supervisorPhone = supervisorPhone == null ? null : supervisorPhone.trim();
    }

    public String getDealSituation() {
        return dealSituation;
    }

    public void setDealSituation(String dealSituation) {
        this.dealSituation = dealSituation == null ? null : dealSituation.trim();
    }

	public String getParam1() {
		return param1;
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
    
}