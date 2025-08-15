package com.dayuan3.admin.service.chain;

import com.dayuan.service.BaseService;
import com.dayuan3.admin.bean.chain.ColdChainUnit;
import com.dayuan3.admin.mapper.chain.ColdChainUnitMapper;
import com.dayuan3.api.vo.ColdChainUnitRespVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 监管对象
 *
 * @author Dz
 */
@Service
public class ColdChainUnitService extends BaseService<ColdChainUnit, Integer> {

    @Autowired
    private ColdChainUnitMapper mapper;

    public ColdChainUnitMapper getMapper() {
        return mapper;
    }

    /**
     * 删除监管对象
     *
     * @param userId 操作用户ID
     * @param ids    删除数据ID
     * @return
     * @throws Exception
     */
    public int deleteData(String userId, Integer[] ids) throws Exception {
        if (ids == null || ids.length < 1) {
            return 0;
        }
        return mapper.deleteData(userId, ids);
    }

    /**
     * 根据组织机构查询监管对象
     *
     * @param departId
     * @param checked  null全部，1已审核，0未审核
     * @return
     */
    public List<ColdChainUnit> queryByDepartId(Integer departId, String checked) {
        return mapper.queryByDepartId(departId, checked);
    }

    /**
     * 根据组织机构查询直属监管对象
     *
     * @param departId
     * @param checked  null全部，1已审核，0未审核
     * @return
     */
    public List<ColdChainUnit> queryByDepartId1(Integer departId, String checked) {
        return mapper.queryByDepartId1(departId, checked);
    }

    /**
     * 根据机构Id、检测单位类型 查询被检单位
     *
     * @param departId         机构Id
     * @param coldName 单位名称
     * @param checked
     * @return
     * @author LuoYX
     * @date 2018年2月5日
     */
    public List<ColdChainUnit> queryRegByDepartId(Integer departId, String coldName) {
        return mapper.queryRegByDepartId(departId, coldName);
    }

    /**
     * 根据机构Id、检测单位类型 查询被检单位
     *
     * @param departArr        机构Id数组
     * @param regualtoryTypeId 检测单位类型
     * @return
     * @author Dz
     */
    public List<ColdChainUnit> queryRegByDepartIds(String regualtoryTypeId, String[] departArr) {
        return mapper.queryRegByDepartIds(regualtoryTypeId, departArr);
    }

    /**
     * 查询机构 下的所有 监管对象
     *
     * @param subDepartIds 机构id及子机构id
     * @return
     * @author LuoYX
     * @date 2018年4月27日
     */
    public List<Integer> queryRegIdsByDepartIds(List<Integer> subDepartIds) {
        return mapper.queryRegIdsByDepartIds(subDepartIds);
    }


    public ColdChainUnit selectByDepartCodeAndRegName(String departCode, String departName, String regName, String regType) {
        return mapper.selectByDepartCodeAndRegName(departCode, departName, regName, regType);
    }

    public ColdChainUnit selectByDepartNameAndRegName(String departName, String regName) {
        return mapper.selectByDepartNameAndRegName(departName, regName);
    }


//	/**
//	 * 查询机构下的市场
//	 * @param departId 部门ID
//	 * @param subset 是否包含子机构
//	 * @param regName 市场名称
//	 * @return
//			 * @author LuoYX
//	 * @date 2018年5月14日
//	 */
//	public List<BaseRegulatoryObject> queryRegByDepartIdAndRegName(Integer departId, String subset, String regName) {
//		return mapper.queryRegByDepartIdAndRegName(departId,subset,regName);
//	}

    /**
     * 查询机构下的市场
     *
     * @param departCode 机构编号
     * @param subset     是否查询子机构下的
     * @return
     * @author LuoYX
     * @date 2018年5月30日
     */
    public List<Map<String, Object>> queryRegMapByDepartCode(String departCode, String subset) {
        return mapper.queryRegMapByDepartCode(departCode, subset);
    }

    /**
     * 获取全部obj
     *
     * @param departId
     * @return
     * @author hu
     */
    public List<ColdChainUnit> queryAllByDepartId(ColdChainUnit obj) {
        return mapper.queryAllByDepartId(obj);
    }

    ;

    /**
     * 根据机构ID、监管对象类型、监管对象名称查询
     *
     * @param departId
     * @param regType
     * @param regName
     * @return
     */
    public List<ColdChainUnit> queryRegByDIdAndRegName(Integer departId, String regType, String regName) {
        return mapper.queryRegByDIdAndRegName(departId, regType, regName);
    }

    /**
     * 根据机构ID、监管对象类型、监管对象名称查询
     *
     * @param departId
     * @param regType
     * @param regName
     * @return
     */
    public List<ColdChainUnit> queryRegByDIdAndRegName2New(Integer departId, String regType, String regName) {
        return mapper.queryRegByDIdAndRegName2New(departId, regType, regName);
    }

    /**
     * 根据 机构code查询市场
     *
     * @param regualtoryTypeId 市场类型
     * @param departCode
     * @return
     */
    public List<ColdChainUnit> queryRegByDepartCode(String regualtoryTypeId, String departCode) {
        return mapper.queryRegByDepartCode(regualtoryTypeId, departCode);
    }

    /**
     * 根据机构ID和监管对象编码查询监管对象
     *
     * @param otherCode
     * @return
     */
    public ColdChainUnit queryByOtherCode(Integer departId, String otherCode) {
        return mapper.queryByOtherCode(departId, otherCode);
    }

    /**
     * 根据组织机构，是否审核，最后更新时间查询对象，用于自助终端后台定时生成首拼
     *
     * @param departId
     * @param checked
     * @param lastUpdateTime
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月25日
     */
    public List<ColdChainUnit> queryByLastUpdateTime(Integer departId, String checked, String lastUpdateTime) {
        return mapper.queryByLastUpdateTime(departId, checked, lastUpdateTime);
    }

    /**
     * @return
     * @Description 根据监管对象ID信息查询基本信息和经营户信息
     * @Date 2021/06/03 13:50
     * @Author xiaoyl
     * @Param regId 监管对象ID
     */
    public ColdChainUnit queryById2Print(Integer regId) {
        return mapper.queryById2Print(regId);
    }

    /**
     * 被检单位名称校验重复
     *
     * @param id
     * @param name
     * @param type
     * @return
     * @date 2022-03-14
     * 用于仪器嵌入的网页端新增被检单位时的唯一校验
     */
    public ColdChainUnit reqName(Integer id, String name, String type,Integer departId) {
        return mapper.reqName(id, name, type,departId);
    }
    /**
    * @Description 根据监管对象ID查找数据，包括经营户数量
    * @Date 2022/04/13 13:29
    * @Author xiaoyl
    * @Param
    * @return
    */
    public ColdChainUnit queryByIdForTemplate4(Integer id) {
        return mapper.queryByIdForTemplate4(id);
    }

    public List<ColdChainUnitRespVo> queryAllUnit(String keywords) {
        return mapper.queryAllUnit(keywords);
    }
}
