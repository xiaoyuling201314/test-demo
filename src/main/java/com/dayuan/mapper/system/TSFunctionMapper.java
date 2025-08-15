package com.dayuan.mapper.system;

import com.dayuan.bean.system.TSFunction;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.system.RoleFunctionModel;
import com.dayuan3.api.vo.TSFunctionRespVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Description:  系统菜单
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月7日
 */
public interface TSFunctionMapper extends BaseMapper<TSFunction, String> {

    /**
     * 获取所有菜单
     *
     * @return
     */
    List<TSFunction> getMenus();

    /**
     * 根据角色id获取(云平台)主菜单
     *
     * @param roleId
     * @return
     */
    List<RoleFunctionModel> getRoleMenus(String roleId);

    /**
     * 根据父id获取菜单
     *
     * @param id
     * @return
     */
    List<TSFunction> queryMenuByPid(@Param("id") String id, @Param("functionType") Short functionType);

    /**
     * 根据ID查询菜单以及子类
     *
     * @param id
     * @return
     */
    List<TSFunction> querySubFunction(@Param("id") String id, @Param("deleteFlag") Integer deleteFlag);
    /**
     * 根据ID列表查询菜单信息
     * @param ids
     * @return
     */
    //List<String> queryMenuByIdList(String[] ids);
    /**
     * 根据菜单名称进行查询
     * @param functionName
     * @return
     */
    //List<TSFunction> queryMenuByName(String functionName);

    /**
     * 根据角色权限获取菜单
     *
     * @param roleId 角色ID
     * @return
     */
    List<TSFunction> queryByRoleId(String roleId);

    /**
     * 根据url查找菜单信息
     *
     * @param functionUrl
     * @return
     */
    TSFunction queryByFunctionUrl(String functionUrl);

    //	/**
//	 * 根据主菜单获取下级菜单
//	 * @param roleFuntion
//	 * @return
//	 */
//	List<RoleFunctionModel> getSubordination(RoleFunctionModel roleFuntion);
    String queryMaxIdByPid(@Param("id") String id);

    TSFunction queryByFunctionName(TSFunction bean);

    String queryMaxSortingByPid(@Param("parentId") String parentId, @Param("functionType") Short functionType);

    int queryMaxId();

    /**
     * 按需查菜单
     *
     * @param functionName
     * @param functionType
     * @return
     */
    List<TSFunction> selectFunctionAll(@Param("functionLevel") Short functionLevel, @Param("functionName") String functionName, @Param("functionType") Short functionType);

    /**
     * 根据父级菜单id查询子级菜单
     *
     * @param id
     * @return
     */
    List<TSFunction> selectSystemByParentId(@Param("functionName") String functionName, @Param("id") String id);

    /**
     * 查找除去一级菜单的所有菜单
     *
     * @param functionName
     * @param functionType
     * @return
     */
    List<TSFunction> selectFunctionAllNot1(@Param("functionName") String functionName, @Param("functionType") Short functionType);

    /**
     * 菜单的启用
     *
     * @param id
     */
    void enableStart(Integer id);

    /**
     * 根据角色ID和菜单类型查询菜单
     *
     * @param roleId
     * @param type   0：云平台 1：APP 2：工作站 3：公众号
     * @return
     * @author shit
     */
    List<TSFunction> queryByRIdAndType(@Param("roleId") String roleId, @Param("type") Short type);
    /**
    * @Description 根据登录用户的角色ID查询是否有指定地址的权限
    * @Date 2022/10/20 14:24
    * @Author xiaoyl
    * @Param
    * @return
    */
    TSFunction queryVisualPrivile(@Param("roleId")String roleId, @Param("functionUrl")String functionUrl);
    /**
     * Description  根据角色ID、类型和等级查询菜单权限
     * @Author xiaoyl
     * @Date 2025/7/23 10:25
     */
    List<TSFunctionRespVo> getRolesForWX(@Param("roleId")String roleId,@Param("functionType")Integer functionType, @Param("level")int level);
}