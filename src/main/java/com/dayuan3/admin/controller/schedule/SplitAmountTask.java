package com.dayuan3.admin.controller.schedule;

import com.alibaba.fastjson.JSON;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.controller.schedule.MyScheduledConfig;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.DateUtil;
import com.dayuan3.admin.bean.SplitAmount;
import com.dayuan3.admin.bean.SplitMember;
import com.dayuan3.admin.service.SplitAmountService;
import com.dayuan3.admin.service.SplitMemberService;
import com.dayuan3.api.common.ErrCode;
import com.dayuan3.api.common.MallBookUtil;
import com.dayuan3.api.common.MiniProgramException;
import com.dayuan3.api.common.MiniProgramJson;
import com.dayuan3.api.vo.pay.SplitAmountReqVO;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import com.trhui.mallbook.common.utils.JsonUtil;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.response.hf.HfCompleteResponse;
import com.trhui.mallbook.domain.response.trade.PaymentQueryResponse;
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
 * Description 定时分账任务
 * @Author xiaoyl
 * @Date 2025/7/19 15:40
 */
@Lazy(false)
@RestController
@EnableScheduling
@RequestMapping("/splitAmountTask")
public class SplitAmountTask extends MyScheduledConfig {

	Integer taskId = 104;//定时器任务ID
	@Autowired
	private IncomeService incomeService;
	@Autowired
	private SplitAmountService splitAmountService;

	@Autowired
	private SplitMemberService splitMemberService;

	public void splitAmountWork() {
		try {
			//1.查询近3天所有待分账的交易订单
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_YEAR, -3);
			List<Income> list = incomeService.queryAllSplitOrder(cal.getTime());
			if (list.size() > 0) {
				List<SplitMember> allSplitMembers=splitMemberService.querySplitMember();
				int splitCount=allSplitMembers.size();
				log.info("待分账订单数量：" + list.size() + "，分账方数量：" + splitCount);
				if(splitCount==0){
					throw new MiniProgramException(ErrCode.DATA_NOT_FOUND,null,"分账方数量为0，请联系管理员配置！");
				}
				// 分账接口最多支持7个分账方，所以每7个分账方为一组进行处理
				for (int i = 0; i < splitCount; i += 7) {
					int endIndex = Math.min(i + 7, splitCount);
					List<SplitMember> currentSplitMembers = allSplitMembers.subList(i, endIndex);
					for (Income bean : list) {
						SplitAmountReqVO splitAmountReqVO = new SplitAmountReqVO(bean.getNumber(), GeneratorOrder.generateSplitNo("A"), bean.getMoney(), currentSplitMembers);
						BaseResponse<HfCompleteResponse> response = MallBookUtil.splitAmount(splitAmountReqVO);
						HfCompleteResponse result = response.getData();
						Date now = new Date();
						SplitAmount splitAmount = new SplitAmount(splitAmountReqVO.getMerOrderId(), bean.getNumber(), splitAmountReqVO.getSplitMoney(), (short) 0, now, (short) 0, now);
						if (response.success()) {
							splitAmount.setSplitJson(result.getParameter1());
							log.info(String.format("交易单号【%s】分账申请成功:%s", bean.getNumber(), JsonUtil.toJsonStr(response.getData())));
						} else {
							splitAmount.setStatus((short) 2);
							splitAmount.setRemark(response.getMsg());
							log.error(String.format("交易单号【%s】分账申请失败:%s", bean.getNumber(), response.getMsg()));
						}
						splitAmountService.save(splitAmount);
					}
				}
			}
			log.info(String.format("----定时分账任务执行成功---%s,待分账定数量：%d---END",DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"),list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			log.error("定时分账任务执行异常：******************************" + e.getMessage() + e.getStackTrace());
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
		Runnable runnable = () -> splitAmountWork();
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
		Runnable runnable = () -> splitAmountWork();
		//任务触发器,任务执行完之后重新查询数据库任务状态，如果变成删除则取消定时任务
		Trigger trigger = getTrigger(taskId);
		putSchedule(runnable, trigger, taskId);
	}
}
