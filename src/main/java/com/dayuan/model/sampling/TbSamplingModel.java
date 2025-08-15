package com.dayuan.model.sampling;

import java.util.List;

import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.sampling.TbSamplingDetail;
import com.dayuan.model.BaseModel;
import com.dayuan3.common.bean.TbSamplingRequester;
import com.dayuan3.common.bean.TbSamplingRequester;


public class TbSamplingModel extends BaseModel {

	private TbSampling tbSampling;
    
	private List<TbSamplingDetail> tbSamplingDetails;

	private List<TbSamplingRequester> tbSamplingRequesters;

	/*********** 用于过滤数据 *************/
	private Integer[] departArr;
	private Integer[] pointArr;

	private String samplingDateStartDate;
	private String samplingDateEndDate;

	private Integer finish; //完成进度，1全部，2未完成，3已完成

	/**
	 * 接收检测任务的设备
	 */
	private String recevieDevice;
	/**
	 * 样品编号
	 */
	private String sampleCode;
	/**
	 * 接收状态：0-未接收，1-已接收
	 */
	private Integer status;
	
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

	public String getRecevieDevice() {
		return recevieDevice;
	}

	public void setRecevieDevice(String recevieDevice) {
		this.recevieDevice = recevieDevice;
	}

	public String getSampleCode() {
		return sampleCode;
	}

	public void setSampleCode(String sampleCode) {
		this.sampleCode = sampleCode;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public List<TbSamplingRequester> getTbSamplingRequesters() {
		return tbSamplingRequesters;
	}

	public void setTbSamplingRequesters(List<TbSamplingRequester> tbSamplingRequesters) {
		this.tbSamplingRequesters = tbSamplingRequesters;
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
}
