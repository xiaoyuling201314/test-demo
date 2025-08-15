package com.dayuan3.terminal.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dayuan.bean.Page;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.model.BaseModel;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.model.IncomeModel;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @author Dz
 * @description 针对表【income】的数据库操作Service
 * @createDate 2025-07-02 15:58:46
 */
public interface IncomeService extends IService<Income> {

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
     * 更新财务明细和抽样单状态信息
     *
     * @description
     * @param income
     * @param user
     * @param payMethod 付款方式：0 微信，1支付宝
     * @return
     * @throws MissSessionExceprtion
     * @author xiaoyl
     * @date 2019年7月8日
     */
//	@Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
//	int payMentForOrder(Income income,InspectionUnitUser user,short status,short payMethod);

    /**
     * 更新财务明细和抽样单状态信息
     *
     * @param income
     * @param user
     * @param status    订单状态:0_暂存,1_待支付,2_已完成,3_取消
     * @param payMethod 付款方式：0 微信，1支付宝,2余额
     * @return
     * @throws MissSessionExceprtion
     * @description
     * @author xiaoyl
     * @date 2019年7月8日
     */
    int payMentForOrder(Income income, InspectionUnitUser user, short status, short payMethod);

    /**
     * 根据订单ID获取已付款订单
     *
     * @param id
     * @return
     */
    Income queryPaymentOrder(Integer id);

    ;

    /**
     * 微信端根据订单id查询
     *
     * @return
     */
    Income selectBySamplingId(Integer id,String incNumber,Short transactionType);

    ;

    /**
     * 微信端根据订单id删除废记录
     *
     * @return
     */
    void deleteBySamplingId(Integer id);

    /**
     * 收费汇总
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    List<IncomeModel> loadDatagridForStatistics(Page page);

    /**
     * 收费汇总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    int getRowTotalForStatistics(Page page);

    /**
     * 收费汇总
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    List<Income> loadDatagridForIncome(Page page);

    /**
     * 收费汇总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    int getRowTotalForIncome(Page page);

    /**
     * 根据微信商户订单号查询订单 2019-8-7 huht
     *
     * @param number
     * @param orderPlatform 下单方式 0 自助终端，1 公众号
     * @return
     */
    Income selectByNumber(String number, int orderPlatform);

    /**
     * 根据商户订单号查询订单 ,因为可能出现不同支付方式同时支付导致出现重复收费的情况，
     * 所以根据商户订单号可能出现1-3个交易记录
     *
     * @param sampleId 抽样单Id
     * @param number   商户单号
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年11月12日
     */
    List<Income> queryListByNumber(Integer sampleId, String number);

    /**
     * 写入交易流水表和余额交易流水表
     *
     * @param income
     * @param flow
     * @return
     * @throws MissSessionExceprtion
     * @description
     * @author xiaoyl
     * @date 2019年10月29日
     */
    int saveIncomeAndFlow(Income income, AccountFlow flow, InspectionUnitUser user)
            throws MissSessionExceprtion;

    /**
     * 取消充值
     *
     * @param bean
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年10月29日
     */
    int cancelRechargeOrder(Integer incomeId, InspectionUnitUser user, HttpServletRequest request);

    /**
     * 取消支付
     *
     * @param bean
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年10月29日
     */
    int cancelPayOrder(Income bean, InspectionUnitUser user,  HttpServletRequest request);

    /**
     * 根据商户订单号和支付类型查询交易信息，用于判断是否重复回调，避免写入多条重复支付数据
     *
     * @param number  商户订单号
     * @param payType 支付类型0微信，1支付宝，2余额
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年11月13日
     */
    int queryUniqueByNumber(String number, short payType);

    /**
     * 后台操作修改余额
     *
     * @param income 此处的ID为 送检用户余额表 inspection_user_account.id
     * @return
     * @remark transactionType费用类型(0_检测费用, 1_打印费用, 2_充值费用, 3_订单退款, 4_充值退款, 5增加余额, 6减少余额)
     */
    void addOrUpdateMoney(Income income) throws Exception;


    /**
     * 操作金额方法，目前没有地方调用
     *
     * @param account
     * @param changeMoney
     * @param transactionType
     * @throws Exception
     */
    void changeMoney(InspectionUserAccount account, int changeMoney, Short transactionType) throws Exception;
    
    /**
     * 查询用户可开票订单
     * @param userId 用户id
     * @param start 开始时间
     * @param end 结束时间
     * @param rowStart 
     * @param rowEnd
     * @return
     */
    List<Income> queryInvoiceList(Integer userId,String start,String end,Integer rowStart,Integer rowEnd);
    
    /**
     * 获取多个income的总金额
     * @param ids
     * @return
     */
    Double queryIncomeListMoney(String[] ids);

    String queryBySamplingId(Integer orderId);
    /**
     * Description 查询近3天所有待分账的交易订单
     * @Author xiaoyl
     * @Date 2025/7/19 16:55
     */
    List<Income> queryAllSplitOrder(Date start);
}
