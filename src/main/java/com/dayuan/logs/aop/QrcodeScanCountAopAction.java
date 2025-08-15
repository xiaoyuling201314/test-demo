package com.dayuan.logs.aop;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.BaseBean;
import com.dayuan.bean.BaseBean2;
import com.dayuan.logs.bean.SysLog;
import com.dayuan.logs.bean.TbQrcodeScanCount;
import com.dayuan.logs.service.TbQrcodeScanCountService;
import com.dayuan3.common.bean.SystemConfig;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.CodeSignature;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
* @Description 通过AOP切面编程来拦截controller，实现二维码扫描计数
* @Date 2021/07/20 15:54
* @Author xiaoyl
* @Param
* @return
*/
@Aspect
@Component
public class QrcodeScanCountAopAction {

    @Autowired
    private TbQrcodeScanCountService qrcodeScanCountService;
    private final Logger log = Logger.getLogger(QrcodeScanCountAopAction.class);

    /**
     * 获取传入参数名称及对应的值
     *
     * @param joinPoint
     * @return Map<参数名称, 参数值></参数名称,参数值>
     */
    public static JSONArray getRequestParam(ProceedingJoinPoint joinPoint) {
        JSONArray operateParamArray = new JSONArray();
        // 拦截的方法参数
        Object[] args = joinPoint.getArgs();
        for (int i = 0; i < args.length; i++) {
            Object paramsObj = args[i];
            //通过该方法可查询对应的object属于什么类型：String type = paramsObj.getClass().getName();
            if (paramsObj instanceof String) { //删除操作参数
                String str = (String) paramsObj;
                //将其转为jsonobject
                JSONObject dataJson = new JSONObject();
                dataJson.put("deleteIds", str);
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


    //定义切入点：抽样单、监管对象、经营户二维码扫描方法
    @Pointcut("execution(* com.dayuan.controller.interfaces.SamplingController.samplingDetail(..)) " +
            " || execution(* com.dayuan.controller.interfaces.RegulatoryController.regObjectApp(..)) " +
            " || execution(* com.dayuan.controller.interfaces.RegulatoryController.businessApp(..))")
    private void controllerAspect() {
    }

    /**
     * 方法执行
     *
     * @param pjp
     * @return
     * @throws Throwable
     */
    @After("controllerAspect()")
    public void scanAfter(JoinPoint pjp) throws Throwable {
        //1.获取method对象
        Method method = getMethod(pjp);
        JSONObject requestParam =null;
        //2.断是否包含自定义的注解
        if (null != method && method.isAnnotationPresent(QrcodeScanCount.class)) {
            try {
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                QrcodeScanCount qrcodeScanCount = method.getAnnotation(QrcodeScanCount.class);
                //3.从请求的参数中解析出查询key对应的value值
                requestParam = getNameAndValue(pjp);//获取普通操作请求参数
                String scanParam=requestParam.getString("samplingNo")==null ? requestParam.getString("id") : requestParam.getString("samplingNo");
                //4.根据扫描类型，请求参数进行查找是否已首次扫描
                TbQrcodeScanCount oldBean=qrcodeScanCountService.queryByScanParams(scanParam,qrcodeScanCount.scanType());
                //5.将日志写入数据库
                Date now=new Date();
                if(oldBean!=null){
                    oldBean.setScanNumber(oldBean.getScanNumber()+1);
                    oldBean.setUpdateDate(now);
                    qrcodeScanCountService.updateBySelective(oldBean);
                }else{
                    oldBean=new TbQrcodeScanCount(qrcodeScanCount.module(),(short)qrcodeScanCount.scanType(),scanParam,1,now);
                    qrcodeScanCountService.insertSelective(oldBean);
                }

            } catch (Throwable e) {
               log.error(String.format("二维码扫描计数器写入异常，请求参数：%s|异常原因%s|%s", requestParam.toJSONString(),e.getMessage(),e.getStackTrace()));
            }
        }
    }
    /**
     * @return
     * @Description 获取访问method
     * @Date 2021/05/26 14:31
     * @Author xiaoyl
     * @Param
     */
    public static Method getMethod(JoinPoint joinPoint) {
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
     * 获取Method的参数名称及对应的值
     *
     * @param joinPoint
     * @return JSON字符串
     */
    public static JSONObject getNameAndValue(JoinPoint joinPoint) {
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
}
