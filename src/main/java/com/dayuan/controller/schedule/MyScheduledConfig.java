package com.dayuan.controller.schedule;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.common.WebConstant;
import com.dayuan.service.system.ScheduledService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.SchedulingException;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.*;
import java.util.function.Function;

/**
 * @Description 使用自定义的线程池代替默认的线程池, 设置线程池大小
 * @Author xiaoyl
 * @Date 2023/3/28 17:13
 */
@Configuration
public class MyScheduledConfig implements SchedulingConfigurer {
    public static Logger log = Logger.getLogger("ScheduledLog");
    public static ThreadPoolTaskScheduler taskScheduler = null;
    public static ExecutorService executorService = null;
    //    public Integer taskId;//定时器任务DI
    //线程池数量，从sysconfig.properties文件读取，没有配置的话则默认为5
    private static final String threadPoolSize = WebConstant.res.containsKey("threadPoolSize") ? WebConstant.res.getString("threadPoolSize") : "5";
    //执行任务对象
//    public ScheduledFuture<?> future;
    @Autowired
    public ScheduledService scheduledService;
    //任务队列管理：初始化 map 对象，装配 schedule 方法的返回对象为 value 值
    public static ConcurrentHashMap<Integer, ScheduledFuture<?>> scheduledFutureMap=new ConcurrentHashMap<Integer, ScheduledFuture<?>>();

    @Bean
    public static TaskScheduler taskScheduler() {
        // Spring提供的定时任务线程池类
        if (taskScheduler == null) {
            taskScheduler = new ThreadPoolTaskScheduler();
            taskScheduler.setThreadNamePrefix("threadPool-thread-");// 线程名称前缀
            taskScheduler.setPoolSize(Integer.valueOf(threadPoolSize));//设定多线程来处理
            taskScheduler.setAwaitTerminationSeconds(60);
            taskScheduler.setWaitForTasksToCompleteOnShutdown(true);
            taskScheduler.initialize();
            log.info(String.format("===线程池初始化===：线程池数量为：%s", threadPoolSize));
        }
        //executorService=new ThreadPoolExecutor(2,20,0,TimeUnit.SECONDS,new ArrayBlockingQueue<>(512),new ThreadPoolExecutor.DiscardPolicy());
        return taskScheduler;
    }

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        taskRegistrar.setScheduler(taskScheduler());
    }

    /**
     * @return
     * @Description 共用的任务触发器，业务逻辑方法执行完成后调用，动态获取数据库配置的定时频率
     * @Date 2023/03/30 15:40
     * @Author xiaoyl
     * @Param taskId 任务ID
     */
    public Trigger getTrigger(Integer taskId) {
        Trigger trigger = triggerContext -> {
            //获取定时触发器，这里每次从数据库获取最新记录，更新触发器，实现定时间隔的动态调整
            Scheduled scheduled = scheduledService.selectById(taskId);
            Date nextExecutor = null;
            if (scheduled != null) {
                CronTrigger cronTrigger = new CronTrigger(scheduled.getScheduled());
                nextExecutor = cronTrigger.nextExecutionTime(triggerContext);
            } else {
                //运行过程中关闭定时任务时同步取消线程池中的任务
                ScheduledFuture<?> scheduledFuture = scheduledFutureMap.get(taskId);
                if (scheduledFuture != null) {
                    scheduledFuture.cancel(true);
                    if (scheduledFuture.isCancelled()) {
                        scheduledFutureMap.remove(taskId);
                    }
                }
            }
            return nextExecutor;
        };
        return trigger;
    }

    /**
     * Description：将Runnable对象和Trigger对象作为参数传入该静态方法
     * 1.首先判断任务是否已运行，如果已运行则先从线程池和map中移除
     * 2.根据任务ID查询数据库中的定时任务是否开启，只有开启才会添加到定时任务中去
     *
     * @param runnable
     * @param trigger
     * @param taskId   定时任务
     */
    public void putSchedule(Runnable runnable, Trigger trigger, Integer taskId) {
        //1.首先判断任务是否已运行，如果已运行则先从线程池和map中移除
        ScheduledFuture<?> scheduledFuture = scheduledFutureMap.get(taskId);
        if (scheduledFuture != null) {//&& scheduledFuture.isCancelled()
            scheduledFuture.cancel(true);
            if (scheduledFuture.isCancelled()) {
                scheduledFutureMap.remove(taskId);
            }
        }
        //2.据任务ID查询数据库中的定时任务是否开启，只有开启才会添加到定时任务中去
        Scheduled scheduledBean = scheduledService.selectById(taskId);
        if (scheduledBean != null) {
            // 将携带有Runnable和Trigger的ScheduledFuture类对象作为 Map 的 value 进行装配
            scheduledFuture = taskScheduler().schedule(runnable, trigger);
//            Future<Object> future= executorService.submit(runnable,trigger);
            scheduledFutureMap.put(taskId, scheduledFuture);
            log.info(String.format("===开启任务===：%s,任务名称：%s", taskId, scheduledBean.getScheduledName()));
        }
    }

    /**
     * @return
     * @Description 任务取消，通过上述 put 方法的参数taskId（定时任务id）标识，将定时任务移除出 map
     * @Date 2023/03/31 9:38
     * @Author xiaoyl
     * @Param
     */
    public AjaxJson cancelSchedule(Integer taskId){
        AjaxJson ajaxJson = new AjaxJson();
        ScheduledFuture<?> scheduledFuture = scheduledFutureMap.get(taskId);
        Scheduled scheduledBean = scheduledService.selectById(taskId);
        // 条件判断
        if (scheduledFuture != null) {//&& scheduledFuture.isCancelled()
            scheduledFuture.cancel(true);
            if (scheduledFuture.isCancelled()) {
                scheduledFutureMap.remove(taskId);
            }
        } else {
            ajaxJson.setMsg(String.format("===任务取消失败,任务未运行===：%s,任务名称：%s", taskId, scheduledBean.getScheduledName()));
            ajaxJson.setSuccess(false);
            return ajaxJson;
        }
        if (scheduledFutureMap.get(taskId) != null) {
            ajaxJson.setMsg(String.format("===任务取消失败===：%s,任务名称：%s", taskId, scheduledBean.getScheduledName()));
            ajaxJson.setSuccess(false);
            return ajaxJson;
        }
        log.info(String.format("===任务取消成功===：%s,任务名称：%s", taskId, scheduledBean.getScheduledName()));
        return ajaxJson;
    }
}
