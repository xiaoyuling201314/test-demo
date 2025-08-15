package com.dayuan.common;

import java.util.ResourceBundle;

/**
 * Web常量类
 *
 * @author Bill
 */
public class WebConstant {

    public static final ResourceBundle res = ResourceBundle.getBundle("sysconfig");

    /**
     * 密码规则正则表达式，数字、大写字母、小写字母和特殊字符中至少2种组合成的8~16位字符串
     */
    public static final String pwRegEx = "^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![@#$%^&*_<>,./~`:;\"'=\\\\{\\\\}\\\\!\\\\(\\\\)\\\\+\\\\?\\\\|\\\\\\\\]+$)[0-9A-Za-z@#$%^&*_<>,./~`:;\"'=\\\\{\\\\}\\\\!\\\\(\\\\)\\\\+\\\\?\\\\|\\\\\\\\]{8,16}$";

    /**
     * 存储到session中的用户
     */
    public static final String SESSION_USER = "session_user";
    /**
     * 存储到session中的送检用户
     */
    public static final String SESSION_USER1 = "session_user_terminal";
    /**
     * 用户 user 常量
     */
    public static final String USER = "user";
    /**
     * 机构的常量
     */
    public static final String ORG = "org";
    /**
     * 检测点的常量
     */
    public static final String POINT = "point";
    /**
     * 信息存储常量
     */
    public static final String MSG = "msg";
    /**
     * 菜单常量
     */
    public static final String MENU_LIST = "menuList";
    /**
     * 用户详细信息常量
     */
    public static final String USER_DATA = "userData";


//	/**
//	 * FTP地址
//	 */
//	public static final String FTP_ADRESS=res.getString("ftpAddress");
//
//	/**
//	 * FTP端口
//	 */
//	public static final int FTP_PORT=Integer.parseInt(res.getString("ftpPort"));
//
//	/**
//	 * FTP账号
//	 */
//	public static final String FTP_USERNAME=res.getString("ftpUserName");
//
//	/**
//	 * FTP密码
//	 */
//	public static final String FTP_PASSWORD=res.getString("ftpPassword");

    /**
     * APP下载二维码宽度
     */
    public static final int APP_QRCODE_WIDTH = 330;

    /**
     * APP下载二维码高度
     */
    public static final int APP_QRCODE_HEIGHT = 330;


    /**
     * 附件类型-抽样单经营户签名
     */
    public static final String FILE_TYPE1 = "signature";

    /**
     * 附件类型-不合格处理监督人签名
     */
    public static final String FILE_TYPE2 = "signPic";

    /**
     * 附件类型-不合格处理取证文件
     */
    public static final String FILE_TYPE3 = "Enforce";


    /************************* 抽样单单号首字母 - START ***************************/
    /**
     * APP抽样单单号首字母
     */
    public static final String SAMPLING_NUM1 = "A";
    /**
     * 平台抽样单单号首字母
     */
    public static final String SAMPLING_NUM2 = "W";

    /**
     * APP送样单单号首字母
     */
    public static final String SAMPLING_NUM3 = "S";
    /**
     * 平台送样单单号首字母
     */
    public static final String SAMPLING_NUM4 = "T";

    /**
     * 自助终端订单单号首字母
     */
    public static final String SAMPLING_NUM5 = "Z";
    /**
     * 微信订单单号首字母
     */
    public static final String SAMPLING_NUM6 = "X";

    /**
     * 第三方抽样单单号首字母
     */
    public static final String SAMPLING_NUM7 = "B";

    /**
     * 小程序订单单号首字母
     */
    public static final String MINIPROGRAM_ORDER_NUM = "M";

    /**
     * 微信快检报告首字母
     */
    public static final String CHECK_REPORT_NUM = "X";

/************************* 抽样单单号首字母 - END ***************************/


/************************* 接口返回码 - START ***************************/
    /**
     * 操作成功
     */
    public static final String INTERFACE_CODE0 = "0X00000";
    /**
     * 参数XX不能为空
     */
    public static final String INTERFACE_CODE1 = "0X00001";
    /**
     * 参数不正确
     */
    public static final String INTERFACE_CODE2 = "0X00002";
    /**
     * 参数格式不正确
     */
    public static final String INTERFACE_CODE3 = "0X00003";
    /**
     * 数据类型未定义
     */
    public static final String INTERFACE_CODE4 = "0X00004";
    /**
     * 记录不存在或已删除
     */
    public static final String INTERFACE_CODE5 = "0X00005";
    /**
     * 记录已存在
     */
    public static final String INTERFACE_CODE15 = "0X00006";
    /**
     * 附件超出限制大小
     */
    public static final String INTERFACE_CODE17 = "0X00007";
    /**
     * 附件格式不符合要求
     */
    public static final String INTERFACE_CODE18 = "0X00008";

    /**
     * 用户TOKEN失效
     */
    public static final String INTERFACE_CODE6 = "0X40000";
    /**
     * 账户不存在
     */
    public static final String INTERFACE_CODE7 = "0X40001";
    /**
     * 密码错误
     */
    public static final String INTERFACE_CODE8 = "0X40002";
    /**
     * 账户被停用
     */
    public static final String INTERFACE_CODE9 = "0X40003";


    /**
     * 未知异常
     */
    public static final String INTERFACE_CODE11 = "0X50000";
    /**
     * 权限不足
     */
    public static final String INTERFACE_CODE14 = "0X50001";


    /**
     * 该检测点下没有该系列仪器
     */
    public static final String INTERFACE_CODE12 = "0X10001";
    /**
     * 该检测点下此系列仪器均已注册
     */
    public static final String INTERFACE_CODE13 = "0X10002";

    /**
     * 检测任务已接收
     */
    public static final String INTERFACE_CODE16 = "0X10101";

    /************************* 接口返回码 - END ***************************/


//================================定时器对应库的ID=======================================
    public static final Integer WX_REG_COUNT = 5;   //微信快检公式-检测汇总对应定时器ID
    public static final Integer WX_STOCK = 6;       //微信快检公式-进货统计对应定时器ID
    public static final Integer WX_SALE = 7;        //微信快检公式-销售统计对应定时器ID
    public static final Integer WX_CHECK_CONFIG = 3;//微信快检公式-配置文件对应定时器ID

}
