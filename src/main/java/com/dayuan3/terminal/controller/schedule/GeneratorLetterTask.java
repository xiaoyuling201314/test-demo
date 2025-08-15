package com.dayuan3.terminal.controller.schedule;

import java.util.Date;
import java.util.List;

import com.dayuan.bean.AjaxJson;
import com.dayuan.controller.schedule.MyScheduledConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.data.BaseFoodType;
import com.dayuan.service.data.BaseFoodTypeService;
import com.dayuan.service.regulatory.BaseRegulatoryBusinessService;
import com.dayuan.service.regulatory.BaseRegulatoryObjectService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.InspectionUnitUserLabel;
import com.dayuan3.common.bean.SystemConfig;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.common.service.InspectionUnitUserLabelService;
import com.dayuan3.common.service.SystemConfigService;
import com.dayuan3.common.util.PingYinUtil;
import com.dayuan3.admin.bean.InspectionUnit;
import com.dayuan3.terminal.bean.RequesterUnit;
import com.dayuan3.admin.service.InspectionUnitService;
import com.dayuan3.terminal.service.RequesterUnitService;
import org.springframework.web.bind.annotation.ResponseBody;

@Lazy(false)
@Component
@EnableScheduling
@Controller
@RequestMapping("/generatorLetter")
public class GeneratorLetterTask extends MyScheduledConfig {
	Integer taskId = 10;//定时器任务ID

	@Autowired
	private BaseFoodTypeService baseFoodTypeService;

	@Autowired
	private RequesterUnitService requesterUnitService;

	@Autowired
	private BaseRegulatoryObjectService baseRegulatoryObjectService;

	@Autowired
	private BaseRegulatoryBusinessService baseRegulatoryBusinessService;
	
	@Autowired
	private InspectionUnitUserLabelService labelService;
	
	@Autowired
	private SystemConfigService systemConfigService;

	@Autowired
	private InspectionUnitService inspectionUnitService;
/*	private static Logger log = Logger.getLogger("ScheduledLog");
	@Autowired
	private ScheduledService scheduledService;
	private ScheduledFuture<?> future;

	private ThreadPoolTaskScheduler threadPoolTaskScheduler;*/

	// 样品信息最后更新时间
	public  String lastUpdateTimeFood = "2001-01-01 00:00:01";
	// 委托单位最后更新时间
	public  String lastUpdateTimeRequester = "2001-01-01 00:00:01";
	// 委托单位标签最后更新时间
	public  String lastUpdateTimeUserLabel ="2001-01-01 00:00:01"; 
	// 样品来源最后更新时间
	public  String lastUpdateTimeRegObj = "2001-01-01 00:00:01";
	// 经营档口最后更新时间
	public  String lastUpdateTimeBusiness ="2001-01-01 00:00:01";
	//送检单位最后更新时间
	public  String lastUpdateTimeInsUnit ="2001-01-01 00:00:01";

	// 生成首字母和全拼的方法
	public void generatorLetter() {
		Date d1=new Date();
		log.info("启动样品、委托单位生成- 拼音定时任务!开始时间"+DateUtil.yyyymmddhhmmss.format(new Date()));
		SystemConfig bean=systemConfigService.queryDataByConfigType(15);
		JSONObject configJSON=JSONObject.parseObject(bean.getConfigParam());
		// 1.提取样品首字母和拼音
		lastUpdateTimeFood=configJSON.getString("last_updateTime_food");
		List<BaseFoodType> list = baseFoodTypeService.queryFoodByLastUpdateTime(lastUpdateTimeFood);
		if (list != null && list.size() > 0) {
			list.forEach((item) -> {
				String name = item.getFoodName();
				String otherName = item.getFoodNameOther();
				try {
					if (StringUtil.isEmpty(otherName)) {
						item.setFoodFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setFoodFullLetter(PingYinUtil.getFullLetter(name));
					} else {
						String[] others = otherName.split("[， , 、]");
						String firstStr = "";
						String fullStr = "";
						for (int i = 0; i < others.length; i++) {
							firstStr += "," + PingYinUtil.getFirstLetter(others[i]);
							fullStr += "," + PingYinUtil.getFullLetter(others[i]);
						}
						item.setFoodFirstLetter(PingYinUtil.getFirstLetter(name) + firstStr);
						item.setFoodFullLetter(PingYinUtil.getFullLetter(name) + fullStr);
					}
					item.setUpdateDate(new Date());
					baseFoodTypeService.updateById(item);
				} catch (Exception e) {
					log.error(GeneratorLetterTask.class);
					log.error(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品首字母和拼音异常：" + e.getMessage());
				}
			});
//			lastUpdateTimeFood = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_food", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
			CommonDataController.terminalfoodList = null;
			CommonDataController.foodList = null;
		}
		// 2.提取所有委托单位
		lastUpdateTimeRequester=configJSON.getString("last_updateTime_requester");
		List<RequesterUnit> requesterUnits = requesterUnitService.queryAll(lastUpdateTimeRequester);
		if (requesterUnits != null && requesterUnits.size() > 0) {
			requesterUnits.forEach((item) -> {
				String name = item.getRequesterName();
				String otherName = item.getRequesterOtherName();
				try {
					if (StringUtil.isEmpty(otherName)) {
						item.setRequesterFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setRequesterFullLetter(PingYinUtil.getFullLetter(name));
					} else {//add by xiaoyl2019-11-20 提取企业别名的拼音首字母和全拼
						String[] others = otherName.split("[， , 、]");
						String firstStr = "";
						String fullStr = "";
						for (int i = 0; i < others.length; i++) {
							firstStr += "," + PingYinUtil.getFirstLetter(others[i]);
							fullStr += "," + PingYinUtil.getFullLetter(others[i]);
						}
						item.setRequesterFirstLetter(PingYinUtil.getFirstLetter(name) + firstStr);
						item.setRequesterFullLetter(PingYinUtil.getFullLetter(name) + fullStr);
					}
					item.setUpdateDate(new Date());
					requesterUnitService.updateBySelective(item);
				} catch (Exception e) {
					log.error(GeneratorLetterTask.class);
					log.error(DateUtil.datetimeFormat.format(new Date()) + ",定期生成委托单位首字母和拼音异常：" + e.getMessage());
				}
			});
//			lastUpdateTimeRequester = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_requester", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
			CommonDataController.terminalRequestList = null;
			CommonDataController.unitList = null;
		}
		/*// 3.提取所有样品来源
		 * 
		lastUpdateTimeRegObj=configJSON.getString("last_updateTime_regObj");
		List<BaseRegulatoryObject> regsList = baseRegulatoryObjectService.queryByLastUpdateTime(null, "1",
				lastUpdateTimeRegObj);
		if (regsList != null && regsList.size() > 0) {
			regsList.forEach((item) -> {
				String name = item.getRegName();
				try {
					item.setRegFirstLetter(PingYinUtil.getFirstLetter(name));
					item.setRegFullLetter(PingYinUtil.getFullLetter(name));
					baseRegulatoryObjectService.updateBySelective(item);
				} catch (Exception e) {
					log.error(GeneratorLetterTask.class);
					log.error(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品来源首字母和拼音异常：" + e.getMessage());
				}
			});
			lastUpdateTimeRegObj = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_regObj", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
			CommonDataController.terminalRegobjList = null;
			CommonDataController.objList = null;
		}
		// 4.提取所有档口
		 lastUpdateTimeBusiness=configJSON.getString("last_updateTime_business");
		List<BaseRegulatoryBusiness> businessList = baseRegulatoryBusinessService
				.queryByLastUpdateTime(lastUpdateTimeBusiness);
		if (businessList != null && businessList.size() > 0) {
			businessList.forEach((item) -> {
				String name = item.getRegName();
				try {
					if (StringUtil.isNotEmpty(name)) {
						item.setBusinessFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setBusinessFullLetter(PingYinUtil.getFullLetter(name));
						baseRegulatoryBusinessService.updateBySelective(item);
					}
				} catch (Exception e) {
					log.error(GeneratorLetterTask.class);
					log.error(DateUtil.datetimeFormat.format(new Date()) + ",定期生成样品来源首字母和拼音异常：" + e.getMessage());
				}
			});
			lastUpdateTimeBusiness = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_business", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
		}*/
		//5.提取送检单位
		lastUpdateTimeInsUnit=configJSON.getString("last_updateTime_insUnit");
		List<InspectionUnit> InspectionUnitList=inspectionUnitService.queryAll(lastUpdateTimeInsUnit);
		if(InspectionUnitList!=null&&InspectionUnitList.size()>0){
//			lastUpdateTimeInsUnit = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_insUnit", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
			CommonDataController.inspectionList = null;
		}
		
		//6.提取委托单位标签
		lastUpdateTimeUserLabel=configJSON.getString("last_updateTime_userLabel");
		List<InspectionUnitUserLabel> labelList=labelService.queryAllByLastUpdateTime(null,lastUpdateTimeUserLabel);
		if(labelList!=null&&labelList.size()>0){
			labelList.forEach((item) -> {
				String name = item.getLabelName();
				try {
					if (StringUtil.isEmpty(name)) {
						item.setLabelFirstLetter(PingYinUtil.getFirstLetter(name));
						item.setLabelFullLetter(PingYinUtil.getFullLetter(name));
						item.setUpdateDate(new Date());
					} 
					labelService.updateBySelective(item);
				} catch (Exception e) {
					log.error(GeneratorLetterTask.class);
					log.error(DateUtil.datetimeFormat.format(new Date()) + ",定期生成委托单位首字母和拼音异常：" + e.getMessage());
				}
			});
//			lastUpdateTimeUserLabel = DateUtil.datetimeFormat.format(new Date());
			configJSON.put("last_updateTime_userLabel", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss.SSS"));
		}
		//将最后一次执行时间写入数据库
		try {
			bean.setConfigParam(configJSON.toJSONString());
			systemConfigService.updateBySelective(bean);
		} catch (Exception e) {
			log.error(GeneratorLetterTask.class);
			log.error(DateUtil.datetimeFormat.format(new Date()) + ",更新定时生成拼音系统参数异常：" + e.getMessage());
		}
		log.info(String.format("线程名称: {%s},执行任务-委托单位生成拼音定时任务，耗时：%sms", Thread.currentThread().getName(), DateUtil.getTimeDifferenceMs(d1, new Date())));

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
		Runnable runnable = () -> generatorLetter();
		//任务触发器,重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		//注册定时任务
		putSchedule(runnable, trigger, taskId);
		if (scheduledFutureMap.get(taskId) == null) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("定时任务已关闭，重启失败！");
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
		Runnable runnable = () -> generatorLetter();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
/*	@Bean
	public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
		ThreadPoolTaskScheduler threadPoolTaskScheduler=new ThreadPoolTaskScheduler();
		threadPoolTaskScheduler.initialize();
		return threadPoolTaskScheduler;
	}*/

/*	@RequestMapping("/start")
	public void setCron() {
		// stopCron();
		future = threadPoolTaskScheduler().schedule(new Runnable() {
			@Override
			public void run() {
				generatorLetter();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = scheduledService.selectById(10);// 根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
				Date nextExecutor = null;
				// 如果查询结果为null，则不执行以下代码，防止定时器报空指针异常
				if (scheduled != null) {
					CronTrigger trigger = new CronTrigger(scheduled.getScheduled());
					System.out.println("cron2:" + scheduled.getScheduled());
					nextExecutor = trigger.nextExecutionTime(triggerContext);
				}
				return nextExecutor;
			}
		});
	}

	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegister) {
		taskRegister.addTriggerTask(new Runnable() {
			@Override
			public void run() {
				generatorLetter();
			}
		}, new Trigger() {
			@Override
			public Date nextExecutionTime(TriggerContext triggerContext) {
				// 任务触发，可修改任务的执行周期
				Scheduled scheduled = scheduledService.selectById(10);// 根据定时器的ID查询未删除并且在启用状态下定时器的间隔时间
				Date nextExecutor = null;
				// 如果查询结果为null，则不执行以下代码，防止定时器报空指针异常
				if (scheduled != null) {
					CronTrigger trigger = new CronTrigger(scheduled.getScheduled());
					System.out.println("cron:" + scheduled.getScheduled());
					nextExecutor = trigger.nextExecutionTime(triggerContext);
				}
				return nextExecutor;
			}
		});
	}*/
}
