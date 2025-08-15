package com.dayuan3.common.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.terminal.model.BalanceModel;

import java.util.List;

public interface InspectionUserAccountMapper extends BaseMapper<InspectionUserAccount> {
	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<BalanceModel> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);

	InspectionUserAccount queryAccountByUserId(Integer userId);
	/**
	 * 	充值更新余额账户
	 * @description
	 * @param record
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	int updateBanalceForRecharge(InspectionUserAccount record);

	/**
	 * 	支付时更新余额账户
	 * @description
	 * @param record
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	int updateBanalceForPay(InspectionUserAccount record);

	/**
	 * 	充值更新余额账户-版本控制
	 * @description
	 * @param record
	 * @return
	 * @author shit
	 * @date   2019年11月20日
	 */
	int updateBanalceForRecharge2(InspectionUserAccount record);

	/**
	 * 	支付时更新余额账户-版本控制
	 * @description
	 * @param record
	 * @return
	 * @author shit
	 * @date   2019年11月20日
	 */
	int updateBanalceForPay2(InspectionUserAccount record);
}