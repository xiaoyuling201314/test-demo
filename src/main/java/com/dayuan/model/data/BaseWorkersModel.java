package com.dayuan.model.data;

import com.dayuan.bean.data.BasePoint;
import com.dayuan.bean.data.BaseWorkers;
import com.dayuan.bean.data.TSDepart;
import com.dayuan.model.BaseModel;
/**
 * 
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年8月18日
 */
public class BaseWorkersModel extends BaseModel {
	
    private BaseWorkers baseBean;
    
    private BasePoint point;
    
    private TSDepart depart;
    
    //用于过滤指定机构人员 - 检测机构ID
    private String filterDepartId;
    
    //用于过滤指定机构人员 - 检测机构ID
    private String filterPointId;

	public BaseWorkers getBaseBean() {
		return baseBean;
	}

	public void setBaseBean(BaseWorkers baseBean) {
		this.baseBean = baseBean;
	}

	public BasePoint getPoint() {
		return point;
	}

	public void setPoint(BasePoint point) {
		this.point = point;
	}

	public TSDepart getDepart() {
		return depart;
	}

	public void setDepart(TSDepart depart) {
		this.depart = depart;
	}

	public String getFilterDepartId() {
		return filterDepartId;
	}

	public void setFilterDepartId(String filterDepartId) {
		this.filterDepartId = filterDepartId;
	}

	public String getFilterPointId() {
		return filterPointId;
	}

	public void setFilterPointId(String filterPointId) {
		this.filterPointId = filterPointId;
	}

}