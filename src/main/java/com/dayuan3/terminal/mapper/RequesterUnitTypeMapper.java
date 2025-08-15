package com.dayuan3.terminal.mapper;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.terminal.bean.RequesterUnitType;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RequesterUnitTypeMapper extends BaseMapper<RequesterUnitType, Integer> {

	List<RequesterUnitType> queryAllType();

    /**
     * 根据ID查询监控类型
     * @param ids
     * @return
     * @author shit
     */
    List<RequesterUnitType> selectByIds(String[] ids);

    RequesterUnitType selectByName(@Param("unitType")String unitType);
}