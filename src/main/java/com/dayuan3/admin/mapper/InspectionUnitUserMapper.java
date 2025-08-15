package com.dayuan3.admin.mapper;

import java.util.Date;
import java.util.List;

import com.dayuan.bean.Page;
import com.dayuan3.terminal.bean.InspectionUserLog;
import com.dayuan3.admin.model.InspectionUnitUserModel;
import org.apache.ibatis.annotations.Param;

import com.dayuan.mapper.BaseMapper;
import com.dayuan3.admin.bean.InspectionUnitUser;

public interface InspectionUnitUserMapper extends BaseMapper<InspectionUnitUser, Integer> {

	InspectionUnitUser queryUser(InspectionUnitUser user);

	List<InspectionUnitUser> queryUserByInspectId(@Param("inspectionId")Integer inspectionId,@Param("rowStart")Integer rowStart,@Param("rowEnd")Integer rowEnd);

    String getMaxAccount();

    InspectionUnitUser queryByPhone(@Param("linkPhone")String linkPhone);
	
    
    /** 2019-7-25 huht
     * 查询账号密码是否存在
     * @param username
     * @param password
     * @return
     */
    InspectionUnitUser   selectByUserName(@Param("userName")String userName,@Param("password")String password ,@Param("openId")String openId);
    
    /**
     * 2020-3-17 huht 查询小程序miniopenid
     * @param userName
     * @param password
     * @param openId
     * @param miniOpenId
     * @return
     */
	InspectionUnitUser   selectByUserName2(@Param("userName")String userName,@Param("password")String password ,@Param("openId")String openId,@Param("miniOpenId")String miniOpenId);
	/**
	 * 根据送检单位查询用户数量
	 * @description
	 * @param inspectionId
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月29日
	 */
	int queryCountByInspectId(@Param("inspectionId")Integer inspectionId);
	
	/**
	 * 管理权限转移
	 * huht 2019-8-31
	 * @param inspectionId 送检单位id
	 * @param id 获取管理员权限的用户id
	 */
	void changeManage(@Param("inspectionId")Integer inspectionId,@Param("id")Integer id);
    
	/**
	 * 查询刚注册未审核数量（审核时间为空）
	 * @param inspectionId
	 * @return
	 */
	int selectUnResCount(Integer inspectionId);

	/**
	 * 根据登录账号去查询送检用户
	 *
	 * @param userName
	 * @return
	 */
    InspectionUnitUser selectByUsername(String userName);

	/**
	 * 根据手机号码去查询送检用户
	 *
	 * @param phone
	 * @return
	 */
	InspectionUnitUser selectByPhone(String phone);

	int getRowTotalAll(Page page);

	List<InspectionUnitUserModel> loadDatagridAll(Page page);

    void delOpenid(InspectionUnitUser iuu);

	/**
	 * 重置送检账号支付密码
	 * @param iuu
	 */
	void resetpwd(InspectionUnitUser iuu);

    int selcetNumber(@Param("id") Integer id, @Param("identifiedNumber") String identifiedNumber);

	InspectionUnitUser queryByUserId(Integer userId);

	/**
	 * 送检用户停用或者启用用户方法
	 * @param stopId
	 * @param checked
	 */
    void stop(@Param("stopId") Integer stopId, @Param("checked") Short checked, @Param("updateBy") String updateBy, @Param("now") Date now);

	/**
	 * 保存操作日志
	 * @param iulog
	 */
	void insertInsUserLog(InspectionUserLog iulog);

	/**
	 * 根据用户openid或者手机号码+密码查询用户信息
	 * @Author xiaoyl
	 * @Date 2025/6/11 10:55
	 */
	InspectionUnitUser queryUserLogin(@Param("openid")String openid, @Param("phone")String phone, @Param("password")String password);

}