package com.dayuan.service.regulatory;

import com.dayuan.bean.regulatory.BaseRegulatoryType;
import com.dayuan.mapper.regulatory.BaseRegulatoryTypeMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 监管对象类型
 *
 * @author Dz
 */
@Service
public class BaseRegulatoryTypeService extends BaseService<BaseRegulatoryType, String> {

    @Autowired
    private BaseRegulatoryTypeMapper mapper;

    public BaseRegulatoryTypeMapper getMapper() {
        return mapper;
    }

    /**
     * 根据类型编码,查询监管对象类型
     */
    public BaseRegulatoryType queryByRegTypeCode(String regTypeCode) {
        return mapper.queryByRegTypeCode(regTypeCode);
    }

    /**
     * 查询所有监管对象类型
     */
    public List<BaseRegulatoryType> queryAll() {
        return mapper.queryAll();
    }

    public BaseRegulatoryType selectByRegType(String regType) {
        return mapper.selectByRegType(regType);
    }

    /**
     * 通过类型名称查询监管对象类型
     */
    public BaseRegulatoryType queryByTypeName(String typeName) {
        return mapper.queryByTypeName(typeName);
    }

    /**
     * 通过监管对象ID查询监管对象类型
     *
     * @param regId 监管对象ID
     * @return
     * @author Dz
     * 2019年4月24日 下午2:31:31
     */
    public BaseRegulatoryType queryByRegId(Integer regId) {
        return mapper.queryByRegId(regId);
    }

    /**
     * 查询一个默认的监管类型（最小的sorting参数）
     *
     * @return
     */
    public BaseRegulatoryType queryOneBySortAsc() {
        return mapper.queryOneBySortAsc();
    }
    /**
    * @Description 根据机构ID查询监管对象接入情况并按照监管对象类型分组
    * @Date 2022/08/24 9:51
    * @Author xiaoyl
    * @Param
    * @return
    */
    public List<BaseRegulatoryType> queryRegTypeGroup(Integer departId) {
        return mapper.queryRegTypeGroup(departId);
    }
}
