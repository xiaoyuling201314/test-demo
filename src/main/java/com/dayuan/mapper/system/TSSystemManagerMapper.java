package com.dayuan.mapper.system;

import com.dayuan.bean.system.TSSystemManager;
import com.dayuan.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 系统软件版本管理
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年11月6日
 */
public interface TSSystemManagerMapper extends BaseMapper<TSSystemManager, Integer> {

    /**
     * 获取软件最新版本
     *
     * @param appType 软件类型
     * @param nowDate 日期时间
     * @return
     */
    TSSystemManager latestUpdatePackage(@Param("appType") String appType, @Param("nowDate") String nowDate);

    /**
     * 获取所有软件最新版本
     *
     * @param nowDate 日期时间
     * @return
     */
    List<TSSystemManager> allLatestUpdatePackages(@Param("nowDate") String nowDate);

    List<TSSystemManager> selectListAllHistorySoftware(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * 查询出历史版本（补丁包）
     *
     * @param currentDate
     * @param appType
     * @return
     */
    List<TSSystemManager> selectListAllHistorySoftware2(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * shit添加 查询出app的类型
     *
     * @return
     */
    List<String> selectAppType();


    /**
     * 查询当前使用中的软件
     *
     * @param currentDate
     * @param appType
     * @return
     */
    TSSystemManager selectInUse(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * 查询当前使用中的软件（补丁包）
     *
     * @param currentDate
     * @param appType
     * @return
     */
    TSSystemManager selectInUse2(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * 查询出未启用的软件
     *
     * @param currentDate
     * @param appType
     * @return
     */
    List<TSSystemManager> selectNotEnabled(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * 查询出所有未启用的软件（补丁包）
     *
     * @param currentDate
     * @param appType
     * @return
     */
    List<TSSystemManager> selectNotEnabled2(@Param("currentDate") String currentDate, @Param("appType") String appType);

    /**
     * 查询出简介
     *
     * @return
     */
    List<Map<String, Object>> selectIntroduce();


    /**
     * 查询出该软件是否有补丁包
     * @param appType
     * @return
     */
    Integer selectPatchByType(String appType);

}