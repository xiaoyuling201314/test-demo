package com.dayuan3.terminal.model;

import java.util.ArrayList;
import java.util.List;

import com.dayuan.model.BaseModel;

/**
 * 送样单位model
 *
 * @author xiaoyl
 * @date 2019年7月1日
 */
public class RequesterUnitModel extends BaseModel {
    /**
     * 委托单位名称
     */
    private String requesterName;

    /**
     * 查询条件:送检单位Id
     */
    private String inspId;

    private String samplingId;//订单ID

    private String id;

    private Integer checked;//是否审核

    private Short weekendWork;//周末是否上班 0 否， 1 是

    private Integer unitType;//单位类型1:餐饮 2:学校 3:食堂 4:供应商 9:其他 shit添加

    //================= 以下为非数据库字段 =========================
    private String[] unitTypeArr = new String[]{};//单位类型数组(格式如：["1","2","3","4","9"])shit添加

    private Short noPage;//不为1表示不进行分页
    
    private Short coverageType;//覆盖类型：0日覆盖，1周覆盖、2月覆盖

    private Short filterDelete;//是否过滤已删除单位：0 过滤，1 不过滤

    public String getRequesterName() {
        return requesterName;
    }

    public void setRequesterName(String requesterName) {
        this.requesterName = requesterName;
    }

    public String getInspId() {
        return inspId;
    }

    public void setInspId(String inspId) {
        this.inspId = inspId;
    }

    public String getSamplingId() {
        return samplingId;
    }

    public void setSamplingId(String samplingId) {
        this.samplingId = samplingId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getChecked() {
        return checked;
    }

    public void setChecked(Integer checked) {
        this.checked = checked;
    }

    public Integer getUnitType() {
        return unitType;
    }

    public void setUnitType(Integer unitType) {
        this.unitType = unitType;
    }

    public String[] getUnitTypeArr() {
        return unitTypeArr.length == 0 ? null : unitTypeArr;
    }

    public void setUnitTypeArr(String[] unitTypeArr) {
        this.unitTypeArr = unitTypeArr;
    }

    public Short getNoPage() {
        return noPage;
    }

    public void setNoPage(Short noPage) {
        this.noPage = noPage;
    }

    public Short getWeekendWork() {
        return weekendWork;
    }

    public void setWeekendWork(Short weekendWork) {
        this.weekendWork = weekendWork;
    }

	public Short getCoverageType() {
		return coverageType;
	}

	public void setCoverageType(Short coverageType) {
		this.coverageType = coverageType;
	}

    public Short getFilterDelete() {
        return filterDelete;
    }

    public void setFilterDelete(Short filterDelete) {
        this.filterDelete = filterDelete;
    }
}