package com.dayuan3.common.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.exception.MyException;
import com.dayuan.model.BaseModel;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.controller.CommonDataController;
import com.dayuan3.common.mapper.AccountFlowMapper;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.bean.TopupActivities;
import com.dayuan3.terminal.bean.TopupActivitiesDetail;
import com.dayuan3.terminal.service.IncomeService;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * 余额交易流水
 *
 * @author xiaoyl
 * @date 2019年10月28日
 */
@Service
public class AccountFlowServiceImpl extends ServiceImpl<AccountFlowMapper, AccountFlow> implements AccountFlowService {
    @Autowired
    private IncomeService incomeService;

    @Override
    public AccountFlow queryByIncomeId(Integer incomeId) {
        return getBaseMapper().queryByIncomeId(incomeId);
    }

    @Override
    public int updateAccountFlow(AccountFlow flow) {
        return getBaseMapper().updateAccountFlow(flow);
    }

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
    public Page loadDatagrid(Page page, BaseModel t, Class c, String loadDatagridMethod, String getRowTotalMethod) throws Exception {
        Object bean = ContextHolderUtils.getBean(c);

        //获取查询列表数据方法
        Method m1 = c.getDeclaredMethod(loadDatagridMethod, Page.class);
        //获取查询记录总数方法
        Method m2 = c.getDeclaredMethod(getRowTotalMethod, Page.class);

        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal((Integer) m2.invoke(bean, page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
        }

        List<T> dataList = (List<T>) m1.invoke(bean, page);
        page.setResults(dataList);
        return page;
    }

    /**
     * 微信端添加预支付交易流水
     *
     * @param type 0充值 1余额支付
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public AccountFlow insertFlow(Integer type, InspectionUnitUser user, Integer money, String No, String prepay_id, String activitieUuid, Integer samplingId, String remark) throws Exception {
        AccountFlow bean = new AccountFlow();
        Income income = new Income();
        if (type == 0) {//充值
            //充值订单
            income.setNumber(No);
            income.setPayNumber(prepay_id); //预支付标识先暂存流水号字段 支付成功后替换为 流水号
            income.setSamplingId(null);
            income.setPayType((short) 0);
            income.setTransactionType((short) 2);//充值费用
            income.setMoney(money);
            income.setStatus((short) 0);
            income.setOrderPlatform((short) 1);
            Date now = new Date();
            income.setCreateDate(now);
            income.setUpdateDate(now);
            if (income.getCheckMoney() == null) {
                income.setCheckMoney(0.0);
            }
            income.setCreateBy(user.getId().toString());
            income.setUpdateBy(user.getId().toString());
            incomeService.save(income);//预支付信息存入流水表
            //处理余额交易流水
            bean.setIncomeId(income.getId());
            bean.setMoney(money);
            bean.setFlowState((short) 1);//充值
            bean.setStatus((short) 0);//交易状态待支付
            bean.setCreateDate(now);
            bean.setCreateBy(user.getId().toString());
            bean.setUpdateDate(now);
            bean.setUpdateBy(user.getId().toString());
            if (StringUtil.isNotEmpty(remark)) {
                bean.setRemark(remark);
            }
            getBaseMapper().insertOrUpdate(bean);

        } else {//余额支付

            income.setNumber(No);
            income.setPayNumber(No);
            income.setSamplingId(samplingId);
            income.setPayType((short) 2);//余额
            income.setTransactionType((short) 0);//检测费用费用
            income.setMoney(money);
            income.setStatus((short) 0);
            income.setOrderPlatform((short) 1);
            Date now = new Date();
            income.setCreateDate(now);
            income.setUpdateDate(now);
            if (income.getCheckMoney() == null) {
                income.setCheckMoney(0.0);
            }
            income.setCreateBy(user.getId().toString());
            income.setUpdateBy(user.getId().toString());
            incomeService.save(income);//预支付信息存入流水表
            //处理余额交易流水
            bean.setIncomeId(income.getId());
            bean.setMoney(money);
            bean.setFlowState((short) 0);//支付
            bean.setStatus((short) 0);//交易状态待支付
            bean.setCreateDate(now);
            bean.setCreateBy(user.getId().toString());
            bean.setUpdateDate(now);
            bean.setUpdateBy(user.getId().toString());
            getBaseMapper().insertOrUpdate(bean);

        }

        return bean;


    }


    public List<TopupActivitiesDetail> sort(List<TopupActivitiesDetail> list) {
        Collections.sort(list, new Comparator<TopupActivitiesDetail>() {

            @Override
            public int compare(TopupActivitiesDetail u1, TopupActivitiesDetail u2) {
                if (u1.getActualMoney().compareTo(u2.getActualMoney()) == 1) {
                    return 1;
                }
                if (u1.getActualMoney() == u2.getActualMoney()) {
                    return 0;
                }
                return -1;
            }
        });
        System.out.println("升序排序后：" + list);
        return list;
    }


}
