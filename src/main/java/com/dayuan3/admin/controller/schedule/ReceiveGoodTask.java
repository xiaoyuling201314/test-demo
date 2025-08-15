package com.dayuan3.admin.controller.schedule;

import com.dayuan.bean.AjaxJson;
import com.dayuan.controller.schedule.MyScheduledConfig;
import com.dayuan.util.DateUtil;
import com.dayuan3.admin.bean.SplitAmount;
import com.dayuan3.admin.service.SplitAmountService;
import com.dayuan3.api.common.MallBookUtil;
import com.dayuan3.api.vo.pay.SplitAmountReqVO;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import com.trhui.mallbook.common.utils.JsonUtil;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.response.hf.HfCompleteResponse;
import com.trhui.mallbook.domain.response.hf.HfReceiveResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Description 确认收货任务
 * @Author xiaoyl
 * @Date 2025/7/19 15:40
 */
@Lazy(false)
@RestController
@EnableScheduling
@RequestMapping("/receiveGoodTask")
public class ReceiveGoodTask extends MyScheduledConfig {

	Integer taskId = 105;//定时器任务ID
	@Autowired
	private IncomeService incomeService;
	@Autowired
	private SplitAmountService splitAmountService;

	public void receviedGoodsWork() {
		try {
			//1.查询近3天所有待确认收货的的分账订单
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_YEAR, -3);
			List<SplitAmount> list = splitAmountService.query2ReceivedOrder(cal.getTime());
			if (list.size() > 0) {
				for (SplitAmount bean : list) {
					SplitAmount splitAmount=splitAmountService.queryByNumber(bean.getNumber());
					splitAmount.setReceiveNumber(GeneratorOrder.generateSplitNo("B"));
					BaseResponse<HfReceiveResponse> response =MallBookUtil.receiveGoods(splitAmount);
					if (response.success()){
						log.info(JsonUtil.toJsonStr(response.getData()));
						splitAmount.setReceiveStatus((short)1);
						splitAmount.setReceiveDate(new Date());
						splitAmountService.saveOrUpdate(splitAmount);
						log.info(String.format("分账单号【%s】确认收货:%s",bean.getNumber(),JsonUtil.toJsonStr(response.getData())));
					}else{
						log.error(String.format("分账单号【%s】确认收货失败:%s",bean.getNumber(),response.getMsg()));
					}
				}
			}
			log.info(String.format("----定时确认收货执行成功---%s,确认收货数量：%d---END",DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"),list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			log.error("定时确认收货务执行异常：******************************" + e.getMessage() + e.getStackTrace());
		}
	}
	/**

	/**
	 * @return
	 * @Description 手动开启定时器任务，开启前先判断任务是否取消，未取消则先进行取消操作；
	 * 根据定时任务ID查询任务是否开启，开启才添加到定时任务中
	 * @Date 2023/03/30 15:30
	 * @Author xiaoyl
	 * @Param
	 */
	@RequestMapping("/start")
	public AjaxJson setCron() {
		AjaxJson ajaxJson = new AjaxJson();
		//根据定时任务ID查询任务是否开启，开启才添加到定时任务中
		Runnable runnable = () -> receviedGoodsWork();
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
		Runnable runnable = () -> receviedGoodsWork();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
}
