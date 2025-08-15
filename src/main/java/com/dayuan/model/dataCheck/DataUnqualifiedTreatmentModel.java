package com.dayuan.model.dataCheck;

import java.util.List;

import com.dayuan.bean.dataCheck.DataUnqualifiedDispose;
import com.dayuan.bean.dataCheck.DataUnqualifiedTreatment;
import com.dayuan.model.BaseModel;


/**
 * 不合格处理
 * @author Bill
 *
 * 2017年7月28日
 */
public class DataUnqualifiedTreatmentModel extends BaseModel {

	private DataUnqualifiedTreatment treatment;
	
	private List<DataUnqualifiedDispose> disposeList;
	
	

	public DataUnqualifiedTreatment getTreatment() {
		return treatment;
	}

	public void setTreatment(DataUnqualifiedTreatment treatment) {
		this.treatment = treatment;
	}

	public List<DataUnqualifiedDispose> getDisposeList() {
		return disposeList;
	}

	public void setDisposeList(List<DataUnqualifiedDispose> disposeList) {
		this.disposeList = disposeList;
	}



}
