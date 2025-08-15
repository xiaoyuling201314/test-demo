package com.dayuan.model.data;

import java.util.List;

import com.dayuan.bean.data.BasePoint;
import com.dayuan.model.BaseModel;

/**
 * 机构、检测点树模型
 * @author Dz
 *
 */
public class DepartTreeModel extends BaseModel {

	// 主键
	private String id;
	// 项目组织机构名称
	private String departName;
	// 机构集合
	private List<DepartTreeModel> departs;
	// 检测点集合
	private List<BasePoint> points;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public List<DepartTreeModel> getDeparts() {
		return departs;
	}

	public void setDeparts(List<DepartTreeModel> departs) {
		this.departs = departs;
	}

	public List<BasePoint> getPoints() {
		return points;
	}

	public void setPoints(List<BasePoint> points) {
		this.points = points;
	}

}
