package com.dayuan.mapper.type;

import com.dayuan.bean.type.BaseType;

public interface BaseTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BaseType record);

    int insertSelective(BaseType record);

    BaseType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BaseType record);

    int updateByPrimaryKey(BaseType record);
}