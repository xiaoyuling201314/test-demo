package com.dayuan.service.system.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.TSUser;
import com.dayuan.mapper.system.TSUserMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.model.system.UserRoleModel;
import com.dayuan.service.system.TSUserService;
import com.dayuan.util.StringUtil;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @author Dz
* @description 针对表【t_s_user(系统用户表)】的数据库操作Service实现
* @createDate 2025-06-17 12:13:18
*/
@Service
public class TSUserServiceImpl extends ServiceImpl<TSUserMapper, TSUser>
    implements TSUserService {

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
//			page.setRowOffset(page.getRowOffset());
//			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 用户登录验证
     *
     * @param verify
     * @return
     */
    public TSUser toLogin(TSUser verify) {
        TSUser user = getBaseMapper().toLogin(verify);
        return user;
    }

    /**
     * 判断注册用户名是否已存在
     *
     * @param userName
     * @return
     */
    public TSUser getUserByUserName(String userName) {
        return getBaseMapper().getUserByUserName(userName);
    }

    /**
     * 注册用户
     *
     * @param userName
     * @return 0注册失败  1注册成功
     */
    public boolean register(TSUser user) {
        int count = getBaseMapper().insert(user);
        return count > 0;
    }

    public boolean update(TSUser user) throws Exception {
        int count = getBaseMapper().updateById(user);
        return count > 0;
    }

    public UserRoleModel getUserAndRole(String id) throws Exception {
        return getBaseMapper().getUserAndRole(id);
    }

    /**
     * 根据用户组织机构ID或检测点ID查询用户列表
     *
     * @param uModel
     * @return
     */
    public List<TSUser> querySampleUser(TSUser uModel) {
        List<TSUser> list = null;
        Map<String, Object> map = new HashMap<>();
        if (null != uModel.getPointId()) {//查询检测点信息
            map.put("pointId", uModel.getPointId());
            map.put("departId", null);
            list = getBaseMapper().querySampleUser(map);
        } else {//查询机构信息
            map.put("pointId", null);
            map.put("departId", uModel.getDepartId());
            list = getBaseMapper().querySampleUser(map);
        }
        return list;
    }

    /**
     * 通过机构ID查询用户
     *
     * @param departId  机构ID
     * @param subset    是否包含子级检测点 Y是/N否
     * @param pointName 检测点名称
     * @return
     */
    public List<TSUser> queryByDepartId(Integer departId, String subset, String realname) throws Exception {
        List<TSUser> points = getBaseMapper().queryByDepartId(departId, subset, realname);
        return points;
    }

    /**
     * 通过角色ID查询用户
     *
     * @param departId
     * @param subset
     * @param realname
     * @return
     * @throws Exception
     */
    public List<TSUser> queryByRoleId(String roleId, String realname) throws Exception {
        List<TSUser> users = getBaseMapper().queryByRoleId(roleId, realname);
        return users;
    }

    /**
     * @return
     * @Description根据检测点ID查询用户列表，用于抽样单复核使用
     * @Date 2020/10/29 11:46
     * @Author xiaoyl
     * @Param
     */
    public List<TSUser> queryByPointId(Integer pointId) {
        List<TSUser> list = getBaseMapper().queryByPointId(pointId);
        return list;
    }


    /**
     * 根据用户 微信openid、登录账号、登录密码 查询用户是否存在
     *
     * @param openid   微信openid
     * @param username 登录账号
     * @param password 登录密码
     * @return
     */
    public List<TSUser> selectByData(String openid, String username, String password) {
        if (StringUtil.isEmpty(openid) && StringUtil.isEmpty(username)) {
            return null;
        }
        return getBaseMapper().selectByData(openid, username, password);
    }

    /**
     * 微信用户解绑
     *
     * @param wxUser
     */
    public void unbind(TSUser wxUser) {
        getBaseMapper().unbind(wxUser);
    }

    /**
     * 微信解绑
     *
     * @param user
     */
    public void delOpenid(TSUser user) {
        getBaseMapper().delOpenid(user);
    }

    /**
     * 所属机构下的用户的最大序号
     *
     * @param departId
     * @return
     */
    public short queryMaxSortByDepartId(Integer departId) {
        return getBaseMapper().queryMaxSortByDepartId(departId);
    }

    /**
     * 微信云服务-查询企业下所有用户
     *
     * @param keyword   模糊查询条件(用户名称、昵称)
     * @param rowOffset
     * @param pageSize
     * @param departId
     * @return
     */
    public List<UserRoleModel> wxQueryUsers(int rowOffset, int pageSize, Integer departId, String keyword) {
        return getBaseMapper().wxQueryUsers(rowOffset, pageSize, departId, keyword);
    }
    /**
     * @Description 根据微信公众号openId查询用户信息
     * @Date 2022/12/07 17:11
     * @Author xiaoyl
     * @Param
     * @return
     */
    public TSUser queryByMiniOpenId(String miniOpenId) {
        return getBaseMapper().queryByMiniOpenId(miniOpenId);
    }

}




