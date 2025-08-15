package com.dayuan3.pretreatment.model;

import java.util.List;

import com.dayuan.bean.sampling.TbSamplingDetailCode;
import com.dayuan.model.BaseModel;

public class TbSamplingDetailCodeModel extends BaseModel {

	private List<TbSamplingDetailCode> samplingDetailCodes;

	//样品码
	private String sampleCode;
	//试管码
	private String tubeCode;

	public List<TbSamplingDetailCode> getSamplingDetailCodes() {
		return samplingDetailCodes;
	}

	public void setSamplingDetailCodes(List<TbSamplingDetailCode> samplingDetailCodes) {
		this.samplingDetailCodes = samplingDetailCodes;
	}

	public String getSampleCode() {
		return sampleCode;
	}

	public void setSampleCode(String sampleCode) {
		this.sampleCode = sampleCode;
	}

	public String getTubeCode() {
		return tubeCode;
	}

	public void setTubeCode(String tubeCode) {
		this.tubeCode = tubeCode;
	}
}