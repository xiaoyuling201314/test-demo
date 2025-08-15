package com.dayuan3.common.util;

import com.alibaba.fastjson.JSONObject;

/**
 * 系统相关配置 JSONObject对象
 *
 * @author xiaoyl
 * @date 2019年9月25日
 */
public class SystemConfigUtil {
    /**
     * 自助终端-微信支付相关json
     */
    public static JSONObject WEIPAY_CONFIG = null;
    /**
     * 自助终端-支付宝支付相关json对象
     */
    public static JSONObject ALIPAY_CONFIG = null;

    /**
     * 公众号相关json对象
     */
    public static JSONObject WECHAT_PUBLIC_CONFIG = null;

    /**
     * 公众号推送消息模板
     */
    public static JSONObject WECHAT_PUSH_TEMPLATE_CONFIG = null;

    /**
     * 短信发送接口配置
     */
    public static JSONObject MESSAGE_INTERFACE_CONFIG = null;
    /**
     * 支付方式配置
     */
    public static JSONObject PAYTYPE_CONFIG = null;

    /**
     * 开发票配置
     */
    public static JSONObject INVOICE_CONFIG = null;

    /**
     * 检测报告配置
     */
    public static JSONObject REPORT_CONFIG = null;
    /**
     * 充值选项配置
     */
    public static JSONObject RECHARGE_CONFIG = null;
    /**
     * 打印费用配置
     */
    public static JSONObject PRINT_CONFIG = null;
    /**
     * 送样重量要求配置
     */
    public static JSONObject SAMPLE_WEIGHT_CONFIG = null;
    /**
     * 系统名称配置
     */
    public static JSONObject SYSTEM_NAME_CONFIG = null;

    /**
     * 小程序配置
     */

    public static JSONObject MINI_PROGRAM_CONFIG = null;

    /**
     * APP配置
     */

    public static JSONObject APP_PROGRAM_CONFIG = null;

    /**
     * 定时生成拼音时间配置
     */
//	public static JSONObject GENERATOR_LETTER_CONFIG=null;
    /**
     * 乐橙云摄像头配置
     */
    public static JSONObject MONITOR_CONFIG = null;

    /**
     * 微信上门取样配置
     */
    public static JSONObject WECHAT_TAKE_CONFIG = null;

    /**
     * 抽样单检测报告打印次数配置
     */
    public static JSONObject SAMPLING_PRINT_CONFIG = null;

    /**
     * 导出配置
     */
    public static JSONObject EXPORT_CONFIG = null;
    /**
     * 复检规范时间限制
     */
    public static JSONObject RECHECK_CONFIG = null;

    /**
     * 检测报告模板页面地址配置
     */
    public static JSONObject REPORT_TEMPLATE = null;
    /**
     * 其他参数配置
     */
    public static JSONObject OTHER_CONFIG = null;

	/**
	 * 抽检任务配置
	 */
	public static JSONObject CHECK_TASK_CONFIG=null;

      /**
      * @Description 检测单批准人员配置
      * @Date 2020/10/29 14:20
      * @Author xiaoyl
      * @Param
      * @return
      */
    public static JSONObject APPROVAL_SAMPLING_CONFIG=null;
    /**
    * @Description IP138配置接口配置
    * @Date 2022/03/04 10:35
    * @Author xiaoyl
    * @Param
    * @return
    */
    public static JSONObject IP138_INTERFACE_CONFIG=null;
    /**
    * @Description 可视化大屏参数配置
    * @Date 2022/03/29 15:37
    * @Author xiaoyl
    * @Param
    * @return
    */
    public static JSONObject VISUAL_SCREEN_CONFIG=null;

   /**
   * @Description 甘肃任务考核参数配置
   * @Date 2022/05/18 9:34
   * @Author xiaoyl
   * @Param
   * @return
   */
    public static JSONObject GS_ASSESSMENT_CONFIG=null;
    /**
    * @Description 不合格数据微信通知黑名单配置
    * @Date 2022/08/25 14:13
    * @Author xiaoyl
    * @Param
    * @return
    */
    public static JSONObject WXMSG_BLAKLIST_CONFIG=null;
    /**
     * Description 微信公众号用户角色对应表
     * @Author xiaoyl
     * @Date 2025/6/18 9:07
     */
    public static JSONObject WXUSER_ROLE_CONFIG=null;

   /**
   * @Description 汇付聚合支付接口参数配置
   * @Date 2025/06/22 14:03
   * @Author xiaoyl
   */
    public static JSONObject MALLBOOK_PAY_CONFIG=null;

    /**
     * Description 汇付：分账参数配置
     * @Author xiaoyl
     * @Date 2025/7/14 13:30
     */
    public static JSONObject MALLBOOK_SPLIT_MONEY_CONFIG=null;
    /**
     * 读取配置
     * @param json  配置
     * @param defaultVal    默认值
     * @param keys  多级key
     * @return
     */
    public static Integer getInteger(JSONObject json, Integer defaultVal, String... keys){
        for (int i=0; i< keys.length; i++) {
            if (i != keys.length-1) {
                if (json != null) {
                    json = json.getJSONObject(keys[i]);
                } else {
                    return defaultVal;
                }
            } else {
                defaultVal = json.getInteger(keys[i]) == null ? defaultVal : json.getInteger(keys[i]);
            }
        }
        return defaultVal;
    }

    /**
     * 读取配置
     * @param json  配置
     * @param defaultVal    默认值
     * @param keys  多级key
     * @return
     */
    public static String getString(JSONObject json, String defaultVal, String... keys){
        for (int i=0; i< keys.length; i++) {
            if (i != keys.length-1) {
                if (json != null) {
                    json = json.getJSONObject(keys[i]);
                } else {
                    return defaultVal;
                }
            } else {
                defaultVal = json.getString(keys[i]) == null ? defaultVal : json.getString(keys[i]);
            }
        }
        return defaultVal;
    }

}
