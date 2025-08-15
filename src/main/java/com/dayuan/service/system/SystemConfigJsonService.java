package com.dayuan.service.system;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.util.FileUtil;
import com.dayuan.util.StringUtil;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.net.URLDecoder;

/**
 * 系统配置
 *
 * @author Dz
 * 2021/07/19
 */
@Service
public class SystemConfigJsonService {
    private final Logger log = Logger.getLogger(SystemConfigJsonService.class);

    /**
     * 系统配置
     */
    private JSONObject systemConfig;

    /**
     * 系统配置类型
     */
    public enum systemConfigType {
        /**
         * 监管对象二维码风格
         */
        REG_QRCODE_STYLE
    }

    /**
     * 读取系统配置
     * @return
     */
    private JSONObject getSystemConfig0() {
        if (systemConfig == null) {
            URL url = this.getClass().getClassLoader().getResource("systemConfig.json");
            if (url != null) {
                String filePath = "";
                try {
                    filePath = URLDecoder.decode(url.getPath(), "UTF-8");
                } catch (Exception e) {
                    log.error("*****"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
                }
                filePath = filePath.substring(1);
                String systemConfigJsonStr = FileUtil.readFileAll(filePath);
                if (StringUtil.isNotEmpty(systemConfigJsonStr)) {
                    systemConfig = JSONObject.parseObject(systemConfigJsonStr);
                }
            }

            if (systemConfig == null) {
                systemConfig = new JSONObject();
            }
        }
        return systemConfig;
    }

    /**
     * 读取系统配置
     * @return
     */
    public JSONObject getSystemConfig(systemConfigType systemConfigType) {
        return getSystemConfig0().getJSONObject(systemConfigType.name());
    }

    /**
     * 更新系统配置
     * @param config
     */
    public synchronized void setSystemConfig(systemConfigType systemConfigType, JSONObject config) throws Exception {
        if (systemConfig == null) {
            getSystemConfig0();
        }
        systemConfig.put(systemConfigType.name(), config);
        URL url = this.getClass().getClassLoader().getResource("systemConfig.json");
        String filePath = URLDecoder.decode(url.getPath(), "UTF-8");
        filePath = filePath.substring(1);
        FileUtil.clearInfoForFile(filePath);
        FileUtil.SaveFileAs(systemConfig.toJSONString(), filePath);
    }
}
