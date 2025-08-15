package com.dayuan.service.system;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.model.BaseModel;
import com.dayuan.model.system.UserRoleModel;

import java.util.List;

/**
 * @author Dz
 * @description 针对表【t_s_user(系统用户表)】的数据库操作Service
 * @createDate 2025-06-17 12:13:18
 */
public interface TSUserService extends IService<TSUser> {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception;

    /**
     * 用户登录验证
     *
     * @param verify
     * @return
     */
    public TSUser toLogin(TSUser verify);

    /**
     * 判断注册用户名是否已存在
     *
     * @param userName
     * @return
     */
    public TSUser getUserByUserName(String userName);

    /**
     * 注册用户
     *
     * @param userName
     * @return 0注册失败  1注册成功
     */
    public boolean register(TSUser user);

    public boolean update(TSUser user) throws Exception;

    public UserRoleModel getUserAndRole(String id) throws Exception;

    /**
     * 根据用户组织机构ID或检测点ID查询用户列表
     *
     * @param uModel
     * @return
     */
    public List<TSUser> querySampleUser(TSUser uModel);

    /**
     * 通过机构ID查询用户
     *
     * @param departId  机构ID
     * @param subset    是否包含子级检测点 Y是/N否
     * @param pointName 检测点名称
     * @return
     */
    public List<TSUser> queryByDepartId(Integer departId, String subset, String realname) throws Exception;

    /**
     * 通过角色ID查询用户
     *
     * @param departId
     * @param subset
     * @param realname
     * @return
     * @throws Exception
     */
    public List<TSUser> queryByRoleId(String roleId, String realname) throws Exception;

    /**
     * @return
     * @Description根据检测点ID查询用户列表，用于抽样单复核使用
     * @Date 2020/10/29 11:46
     * @Author xiaoyl
     * @Param
     */
    public List<TSUser> queryByPointId(Integer pointId);


    /**
     * 根据用户 微信openid、登录账号、登录密码 查询用户是否存在
     *
     * @param openid   微信openid
     * @param username 登录账号
     * @param password 登录密码
     * @return
     */
    public List<TSUser> selectByData(String openid, String username, String password);

    /**
     * 微信用户解绑
     *
     * @param wxUser
     */
    public void unbind(TSUser wxUser);

    /**
     * 微信解绑
     *
     * @param user
     */
    public void delOpenid(TSUser user);

    /**
     * 所属机构下的用户的最大序号
     *
     * @param departId
     * @return
     */
    public short queryMaxSortByDepartId(Integer departId);

    /**
     * 微信云服务-查询企业下所有用户
     *
     * @param keyword   模糊查询条件(用户名称、昵称)
     * @param rowOffset
     * @param pageSize
     * @param departId
     * @return
     */
    public List<UserRoleModel> wxQueryUsers(int rowOffset, int pageSize, Integer departId, String keyword);

    /**
    * @Description 根据微信公众号openId查询用户信息
    * @Date 2022/12/07 17:11
    * @Author xiaoyl
    * @Param
    * @return
    */
    public TSUser queryByMiniOpenId(String miniOpenId);

}
