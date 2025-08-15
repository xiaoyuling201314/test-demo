package com.dayuan3.admin.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.admin.bean.InspectionUserRelation;

import java.util.List;

public interface InspectionUserRelationMapper extends BaseMapper<InspectionUserRelation, Integer> {

    int deleteByUserId(Integer id);

    int saveBath(List<InspectionUserRelation> list);
}