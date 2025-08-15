package com.dayuan3.common.aop;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.dayuan3.common.controller.TBaseFoodTypeController;

import net.sf.json.JSONObject;

/**
 *
 * @Description:
 * @Company:
 * @author
 * @date
 */
@Aspect
@Component
public class GeneratorLetterAspect {
	
	private Logger log = Logger.getLogger(GeneratorLetterAspect.class);
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Autowired
	private TBaseFoodTypeController tbFoodTypeController;
	
	@Around("execution(* com.dayuan.controller.data.BaseFoodTypeController.save(..)) || execution(* com.dayuan.controller.data.BaseFoodTypeController.delete(..))"
			+ " || execution(* com.dayuan3.terminal.controller.RequesterUnitController.save(..)) || execution(* com.dayuan3.terminal.controller.RequesterUnitController.delete(..))") 
    public Object afterReturning(ProceedingJoinPoint joinPoint) {
		String before=sdf.format(new Date());
		 Object[] args = joinPoint.getArgs();
		 Object result =null;
		 try {
			 result = joinPoint.proceed(args);
			if(JSONObject.fromObject(result).getString("success").equals("true")) {
				String className=joinPoint.getTarget().getClass().getName();
				switch (className) {
				case "com.dayuan.controller.data.BaseFoodTypeController":
					tbFoodTypeController.changeAllLetter(0, before);
					log.info("样品数据操作维护后，更新样品库和内存中的数据，执行时间："+before);
					break;
					case "com.dayuan3.terminal.controller.RequesterUnitController":
						tbFoodTypeController.changeAllLetter(1, before);
						log.info("委托单位数据操作维护后，更新样品库和内存中的数据，执行时间："+before);
						break;
				default:
					break;
				}
			}
		} catch (Throwable e) {
			log.error("同步执行生成拼音拦截器异常，时间："+before+"异常消息："+e.getMessage());
		}
		return result;
	}
	
	
}
