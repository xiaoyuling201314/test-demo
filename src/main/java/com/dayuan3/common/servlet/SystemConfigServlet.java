package com.dayuan3.common.servlet;

import com.alibaba.fastjson.JSONObject;
import com.dayuan3.api.common.ChannelConfig;
import com.dayuan3.common.bean.SystemConfig;
import com.dayuan3.common.service.SystemConfigService;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.common.util.WeChatConfig;
import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.util.List;

//import com.dayuan3.miniProgram.controller.MiniUserController;

/**
 * 项目启动时候自动加载系统配置参数
 *
 * @author xiaoyl
 * @date 2019年9月25日
 */
public class SystemConfigServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static Logger log = Logger.getLogger(SystemConfigServlet.class);

    /**
     * 根据传入类型编号更新对应的系统参数
     *
     * @param configCode
     * @param configParam
     * @description
     * @author xiaoyl
     * @date 2019年9月26日
     */
    public static void updateJson(String configCode, String configParam) {
        JSONObject jsonObj = configParam != null ? JSONObject.parseObject(configParam) : null;
        switch (configCode) {// 系统配置类型唯一编号
            case "1001":// 微信支付相关
                SystemConfigUtil.WEIPAY_CONFIG = jsonObj;
                log.info("自助终端微信支付配置结果：" + SystemConfigUtil.WEIPAY_CONFIG);
                break;
            case "1002":// 支付宝支付相关
                SystemConfigUtil.ALIPAY_CONFIG = jsonObj;
                log.info("支付宝支付相关配置结果：" + SystemConfigUtil.ALIPAY_CONFIG);
                break;
            case "1003":// 公众号相关
                SystemConfigUtil.WECHAT_PUBLIC_CONFIG = jsonObj;
                WeChatConfig.updateWxConfig();//json更新完 自动更新微信端配置 2021-04-03 shit
                log.info("公众号相关配置结果：" + SystemConfigUtil.WECHAT_PUBLIC_CONFIG);
                break;
            case "1004":// 公众号推送模板
                SystemConfigUtil.WECHAT_PUSH_TEMPLATE_CONFIG = jsonObj;
                log.info("公众号推送模板配置结果：" + SystemConfigUtil.WECHAT_PUSH_TEMPLATE_CONFIG);
                break;
            case "1005":// 短信发送接口
                SystemConfigUtil.MESSAGE_INTERFACE_CONFIG = jsonObj;
                log.info("短信发送结果配置结果：" + SystemConfigUtil.MESSAGE_INTERFACE_CONFIG);
                break;
            case "1006":// 支付方式类型
                SystemConfigUtil.PAYTYPE_CONFIG = jsonObj;
                log.info("支付方式配置结果：" + SystemConfigUtil.PAYTYPE_CONFIG);
                break;
            case "1007":// 微信公众号开票
                SystemConfigUtil.INVOICE_CONFIG = jsonObj;
                log.info("微信公众号开票配置结果：" + SystemConfigUtil.INVOICE_CONFIG);
                break;
            case "1008":// 检测报告相关配置
                SystemConfigUtil.REPORT_CONFIG = jsonObj;
                log.info("检测报告相关配置结果：" + SystemConfigUtil.REPORT_CONFIG);
                break;
            case "1009":// 充值选项配置
                SystemConfigUtil.RECHARGE_CONFIG = jsonObj;
                log.info("充值选项配置结果：" + SystemConfigUtil.RECHARGE_CONFIG);
                break;
            case "1010":// 打印费用配置
                SystemConfigUtil.PRINT_CONFIG = jsonObj;
                log.info("打印费用配置结果：" + SystemConfigUtil.PRINT_CONFIG);
                break;
            case "1011":// 送样要求配置
                SystemConfigUtil.SAMPLE_WEIGHT_CONFIG = jsonObj;
                log.info("送样要求配置结果：" + SystemConfigUtil.SAMPLE_WEIGHT_CONFIG);
                break;
            case "1012":// 系统名称配置
                SystemConfigUtil.SYSTEM_NAME_CONFIG = jsonObj;
                log.info("系统名称配置结果：" + SystemConfigUtil.SYSTEM_NAME_CONFIG);
                break;
            case "1013":// 小程序配置
                SystemConfigUtil.MINI_PROGRAM_CONFIG = jsonObj;
//			MiniUserController.updateMiniConfig();
                log.info("小程序配置结果：" + SystemConfigUtil.MINI_PROGRAM_CONFIG);

                break;
            case "1014":// 定时生成拼音时间配置
//			SystemConfigUtil.GENERATOR_LETTER_CONFIG = JSONObject.parseObject(configParam);
                log.info("定时生成拼音时间配置：" + JSONObject.parseObject(configParam));
                break;
            case "1015":// 乐橙云摄像头配置
                SystemConfigUtil.MONITOR_CONFIG = jsonObj;
                log.info("乐橙云摄像头间配置：" + JSONObject.parseObject(configParam));
                break;
            case "1017":// 微信上门取样配置
                SystemConfigUtil.WECHAT_TAKE_CONFIG = jsonObj;
                log.info("微信上门取样配置：" + JSONObject.parseObject(configParam));
                break;
            case "1018"://抽样单检测报告打印次数配置
                SystemConfigUtil.SAMPLING_PRINT_CONFIG = jsonObj;
                log.info("抽样单检测报告打印次数配置：" + JSONObject.parseObject(configParam));
                break;
            case "1019":// 导出配置
                SystemConfigUtil.EXPORT_CONFIG = jsonObj;
                log.info("导出配置：" + JSONObject.parseObject(configParam));
                break;
            case "1020":// APP配置
                SystemConfigUtil.APP_PROGRAM_CONFIG = jsonObj;
                log.info("小程序配置结果：" + SystemConfigUtil.APP_PROGRAM_CONFIG);
                break;
            case "1021":// 复检规范时间限制
                SystemConfigUtil.RECHECK_CONFIG = jsonObj;
                log.info("复检规范时间限制：" + SystemConfigUtil.RECHECK_CONFIG);
                break;
            case "1022":// 检测报告模板配置
                SystemConfigUtil.REPORT_TEMPLATE = jsonObj;
                log.info("检测报告模板配置：" + SystemConfigUtil.REPORT_TEMPLATE);
                break;
            case "1023":// 抽检任务配置
                SystemConfigUtil.CHECK_TASK_CONFIG = jsonObj;
                log.info("抽检任务配置：" + SystemConfigUtil.CHECK_TASK_CONFIG);
                break;
            case "1024":// 其他参数配置（用来存放一些小参数配置）
                SystemConfigUtil.OTHER_CONFIG = jsonObj;
                log.info("其他参数配置：" + SystemConfigUtil.OTHER_CONFIG);
                break;
            case "1025"://  检测报告批准人员配置
                SystemConfigUtil.APPROVAL_SAMPLING_CONFIG = jsonObj;
                log.info("检测报告批准人员配置：" + SystemConfigUtil.APPROVAL_SAMPLING_CONFIG);
                break;
            case "1026"://  IP138配置，根据IP获取物理地址
                SystemConfigUtil.IP138_INTERFACE_CONFIG = jsonObj;
                log.info("IP138配置，根据IP获取物理地址：" + SystemConfigUtil.IP138_INTERFACE_CONFIG);
                break;
            case "1027"://可视化大屏参数配置
                SystemConfigUtil.VISUAL_SCREEN_CONFIG = jsonObj;
                log.info("可视化大屏参数配置：" + SystemConfigUtil.VISUAL_SCREEN_CONFIG);
                break;
            case "1028"://甘肃任务考核参数配置
                SystemConfigUtil.GS_ASSESSMENT_CONFIG = jsonObj;
                log.info("甘肃任务考核参数配置：" + SystemConfigUtil.GS_ASSESSMENT_CONFIG);
                break;
            case "1029"://不合格数据微信通知黑名单配置
                SystemConfigUtil.WXMSG_BLAKLIST_CONFIG = jsonObj;
                log.info("不合格数据微信通知黑名单配置：" + SystemConfigUtil.WXMSG_BLAKLIST_CONFIG);
                break;
            case "1030"://微信公众号用户角色对应表
                SystemConfigUtil.WXUSER_ROLE_CONFIG = jsonObj;
                log.info("微信公众号用户角色对应表：" + SystemConfigUtil.WXUSER_ROLE_CONFIG);
                break;
            case "1031"://汇付聚合支付接口参数配置
                SystemConfigUtil.MALLBOOK_PAY_CONFIG = jsonObj;
                ChannelConfig.updateMallBookConfig();
                log.info("汇付聚合支付接口参数配置：" + SystemConfigUtil.MALLBOOK_PAY_CONFIG);
                break;
            case "1032"://分账信息参数配置
                SystemConfigUtil.MALLBOOK_SPLIT_MONEY_CONFIG = jsonObj;
                log.info("分账信息参数配置：" + SystemConfigUtil.MALLBOOK_SPLIT_MONEY_CONFIG);
                break;
            default:
                break;
        }
    }

    @Override
    public void init() throws ServletException {
        // 获取上下文
        WebApplicationContext contex = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
        SystemConfigService systemConfigService = (SystemConfigService) contex.getBean("systemConfigService");
        try {
            List<SystemConfig> list = systemConfigService.queryByProjectID("1");
            if (list.size() > 0) {
                for (SystemConfig systemConfig : list) {
                    updateJson(systemConfig.getConfigCode(), systemConfig.getConfigParam());
                }
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
