package com.dayuan.mapper.data;

import com.dayuan.bean.data.BasePointUser;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 检测机构、点人员关联表
 *
 * @author Dz
 * @Description:
 * @Company:食安科技
 * @date 2017年9月1日
 */
public interface BasePointUserMapper extends BaseMapper<BasePointUser, String> {

    /**
     * 检测机构直属检测点成员
     *
     * @param departId
     * @return
     */
    List<BasePointUser> getSubPointUsers(Integer departId);

    /**
     * 获取当前检测点人员
     *
     * @param pointId
     * @return
     */
    List<BasePointUser> queryByPointId(Integer pointId);

    /**
     * 获取当前检测机构指定人员
     *
     * @param departId
     * @return
     */
    List<BasePointUser> queryByDepartId(String departId);

    /**
     * 获取当前检测点指定人员
     * @param pointId 检测点
     * @param userId
     * @return
     */
//	BasePointUser queryByPointAndUser(@Param("pointId")String pointId, @Param("userId")String userId);

    /**
     * 获取当前检测机构指定人员
     * @param departId 检测机构
     * @param userId
     * @return
     */
//	BasePointUser queryByDepartAndUser(@Param("departId")String departId, @Param("userId")String userId);

    /**
     * 通过机构或检测点ID查询人员(包含下级单位)
     *
     * @param departId 检测机构ID
     * @param pointId  检测点ID
     */
    List<BasePointUser> queryByPoint(@Param("departId") Integer departId, @Param("pointId") Integer pointId);

    /**
     * 删除检测机构及其下级机构关联用户
     *
     * @param departId
     */
    void deleteDepartUsers(Integer departId);

    /**
     * 删除检测点关联用户
     *
     * @param pointIds
     */
    void deletePointUsers(String[] pointIds);

    List<BasePointUser> selectByPointId(Integer pointId);

    /**
     * 在把人员移除项目的时候添加结束时间
     *
     * @param ids
     * @param endDate
     * @return
     */
    int delete(@Param("ids") String[] ids, @Param("endDate") Date endDate);

    /**
     * 根据人员id和人员状态为离职之后删除其中间表信息
     *
     * @param userId
     * @param endTime
     */
    void deleteByUserId(@Param("userId") String userId, @Param("endTime") Date endTime);

    /**
     * shit添加,如果该项目完成或者终止那就保存结束时间到该项目对应的中间表
     *
     * @param departId
     */
    void updateByProjectId(@Param("departId") Integer departId, @Param("endTime") Date endTime);

    /**
     * 查询人员职位
     * @param userId
     * @return
     */
    String selectPosition(@Param("db") String db, @Param("userId") String userId);
}