package com.dayuan.controller.schedule;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.schedule.util.SignUtils;
import com.dayuan.service.statistics.DataRegStatisticsService;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.DateUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.TriggerContext;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ScheduledFuture;

/**
 * 定时同步几米平台的定位数据
 * api 地址http://www.jimicloud.com/apiJimi.html#getdataOne
 * @author xiaoyl
 * @date   2019年9月16日
 */
@Lazy(false)
@Component
@EnableScheduling
@Controller
@RequestMapping("/GPSSyncSchedule")
public class GPSSyncSchedule extends MyScheduledConfig{
	Integer taskId = 12;//定时器任务ID

	@Autowired
	private DataRegStatisticsService dataRegStatisticsService;
/*	private static Logger log = Logger.getLogger("ScheduledLog");
	@Autowired
	private ScheduledService scheduledService;
	private ScheduledFuture<?> future;
	private ThreadPoolTaskScheduler threadPoolTaskScheduler;*/
	private String startDate="";
	/*@Bean
	public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
		return new ThreadPoolTaskScheduler();
	}*/
	
	private void syncGPS(){
		try {
			Date d1=new Date();
			//TODO
			Map<String, String> paramMap = new HashMap<String, String>();
			// 公共参数
			paramMap.put("app_key", WebConstant.res.getString("jimi_app_key"));
			paramMap.put("v", "1.0");
			paramMap.put("timestamp", getCurrentDate());
			paramMap.put("sign_method", "md5");
			paramMap.put("format", "json");
			paramMap.put("method", "jimi.oauth.token.get");
			//1.获取接口访问token
			String  accesstoken=getAccesstoken(paramMap);
			//2.查询账户下所有设备信息
			
			//3。遍历设备查询所有轨迹数据
			log.info("线程名称: {" + Thread.currentThread().getName() + "},执行任务-定位设备数据同步，耗时：" + DateUtil.getTimeDifferenceMs(d1, new Date()) + "ms");
		} catch (Exception e) {
			log.error("*************** 执行任务失败-定位设备数据同步 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
	}
	/**
	 * @return
	 * @Description 手动开启定时器任务，开启前先判断任务是否取消，未取消则先进行取消操作；
	 * 根据定时任务ID查询任务是否开启，开启才添加到定时任务中
	 * @Date 2023/03/30 15:30
	 * @Author xiaoyl
	 * @Param
	 */
	@RequestMapping("/start")
	@ResponseBody
	public AjaxJson setCron() {
		AjaxJson ajaxJson = new AjaxJson();
		//根据定时任务ID查询任务是否开启，开启才添加到定时任务中
		Runnable runnable = () -> syncGPS();
		//任务触发器,重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		//注册定时任务
		putSchedule(runnable, trigger, taskId);
		if (scheduledFutureMap.get(taskId) == null) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("任务已关闭，重启失败！");
			return ajaxJson;
		}
		return ajaxJson;
	}

	/**
	 * @return
	 * @Description 配置定时器任务，根据taskID查询任务并添加到任务中
	 * @Date 2023/03/30 15:30
	 * @Author xiaoyl
	 * @Param
	 */
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistar) {
		Runnable runnable = () -> syncGPS();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
/*	//需要重新启动定时器时调用的方法
	@RequestMapping("/start")
	public void setCron() {
		future = taskScheduler().schedule(new Runnable() {
			@Override
			public void run() {
				syncGPS();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					//定时同步几米平台的定位数据
					scheduled = scheduledService.selectById(12);
				} catch (Exception e) {
					log.error("*************** 重启任务失败-定位设备数据同步 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
				}
				Date nextExecutor = null;
				//如果查询结果为null，则不执行以下代码，防止定时器报空指针异常
				if(scheduled!=null){
					CronTrigger trigger = new CronTrigger(scheduled.getScheduled());
					nextExecutor = trigger.nextExecutionTime(triggerContext);
				}
				return nextExecutor;
			}
		});
	}
	
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistar){
		taskRegistar.addTriggerTask(new Runnable() {
			@Override
			public void run() {
				syncGPS();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					//定时同步几米平台的定位数据
					scheduled = scheduledService.selectById(12);
				} catch (Exception e) {
					log.error("*************** 开启任务失败-定位设备数据同步 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
				}
				Date nextExecutor = null;
				//如果查询结果为null，则不执行以下代码，防止定时器报空指针异常
				if(scheduled!=null){
					CronTrigger trigger = new CronTrigger(scheduled.getScheduled());
					nextExecutor = trigger.nextExecutionTime(triggerContext);
				}
				return nextExecutor;
			}
		});
	}*/

	private String getAccesstoken(Map<String, String> paramMap) {
		String accesstoken="";
		Map<String, String> headerMap = new HashMap<String, String>();
		headerMap.put("Content-Type", "application/x-www-form-urlencoded");
		// 私有参数
		paramMap.put("user_id", "广州达元");
		paramMap.put("user_pwd_md5", DigestUtils.md5Hex("dyxx123456"));
		paramMap.put("expires_in", "120");
		String sign = "";
		try {
			sign = SignUtils.signTopRequest(paramMap, WebConstant.res.getString("jimi_app_secret"), "md5");
			paramMap.put("sign", sign);
			JSONObject jsonResult=sendPost(headerMap, paramMap);
			if(jsonResult!=null && jsonResult.getString("message").equals("success")) {
				jsonResult=jsonResult.getJSONObject("result");
				accesstoken=jsonResult.getString("accessToken");
				System.out.println("接口访问Token："+jsonResult.getString("accessToken"));
			}
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return accesstoken;
	}
	private static JSONObject sendPost(Map<String, String> headerMap, Map<String, String> paramMap) {
		try {
			HttpPost post = new HttpPost(WebConstant.res.getString("jimi_openapi_url"));
			List<NameValuePair> list = new ArrayList<NameValuePair>();
			for (String key : paramMap.keySet()) {
				list.add(new BasicNameValuePair(key, paramMap.get(key)));
			}
			post.setEntity(new UrlEncodedFormEntity(list, "UTF-8"));
			if (null != headerMap) {
				post.setHeaders(assemblyHeader(headerMap));
			}
			
			CloseableHttpClient httpClient = HttpClients.createDefault();
			HttpResponse response = httpClient.execute(post);
			HttpEntity entity = response.getEntity();
			String result=EntityUtils.toString(entity, "utf-8");
			JSONObject resultJson= new JSONObject(result);
			return resultJson;
		} catch (Exception e) {
			log.error("**************************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
		}
		return null;
	}
	
	/**
	 * 组装头部信息
	 * 
	 * @param headers
	 * @return
	 */
	private static Header[] assemblyHeader(Map<String, String> headers) {
		Header[] allHeader = new BasicHeader[headers.size()];
		int i = 0;
		for (String str : headers.keySet()) {
			allHeader[i] = new BasicHeader(str, headers.get(str));
			i++;
		}
		return allHeader;
	}

	public static String getCurrentDate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String result = formatter.format(new Date());
		return result;
	}
}
