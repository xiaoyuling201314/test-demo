package com.dayuan3.common.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dayuan.bean.Page;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.model.AccountFlowModel;
import com.dayuan3.terminal.model.FlowModel;

import java.util.List;

public interface AccountFlowMapper extends BaseMapper<AccountFlow> {

	/**
	 * 查询分页数据列表
	 * @param page
	 * @return
	 */
	List<AccountFlowModel> loadDatagrid(Page page);

	/**
	 * 查询记录总数量
	 * @param page
	 * @return
	 */
	int getRowTotal(Page page);
	/**
	 * 根据流水Id查找余额交易信息
	 * @description
	 * @param id
	 * @return
	 * @author xiaoyl
	 * @date   2019年10月29日
	 */
	AccountFlow queryByIncomeId(Integer id);
	/**
	 * 更新余额交易记录
	 * @description
	 * @param flow
	 * @return
	 * @author xiaoyl
	 * @date   2019年11月2日
	 */
	int updateAccountFlow(AccountFlow flow);

	/**
	 * 余额流水分页查询
	 * @param page
	 * @return
	 */
	List<FlowModel> loadDatagridBalance(Page page);
	/**
	 * 余额流水分页查询
	 * @param page
	 * @return
	 */
	int getRowTotalBalance(Page page);

}