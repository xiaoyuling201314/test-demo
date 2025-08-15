package com.dayuan.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dayuan.bean.system.TSOperation;
import com.dayuan.mapper.system.TSOperationMapper;
import com.dayuan.mapper.system.TSRoleFunctionMapper;
import com.dayuan.service.BaseService;

/**
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月31日
 */
@Service("tSOperationService")
public class TSOperationService extends BaseService<TSOperation, String> {

    @Autowired
    private TSOperationMapper mapper;

    public TSOperationMapper getMapper() {
        return mapper;
    }

    /**
     * 根据菜单ID和功能权限名称查询操作权限
     *
     * @param functionId
     * @param operationName
     * @return
     */
    public TSOperation queryByOperationName(TSOperation bean) throws Exception {
        return mapper.queryByOperationName(bean);
    }

    public List<TSOperation> queryByRoleIdAndFunctionId(String roleId, String functionId) throws Exception {
        return mapper.queryByRoleIdAndFunctionId(roleId, functionId);
    }

    public String queryLastCode(String id) {
        return mapper.queryLastCode(id);
    }

    /**
     * 根据function_id进行批量删除
     *
     * @param id 菜单功能ID
     */
    public void deleteByFunctionId(String id) {
        mapper.deleteByFunctionId(id);
    }

    /**
     * 根据function_id进行批量启用
     *
     * @param id 菜单功能ID
     */
    public void enableByFunctionId(Integer id) {
        mapper.enableByFunctionId(id);
    }

    /**
     * 查询所有 按钮权限
     *
     * @param roleId 角色ID
     * @return
     * @author LuoYX
     * @date 2018年5月25日
     */
    public List<TSOperation> queryAllPrivilegs(String roleId) {
        return mapper.queryAllPrivilegs(roleId);
    }

    /**
     * 根据角色ID和菜单类型查询权限按钮
     * @param roleId 角色ID
     * @param type 菜单类型
     * @author shit
     * @return
     */
    public List<TSOperation> queryByRIdAndType(String roleId, Short type) {
        return mapper.queryByRIdAndType( roleId,  type);
    }
    /**
    * @Description 根据角色ID、操作权限code查询是否有该权限
    * @Date 2022/10/20 14:45
    * @Author xiaoyl
    * @Param
    * @return
    */
    public int queryByOperationCode(String roleId,String operationCode) {
        return mapper.queryByOperationCode(roleId,operationCode);
    }
}
