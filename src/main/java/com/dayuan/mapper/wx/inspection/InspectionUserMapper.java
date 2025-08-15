package com.dayuan.mapper.wx.inspection;

import com.dayuan.bean.wx.inspection.InspectionUser;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.model.wx.inspection.InspectionUserModel;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 查看你送我检信息的用户Mapper
 * Created by dy on 2018/8/3.
 */
public interface InspectionUserMapper extends BaseMapper<InspectionUser, Integer> {

    /**
     * 根据账号密码查询用户信息
     *
     * @param userName
     * @param password
     * @return
     * @throws Exception
     */
    InspectionUser selectUserByUserNameOrPassword(@Param("userName") String userName, @Param("password") String password, @Param("openid") String openid);

    /**
     * 根据电话号码查询用户信息
     *
     * @param mobilePhone
     * @return
     */
    InspectionUser selectInspectionUser(String mobilePhone);

    /**
     * 通过账号名称查询用户
     *
     * @param username
     * @return
     */
    InspectionUser selectUserByUsername(String username);

    /**
     * 通过手机号码和用户名查询用户
     *
     * @param mobilePhone
     * @return
     */
    InspectionUser selectUserByPhone(@Param("mobilePhone") String mobilePhone);

    /**
     * 修改密码
     *
     * @param userId
     * @param password
     */
    void changePassword(@Param("userId") Integer userId, @Param("password") String password);

    /**
     * 根据openid查询是否授权
     *
     * @param openid
     * @return
     */
    InspectionUser selectByOpenid(String openid);

    /**
     * 查询用户
     *
     * @param mobilePhone
     * @return
     */
    InspectionUser selectUserPhoneAndOpenid(@Param("mobilePhone") String mobilePhone);

    /**
     * 查询用户2
     *
     * @param mobilePhone
     * @return
     */
    InspectionUser selectUserPhoneAndOpenid2(@Param("mobilePhone") String mobilePhone, @Param("departId") String departId);

    /**
     * 跟换手机号码
     *
     * @param inspection_user
     */
    void replacePhoneByUser(InspectionUser inspection_user);

    /**
     * 更改该用户之前送检过的所有送检信息的电话号码
     *
     * @param mobilePhone
     */
    void replacePhoneInSamping(@Param("oldPhone") String oldPhone, @Param("mobilePhone") String mobilePhone);

    /**
     * 更改该用户之前送检过的所有送检信息的电话号码 指定机构下的
     *
     * @param mobilePhone
     */
    void replacePhoneInSamping2(@Param("oldPhone") String oldPhone, @Param("mobilePhone") String mobilePhone, @Param("departIds") List<Integer> departIds);

    /**
     * 微信界面解绑操作
     *
     * @param inspection_user session中存放当前登陆的用户 有id openid userName mobilePhone等参数
     * @throws Exception
     */
    void untieUser(InspectionUser inspection_user);

    /**
     * 绑定的编辑
     *
     * @param inspectionUser
     */
    void updateBindUser(InspectionUser inspectionUser);

    /**
     * 解绑用户
     *
     * @param id 用户id
     * @throws Exception
     */
    void deleteOpenidById(Integer id);

    /**
     * 通过appid查询关注人数
     *
     * @param model
     * @return
     */
    List<InspectionUser> selectByAppid(InspectionUserModel model);

    /**
     *编辑地址
     */
    void saveAddress(InspectionUser inspectionUser);
}
