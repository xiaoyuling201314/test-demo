package com.dayuan3.api.common;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import com.trhui.mallbook.config.MallBookConfig;
import org.springframework.beans.factory.config.YamlPropertiesFactoryBean;
import org.springframework.core.io.ClassPathResource;

import java.util.Properties;

/**
 * Description 汇付聚合支付参数配置对象
 * @Author xiaoyl
 * @Date 2025/7/14 14:06
 */
public class ChannelConfig {
    /**
     * mallbook 测试环境地址
     */
    public static String payUrl;

    /**
     * 业务系统商户平台编号
     */
    public static String merchantNo;
    /**
     * 接口版本号，不同版本号触发不同接口业务
     */
    public static String version;

    /**
     * 商户平台私钥
     */
    public static String merchantPrivateKey;
    /**
     * mallbook公钥
     */
    public static String mallBookPublicKey;
    /**
     * 前台回调地址
     * 1.微信公众号支付完成后跳转至Mallbook点金计划页面，可从点金计划页面跳转至商户平台的前台回调地址。
     * 2.网银支付完成跳回商户指定页面。
     * （非微信公众号、网银支付建议传和后台回调地址一样）
     */
    public static String frontUrl;
    /**
     * 后台回调地址：接收交易结果状态
     */
    public static String notifyUrl;

    /**
     * 申请退款后台回调地址：接收交易结果状态
     */
    public static String reFundnotifyUrl;
    /**
     * 异步分账回调接口地址
     */
    public static String splitNotifyUrl;

    /**
     * 暂未使用: 分账子商户以及分账比例配置
     */
    public static String splitList;

    /**
     * 结算回调接口地址
     */
    public static String withDrawalNotifyUrl;

    public static void updateMallBookConfig() {
        JSONObject json = SystemConfigUtil.MALLBOOK_PAY_CONFIG;//获取系统配置参数
        if (json != null) {
            JSONObject mallBook = json.getJSONObject("mallbook");
            if (mallBook != null) {
                payUrl = mallBook.getString("pay_url");
                merchantNo = mallBook.getString("merchant_no");
                version = mallBook.getString("version");
                frontUrl=mallBook.getString("frontUrl");
                notifyUrl=mallBook.getString("notifyUrl");
                splitNotifyUrl=mallBook.getString("splitNotifyUrl");
                reFundnotifyUrl=mallBook.getString("reFundnotifyUrl");
                withDrawalNotifyUrl=mallBook.getString("withDrawalNotifyUrl");
                merchantPrivateKey = mallBook.getString("merchant_private_key");
                mallBookPublicKey = mallBook.getString("mall_book_public_key");
                splitList=mallBook.getString("splitList");
                MallBookConfig config = new MallBookConfig();
                config.setMerchantPrivateKey(merchantPrivateKey);
                config.setDebug(true);
                //测试环境，false：生产环境，改为true
                config.setProdEnvironment(mallBook.getBoolean("prodEnv"));
                config.setApiBase(payUrl);
                config.setMerchantNo(merchantNo);
                config.setVersion(version);
                config.setFileUploadDebug(false);
                config.setTimeout(60000);
                config.init();
            }
        }
    }
   /* static {
        YamlPropertiesFactoryBean yamlProFb = new YamlPropertiesFactoryBean();
        yamlProFb.setResources(new ClassPathResource("application.yaml"));
        Properties properties = yamlProFb.getObject();
        System.out.println("mallbook 参数配置初始化");
        System.out.println("--------------------------------");
        System.out.println("环境地址:" + properties.get("mallbook.pay_url"));
        System.out.println("商户平台编号:" + properties.get("mallbook.merchant_no"));
        System.out.println("接口版本号:" + properties.get("mallbook.version"));
        System.out.println("商户平台私钥:" + properties.get("mallbook.merchant_private_key"));
        System.out.println("mallbook 公钥:" + properties.get("mallbook.mall_book_public_key"));
        System.out.println("--------------------------------");
        payUrl = properties.get("mallbook.pay_url").toString();
        merchantNo = properties.get("mallbook.merchant_no").toString();
        version = properties.get("mallbook.version").toString();
        merchantPrivateKey = properties.get("mallbook.merchant_private_key").toString();
        mallBookPublicKey = properties.get("mallbook.mall_book_public_key").toString();

        MallBookConfig config = new MallBookConfig();
        config.setMerchantPrivateKey(merchantPrivateKey);
        config.setDebug(true);
        config.setProdEnvironment(true);
        config.setApiBase(payUrl);
        config.setMerchantNo(merchantNo);
        config.setVersion(version);
        config.setFileUploadDebug(false);
        config.setTimeout(60000);
        config.init();
    }*/
}
