package com.dayuan3.common.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.exception.MyException;
import com.dayuan.model.BaseModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.StringUtil;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.common.mapper.AccountFlowMapper;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.service.IncomeService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * Description  余额交易流水
 *
 * @Author xiaoyl
 * @Date 2025/7/3 16:17
 */
public interface AccountFlowService extends IService<AccountFlow> {

    /**
     * 数据列表分页方法
     *
     * @param page               分页
     * @param t                  条件参数
     * @param c                  查询方法的类
     * @param loadDatagridMethod 查询列表数据方法
     * @param getRowTotalMethod  查询记录总数方法
     * @return
     * @throws Exception
     */
    public Page loadDatagrid(Page page, BaseModel t, Class c, String loadDatagridMethod, String getRowTotalMethod) throws Exception;

    /**
     * 微信端添加预支付交易流水
     *
     * @param type 0充值 1余额支付
     */
    public AccountFlow insertFlow(Integer type, InspectionUnitUser user, Integer money, String No, String prepay_id, String activitieUuid, Integer samplingId, String remark) throws Exception;

    public AccountFlow queryByIncomeId(Integer incomeId);

    public int updateAccountFlow(AccountFlow flow);

}
