package com.dayuan3.terminal.controller;

import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.Page;
import com.dayuan.bean.data.BaseDetectItem;
import com.dayuan.bean.data.BaseItemType;
import com.dayuan.bean.system.Scheduled;
import com.dayuan.service.data.BaseDetectItemService;
import com.dayuan.service.data.BaseItemTypeService;
import com.dayuan.service.system.ScheduledService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.terminal.bean.SpecialOffer;
import com.dayuan3.terminal.bean.SpecialOfferItem;
import com.dayuan3.terminal.model.SpecialOfferModel;
import com.dayuan3.terminal.service.SpecialOfferItemService;
import com.dayuan3.terminal.service.SpecialOfferLogService;
import com.dayuan3.terminal.service.SpecialOfferService;
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
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.concurrent.ScheduledFuture;

@Lazy(false)
@Component
@EnableScheduling
@Controller
@RequestMapping("specialOffer")
public class SpecialOfferController implements SchedulingConfigurer {

    public static final String datefmt = "yyyy-MM-dd HH:mm:ss";
    private static final Logger log = Logger.getLogger("ScheduledLog");
    private static ScheduledFuture<?> future;
    private static final HashMap<String, ScheduledFuture<?>> map = new HashMap<String, ScheduledFuture<?>>();
    @Autowired
    private static final ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
    private final Integer n = 0;
    @Autowired
    private SpecialOfferService specialOfferService;
    @Autowired
    private SpecialOfferItemService specialOfferItemService;
    @Autowired
    private BaseDetectItemService baseDetectItemService;
    @Autowired
    private SpecialOfferLogService logService;
    @Autowired
    private BaseItemTypeService baseItemTypeService;
    @Autowired
    private ScheduledService scheduledService;
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

    /**
     * 获取当前时间n小时
     *
     * @return
     */
    public static Date getBeforHour(int hour) {
        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        calendar.add(Calendar.HOUR_OF_DAY, hour);
        return calendar.getTime();
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
        return new ModelAndView("/terminal/specialOffer/list", mapData);
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
                SpecialOffer bean = specialOfferService.queryById(id);
                mapData.put("bean", bean);
            }
            List<BaseItemType> itemList = baseItemTypeService.queryAll();
            mapData.put("itemList", itemList);

        } catch (Exception e) {
            log.info("***************************" + e.getMessage());
        }
        return new ModelAndView("/terminal/specialOffer/edit", mapData);
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
    public AjaxJson save(SpecialOffer bean, String items, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson jsonObj = new AjaxJson();
        try {

            //1.判断开始结束时间
            Date now = new Date();
            int t = DateUtil.getBetweenTime(bean.getTimeStart(), now);
            if (t < 0) {//
                jsonObj.setSuccess(false);
                jsonObj.setMsg("活动开始时间不能大于当前时间!");
                return jsonObj;
            }
            //2.验证参数

            if (bean.getDiscount() == 0) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("折扣率不能为空!");
                return jsonObj;
            }
            if (bean.getApplyAllItems() == 0 && StringUtil.isEmpty(items)) {
                items = baseDetectItemService.queryAllIDs();
            }
            if (items == null) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("检测项目不能为空!");
                return jsonObj;
            }
            specialOfferService.dealOffer(bean, items);
            if (bean.getStatus() == 0 && bean.getChecked() == 1) {//已审核就加入定时计划
                long s1 = bean.getTimeStart().getTime();
                long s2 = now.getTime();
                if (s2 >= s1) {//当前时间大于开启时间
                    changeItem("open", bean.getId().toString());
                } else {//未开启加入定时计划
                    startCron("open", bean.getId().toString(), getCron(bean.getTimeStart()));
                }
            }
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
    public AjaxJson datagrid(SpecialOfferModel model, Page page) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            page.setOrder("desc");
            page = specialOfferService.loadDatagrid(page, model);
            jsonObj.setObj(page);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }


    //定时任务开启--------------------------

    /**
     * 获取全部检测项目列表
     *
     * @param
     * @param
     * @return
     */
    @RequestMapping(value = "/getItemList")
    @ResponseBody
    public AjaxJson getItemList(String timeStart, String timeEnd, Integer offerId) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            if (timeStart == null || timeEnd == null) {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("活动时间不能为空!");
                return jsonObj;
            }
            List<SpecialOffer> offerist = specialOfferService.selectByTime(timeStart, timeEnd);
            String[] ida = new String[offerist.size()];
            for (int i = 0; i < offerist.size(); i++) {
                ida[i] = offerist.get(i).getId().toString();
            }
            if (ida.length == 0) {
                ida = null;
            }
            List<BaseDetectItem> list = baseDetectItemService.queryAllByChecked(ida);
            jsonObj.setObj(list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

    /**
     * 获取全部检测项目列表
     *
     * @param
     * @param
     * @return
     */
    @RequestMapping(value = "/getItemListById")
    @ResponseBody
    public AjaxJson getItemListById(Integer id) {
        AjaxJson jsonObj = new AjaxJson();
        try {
            List<SpecialOfferItem> list = specialOfferItemService.selectByOfferId(id);
            jsonObj.setObj(list);
        } catch (Exception e) {
            log.error("******************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
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
        log.info("启动优惠活动定时任务!");
        scheduler.initialize();//初始化
        //delete by xiaoyl 2023-04-03 普通任务使用单线程
//        scheduler.setPoolSize(100);
        scheduler.setAwaitTerminationSeconds(60);
        scheduler.setWaitForTasksToCompleteOnShutdown(true);

        try {
            List<SpecialOffer> list = specialOfferService.selectOfferList();
            for (SpecialOffer specialOffer : list) {
                if (specialOffer.getStatus() == 0) {//准备状态
                    //1.校验开始时间是否过了
                    long start = specialOffer.getTimeStart().getTime();
                    long now = new Date().getTime();
                    if (now < start) {//未开始 需要加入定时计划
                        startCron("open", specialOffer.getId().toString(), getCron(specialOffer.getTimeStart()));
                        logService.writeLog(specialOffer.getId(), (short) 6, "服务重启,活动自动加入“开启”定时任务列表!", true, 0, specialOffer, null);
                    } else {//过了开始时间
                        long end = specialOffer.getTimeEnd().getTime();
                        if (now > end) {//过了结束时间
                            specialOfferService.closeList(specialOffer.getId());
                            logService.writeLog(specialOffer.getId(), (short) 3, "服务重启,发现活动结束时间已过,终止活动!", true, 0, specialOffer, null);
                        } else {
                            specialOfferService.openItem(specialOffer.getId(), 1);//立即开启
                            logService.writeLog(specialOffer.getId(), (short) 2, "开启活动,原计划开启时间为：" + DateUtil.formatDate(specialOffer.getTimeStart(), datefmt), true, 0, specialOffer, null);
                            startCron("close", specialOffer.getId().toString(), getCron(specialOffer.getTimeEnd()));
                        }
                    }


                } else {//进行中
                    long end = specialOffer.getTimeEnd().getTime();
                    long now = new Date().getTime();
                    //1.校验结束时间是否过了
                    if (now < end) {//未结束  需要加入定时计划
                        startCron("close", specialOffer.getId().toString(), getCron(specialOffer.getTimeEnd()));//开启关闭的定时计划
                        logService.writeLog(specialOffer.getId(), (short) 6, "服务重启,活动重新启动且自动加入“关闭”定时任务列表!", true, 0, specialOffer, null);
                    } else {//活动已结束
                        specialOfferService.closeList(specialOffer.getId());
                        logService.writeLog(specialOffer.getId(), (short) 3, "服务重启,发现活动已结束立即终止活动!", true, 0, specialOffer, null);
                    }
                }

            }
        } catch (Exception e) {
            log.info("***************************" + e.getMessage());
            System.err.println(e.getMessage());

        }

    }

    /**
     * 处理定时计划 type: open、close
     */
    public void changeItem(String type, String id) {
        AjaxJson jsonObject = new AjaxJson();
        try {

            SpecialOffer bean = specialOfferService.queryById(Integer.parseInt(id));
            switch (type) {
                case "open"://开启
                    //开启定时计划
                    System.out.println(DateUtil.formatDate(new Date(), datefmt) + bean.getTheme() + "----活动开启");
                    specialOfferService.openItem(Integer.parseInt(id), 0);
                    logService.writeLog(Integer.parseInt(id), (short) 2, "定时开启活动,且加入“关闭”定时任务列表!", true, 0, bean, null);
                    startCron("close", id, getCron(bean.getTimeEnd()));//开启关闭的定时计划
                    break;
                case "close"://关闭
                    System.out.println(DateUtil.formatDate(new Date(), datefmt) + bean.getTheme() + "----活动关闭");
                    specialOfferService.closeList(Integer.parseInt(id));
                    logService.writeLog(Integer.parseInt(id), (short) 3, "定时关闭活动!", true, 0, bean, null);
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

    //修改定时任务时间
    @RequestMapping("/changeCron")
    public AjaxJson changeCron(String type, String id, String cron) {//开启的时候 先查看是否有同步线程
        AjaxJson jsonObj = new AjaxJson();
        try {
            future = map.get(id);
            if (cron == null) {//关闭线程
                if (future != null) {
                    future.cancel(true);//先关闭
                    map.remove(id);
                    log.info(id + "定时任务为空----关闭定时器");
                }
            } else {
                if (future == null) {
                    startCron(type, id, cron);
                } else {
                    future.cancel(true);//先关闭
                    map.remove(id);
                    jsonObj = startCron(type, id, cron);
                    if (!jsonObj.isSuccess()) {
                        return jsonObj;
                    }
                    log.info(type + "修改定时任务----定时器开启");
                }
            }
        } catch (Exception e) {
            log.error(type + "修改定时任务失败!" + e.getMessage());
            jsonObj.setMsg("修改失败!");
            jsonObj.setSuccess(false);
            return jsonObj;
        }
        return jsonObj;
    }

    //关闭线程
    @RequestMapping("/stopCron")
    @ResponseBody
    public AjaxJson stopCron(String id) throws Exception {
        AjaxJson jsonObj = new AjaxJson();
        try {
            SpecialOffer bean = specialOfferService.queryById(Integer.parseInt(id));
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
            specialOfferService.closeList(Integer.parseInt(id));
            jsonObj.setMsg("关闭成功!");
            jsonObj.setSuccess(true);
            logService.writeLog(Integer.parseInt(id), (short) 3, "提前关闭活动!原计划关闭时间：" + DateUtil.formatDate(bean.getTimeEnd(), datefmt), true, 1, bean, null);
        } catch (Exception e) {
            log.error(e.getMessage());
            jsonObj.setMsg("关闭失败!");
            jsonObj.setSuccess(false);
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
            String[] ida = ids.split(",");
            Integer[] idas = new Integer[ida.length];
            for (int i = 0; i < ida.length; i++) {
                idas[i] = Integer.parseInt(ida[i]);
                future = map.get(ida[i]);
                if (future != null) {
                    future.cancel(true);
                    map.remove(ida[i]);
                }
				specialOfferService.deleteList(idas[i]);
                logService.writeLog(idas[i], (short) 4, "删除活动!", true, 1, null, null);
            }
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
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
            SpecialOffer bean = specialOfferService.queryById(id);
            List<SpecialOffer> offerist = specialOfferService.selectByTime(DateUtil.formatDate(now, datefmt), DateUtil.formatDate(bean.getTimeEnd(), datefmt));
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
            if (bean.getStatus() == 0) {//未启动状态才启动1
                specialOfferService.openItem(id, 1);//立即开启
                logService.writeLog(bean.getId(), (short) 2, "开启活动,原计划开启时间为：" + DateUtil.formatDate(bean.getTimeStart(), datefmt), true, 1, bean, null);
            } else {
                jsonObj.setSuccess(false);
                jsonObj.setMsg("当前活动状态已发生变化，请刷新后操作!");
                return jsonObj;
            }
            startCron("close", id.toString(), getCron(bean.getTimeEnd()));//启动关闭定时计划
        } catch (Exception e) {
            log.error("**************************" + e.getMessage() + e.getStackTrace());
            jsonObj.setSuccess(false);
            jsonObj.setMsg("操作失败");
        }
        return jsonObj;
    }

}
