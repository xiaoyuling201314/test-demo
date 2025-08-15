package com.dayuan3.common.service;

import com.dayuan.mapper.BaseMapper;
import com.dayuan.service.BaseService;
import com.dayuan3.common.bean.InspectionUnitUserAddress;
import com.dayuan3.common.mapper.InspectionUnitUserAddressMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shit
 * @comment 送检用户地址管理表
 * @Date 2020-03-12
 */
@Service
public class InspectionUnitUserAddressService extends BaseService<InspectionUnitUserAddress, Integer> {
    @Autowired
    private InspectionUnitUserAddressMapper mapper;

    @Override
    public BaseMapper<InspectionUnitUserAddress, Integer> getMapper() {
        return mapper;
    }

    /**
     * 根据用户ID查询配置的地址
     *
     * @param userId
     * @return
     */
    public List<InspectionUnitUserAddress> selectByUserId(Integer userId) throws Exception {
        return mapper.selectByUserId(userId);
    }

    /**
     * 设置默认标签/取消默认
     *
     * @param iuua
     */
    public void updateDefault(InspectionUnitUserAddress iuua) {
        mapper.updateDefault(iuua);
    }
}
