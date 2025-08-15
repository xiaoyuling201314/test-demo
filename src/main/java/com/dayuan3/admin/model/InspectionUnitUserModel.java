package com.dayuan3.admin.model;

import com.dayuan.model.BaseModel;
import com.dayuan3.admin.bean.InspectionUnit;

/**
 * 送样单位model
 * @author xiaoyl
 * @date   2019年7月1日
 */
public class InspectionUnitUserModel extends BaseModel {

    private InspectionUnit inspectionUnit;

    public InspectionUnit getInspectionUnit() {
        return inspectionUnit;
    }

    public void setInspectionUnit(InspectionUnit inspectionUnit) {
        this.inspectionUnit = inspectionUnit;
    }

    private Short type;//用户类型 0：送检用户 1：管理人员 2：监管方

    public Short getType() {
        return type;
    }

    public void setType(Short type) {
        this.type = type;
    }
}