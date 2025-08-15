package com.dayuan3.terminal.controller.schedule;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.controller.schedule.MyScheduledConfig;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.DateUtil;
import com.dayuan3.terminal.service.OrderStatisticDailyService;
import com.dayuan3.terminal.service.OrderStatisticMonthlyService;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.ScheduledFuture;

/**
 * 订单财务统计
 * 
 * @author Dz
 * @date 2019年9月17日
 */
@Lazy(false)
@Controller
@EnableScheduling
@RequestMapping("/orderStatisticTask")
public class OrderStatisticTask extends MyScheduledConfig {

	Integer taskId = 13;//定时器任务ID
	@Autowired
	private OrderStatisticDailyService orderStatisticDailyService;
	@Autowired
	private OrderStatisticMonthlyService orderStatisticMonthlyService;

	private void orderStatstics(){
		try {
			Date d1 = new Date();
			Calendar calendar = Calendar.getInstance();

			if (calendar.get(Calendar.DAY_OF_MONTH) == 1){
				//财务统计-昨天
				calendar.add(Calendar.DAY_OF_MONTH, -1);
				orderStatisticDailyService.saveOrUpdateDailyStatistic(calendar);
				//财务统计-上个月
				orderStatisticMonthlyService.monthlyStatistic(calendar);

			} else {
				//财务统计-昨天
				calendar.add(Calendar.DAY_OF_MONTH, -1);
				orderStatisticDailyService.saveOrUpdateDailyStatistic(calendar);
			}
			log.info(String.format("线程名称: {%s},执行任务-订单财务统计，耗时：%sms", Thread.currentThread().getName(), DateUtil.getTimeDifferenceMs(d1, new Date())));

		} catch (Exception e) {
			log.error("*************** 执行任务失败-订单财务统计 ***************"+e.getMessage()+e.getStackTrace());
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
		Runnable runnable = () -> orderStatstics();
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
		Runnable runnable = () -> orderStatstics();
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
				orderStatstics();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					log.info("重启任务-订单财务统计");
					//根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
					scheduled = scheduledService.selectById(13);
				} catch (Exception e) {
					log.error("*************** 重启任务失败-订单财务统计 ***************"+e.getMessage()+e.getStackTrace());
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
				orderStatstics();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = null;
				try {
					log.info("开启任务-订单财务统计");
					//根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
					scheduled = scheduledService.selectById(13);
				} catch (Exception e) {
					log.error("*************** 开启任务失败-订单财务统计 ***************"+e.getMessage()+e.getStackTrace());
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
