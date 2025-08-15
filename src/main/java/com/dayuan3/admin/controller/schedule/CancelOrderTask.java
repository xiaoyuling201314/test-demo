package com.dayuan3.admin.controller.schedule;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.controller.schedule.MyScheduledConfig;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.DateUtil;
import com.dayuan3.api.common.MallBookUtil;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import com.dayuan3.terminal.service.ReqUnitStatisticDailyService;
import com.dayuan3.terminal.service.ReqUnitStatisticMonthlyService;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.response.trade.PaymentQueryResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Description 定时取消订单
 * @Author xiaoyl
 * @Date 2025/7/9 21:22
 */
@Lazy(false)
@RestController
@EnableScheduling
@RequestMapping("/cancelOrderTask")
public class CancelOrderTask extends MyScheduledConfig {

	Integer taskId = 19;//定时器任务ID
	@Autowired
	private IncomeService incomeService;
	@Autowired
	private TbSamplingService tbSamplingService;

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

	public void updateSamplingStatus() {
		try {
			//1.查询所有超时未支付的订单信息以及income表的交易信息，有预支付信息的订单前往支付后台进行核实确定未支付才能取消该订单
			Date d = getBeforHour(-1);
			List<TbSampling> list = tbSamplingService.queryAllTimeOutOrder(d);
			if (list.size() > 0) {//有超时待支付订单，进行进一步查询
				for (TbSampling bean : list) {
					if (null!=bean.getPayStatus() && bean.getPayStatus() == 0) {
						//前往汇付后台查询订单是否支付成功，若支付成功则更新交易状态和订单状态
						queryPayStatus(bean);
					}
				}
			}
			//更新交易记录和超时未支付订单状态信息
			tbSamplingService.UpdateByOrderStatus(getBeforHour(-1));
			log.info("----定时删除未及时支付订单成功---" + DateUtil.formatDate(getBeforHour(-1), "yyyy-MM-dd HH:mm:ss") + "---END");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("定时删除未及时支付订单异常：******************************" + e.getMessage() + e.getStackTrace());
		}
	}
	/**
	 * 前往支付后台查询是否支付成功
	 *
	 * @param bean
	 * @description
	 * @author xiaoyl
	 * @date 2020年3月20日
	 */
	public void queryPayStatus(TbSampling bean) {
		try {
			int payResult=0;// 0：待处理；1：成功；2：失败3：已取消
			Income income=incomeService.selectBySamplingId(bean.getId(),null,(short)0);
			BaseResponse<PaymentQueryResponse> result= MallBookUtil.queryOrder(income.getNumber(),"1");
			PaymentQueryResponse queryObj= result.getData();
			//0：待处理；1：成功；2：失败 3：已取消,关单成功后状态会更新为已取消。
			payResult=Integer.valueOf(queryObj.getStatus());
			if(payResult==1){
				income.setStatus((short)payResult);
				//支付成功，更新订单状态
				tbSamplingService.paid(bean.getId());
			}else{
				//取消订单
				income.setStatus((short)3);
				bean.setOrderStatus(4);
				tbSamplingService.updateById(bean);
			}
			if (payResult!=0 && payResult!=9) {//9 对应预下单的状态,0和 9 都可以当待处理处理
				income.setUpdateDate(new Date());
				if(payResult==1){
					//官方商户订单号
					income.setPayNumber(queryObj.getPartyOrderId());
					//官方订单号
					income.setParam1(queryObj.getOutTransId());
					//渠道订单号
					income.setParam2(queryObj.getChannelOrderId());
				}
				incomeService.updateById(income);
			}
			log.info(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss") + "微信支付状态查询完成，订单号为：" + bean.getOrderNumber() + "查询结果为：" + JSON.toJSON(queryObj));
		} catch (Exception e) {
			log.error(DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss") + "定时器查询支付状态异常!" + e.getMessage());
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
	public AjaxJson setCron() {
		AjaxJson ajaxJson = new AjaxJson();
		//根据定时任务ID查询任务是否开启，开启才添加到定时任务中
		Runnable runnable = () -> updateSamplingStatus();
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
		Runnable runnable = () -> updateSamplingStatus();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
}
