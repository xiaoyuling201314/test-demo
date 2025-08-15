package com.dayuan3.terminal.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.bean.system.TSUser;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MissSessionExceprtion;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.sampling.TbSamplingMapper;
import com.dayuan.model.BaseModel;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.StringUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.mapper.InspectionUnitUserMapper;
import com.dayuan3.admin.service.InspectionUnitUserService;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.mapper.IncomeMapper;
import com.dayuan3.terminal.model.IncomeModel;
import com.dayuan3.terminal.service.IncomeService;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.List;

/**
* @author Dz
* @description 针对表【income】的数据库操作Service实现
* @createDate 2025-07-02 15:58:46
*/
@Service
public class IncomeServiceImpl extends ServiceImpl<IncomeMapper, Income>
    implements IncomeService {

    @Autowired
    private TbSamplingMapper samplingMapper;
    @Autowired
    private InspectionUserAccountService accountService;
    @Autowired
    private AccountFlowService flowService;
    @Autowired
    private InspectionUnitUserMapper userMapper;
    @Autowired
    private InspectionUnitUserService inspectionUnitUserService;



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
//	public int payMentForOrder(Income income,InspectionUnitUser user,short status,short payMethod){
//		try {
//			Date now=new Date();
//			if (user!=null){
//				income.setUpdateBy(String.valueOf(user.getId()));
//			}
//			income.setUpdateDate(now);
//			int count=mapper.updateByPrimaryKeySelective(income);
//			TbSampling bean= samplingMapper.selectByPrimaryKey(income.getSamplingId());
//			bean.setOrderStatus(status);
//			if (user!=null){
//				bean.setUpdateBy(String.valueOf(user.getId()));
//			}
//			bean.setUpdateDate(now);
//			bean.setPayDate(income.getPayDate());
//			bean.setPayMethod(payMethod);// add by xiaoyul 2019-10-11 付款成功后更新付款方式至订单表张中
//			count =samplingMapper.updateByPrimaryKeySelective(bean);
//			return count;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return 0;
//	}

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
    @Override
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public synchronized int payMentForOrder(Income income, InspectionUnitUser user, short status, short payMethod) {
        Date now = new Date();
        InspectionUserAccount account = null;
        AccountFlow flow = null;
        int count = 0;
        //1.更新交易流水信息
        if (user == null) {
            if(StringUtil.isNotEmpty(income.getCreateBy())) {//登录系统操作时获取用户信息
                user = userMapper.selectByPrimaryKey(Integer.valueOf(income.getCreateBy()));
            }else {//未登录打印获取用户信息
                TbSampling sampling=samplingMapper.selectById(income.getSamplingId());
                user = userMapper.selectByPrimaryKey(Integer.valueOf(sampling.getCreateBy()));
            }
        }
        income.setUpdateBy(user.getId().toString());
        income.setUpdateDate(now);
        count = getBaseMapper().updateById(income);
        if (income.getTransactionType() != 2) {// 微信/支付宝/余额支付费用
            // 2.订单支付成功，更新订单信息，支付打印费用的时候不更新
            TbSampling bean = samplingMapper.selectById(income.getSamplingId());
            if(income.getTransactionType()==0) {
//        		bean.setOrderStatus(status);
//        		bean.setUpdateBy(String.valueOf(user.getId()));
//        		bean.setUpdateDate(now);
//        		bean.setPayDate(income.getPayDate());
//        		bean.setPayMethod(payMethod);// add by xiaoyul 2019-10-11 付款成功后更新付款方式至订单表张中
                count += samplingMapper.updateById(bean);
            }else if(income.getTransactionType()==1) {//更新订单主表打印次数和费用
//        		Integer printNumber = bean.getPrintNum() == null ? 1 : bean.getPrintNum() + 1;
//        		double printingFee =bean.getPrintingFee() + income.getMoney();
//        		bean.setPrintingFee(printingFee);
//        		bean.setPrintNum(printNumber.shortValue());
//        		bean.setUpdateDate(new Date());
                count +=samplingMapper.updateById(bean);
            }
            if (income.getPayType() == 2) {// 余额支付，更新余额表和余额交易流水表
                flow = flowService.queryByIncomeId(income.getId());
                if (flow.getStatus() == 0) {//待支付状态
                    account = accountService.queryAccountByUserId(user.getId());
                    int overage;// 扣除金额
                    if (account.getActualMoney()>(income.getMoney()+income.getReportMoney())) {// 直接余额支付
                        overage =income.getMoney()+income.getReportMoney();
                        account.setActualMoney(overage);
                        account.setGiftMoney(0);
                    } else if (account.getActualMoney()== 0) {// 账号充值余额为0；直接扣赠送金额
                        overage = income.getMoney()+income.getReportMoney();
                        account.setGiftMoney(overage);
                    } else {// 账号充值余额<待支付金额，采取充值金额+赠送金额支付的方式
                        overage = income.getMoney()+income.getReportMoney()-account.getActualMoney();
                        account.setActualMoney(account.getActualMoney());
                        account.setGiftMoney(overage);
                    }
                    // 3.更新账户余额
                    account.setUpdateDate(now);
                    count += accountService.updateBanalceForPay(account);
                    // 4.更新余额交易记录
                    flow.setStatus((short) 1);
                    flow.setUpdateBy(user.getId().toString());
                    flow.setUpdateDate(now);
                    flow.setPayDate(income.getPayDate());
                    count += flowService.updateAccountFlow(flow);
                    if (user.getOpenId() != null) {//微信公众号推送消息
                        flow = flowService.getById(flow.getId());
                        try {
                           /* if(income.getTransactionType()==0) {
                                wxPayService.sendDealMsg(1, user.getOpenId(), flow.getMoney(), flow.getGiftMoney(), flow.getBalance(), income.getPayNumber(), now, null, null,flow.getIncomeId());
                            }else if(income.getTransactionType()==1) {//打印费用
                                wxPayService.sendDealMsg(2, user.getOpenId(), flow.getMoney(), flow.getGiftMoney(), flow.getBalance(), income.getPayNumber(), now, null, null,flow.getIncomeId());
                            }*/
                        } catch (Exception e) {
                            System.out.println("消息推送失败"+e.getMessage());
                        }
                    }
                }
            } else {// 在线支付，关闭余额交易记录表
                flow = flowService.queryByIncomeId(income.getId());
                if (flow != null && flow.getStatus() == 0) {//待支付状态
                    flow.setStatus((short) 3);
                    flow.setUpdateBy(user.getId().toString());
                    flow.setUpdateDate(now);
                    flowService.saveOrUpdate(flow);
                    count +=1;
                }
            }
        } else {// 余额充值
            // 1.更新账户表
            flow = flowService.queryByIncomeId(income.getId());
            account = accountService.queryAccountByUserId(user.getId());
         /*   if (flow.getStatus() == 0 || account == null) {//待支付状态
                if (account == null) {// 首次充值
                    account = new InspectionUserAccount(user.getId(), new BigDecimal(income.getMoney()),
                            flow.getGiftMoney(), 1, now, user.getId().toString(), now,now);
                    account.setTotalMoney(account.getActualMoney().add(account.getGiftMoney()));
                    count += accountService.insertSelective(account);
                } else {// 非首次充值
                    account.setRechargeCount(1);// 充值叠加次数，自动加1
                    account.setActualMoney(flow.getMoney());// 充值金额
                    account.setGiftMoney(flow.getGiftMoney());// 赠送金额
                    account.setUpdateDate(now);
                    count += accountService.updateBanalceForRecharge(account);
                }
                // 2.更新余额交易记录
                flow.setStatus((short) 1);
                flow.setUpdateBy(user.getId().toString());
                flow.setUpdateDate(now);
                flow.setPayDate(income.getPayDate());
                count += flowService.updateAccountFlow(flow);
                if (user.getOpenId() != null) {//微信公众号推送消息
                    flow = flowService.getById(flow.getId());
                    try {
                        wxPayService.sendDealMsg(0, user.getOpenId(), flow.getMoney(), flow.getGiftMoney(), flow.getBalance(), income.getPayNumber(), now, null, null,flow.getIncomeId());
                    } catch (Exception e) {
                        System.out.println("消息推送失败"+e.getMessage());
                    }
                }
            }*/
        }
        return count;
    }

    /**
     * 根据订单ID获取已付款订单
     *
     * @param id
     * @return
     */
    @Override
    public Income queryPaymentOrder(Integer id) {
        return getBaseMapper().queryPaymentOrder(id);
    }

    /**
     * 微信端根据订单id查询
     *
     * @return
     */
    @Override
    public Income selectBySamplingId(Integer id, String incNumber, Short transactionType) {
        return getBaseMapper().selectBySamplingId(id,incNumber,transactionType);

    }

    /**
     * 微信端根据订单id删除废记录
     *
     * @return
     */
    @Override
    public void deleteBySamplingId(Integer id) {

        getBaseMapper().deleteBySamplingId(id);

    }

    /**
     * 收费汇总
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    @Override
    public List<IncomeModel> loadDatagridForStatistics(Page page) {
        List<IncomeModel> list = getBaseMapper().loadDatagridForStatistics(page);
        if (list != null && list.size() > 0) {
            for (IncomeModel incomeModel : list) {
                double d = incomeModel.getCheckMoney() + incomeModel.getPrintMoney();
                incomeModel.setTotal(d);
            }
        }
        return list;
    }

    /**
     * 收费汇总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    @Override
    public int getRowTotalForStatistics(Page page) {
        return getBaseMapper().getRowTotalForStatistics(page);
    }

    /**
     * 收费汇总
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    @Override
    public List<Income> loadDatagridForIncome(Page page) {
        return getBaseMapper().loadDatagridForIncome(page);
    }

    /**
     * 收费汇总数量
     *
     * @param page
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年7月31日
     */
    @Override
    public int getRowTotalForIncome(Page page) {
        return getBaseMapper().getRowTotalForIncome(page);
    }

    /**
     * 根据微信商户订单号查询订单 2019-8-7 huht
     *
     * @param number
     * @param orderPlatform 下单方式 0 自助终端，1 公众号
     * @return
     */
    @Override
    public Income selectByNumber(String number, int orderPlatform) {
        return getBaseMapper().selectByNumber(number, orderPlatform);

    }

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
    @Override
    public List<Income> queryListByNumber(Integer sampleId, String number) {
        return getBaseMapper().queryListByNumber(sampleId, number);

    }

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
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public int saveIncomeAndFlow(Income income, AccountFlow flow, InspectionUnitUser user)
            throws MissSessionExceprtion {
        // 1.写入交易流水表
        Date d = new Date();
        int count = 0;
        if (user != null) {
            income.setCreateBy(user.getId().toString());
        }
        income.setCreateDate(d);
        income.setUpdateDate(d);
        count = getBaseMapper().insert(income);
        // 2.写入余额交易流水表
        if (count > 0 && flow != null) {
            flow.setStatus((short) 0);
            flow.setIncomeId(income.getId());
            if (user != null) {
                flow.setCreateBy(user.getId().toString());
            }
            flow.setCreateDate(d);
            flow.setUpdateDate(d);
             flowService.saveOrUpdate(flow);
            count+=1;
        }
        return count;
    }

    /**
     * 取消充值
     *
     * @param bean
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年10月29日
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public int cancelRechargeOrder(Integer incomeId, InspectionUnitUser user, HttpServletRequest request) {
        Income bean = getBaseMapper().selectById(incomeId);
        int count = 0;
        Date d = new Date();
        // 2.取消交易流水表
        bean.setStatus((short) 3);
        if (user != null) {
            bean.setUpdateBy(String.valueOf(user.getId()));
        }
        bean.setUpdateDate(d);
        count += getBaseMapper().updateById(bean);
        // 3.取消余额交易信息
        AccountFlow flow = flowService.queryByIncomeId(bean.getId());
        flow.setStatus((short) 3);
        flow.setUpdateBy(String.valueOf(user.getId()));
        flow.setUpdateDate(d);
        flowService.updateById(flow);
        count +=1;
        return count;
    }

    /**
     * 取消支付
     *
     * @param bean
     * @param cancelOrder 是否取消订单： 0取消，1不取消
     * @return
     * @description
     * @author xiaoyl
     * @date 2019年10月29日
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public int cancelPayOrder(Income bean, InspectionUnitUser user,  HttpServletRequest request) {
        int count = 0;
        Date d = new Date();
        // 1、取消订单：将订单状态修改为已关闭并设置为已删除状态。
        if (bean.getTransactionType() == 0) {//	下单支付检测费用时需要关闭订单状态
            TbSampling sampbean = samplingMapper.selectById(bean.getSamplingId());
//            sampbean.setOrderStatus((short) 3);
            if (user != null) {
                sampbean.setUpdateBy(String.valueOf(user.getId()));
            }
            sampbean.setUpdateDate(d);
            count += samplingMapper.updateById(sampbean);
        }
        // 2. 取消财务流水信息：将预支付信息状态修改为关闭并设置为已删除状态
        bean.setStatus((short) 3);
        if (user != null) {
            bean.setUpdateBy(String.valueOf(user.getId()));
        }
        bean.setUpdateDate(d);
        count += getBaseMapper().updateById(bean);
        // 3.关闭余额交易记录
        AccountFlow flow = flowService.queryByIncomeId(bean.getId());
        if (flow != null) {// 余额支付时，更新余额交易状态
            flow.setStatus((short) 3);
            flow.setUpdateDate(d);
            if (user != null) {
                flow.setUpdateBy(user.getId().toString());
            }
            flowService.updateById(flow);
        }
        return count;
    }

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
    @Override
    public int queryUniqueByNumber(String number, short payType) {
        return getBaseMapper().queryUniqueByNumber(number, payType);

    }


    /**
     * 后台操作修改余额
     *
     * @param income 此处的ID为 送检用户余额表 inspection_user_account.id
     * @return
     * @remark transactionType费用类型(0_检测费用, 1_打印费用, 2_充值费用, 3_订单退款, 4_充值退款, 5增加余额, 6减少余额)
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor=Exception.class)
    public void addOrUpdateMoney(Income income) throws Exception {
        Integer sendType = null;
        Date now = new Date();
        AccountFlow flow = new AccountFlow();//余额交易流水表对象
        Short flowState = null;//流水状态
        int balance = 0;//余额
        //一：生成支付流水表信息
        //表录入字段：订单号 费用类型、下单方式、 收款金额 交易时间 交易状态 备注 被修改用户ID 创建时间，操作用户ID
        InspectionUserAccount account = accountService.getById(income.getId()); //根据ID去查询当前用户的余额信息
        income.setId(null);
        String number = GeneratorOrder.generate(account.getUserId());
        income.setNumber(number);//生成订单号
        income.setPayNumber(number);
        income.setOrderPlatform(new Short("2"));//后台操作
        income.setCreateDate(now);
        income.setUpdateDate(now);
        income.setUpdateBy(income.getCreateBy());
        income.setPayDate(now);
        TSUser sessionUser = PublicUtil.getSessionUser();
        if (sessionUser == null) {
            throw new MyException("操作失败，当前用户未登录！");
        }
        String createUserId = sessionUser.getId();
        income.setCreateUser(createUserId);
        income.setStatus(new Short("1"));//交易状态为 1：支付成功
        income.setRemark(sessionUser.getRealname()+"："+income.getRemark());
        this.save(income);
        //二：修改送检用户余额表金额
        Short transactionType = income.getTransactionType();//拿到费用类型 5：增加金额 6：减少金额
        if (income.getMoney() != null) {
            int changeMoney = income.getMoney();//求得当前需要增加或者减少的金额
            //设置一些基本参数
            account.setUpdateBy(createUserId);
            account.setUpdateDate(now);
            account.setRechargeCount(1);// 充值叠加次数，自动加1
            if (transactionType == 5) {//增加充值赠送的金额
                flowState = 1;
                sendType = 3;
                account.setGiftMoney(changeMoney);
                account.setActualMoney(0);
                accountService.updateBanalceForRecharge(account);
                balance = changeMoney+account.getTotalMoney();
            } else if (transactionType == 6) {//减少充值金额额
                flowState = 0;
                sendType = 4;
                //当需要扣除的金额大于总金额时才能够执行操作
                if (account.getTotalMoney() != null && account.getTotalMoney().compareTo(changeMoney) > -1) {
                    //扣钱的逻辑----start
                    if (account.getActualMoney()>income.getMoney()) {// 直接余额支付
                        account.setActualMoney(changeMoney);
                        account.setGiftMoney(0);
                    } else if (account.getActualMoney()== 0) {// 账号充值余额为0；直接扣赠送金额
                        account.setGiftMoney(changeMoney);
                    } else {// 账号充值余额<待减金额，采取充值金额+赠送金额支付的方式
                        changeMoney = changeMoney-account.getActualMoney();//待减赠送金额=待减金额-账号充值余额
                        account.setActualMoney(account.getActualMoney());
                        account.setGiftMoney(changeMoney);
                    }
                    accountService.updateBanalceForPay(account);
                    balance = account.getTotalMoney()-changeMoney;
                } else {
                    throw new MyException("操作失败，减少金额超出总金额！");
                }
            }

            //三：新增余额交易记录
            flow.setUpdateBy(createUserId);
            flow.setUpdateDate(now);
            flow.setCreateBy(account.getUserId() + "");
            flow.setCreateDate(now);
            flow.setPayDate(now);
            flow.setStatus((short) 1);//交易状态：（待支付、成功、失败、关闭）
            flow.setMoney(changeMoney*100);//交易金额
            flow.setIncomeId(income.getId());//支付流水ID
            flow.setFlowState(flowState);//流水状态
            flow.setBalance(balance*100);//记录余额
            flow.setRemark(income.getRemark());
            flowService.saveOrUpdate(flow);

            //发送微信公众号推送消息
            InspectionUnitUser inspectionUnitUser = inspectionUnitUserService.queryById(account.getUserId());
            String openId = inspectionUnitUser.getOpenId();
            if (openId != null) {//微信公众号推送消息
                try {
//                    wxPayService.sendDealMsg(sendType, openId, changeMoney, null, balance, number, now, null, income.getRemark(),flow.getIncomeId());
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("微信公众号推送失败");
                }
            }
        } else {
            throw new MyException("操作失败，输入金额错误！");
        }
    }


    /**
     * 操作金额方法，目前没有地方调用
     *
     * @param account
     * @param changeMoney
     * @param transactionType
     * @throws Exception
     */
    public void changeMoney(InspectionUserAccount account, int changeMoney, Short transactionType) throws Exception {
        int count = 0;
        if (changeMoney != 0) {
            //设置一些基本参数
            account.setRechargeCount(1);// 充值叠加次数，自动加1
            if (transactionType == 5) {//增加充值赠送的金额
                account.setGiftMoney(changeMoney);
                account.setActualMoney(0);
                count += accountService.updateBanalceForRecharge(account);
            } else if (transactionType == 6) {//减少充值金额额
                //当需要扣除的金额大于总金额时才能够执行操作
                if (account.getTotalMoney() != null && account.getTotalMoney()>changeMoney) {
                    //扣钱的逻辑----start
                    if (account.getActualMoney()>changeMoney) {// 直接余额支付
                        account.setActualMoney(changeMoney);
                        account.setGiftMoney(0);
                    } else if (account.getActualMoney()== 0) {// 账号充值余额为0；直接扣赠送金额
                        account.setGiftMoney(changeMoney);
                    } else {// 账号充值余额<待减金额，采取充值金额+赠送金额支付的方式
                        changeMoney = changeMoney-account.getActualMoney();//待减赠送金额=待减金额-账号充值余额
                        account.setActualMoney(account.getActualMoney());
                        account.setGiftMoney(changeMoney);
                    }
                    count += accountService.updateBanalceForPay(account);
                } else {
                    throw new MyException("操作失败，减少金额超出总金额！");
                }
            }
            if (count <= 0) {
                throw new MyException("操作失败，系统繁忙请稍后再试");
            }
        } else {
            throw new MyException("操作失败，输入金额错误！");
        }
    }

    /**
     * 查询用户可开票订单
     * @param userId 用户id
     * @param start 开始时间
     * @param end 结束时间
     * @param rowStart
     * @param rowEnd
     * @return
     */
    public  List<Income> queryInvoiceList(@Param("userId")Integer userId, @Param("start")String start, @Param("end")String end, @Param("rowStart")Integer rowStart, @Param("rowEnd")Integer rowEnd) {
        return getBaseMapper().queryInvoiceList(userId, start, end, rowStart, rowEnd);
    }

    /**
     * 获取多个income的总金额
     * @param ids
     * @return
     */
    public Double queryIncomeListMoney(@Param("ids")String[] ids) {
        return getBaseMapper().queryIncomeListMoney(ids);
    }

    @Override
    public String queryBySamplingId(Integer orderId) {
        return getBaseMapper().queryBySamplingId(orderId);
    }

    @Override
    public List<Income> queryAllSplitOrder(Date start) {
        return getBaseMapper().queryAllSplitOrder(start);
    }

}




