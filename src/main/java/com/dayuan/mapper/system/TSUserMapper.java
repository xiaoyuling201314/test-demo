package com.dayuan.mapper.system;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.system.UserRoleModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * @author Dz
 * @description 针对表【t_s_user(系统用户表)】的数据库操作Mapper
 * @createDate 2025-06-17 12:13:18
 * @Entity generator.domain.TSUser
 */
public interface TSUserMapper extends BaseMapper<TSUser> {

    /**
     * 查询分页数据列表
     * @param page
     * @return
     */
    List<TSUser> loadDatagrid(Page page);

    /**
     * 查询记录总数量
     * @param page
     * @return
     */
    int getRowTotal(Page page);

    /**
     * 登录
     *
     * @param record
     * @return
     */
    TSUser toLogin(TSUser record);

    /**
     * 根据账号获取用户
     *
     * @param userName
     * @return
     */
    TSUser getUserByUserName(String userName);

    UserRoleModel getUserAndRole(String id);

    /**
     * 根据检测点或组织机构查询用户信息
     *
     * @param object
     * @param ids
     * @return
     * @author xyl
     */
    List<TSUser> querySampleUser(Map<String, Object> map);

    /**
     * 通过组织ID查询用户集合(可包含子级用户)
     */
    List<TSUser> queryByDepartId(@Param("departId") Integer departId, @Param("subset") String subset, @Param("realname") String realname);

    //通过角色ID查询用户
    List<TSUser> queryByRoleId(@Param("roleId") String roleId, @Param("realname") String realname);

    List<TSUser> queryByPointId(@Param("pointId") Integer pointId);

    /**
     * 根据用户 微信openid、登录账号、登录密码 查询用户是否存在
     *
     * @param openid   微信openid
     * @param username 登录账号
     * @param password 登录密码
     * @return
     */
    List<TSUser> selectByData(@Param("openid") String openid, @Param("username") String username, @Param("password") String password);

    /**
     * 微信用户解绑
     *
     * @param wxUser
     */
    void unbind(TSUser wxUser);

    /**
     * 微信解绑
     *
     * @param user
     */
    void delOpenid(TSUser user);

    /**
     * 所属机构下的用户的最大序号
     *
     * @param departId
     * @return
     */
    short queryMaxSortByDepartId(Integer departId);

    /**
     * 微信云服务-查询企业下所有用户
     *
     * @param rowOffset
     * @param pageSize
     * @param departId
     * @return
     */
    List<UserRoleModel> wxQueryUsers(@Param("rowOffset") int rowOffset, @Param("pageSize") int pageSize, @Param("departId") Integer departId, @Param("keyword") String keyword);
    /**
    * @Description 根据微信公众号openId查询用户信息
    * @Date 2022/12/07 17:22
    * @Author xiaoyl
    * @Param
    * @return
    */
    TSUser queryByMiniOpenId(@Param("miniOpenId")String miniOpenId);
}