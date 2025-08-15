package com.dayuan.logs.aop;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.*;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan.logs.bean.SysLog;
import com.dayuan.logs.service.SysLogService;
import com.dayuan.util.CacheManager;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.SystemConfig;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.CodeSignature;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description 通过AOP切面编程来拦截controller，实现日志的写入
 * @Author xiaoyl
 * @Date 2021-05-25 14:27
 */
@Aspect
@Component
public class SystemLogAopAction {

    @Autowired
    private SysLogService sysLogService;

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
     * 获取Method的参数名称及对应的值
     *
     * @param joinPoint
     * @return JSON字符串
     */
    public static JSONObject getNameAndValue(ProceedingJoinPoint joinPoint) {
        Map<String, Object> param = new HashMap<>();
        Object[] paramValues = joinPoint.getArgs();
        String[] paramNames = ((CodeSignature) joinPoint.getSignature()).getParameterNames();
        for (int i = 0; i < paramNames.length; i++) {
            if (paramValues[i] instanceof HttpServletRequest
                    || paramValues[i] instanceof HttpServletResponse
                    || paramValues[i] instanceof HttpSession) {
                continue;
            }
            param.put(paramNames[i], paramValues[i]);
        }
        JSONObject requestParam = new JSONObject(param);
        return requestParam;
    }

    /**
     * @return
     * @Description 获取访问method
     * @Date 2021/05/26 14:31
     * @Author xiaoyl
     * @Param
     */
    public static Method getMethod(ProceedingJoinPoint joinPoint) {
        Method method = null;
        try {
            Object target = joinPoint.getTarget(); // 拦截的实体类，就是当前正在执行的controller
            String methodName = joinPoint.getSignature().getName(); // 拦截的方法名称。当前正在执行的方法
            // 拦截的放参数类型
            Signature sig = joinPoint.getSignature();
            MethodSignature msig = null;
            if (!(sig instanceof MethodSignature)) {
                throw new IllegalArgumentException("该注解只能用于方法");
            }
            msig = (MethodSignature) sig;
            Class[] parameterTypes = msig.getMethod().getParameterTypes();
            method = target.getClass().getMethod(methodName, parameterTypes);
        } catch (NoSuchMethodException e1) {
            e1.printStackTrace();
        } catch (SecurityException e1) {
            e1.printStackTrace();
        }
        return method;
    }

    /**
     * 获取传入参数名称及对应的值
     *
     * @param joinPoint
     * @return Map<参数名称, 参数值></参数名称,参数值>
     */
    public static JSONArray getRequestParam(ProceedingJoinPoint joinPoint) {
        JSONArray operateParamArray = new JSONArray();
        // 拦截的方法参数
        Object[] args = joinPoint.getArgs(); // 参数值
        String[] argNames = ((MethodSignature)joinPoint.getSignature()).getParameterNames(); // 参数名
        for (int i = 0; i < args.length; i++) {
            Object paramsObj = args[i];
            //通过该方法可查询对应的object属于什么类型：String type = paramsObj.getClass().getName();
            if (paramsObj instanceof String) {
                String str = (String) paramsObj;
                //将其转为jsonobject
                JSONObject dataJson = new JSONObject();
                dataJson.put(argNames[i], str);
                if (dataJson == null || dataJson.isEmpty() || "null".equals(dataJson)) {
                    break;
                } else {
                    operateParamArray.add(dataJson);
                }
            } else if (paramsObj instanceof JSONObject) {
                //将其转为jsonobject
                JSONObject dataJson = JSONObject.parseObject(paramsObj.toString());
                if (dataJson == null || dataJson.isEmpty() || "null".equals(dataJson)) {
                    break;
                } else {
                    operateParamArray.add(dataJson);
                }
            } else if (paramsObj instanceof Map) {
                //get请求，以map类型传参
                //1.将object的map类型转为jsonobject类型
                Map<String, Object> map = (Map<String, Object>) paramsObj;
                JSONObject json = new JSONObject(map);
                operateParamArray.add(json);
            } else if (paramsObj instanceof BaseBean || paramsObj instanceof BaseBean2 || paramsObj instanceof SystemConfig) {
                operateParamArray.add(JSONObject.parse(JSONObject.toJSONString(paramsObj)));
            }
        }
        return operateParamArray;
    }

    /**
     * @return
     * @Description 根据service名称，方法名称查询方法
     * @Date 2021/05/26 14:18
     * @Author xiaoyl
     * @Param
     */
    public static Method findMethod(Class<?> clazz, String name, Class<?>... paramTypes) {
        Assert.notNull(clazz, "Class must not be null");
        Assert.notNull(name, "Method name must not be null");
        Class<?> searchType = clazz;
        while (searchType != null) {
            Method[] methods = searchType.getMethods();
            for (Method method : methods) {
                if (name.equals(method.getName())) {
                    return method;
                }
            }
            searchType = searchType.getSuperclass();
        }
        return null;
    }

    //定义切入点：用户、角色、菜单、系统参数配置 com.dayuan.controller.interfaces2
//    @Pointcut("execution(* com.dayuan.controller.*.*.*(..)) || execution(* com.dayuan3.common.controller.SystemConfigController.*(..)) ")
    //定义切入点：用户、角色、菜单、系统参数配置
    @Pointcut("execution(* com.dayuan.controller.system.*.*(..)) " +
            " || execution(* com.dayuan.controller.detect.*.*(..)) " +
            " || execution(* com.dayuan.controller.data.BaseFoodTypeController.*(..))" +
            " || execution(* com.dayuan3.common.controller.SystemConfigController.*(..)) "+
            " || execution(* com.dayuan.controller.interfaces.UserLoginController.*(..))"+
            " || execution(* com.dayuan.controller.interfaces2.IUserLoginController.*(..))"+
            " || execution(* com.dayuan.controller.interfaces2.IDeviceManageController.*(..))"+
            " || execution(* com.dayuan.controller.interfaces2.IRegObjectController.*(..))" +
            " || execution(* com.dayuan.controller.statistics.StatisticsForGSController.*(..))")
    private void controllerAspect() {
    }

    /**
     * 方法执行
     *
     * @param pjp
     * @return
     * @throws Throwable
     */
    @Around("controllerAspect()")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
        Object object = null;
        //1.获取method对象
        Method method = getMethod(pjp);
        SysLog log = null;
        //2.断是否包含自定义的注解
        if (null != method && method.isAnnotationPresent(SystemLog.class)) {
            try {
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                SystemLog systemLog = method.getAnnotation(SystemLog.class);
                String ip = getRemoteIP(request);//访问ip
                String url = request.getRequestURL().toString();//请求地址
                //3.从请求的参数中解析出查询key对应的value值
                String value = "";//编辑对象ID
                String deleteIds = "";//删除对象ID
                if (systemLog.type() != 0) {
                    JSONArray operateParamArray = getRequestParam(pjp);
                    log = new SysLog(ip, url, (short) systemLog.type(), systemLog.module(),
                            systemLog.methods(), null, operateParamArray.toJSONString());

                    for (int i = 0; i < operateParamArray.size(); i++) {
                        JSONObject params = operateParamArray.getJSONObject(i);
                        //获取编辑对象ID
                        if (params.containsKey("id")) {
                            value = params.getString("id");
                        }
                        //获取app、仪器操作用户
                        if (params.containsKey("userToken")) {
                            Cache cache = CacheManager.getCacheInfo(params.getString("userToken"));
                            if(cache != null){
                                TSUser user = (TSUser) cache.getValue();
                                if (null != user && System.currentTimeMillis() < cache.getTimeOut()) {
                                    log.setUserId(user.getId());
                                    log.setUserName(user.getUserName());
                                }
                            }
                        }
                    }
                } else {
                    JSONObject requestParam = getNameAndValue(pjp);//获取普通操作请求参数
                    String loginType="";
                    if("登录".equals(systemLog.methods())){
                        if(StringUtil.isNotEmpty(requestParam.getString("deviceCode"))
                            || StringUtil.isNotEmpty(requestParam.getString("softWareVersion"))
                            || "3".equals(systemLog.source())){
                            loginType="仪器：";
                        }else if(StringUtil.isNotEmpty(requestParam.getString("vcode"))
                            || "1".equals(systemLog.source())){
                            loginType="平台：";
                        }else{
                            loginType="APP：";
                        }
                    }
                    log = new SysLog(ip, url, (short) systemLog.type(), systemLog.module(),
                            loginType+systemLog.methods(), null, requestParam.toJSONString());
                    if(StringUtil.isNotEmpty(requestParam.getString("userName"))){
                        log.setUserName(requestParam.getString("userName"));
                    }
                }
                //4.获取用户信息
                if (log.getUserId() == null) {
                    TSUser user = (TSUser) request.getSession().getAttribute(WebConstant.SESSION_USER);
                    if (user != null) {
                        log.setUserId(user.getId());
                        log.setUserName(user.getUserName());
                    }
                }
                //5.id不为空，查询修改前数据
                if (StringUtil.isNotEmpty(value)) {
                    Object data = getOperateBeforeData(systemLog.parameterType(), systemLog.serviceClass(), systemLog.queryMethod(), value);
                    if( data instanceof  TSUser){//如果是用户，把昵称设置为空，避免存储报错
                        ((TSUser) data).setWxNickname(null);
                    }
                    log.setBeforeData(JSONObject.toJSONString(data));
                    log.setType((short) 2);
                }
                //6.执行controller方法
                object = pjp.proceed();
                //7.处理执行结果，查询修改后的数据
                if (object instanceof AjaxJson) {
                    AjaxJson ajaxJson = (AjaxJson) object;
                    if (ajaxJson.isSuccess()) {//操作执行成功
                        if (systemLog.type() == 0) {//普通操作：直接记录请求参数和执行结果
                            log.setOperateTime(new Date());
                            log.setOperatorResult((short) 0);
                            log.setDescription(ajaxJson.toJsonStr());
                        } else if (systemLog.type() == 1 ) {//新增或编辑：查询修改后的数据
                            String operatorId = String.valueOf(ajaxJson.getAttributes().get("id"));
                            Object data = getOperateBeforeData(systemLog.parameterType(), systemLog.serviceClass(), systemLog.queryMethod(), operatorId);
                            if( data instanceof  TSUser){//如果是用户，把昵称设置为空，避免存储报错
                                ((TSUser) data).setWxNickname(null);
                            }
                            log.setAfterData(JSONObject.toJSONString(data));
                            String updateDate = JSONObject.parseObject(log.getAfterData()).getString("updateDate");
                            log.setOperateTime(updateDate == null ? null : new Date(Long.valueOf(updateDate)));
                            log.setOperatorId(operatorId);
                            log.setOperatorResult((short) 0);
                            log.setDescription(ajaxJson.toJsonStr());
                        } else if (systemLog.type() == 3 ) {//删除操作：记录删除时间和操作ID
                            log.setOperateTime(new Date());
                            log.setOperatorId(deleteIds);
                            log.setOperatorResult((short) 0);
                            log.setDescription(ajaxJson.toJsonStr());
                        }
                    } else {//操作失败，记录失败原因
                        log.setOperateTime(new Date());
                        log.setOperatorResult((short) 1);
                        log.setException(ajaxJson.toJsonStr());
                    }
                }else if(object instanceof InterfaceJson){
                    //add by xiaoyl 2022-03-02 增加接口登录相关日志
                    InterfaceJson ajaxJson = (InterfaceJson) object;
                    log.setOperateTime(new Date());
                    log.setOperatorResult((short) 0);
                    log.setDescription(ajaxJson.toJsonStr());
                } else {
                    log.setOperateTime(new Date());
                    log.setOperatorResult((short) 0);
                    log.setDescription(object.toString());
                }
                //8.将日志写入数据库
                //登录不成功当作执行失败，方便查看用户登录日志
                if (log.getFunc().indexOf("登录")>-1 && log.getDescription() != null && !log.getDescription().contains("status=0")
                        && !log.getDescription().contains("\"resultCode\":\"0X00000\"")) {
                    log.setOperatorResult((short) 1);
                }

                sysLogService.insertSelective(log);
            } catch (Throwable e) {
                log.setOperatorResult((short) 1);
                log.setException(e.getMessage());
                sysLogService.insertSelective(log);
            }
        } else { //不需要拦截直接执行
            object = pjp.proceed();
        }
        return object;
    }

    /**
     * @param paramType:参数类型
     * @param serviceClass：bean名称
     * @param queryMethod：查询method
     * @param value：查询id的value
     * @return
     */
    public Object getOperateBeforeData(String paramType, String serviceClass, String queryMethod, String value) {
        Object obj = new Object();
        //在此处解析请求的参数类型，根据id查询数据，id类型有四种：int，Integer,long,Long
        if (paramType.equals("int")) {
            int id = Integer.parseInt(value);
            Method mh = ReflectionUtils.findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, int.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), id);

        } else if (paramType.equals("Integer")) {
            Integer id = Integer.valueOf(value);
            Method mh = ReflectionUtils.findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, Integer.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), id);

        } else if (paramType.equals("long")) {
            long id = Long.parseLong(value);
            Method mh = ReflectionUtils.findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, Long.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), id);

        } else if (paramType.equals("Long")) {
            Long id = Long.valueOf(value);
            Method mh = ReflectionUtils.findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, Long.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), id);
        } else if (paramType.equals("String")) {
            Method mh = findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, String.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), value);
        } else if (paramType.equals("Serializable")) {
            Method mh = findMethod(SpringContextUtil.getBean(serviceClass).getClass(), queryMethod, Serializable.class);
            //用spring bean获取操作前的参数,此处需要注意：传入的id类型与bean里面的参数类型需要保持一致
            obj = ReflectionUtils.invokeMethod(mh, SpringContextUtil.getBean(serviceClass), value);
        }
        return obj;
    }
}
