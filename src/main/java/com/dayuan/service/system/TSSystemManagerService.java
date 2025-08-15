package com.dayuan.service.system;

import com.dayuan.bean.system.TSSystemManager;
import com.dayuan.mapper.system.TSSystemManagerMapper;
import com.dayuan.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
@Service
public class TSSystemManagerService extends BaseService<TSSystemManager, Integer> {

    @Autowired
    private TSSystemManagerMapper mapper;

    public TSSystemManagerMapper getMapper() {
        return mapper;
    }

    /**
     * 获取软件最新版本
     *
     * @param appType 软件类型
     * @param nowDate 日期时间
     * @return
     */
    public TSSystemManager latestUpdatePackage(String appType, String nowDate) {
        TSSystemManager systemManager = mapper.latestUpdatePackage(appType, nowDate);
        return systemManager;
    }

    /**
     * 获取全部软件最新版本
     *
     * @param nowDate 日期时间
     * @return
     */
    public List<TSSystemManager> allLatestUpdatePackages(String nowDate) {
        List<TSSystemManager> systemManagers = mapper.allLatestUpdatePackages(nowDate);
        return systemManagers;
    }

    public List<TSSystemManager> selectListAllHistorySoftware(String currentDate, String appType) throws Exception {
        return mapper.selectListAllHistorySoftware(currentDate, appType);
    }

    /**
     * 查询出历史版本（补丁包）
     * @param currentDate
     * @param appType
     * @return
     * @throws Exception
     */
    public List<TSSystemManager> selectListAllHistorySoftware2(String currentDate, String appType) throws Exception {
        return mapper.selectListAllHistorySoftware2(currentDate, appType);
    }

    /**
     * shit添加 查询出app的类型
     *
     * @return
     */
    public List<String> selectAppType() throws Exception {
        return mapper.selectAppType();
    }

    /**
     * 查询当前使用中的软件
     *
     * @param currentDate
     * @param appType
     * @return
     */
    public TSSystemManager selectInUse(String currentDate, String appType) {
        return mapper.selectInUse(currentDate, appType);
    }
    /**
     * 查询当前使用中的软件（补丁包）
     *
     * @param currentDate
     * @param appType
     * @return
     */
    public TSSystemManager selectInUse2(String currentDate, String appType) {
        return mapper.selectInUse2(currentDate, appType);
    }

    /**查询出未启用的软件
     * @param format
     * @param appType
     * @return
     */
    public List<TSSystemManager> selectNotEnabled(String format, String appType) {
        return mapper.selectNotEnabled(format, appType);
    }
    /**查询出所有未启用的软件（补丁包）
     * @param format
     * @param appType
     * @return
     */
    public List<TSSystemManager> selectNotEnabled2(String format, String appType) {
        return mapper.selectNotEnabled2(format, appType);
    }

    /**
     * 查询出简介
     * @return
     */
    public List<Map<String, Object>> selectIntroduce() {
        return mapper.selectIntroduce();
    }

    /**
     * 查询出该软件是否有补丁包
     * @param appType
     * @return
     */
    public Integer selectPatchByType(String appType) {
        return mapper.selectPatchByType(appType);
    }
}
