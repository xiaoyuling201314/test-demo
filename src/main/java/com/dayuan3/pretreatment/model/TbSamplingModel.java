package com.dayuan3.pretreatment.model;

import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.model.BaseModel;
import io.swagger.models.auth.In;

import java.util.Date;
import java.util.List;


public class TbSamplingModel extends BaseModel {


    private Integer id;
    private String   order_number;//单号
    private String ccu_name;//冷链单位
    private String iu_name;//经营者
    private String order_username;//送检人
    private Date create_date;//时间
    private Integer detailsCount;//总批次
    private Integer checkedCount;//已完成批次


    // 采样起始时间（字符串形式）
    private String samplingDateStartDate;

    // 采样结束时间（字符串形式）
    private String samplingDateEndDate;

    // 是否完成筛选值（用于 HAVING）
    private Integer finish;



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrder_number() {
        return order_number;
    }

    public void setOrder_number(String order_number) {
        this.order_number = order_number;
    }

    public String getCcu_name() {
        return ccu_name;
    }

    public void setCcu_name(String ccu_name) {
        this.ccu_name = ccu_name;
    }

    public String getIu_name() {
        return iu_name;
    }

    public void setIu_name(String iu_name) {
        this.iu_name = iu_name;
    }

    public String getOrder_username() {
        return order_username;
    }

    public void setOrder_username(String order_username) {
        this.order_username = order_username;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Integer getDetailsCount() {
        return detailsCount;
    }

    public void setDetailsCount(Integer detailsCount) {
        this.detailsCount = detailsCount;
    }

    public Integer getCheckedCount() {
        return checkedCount;
    }

    public void setCheckedCount(Integer checkedCount) {
        this.checkedCount = checkedCount;
    }



    public String getSamplingDateStartDate() {
        return samplingDateStartDate;
    }

    public void setSamplingDateStartDate(String samplingDateStartDate) {
        this.samplingDateStartDate = samplingDateStartDate;
    }

    public String getSamplingDateEndDate() {
        return samplingDateEndDate;
    }

    public void setSamplingDateEndDate(String samplingDateEndDate) {
        this.samplingDateEndDate = samplingDateEndDate;
    }

    public Integer getFinish() {
        return finish;
    }

    public void setFinish(Integer finish) {
        this.finish = finish;
    }




    private TbSampling tbSampling;

    private List<TbSamplingDetail> tbSamplingDetails;

    private String payDate;

    private Integer checkNumber;    //复检次数

    //高级查询条件
    private String samplingStartDate;   //下单时间

    private String samplingEndDate;     //下单时间

    private String payDateStartDate;   //支付时间

    private String payDateEndDate;     //支付时间
    
    private String payNumber;//交易单号
    
    private String beginDate;//开始时间
    
    private String endDate;//结束时间
    
    private String currentMonth;//当前月

    private Short takeSamplingModal;//取样方式 0 自主送样，1上门取样
    
    private Short checkProgress;//检测进度：0 全部，1已完成，2未完成

    private Short checkStatus;//支付状态










    public String getSamplingStartDate() {
        return samplingStartDate;
    }

    public void setSamplingStartDate(String samplingStartDate) {
        this.samplingStartDate = samplingStartDate;
    }

    public String getSamplingEndDate() {
        return samplingEndDate;
    }

    public void setSamplingEndDate(String samplingEndDate) {
        this.samplingEndDate = samplingEndDate;
    }

    public String getPayDateStartDate() {
        return payDateStartDate;
    }

    public void setPayDateStartDate(String payDateStartDate) {
        this.payDateStartDate = payDateStartDate;
    }

    public String getPayDateEndDate() {
        return payDateEndDate;
    }

    public void setPayDateEndDate(String payDateEndDate) {
        this.payDateEndDate = payDateEndDate;
    }

    public TbSampling getTbSampling() {
        return tbSampling;
    }

    public void setTbSampling(TbSampling tbSampling) {
        this.tbSampling = tbSampling;
    }

    public List<TbSamplingDetail> getTbSamplingDetails() {
        return tbSamplingDetails;
    }

    public void setTbSamplingDetails(List<TbSamplingDetail> tbSamplingDetails) {
        this.tbSamplingDetails = tbSamplingDetails;
    }

    public String getPayDate() {
        return payDate;
    }

    public void setPayDate(String payDate) {
        this.payDate = payDate;
    }

    public Integer getCheckNumber() {
        return checkNumber;
    }

    public void setCheckNumber(Integer checkNumber) {
        this.checkNumber = checkNumber;
    }

	public String getPayNumber() {
		return payNumber;
	}

	public void setPayNumber(String payNumber) {
		this.payNumber = payNumber;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getCurrentMonth() {
		return currentMonth;
	}

	public void setCurrentMonth(String currentMonth) {
		this.currentMonth = currentMonth;
	}

	public Short getTakeSamplingModal() {
		return takeSamplingModal;
	}

	public void setTakeSamplingModal(Short takeSamplingModal) {
		this.takeSamplingModal = takeSamplingModal;
	}

	public Short getCheckProgress() {
		return checkProgress;
	}

	public void setCheckProgress(Short checkProgress) {
		this.checkProgress = checkProgress;
	}

    public Short getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(Short checkStatus) {
        this.checkStatus = checkStatus;
    }




}
