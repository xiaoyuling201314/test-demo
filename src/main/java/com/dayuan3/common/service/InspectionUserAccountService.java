package com.dayuan3.common.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.model.BaseModel;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.terminal.bean.Income;
import org.springframework.transaction.annotation.Transactional;

/**
 * Description 送检用户账户
 * @Author xiaoyl
 * @Date 2025/7/4 9:19
 */
public interface InspectionUserAccountService extends IService<InspectionUserAccount> {


	/**
	 * 用户充值/支出，更新余额表和交易流水表
	 * 
	 * @description
	 * @param bean
	 * @param flow
	 * @return
	 * @author xiaoyl
	 * @date 2019年10月28日
	 */
	public int saveUserAccount(InspectionUserAccount bean, AccountFlow flow);
	/**
	 * 根据用户ID查找账号信息
	 * @description
	 * @param userId
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	public InspectionUserAccount queryAccountByUserId(Integer userId);
	
	
	
	/**
	 *  微信端 充值、支付 状态更新
	 * @param flowId 交易流水id
	 * @throws Exception
	 */
	public Boolean updateUserAccount(Integer flowId,Integer samplingId,String openId,String payNumber,int takeSamplingMoney,int printingFee,int checkMoney) throws Exception;

	/**
	 * 	支付时更新余额账户
	 * @description
	 * @param record
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	public int updateBanalceForPay(InspectionUserAccount record);

	/**
	 * 	充值更新余额账户-版本控制
	 * @description
	 * @param record
	 * @return
	 * @author shit
	 * @date   2019年11月20日
	 */
	public int updateBanalceForRecharge2(InspectionUserAccount record);

	/**
	 * 	支付时更新余额账户-版本控制
	 * @description
	 * @param record
	 * @return
	 * @author shit
	 * @date   2019年11月20日
	 */
	public int updateBanalceForPay2(InspectionUserAccount record);

	/**
	 * 数据列表分页方法
	 *
	 * @param page 分页参数
	 * @return 列表
	 */
	public Page loadDatagrid(Page page, BaseModel t) throws Exception;

	public int updateBanalceForRecharge(InspectionUserAccount record);

	@Transactional
	public Boolean updateUserAccount2(Income income,AccountFlow flow, Integer samplingId, String openId, String payNumber) throws Exception;

}
