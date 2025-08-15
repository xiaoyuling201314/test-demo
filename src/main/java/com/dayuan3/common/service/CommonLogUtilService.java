package com.dayuan3.common.service;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.BaseBean2;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan3.common.bean.SysOperationLog;
import com.dayuan3.common.bean.SysPayLog;
import com.dayuan3.common.bean.SysPrintLog;
import com.dayuan3.common.mapper.SysOperationLogMapper;
import com.dayuan3.common.mapper.SysPayLogMapper;
import com.dayuan3.common.mapper.SysPrintLogMapper;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.mapper.InspectionUnitUserMapper;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@Service
public class CommonLogUtilService {
    @Autowired
    private InspectionUnitUserMapper inspectionUsermapper;

    @Autowired
    private SysPayLogMapper sysPayLogMapper;
    @Autowired
    private SysOperationLogMapper sysOperationMapper;
    @Autowired
    private SysPrintLogMapper sysPrintMapper;

    static Logger payLog = Logger.getLogger("payLog");

    /**
     * 写入支付日志
     *
     * @param payNumber   商户订单号
     * @param operatorWay 操作服务端: 0 自助终端，1 app,2 后台
     * @param paySource   支付方式：0 微信，1支付宝，2余额
     * @param payStatus   支付状态：1 生成预付款，2查询状态，3取消付款，4支付成功
     * @param money       支付金额
     * @param module
     * @param className
     * @param func
     * @param description
     * @param success
     * @param request
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年9月9日
     */
    public void savePayLog(String payNumber, short operatorWay, short paySource, short payStatus, double money,
                           String module, String className, String func, String description, boolean success, String exception,
                           HttpServletRequest request) {

        HttpSession session = request.getSession();
        String url = request.getRequestURL().toString();
        // 3. 获取用户IP
        String ip = getRemoteIP(request);
        int operatorResult = success == true ? 0 : 1;
        SysPayLog sysPayLog = new SysPayLog(payNumber, operatorWay, paySource, payStatus, description, money, null, ip,
                url, module, className, func, (short) operatorResult, new Date(), exception);
        Map<String, Object> map = showParams(request);
        if (operatorWay == 0) {
            InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
            if (user != null) {
                sysPayLog.setUserid(String.valueOf(user.getId()));
                sysPayLog.setUsername(user.getRealName());
                sysPayLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 1) {// 获取用户openId
            String openId = (String) request.getSession().getAttribute("openid");
            InspectionUnitUser user = inspectionUsermapper.selectByUserName(null, null, openId);// 查询账号是否存在
            if (user != null) {
                sysPayLog.setUserid(String.valueOf(user.getId()));
                sysPayLog.setUsername(user.getRealName());
                sysPayLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 2) {
            String realName = (String) map.get("realName");
            String phone = (String) map.get("phone");
            String createBy = (String) map.get("createBy");
            sysPayLog.setUserid(createBy);
            sysPayLog.setUsername(realName);
            sysPayLog.setParam1(phone);
        }
        sysPayLog.setRequestParam(map.toString());
        try {
            setInfolog(1, operatorWay, description, sysPayLog.getUserid(), sysPayLog.getParam1(), JSONObject.toJSON(sysPayLog).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        sysPayLogMapper.insertSelective(sysPayLog);

    }

    /**
     * 写入支付日志
     *
     * @param payNumber   商户订单号
     * @param operatorWay 操作服务端: 0 自助终端，1 app,2 后台
     * @param paySource   支付方式：0 微信，1支付宝，2余额
     * @param payStatus   支付状态：1 生成预付款，2查询状态，3取消付款，4支付成功
     * @param money       支付金额
     * @param module
     * @param className
     * @param func
     * @param description
     * @param success
     * @param request
     * @return
     * @description
     * @author huht
     * @date 2019年11月4日 添加注释
     */
    public void savePayLogForWX(String payNumber, short operatorWay, short paySource, short payStatus, double money,
                                String module, String className, String func, String description, boolean success, String exception,
                                Integer userId, String msg, HttpServletRequest request) {

        String url = request.getRequestURL().toString();
        // 3. 获取用户IP
        String ip = getRemoteIP(request);
        int operatorResult = success == true ? 0 : 1;
        SysPayLog sysPayLog = new SysPayLog(payNumber, operatorWay, paySource, payStatus, description, money, null, ip,
                url, module, className, func, (short) operatorResult, new Date(), exception);

        InspectionUnitUser user = inspectionUsermapper.selectByPrimaryKey(userId);// 查询账号是否存在
        if (user != null) {
            sysPayLog.setUserid(String.valueOf(user.getId()));
            sysPayLog.setUsername(user.getRealName());
            sysPayLog.setParam1(user.getPhone());
        }
        //sysPayLog.setRequestParam(msg);
        Map<String, Object> map = showParams(request);
        sysPayLog.setRequestParam(map.toString());
        try {
            setInfolog(1, operatorWay, description, sysPayLog.getUserid(), sysPayLog.getParam1(), JSONObject.toJSON(sysPayLog).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        sysPayLogMapper.insertSelective(sysPayLog);

    }

    /**
     * @param operatorWay 操作服务端: 0 自助终端，1 app,2 后台
     * @param module      模块
     * @param className   类名
     * @param func        方法名
     * @param description 执行成功或错误消息
     * @param success     操作结果
     * @param exception   异常信息
     * @param request
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年9月6日
     */
    public void saveOperatorLog(int operatorWay, String module, String className, String func, String description,
                                boolean success, String exception, HttpServletRequest request) {

        HttpSession session = request.getSession();
        String url = request.getRequestURL().toString();
        // 1. 获取用户IP
        String ip = getRemoteIP(request);
        int operatorResult = success == true ? 0 : 1;
        SysOperationLog sysLog = new SysOperationLog((short) operatorWay, module, className, func, description, ip, url,
                (short) operatorResult, new Date(), exception);
        if (operatorWay == 0) {
            InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
            if (user != null) {
                sysLog.setUserid(String.valueOf(user.getId()));
                sysLog.setUsername(user.getRealName());
                sysLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 1) {// 获取用户openId
            String openId = (String) request.getSession().getAttribute("openid");
            InspectionUnitUser user = inspectionUsermapper.selectByUserName(null, null, openId);// 查询账号是否存在
            if (user != null) {
                sysLog.setUserid(String.valueOf(user.getId()));
                sysLog.setUsername(user.getRealName());
                sysLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 2) {
            TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
            if (user != null) {
                sysLog.setUserid(user.getId());
                sysLog.setUsername(user.getUserName());
                sysLog.setParam1(user.getUserName());
            }
        }
        Map<String, Object> map = showParams(request);
        sysLog.setRequestParam(map.toString());
        sysOperationMapper.insertSelective(sysLog);
/*		try {
            setInfolog(1,operatorWay,  description,sysLog.getUserid(),  sysLog.getUsername(), JSONObject.toJSON(sysLog).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}*/
    }

    /**
     * @param operatorWay 操作服务端: 0 自助终端，1 app,2 后台
     * @param module      模块
     * @param className   类名
     * @param func        方法名
     * @param description 执行成功或错误消息
     * @param success     操作结果
     * @param exception   异常信息
     * @param request
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年9月6日
     */
    public void savePrintLog(int operatorWay, String module, String className, String func, String description,
                             boolean success, String exception, HttpServletRequest request) {

        HttpSession session = request.getSession();
        String url = request.getRequestURL().toString();
        // 1. 获取用户IP
        String ip = getRemoteIP(request);
        int operatorResult = success == true ? 0 : 1;
        SysPrintLog sysLog = new SysPrintLog(ip, url, module, className, func, (short) operatorResult, null, exception,
                new Date());
        //获取用户
        if (operatorWay == 0) {
            InspectionUnitUser user = (InspectionUnitUser) session.getAttribute(WebConstant.SESSION_USER1);
            if (user != null) {
                sysLog.setUserid(String.valueOf(user.getId()));
                sysLog.setUsername(user.getRealName());
                sysLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 1) {// 获取用户openId
            String openId = (String) request.getSession().getAttribute("openid");
            InspectionUnitUser user = inspectionUsermapper.selectByUserName(null, null, openId);// 查询账号是否存在
            if (user != null) {
                sysLog.setUserid(String.valueOf(user.getId()));
                sysLog.setUsername(user.getRealName());
                sysLog.setParam1(user.getPhone());
            }
        } else if (operatorWay == 2) {
            TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
            if (user != null) {
                sysLog.setUserid(user.getId());
                sysLog.setUsername(user.getUserName());
                sysLog.setUsername(user.getUserName());
                sysLog.setParam1(user.getUserName());
            }
        }
        //3获取请求参数
        Map<String, Object> map = showParams(request);
        sysLog.setRequestParam(map.toString());
        sysPrintMapper.insertSelective(sysLog);
/*		try {

			setInfolog(1,operatorWay, description, sysLog.getUserid(),  sysLog.getUsername(), JSONObject.toJSON(sysLog).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}*/
    }

    /**
     * 获取访问主机IP
     *
     * @param request
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年9月9日
     */
    private static String getRemoteIP(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        ip = "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
        return ip;
    }

    /**
     * 获取request的参数集合，返回map格式 {orderid=1000120190909154156679, id=396}
     *
     * @param request
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年9月9日
     */
    public static Map<String, Object> showParams(HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            if (paramValues.length > 0) {
                String paramValue = paramValues[0];
                if (paramValue.length() != 0) {
                    map.put(paramName, paramValue);
                }
            }
        }
        return map;
    }


    /**
     * 新模式支付相关日志统一记录
     *
     * @param type   日志类型 1 inf 2 err
     * @param title  文本日志标题
     * @param userId
     * @param phone  有可能为空
     * @param log    日志详情 bean详情
     * @throws Exception
     */
    public static void setInfolog(int type, int operatorWay, String title, String userId, String phone, String log) throws Exception {
        if (title == null) {
            title = "未知信息";
        }
        if (log == null) {
            log = "";
        }
        String t = "";
        switch (operatorWay) {
            case 0:
                t = "自助终端";
                break;
            case 1:
                t = "微信";
                break;
            case 2:
                t = "后台";
                break;

            default:
                break;
        }
        //开始拼接
        String str = "[" + t + "-" + title + "]" + "-----账号手机号=" + phone + ";账号id=" + userId + ";----" + log;
        switch (type) {
            case 1:
                payLog.info(str);
                break;
            case 2:
                payLog.error(str);
                break;

            default://默认info
                payLog.info(str);
                break;
        }

    }

    /**
    * @Description
     * @param module      模块
     * @param className   类名
     * @param func        方法名
     * @param description 执行成功或错误消息
     * @param success     操作结果
     * @param exception   异常信息
     * @param oldBean 修改前数据
     * @param newBean 修改后数据
     * @Date 2021/03/19 10:19
     * @Author xiaoyl
     *  @Param
     * @return
    */
    public void saveOperatorLog2(String module, String className, String func, String description,
                                 boolean success, String exception, Object oldBean, Object newBean,HttpServletRequest request) {

        HttpSession session = request.getSession();
        String url = request.getRequestURL().toString();
        // 1. 获取用户IP
        String ip = getRemoteIP(request);
        int operatorResult = success == true ? 0 : 1;
        SysOperationLog sysLog = new SysOperationLog((short) 2, module, className, func, description, ip, url,
                (short) operatorResult, new Date(), exception);
            TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
            if (user != null) {
                sysLog.setUserid(user.getId());
                sysLog.setUsername(user.getUserName());
                sysLog.setParam1(user.getUserName());
                sysLog.setParam2(JSONObject.toJSONString(oldBean));
                sysLog.setParam3(JSONObject.toJSONString(newBean));
            }
        Map<String, Object> map = showParams(request);
        sysLog.setRequestParam(map.toString());
        sysOperationMapper.insertSelective(sysLog);
    }

}
