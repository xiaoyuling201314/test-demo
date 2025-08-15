package com.dayuan.aop;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.Cache;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.WebConstant;
import com.dayuan.util.CacheManager;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 接口日志
 * @Description:
 * @Company:
 * @author Dz  
 * @date 2018年7月24日
 */
@Aspect
@Component
public class InterfaceLogAspect {
	
	private Logger log = Logger.getLogger("INTERFACES");

	private Logger iErrLog = Logger.getLogger("iERR");
	
	@Around("execution(* com.dayuan*.controller.interfaces*.*.*(..)) " +
			"|| execution(* com.dayuan3.api.controller.*.*(..)) ")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
		long begin = System.currentTimeMillis();
		//返回
		Object ret = null;

		//获取用户名
		String userName = null;
		String ip = null;
		String url = null;
		JSONObject paramsJson = new JSONObject();

		try {
			ret = pjp.proceed();


			Signature signature = pjp.getSignature();
//			Method method = null;
//			if (signature instanceof MethodSignature) {
//				method = ((MethodSignature) signature).getMethod();
//			}

			//1.获取到所有的参数值的数组
			Object[] args = pjp.getArgs();
			MethodSignature methodSignature = (MethodSignature) signature;
			//2.获取到方法的所有参数名称的字符串数组
			String[] parameterNames = methodSignature.getParameterNames();


			//参数
			for (int i=0; i<args.length; i++){
				if (!(args[i] instanceof HttpServletRequest) && !(args[i] instanceof HttpServletResponse) ) {
					paramsJson.put(parameterNames[i], args[i]);
					if ("userToken".equals(parameterNames[i])) {
						String userToken = (String) args[i];
						Cache cache = CacheManager.getCacheInfo(userToken);
						TSUser user = cache == null ? null : (TSUser)cache.getValue();
						userName = user == null ? null : user.getUserName();
					}
				}
			}

			try {
				HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				//获取用户IP
				ip = request.getHeader("x-forwarded-for");
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

				url = request.getRequestURL().toString();
			} catch (Exception e) {
				return ret;
			}

			JSONObject resultJson = null;
			String resultCode = "";
			if(ret != null) {
				resultJson = (JSONObject) JSONObject.toJSON(ret);	//返回结果
			}
			if(null != resultJson) {
				resultCode = resultJson.getString("resultCode");	//返回码
			}

			//日志
			if (WebConstant.INTERFACE_CODE0.equals(resultCode)){
//				//上传数据中，出现失败记录
//				if (resultJson.getJSONObject("obj") != null && resultJson.getJSONObject("obj").getInteger("failNum") != null && resultJson.getJSONObject("obj").getInteger("failNum") > 0) {
//					iErrLog.info("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] ["+resultCode+"] URL:"+url+" Parm:"+paramsJson.toJSONString() + " return:" + resultJson.toJSONString());
//				} else {
					log.info("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] ["+resultCode+"] URL:"+url+" Parm:"+paramsJson.toJSONString());
//				}
			} else if(WebConstant.INTERFACE_CODE11.equals(resultCode)) {
				log.error("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] ["+resultCode+"] ["+resultJson.getString("msg")+"] URL:"+url+" Parm:"+paramsJson.toJSONString());
			} else if (resultJson != null){
				log.info("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] ["+resultCode+"] ["+resultJson.getString("msg")+"] URL:"+url+" Parm:"+paramsJson.toJSONString());
			} else {
				log.info("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] URL:"+url+" Parm:"+paramsJson.toJSONString());
			}

		} catch (Exception e) {
			log.error("["+(System.currentTimeMillis() - begin)+"ms] ["+ip+"] ["+userName+"] ["+WebConstant.INTERFACE_CODE11+"] URL:"+url+" Parm:"+paramsJson.toJSONString() +"*****"+ e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		}

		return ret;
	}
	
	
}
