package com.dayuan.logs.controller.schedule;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.controller.schedule.MyScheduledConfig;
import com.dayuan.logs.service.SysIpAdressService;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.DateUtil;
import org.apache.log4j.Logger;
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

import java.util.Date;
import java.util.concurrent.ScheduledFuture;

/**
* @Description 根据IP地址获取物理地址，由ip138提供相应的接口
* @Date 2022/03/03 16:01
* @Author xiaoyl
* @Param
* @return
*/
@Lazy(false)
@Component
@EnableScheduling
@Controller
@RequestMapping("/syncIPAddressSchedule")
public class SyncIPAddressSchedule extends MyScheduledConfig {

	Integer taskId = 101;//定时器任务ID
	@Autowired
	private SysIpAdressService sysIpAdressService;
/*	@Autowired
	private ScheduledService scheduledService;
	private ScheduledFuture<?> future;
	private ThreadPoolTaskScheduler threadPoolTaskScheduler;
	private static Logger log = Logger.getLogger("ScheduledLog");
	@Bean
	public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
		return new ThreadPoolTaskScheduler();
	}*/
	
	/**
	 * 统计上个月的市场覆盖率
	 */
	private void queryIPAddress(){
		try {
			Date d1 = new Date();
			sysIpAdressService.syncDealIPAddress();
			log.info(String.format("线程名称: {%s},执行任务-IP138获取地理地址，耗时：%sms", Thread.currentThread().getName(), DateUtil.getTimeDifferenceMs(d1, new Date())));
		} catch (Exception e) {
			log.error("*************** 执行任务失败-IP138获取地理地址 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
	public AjaxJson setCron(Integer departId) {
		AjaxJson ajaxJson = new AjaxJson();
		//根据定时任务ID查询任务是否开启，开启才添加到定时任务中
		Runnable runnable = () -> queryIPAddress();
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
		Runnable runnable = () -> queryIPAddress();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
/*	//需要重新启动定时器时调用的方法
	@RequestMapping("/start")
	public void setCron() {
		future = threadPoolTaskScheduler().schedule(new Runnable() {
			@Override
			public void run() {
				queryIPAddress();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					log.info("重启任务-IP138获取地理地址");
					//根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
					scheduled = scheduledService.selectById(101);	//市场覆盖率定时统计
				} catch (Exception e) {
					log.error("*************** 重启任务失败-IP138获取地理地址 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
				queryIPAddress();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					log.info("开启任务-IP138获取地理地址");
					//根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
					scheduled = scheduledService.selectById(101);
				} catch (Exception e) {
					log.error("*************** 开启任务失败-IP138获取地理地址 ***************"+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
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
}
