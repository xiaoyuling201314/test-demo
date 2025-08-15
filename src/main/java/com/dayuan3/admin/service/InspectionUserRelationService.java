package com.dayuan3.admin.service;

import com.dayuan.service.BaseService;
import com.dayuan3.admin.bean.InspectionUserRelation;
import com.dayuan3.admin.mapper.InspectionUserRelationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Description 用户与经营单位关联表
 * @Author xiaoyl
 * @Date 2025/6/10 15:36
 */
@Service
public class InspectionUserRelationService extends BaseService<InspectionUserRelation, Integer> {
    @Autowired
    private InspectionUserRelationMapper mapper;

    public InspectionUserRelationMapper getMapper() {
        return mapper;
    }
}
