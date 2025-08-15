package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MyException;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.DateUtil;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.model.TopupActivitiesModel;
import com.dayuan3.terminal.service.TopupActivitiesLogService;
import com.dayuan3.terminal.service.TopupActivitiesService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.TriggerContext;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ScheduledFuture;

/**
 * 充值活动功能模块
 *
 * @author cola_hu
 * 2019年10月28日
 */

@Controller
@RequestMapping("/activities")
public class TopupActivitiesController implements SchedulingConfigurer {

    public static final String datefmt = "yyyy-MM-dd HH:mm:ss";
    private static final Logger log = Logger.getLogger("ScheduledLog");
    private static ScheduledFuture<?> future;
    private static final HashMap<String, ScheduledFuture<?>> map = new HashMap<String, ScheduledFuture<?>>();
    @Autowired
    private static final ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
    @Autowired
    private TopupActivitiesService activitiesService;
    @Autowired
    private TopupActivitiesLogService logService;
    @Autowired
    private ScheduledService scheduledService;
    private final Integer n = 0;
    private boolean initRun = true;    //启动项目时 启动接口守护进程

    /**
     * 时间转cron表达式
     *
     * @param date
     * @return
     */
    private static String getCron(Date date) {
        String str = DateUtil.formatDate(date, "ss mm HH dd MM ?");
        return str;
    }

    @Bean
    public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
        return new ThreadPoolTaskScheduler();
    }

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> mapData = new HashMap<>();
        try {


        } catch (Exception e) {
            log.info("***************************" + e.getMessage());
        }
        return new ModelAndView("/terminal/activities/list", mapData);
    }

    /**
     * 活动编辑页面
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response, Integer id) {
        Map<String, Object> mapData = new HashMap<>();
        try {
            if (id != null) {
                TopupActivities bean = activitiesService.queryById(id);
                mapData.put("bean", bean);
            }

        } catch (Exception e) {
            log.info("***************************" + e.getMessage());
        }
        return new ModelAndView("/terminal/activities/edit", mapData);
    }

    /**
     * 保存或修改活动内容
     *
     * @param bean
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public AjaxJson save(TopupActivities bean, String details, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            //1.判断开始结束时间
            Date now = new Date();
            if (bean.getChecked() == 1) {//审核通过加入定时器 需要校验时间是否冲突
                TopupActivities activities = activitiesService.queryById(bean.getId());
                List<TopupActivities> offerist = activitiesService.selectByTime(DateUtil.formatDate(bean.getTimeStart(), datefmt),
                        DateUtil.formatDate(bean.getTimeEnd(), datefmt));

                if (activities != null) {
                    if (offerist.size() >= 2) {
                        jsonObj.setSuccess(false);
                        jsonObj.setMsg("活动时间有冲突无法保存!");
                        return jsonObj;
                    }
                } else {// 新增
                    if (offerist.size() > 0) {
                        jsonObj.setSuccess(false);
                        jsonObj.setMsg("活动时间有冲突无法保存!");
                        return jsonObj;
                    }
                }

            }

            bean = activitiesService.save(bean, details);
            now = new Date();
            if (bean.getStatus() == 0 && bean.getChecked() == 1) {//已审核就加入定时计划
                long s1 = bean.getTimeStart().getTime();
                long s2 = now.getTime();
                if (s2 >= s1) {//当前时间大于开启时间
                    changeItem("open", bean.getId().toString());
                    // logService.writeLog(bean.getId(), (short) 2, "定时开启活动,并把关闭活动加入定时计划!", true, 0,bean);
                } else {//未开启加入定时计划
                    startCron("open", bean.getId().toString(), getCron(bean.getTimeStart()));
                }
            }

        } catch (MyException e) {
            log.error("**************************" + e.getMessage());
            jsonObj.setSuccess(false);
            jsonObj.setMsg(e.getMessage());
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    @RequestMapping(value = "/test")
    @ResponseBody
    public AjaxJson test(TopupActivitiesModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            jsonObj.setObj(CommonDataController.activitie);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 数据列表
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "/datagrid")
    @ResponseBody
    public AjaxJson datagrid(TopupActivitiesModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("desc");
            page = activitiesService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 活动id获取活动参数列表
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/getByActId")
    @ResponseBody
    public AjaxJson getByActId(Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            List<TopupActivitiesDetail> list = activitiesService.selectByActId(id);
            jsonObj.setObj(list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 删除活动
     *
     * @param request
     * @param response
     * @param ids
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            //1.清除活动设置优惠数据
            //2.活动终止日志记录
            String[] ida = ids.split(",");
            Integer[] idas = new Integer[ida.length];
            for (int i = 0; i < ida.length; i++) {
                idas[i] = Integer.parseInt(ida[i]);
                idas[i] = Integer.parseInt(ida[i]);
                future = map.get(ida[i]);
                if (future != null) {
                    future.cancel(true);
                    map.remove(ida[i]);
                }
				logService.writeLog(idas[i], (short) 4, "删除活动!", true, 1, null);
            }
            activitiesService.delete(idas);


        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 删除详情充值选项
     *
     * @param request
     * @param response
     * @param ids
     * @return
     */
    @RequestMapping("/deleteDeatil")
    @ResponseBody
    public AjaxJson deleteDeatil(HttpServletRequest request, HttpServletResponse response, String ids) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            String[] ida = ids.split(",");
            Integer[] idas = new Integer[ida.length];
            activitiesService.deleteDeatil(idas);
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    public void changeItem(String type, String id) {
        AjaxJson jsonObject = new AjaxJson();
        try {

            TopupActivities bean = activitiesService.queryById(Integer.parseInt(id));
            switch (type) {
                case "open"://开启
                    //开启定时计划
                    System.out.println(DateUtil.formatDate(new Date(), datefmt) + bean.getTheme() + "----充值优惠活动开启");
                    activitiesService.openItem(Integer.parseInt(id), null);
                    startCron("close", id, getCron(bean.getTimeEnd()));//开启关闭的定时计划
                    logService.writeLog(Integer.parseInt(id), (short) 2, "定时开启活动,并把活动加入“关闭”定时任务列表!", true, 0, bean);
                    break;
                case "close"://关闭
                    System.out.println(DateUtil.formatDate(new Date(), datefmt) + bean.getTheme() + "----充值优惠活动关闭");
                    activitiesService.closeItem(Integer.parseInt(id), null);
                    logService.writeLog(Integer.parseInt(id), (short) 3, "定时关闭活动!", true, 0, bean);
                    future = map.get(id);
                    if (future != null) {
                        future.cancel(true);//先关闭
                        map.remove(id);
                    }

                    break;

                default:
                    break;
            }


        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObject.setSuccess(false);
            jsonObject.setMsg("查询失败");
        }
    }

    //开启接口定时器方法
    @RequestMapping("/startCron")
    public AjaxJson startCron(String type, String id, String cron) {//开启的时候 先查看是否有同步线程
        AjaxJson jsonObj = new AjaxJson();
        try {
            future = map.get(id);
            if (future != null) {
                future.cancel(true);//先关闭
                map.remove(id);
            }
            ScheduledFuture<?> future = scheduler.schedule(new Runnable() {
                @Override
                public void run() {
                    // 逻辑任务
                    changeItem(type, id);
                }
            }, new CronTrigger(cron));
            map.put(id, future);
            log.info(id + "开启成功!");

        } catch (Exception e) {
            log.error(id + "开启失败!" + e.getMessage());
            jsonObj.setMsg("开启失败!请检查表达式是否正确");
            jsonObj.setSuccess(false);
            return jsonObj;
        }

        return jsonObj;
    }

    /**
     * 开启活动
     *
     * @param request
     * @param response
     * @param ids
     * @return
     */
    @RequestMapping("/startOffer")
    @ResponseBody
    public AjaxJson startOffer(HttpServletRequest request, HttpServletResponse response, Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            Date now = new Date();
            TopupActivities bean = activitiesService.queryById(id);
            List<TopupActivities> offerist = activitiesService.selectByTime(DateUtil.formatDate(now, datefmt), DateUtil.formatDate(bean.getTimeEnd(), datefmt));
            for (int i = 0; i < offerist.size(); i++) {
                if (offerist.get(i).getId() == id) {//是当前活动
                    offerist.remove(i);
                    break;
                }
            }
            if (offerist.size() > 0) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("该活动和其他活动有冲突不能提前启动!");
                return jsonObj;
            }
            if (bean.getStatus() == 0) {//未启动状态才启动
                TSUser user = PublicUtil.getSessionUser();
                activitiesService.openItem(id, user);//立即开启
                logService.writeLog(bean.getId(), (short) 2, "开启活动,原计划开启时间为：" + DateUtil.formatDate(bean.getTimeStart(), datefmt), true, 1, bean);
            } else {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("当前活动状态已发生变化，请刷新后操作!");
                return jsonObj;
            }
            startCron("close", id.toString(), getCron(bean.getTimeEnd()));//启动关闭定时计划
        } catch (MyException e) {
            log.error("**************************" + e.getMessage());
            jsonObj.setSuccess(false);
            jsonObj.setMsg(e.getMessage());
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    //定时任务开启--------------------------

    //关闭线程
    @RequestMapping("/stopCron")
    @ResponseBody
    public AjaxJson stopCron(String id) throws Exception {
        AjaxJson jsonObj = new AjaxJson();
        try {
            TopupActivities bean = activitiesService.queryById(Integer.parseInt(id));
            if (bean.getStatus() == 2) {
                jsonObj.setMsg("该活动已终止,请勿重复操作!");
                jsonObj.setSuccess(true);
                return jsonObj;
            }
            future = map.get(id);
            if (future != null) {
                future.cancel(true);
                map.remove(id);
            }
            activitiesService.closeItem(Integer.parseInt(id), null);
            jsonObj.setMsg("关闭成功!");
            jsonObj.setSuccess(true);
            logService.writeLog(Integer.parseInt(id), (short) 3, "提前关闭活动!原计划关闭时间为" + DateUtil.formatDate(bean.getTimeEnd(), datefmt), true, 1, null);
        } catch (MyException e) {
            log.error("**************************" + e.getMessage());
            jsonObj.setSuccess(false);
            jsonObj.setMsg(e.getMessage());
        } catch (Exception e) {
            log.error(e.getMessage());
            jsonObj.setMsg("关闭失败!");
            jsonObj.setSuccess(false);
        }
        return jsonObj;
    }

    public void configureTasks(ScheduledTaskRegistrar taskRegister) { // 开机启动
        taskRegister.addTriggerTask(new Runnable() {
            @Override
            public void run() {
                // 逻辑任务
                if (initRun) {
                    workStart();//开机只执行一次
                }
                initRun = false;
            }
        }, new Trigger() {
            @Override
            public Date nextExecutionTime(TriggerContext triggerContext) {
                Date nextExecutor = null;
                Scheduled scheduled = null;
                try {
                    //根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
                    scheduled = scheduledService.selectById(106);
                } catch (Exception e) {
                    log.error("*************** 开启任务失败-优惠活动任务 ***************" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
                }
                if (initRun && scheduled != null) {
                    log.info("开启任务-优惠活动任务");
                    CronTrigger trigger = new CronTrigger(scheduled.getScheduled());
                    nextExecutor = trigger.nextExecutionTime(triggerContext);
                }
                return nextExecutor;
            }
        });
    }


    /**
     * 定时任务启动器
     */
    @RequestMapping("workStart")
    public void workStart() {
        log.info("启动充值优惠活动定时任务!");
        scheduler.initialize();//初始化
        //delete by xiaoyl 2023-04-03 普通任务使用单线程
//        scheduler.setPoolSize(100);
        scheduler.setAwaitTerminationSeconds(60);
        scheduler.setWaitForTasksToCompleteOnShutdown(true);

        try {
            List<TopupActivities> list = activitiesService.selectOfferList();
            for (TopupActivities activities : list) {
                if (activities.getStatus() == 0) {//准备状态
                    //1.校验开始时间是否过了
                    long start = activities.getTimeStart().getTime();
                    long now = new Date().getTime();
                    if (now < start) {//未开始 需要加入定时计划
                        logService.writeLog(activities.getId(), (short) 6, "服务重启,活动自动加入“开启”定时任务列表!", true, 0, null);
                        startCron("open", activities.getId().toString(), getCron(activities.getTimeStart()));
                    } else {//过了开始时间
                        long end = activities.getTimeEnd().getTime();
                        if (now > end) {//过了结束时间
                            activitiesService.closeItem(activities.getId(), null);
                            logService.writeLog(activities.getId(), (short) 3, "服务重启,发现活动结束时间已过,终止活动!", true, 0, null);
                        } else {
                            activitiesService.openItem(activities.getId(), null);//立即开启
                            logService.writeLog(activities.getId(), (short) 2, "开启活动,原计划开启时间为：" + DateUtil.formatDate(activities.getTimeStart(), datefmt), true, 0, null);
                            startCron("close", activities.getId().toString(), getCron(activities.getTimeEnd()));
                        }
                    }


                } else {//进行中
                    long end = activities.getTimeEnd().getTime();
                    long now = new Date().getTime();
                    //1.校验结束时间是否过了
                    if (now < end) {//未结束  需要加入定时计划
                        logService.writeLog(activities.getId(), (short) 6, "服务重启,活动重新启动且加入“关闭”定时任务列表!", true, 0, null);
                        activitiesService.resItem(activities.getId(), null);//立即开启
                        startCron("close", activities.getId().toString(), getCron(activities.getTimeEnd()));//开启关闭的定时计划
                    } else {//活动已结束
                        activitiesService.closeItem(activities.getId(), null);
                        logService.writeLog(activities.getId(), (short) 3, "服务重启,发现活动已结束立即终止活动!", true, 0, null);
                    }
                }

            }
        } catch (Exception e) {
            log.info("***************************" + e.getMessage());
            System.err.println(e.getMessage());

        }

    }

}
