package com.dayuan3.admin.bean;

import com.dayuan.bean.BaseBean2;

import java.util.Date;
/**
 * Description 用户与经营单位关联表
 * @Author xiaoyl
 * @Date 2025/6/10 15:38
 */
public class InspectionUserRelation extends BaseBean2 {

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 经营单位ID
     */
    private Integer inspectionId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getInspectionId() {
        return inspectionId;
    }

    public void setInspectionId(Integer inspectionId) {
        this.inspectionId = inspectionId;
    }
}