package com.dayuan3.common.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dayuan.bean.Page;
import com.dayuan.exception.MyException;
import com.dayuan.model.BaseModel;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.mapper.CommonDataMapper;
import com.dayuan3.common.mapper.InspectionUserAccountMapper;
import com.dayuan3.common.service.AccountFlowService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * <p>
 * 送检用户余额表 服务实现类
 * </p>
 *
 * @author xiaoyl
 * @since 2025-07-04
 */
@Service
public class InspectionUserAccountServiceImpl extends ServiceImpl<InspectionUserAccountMapper, InspectionUserAccount> implements InspectionUserAccountService {
    @Autowired
    private InspectionUserAccountService userAccountService;
    @Autowired
    private AccountFlowService accountFlowService;
    @Autowired
    private CommonDataMapper commonDataMapper;
    @Autowired
    private IncomeService incomeService;

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
    @Override
    @Transactional
    public int saveUserAccount(InspectionUserAccount bean, AccountFlow flow) {
        int count = 0;
        InspectionUserAccount model = getBaseMapper().queryAccountByUserId(bean.getUserId());
        if (model == null && flow.getFlowState() == 1) {// 首次充值
            bean.setRechargeCount(1);
            userAccountService.saveOrUpdate(bean);
        }else if(model != null && flow.getFlowState() == 1){// 非首次充值
            bean.setRechargeCount(bean.getRechargeCount() + 1);//充值次数
            bean.setActualMoney(Math.addExact(model.getActualMoney(), bean.getActualMoney()));//充值金额
            bean.setGiftMoney(Math.addExact(model.getGiftMoney(), bean.getGiftMoney()));//赠送金额
            userAccountService.updateById(bean);
        }else if (model!=null && flow.getFlowState() == 0) {// 支出
			if(model.getActualMoney().compareTo(flow.getMoney())>-1) {//实际余额扣款
				bean.setActualMoney(model.getActualMoney()-bean.getActualMoney());
			}else{//实际余额+赠送金额；先从充值金额里扣除，然后再扣除赠送金额
				int  overage;//扣除金额
				if(model.getActualMoney()==0) {//账号充值余额为0
					overage=flow.getMoney();
				}else {//账号充值余额<待支付金额，采取充值金额+赠送金额支付的方式
					overage=flow.getMoney()-model.getActualMoney();
					bean.setActualMoney(0);
				}
				bean.setGiftMoney(model.getGiftMoney()-overage);
			}
			saveOrUpdate(bean);
        }
        //更新交易记录
        flow.setBalance(bean.getActualMoney());//记录余额
        accountFlowService.saveOrUpdate(flow);
        return count;
    }
    /**
     * 根据用户ID查找账号信息
     * @description
     * @param userId
     * @return
     * @author xiaoyl
     * @date   2019年11月2日
     */
    @Override
    public com.dayuan3.common.bean.InspectionUserAccount queryAccountByUserId(Integer userId) {
        return getBaseMapper().queryAccountByUserId(userId);
    }




    /**
     *  微信端 充值、支付 状态更新
     * @param flowId 交易流水id
     * @throws Exception
     */
    @Transactional
    public Boolean updateUserAccount(Integer flowId,Integer samplingId,String openId,String payNumber,int takeSamplingMoney,int printingFee,int checkMoney) throws Exception{
        Boolean deal=true;
       /* AccountFlow flow=accountFlowService.getById(flowId);
        if(flow==null){
            throw new MyException("交易流水异常，查不到交易记录!");
        }
        InspectionUserAccount user=	getBaseMapper().queryAccountByUserId( Integer.parseInt(flow.getCreateBy()));//获取用户账号信息
        if(user==null){//首次使用账号
            //1.开通用户账号
            if(flow.getFlowState()==1){//充值
				user= new InspectionUserAccount();
				user.setUserId(Integer.parseInt(flow.getCreateBy()));
				user.setRechargeCount(1);
				user.setActualMoney(flow.getMoney());
				user.setGiftMoney(flow.getGiftMoney());
				user.setTotalMoney(flow.getMoney()+flow.getGiftMoney());
				Date now =new Date();
				user.setLastRechargeDate(now);
				user.setCreateDate(now);
				user.setUpdateDate(now);
				user.setCreateBy(flow.getCreateBy());
				user.setUpdateBy(flow.getCreateBy());
				saveOrUpdate(user);
				user =mapper.selectByPrimaryKey(user.getId());
				flow.setStatus((short) 1);
				flow.setUpdateDate(now);
				flow.setBalance(user.getTotalMoney());
				flow.setPayDate(now);
				accountFlowService.saveOrUpdate(flow);
				*//*	if(openId!=null){//微信公众号推送消息
						wxPayService.sendDealMsg(0, openId,flow.getMoney() , flow.getGiftMoney(),user.getTotalMoney(), payNumber, now, null,null,flow.getIncomeId());
					}*//*
            }else{//支出 无账号
                throw new MyException("您的账户余额为0，请先充值!");
            }
        }else{
            if(flow.getFlowState()==1){//充值
                user	.setUserId(Integer.parseInt(flow.getCreateBy()));
                if(user.getRechargeCount()==null){
                    user.setRechargeCount(1);
                }else{
                    user.setRechargeCount(	user.getRechargeCount()+1);
                }
				user.setActualMoney(flow.getMoney());//实际金额
				user.setGiftMoney(flow.getGiftMoney());//赠送金额
				Date now =new Date();
				user.setLastRechargeDate(now);
				user.setUpdateDate(now);
				user.setUpdateBy(flow.getCreateBy());
				mapper.updateBanalceForRecharge(user);
				user =mapper.selectByPrimaryKey(user.getId());
				flow.setStatus((short) 1);//交易成功
				flow.setUpdateDate(now);
				flow.setBalance(user.getTotalMoney());
				flow.setPayDate(now);
				accountFlowService.updateByPrimaryKeySelective(flow);
				if(openId!=null){//微信公众号推送消息
					wxPayService.sendDealMsg(0, openId,flow.getMoney() , flow.getGiftMoney(),user.getTotalMoney(), payNumber, now, null,null,flow.getIncomeId());
				}
            }else{//支付
                user	.setUserId(Integer.parseInt(flow.getCreateBy()));
				user.setActualMoney(flow.getMoney());//实际金额
				user.setGiftMoney(flow.getGiftMoney());//赠送金额
				Date now =new Date();
                user.setLastRechargeDate(now);
                user.setUpdateDate(now);
                user.setUpdateBy(flow.getCreateBy());
                Income income=incomeService.getById(flow.getIncomeId());
                if (flow.getStatus() == 0) {//待支付状态

                    int overage;// 扣除金额
                    if (user.getActualMoney()>income.getMoney()) {// 直接余额支付
                        overage =income.getMoney();
                        user.setActualMoney(overage);
                        user.setGiftMoney(0);
                    } else if (user.getActualMoney()== 0) {// 账号充值余额为0；直接扣赠送金额
                        overage = income.getMoney();
                        user.setGiftMoney(overage);
                    } else {// 账号充值余额<待支付金额，采取充值金额+赠送金额支付的方式
                        overage =income.getMoney()-user.getActualMoney();
                        user.setActualMoney(user.getActualMoney());
                        user.setGiftMoney(overage);
                    }
                }
                userAccountService.updateBanalceForPay(user);
                user =userAccountService.getById(user.getId());
                flow.setStatus((short) 1);//交易成功
                flow.setUpdateDate(now);
                flow.setBalance(user.getTotalMoney());
                flow.setPayDate(now);
                accountFlowService.updateAccountFlow(flow);
                commonDataMapper.updateSamplingStatus((short) 2, samplingId, now);

                if(income!=null){
                    income.setOrderPlatform((short) 1);
                    income.setStatus((short) 1);
                    income.setUpdateDate(now);
                    income.setUpdateBy(flow.getCreateBy());
                    income.setPayDate(now);
                    takeSamplingMoney = takeSamplingMoney == null? 0.0:takeSamplingMoney;
                    printingFee = printingFee == 0 ? 0 : printingFee;
                    checkMoney = checkMoney == 0 ? 0 : checkMoney;
                    income.setCheckMoney(checkMoney);
                    income.setReportMoney(printingFee);
                    income.setTakeSamplingMoney(takeSamplingMoney);
                    incomeService.updateById(income);
                }
				if(openId!=null){//微信公众号推送消息
					wxPayService.sendDealMsg(1, openId,flow.getMoney() , flow.getGiftMoney(),user.getTotalMoney(), payNumber, now, null,null,flow.getIncomeId());
				}
            }

        }*/
        return deal;
    }

    @Override
    public int updateBanalceForPay(InspectionUserAccount record) {
        return getBaseMapper().updateBanalceForPay(record);
    }

    @Override
    public int updateBanalceForRecharge2(InspectionUserAccount record) {
        return getBaseMapper().updateBanalceForRecharge2(record);
    }

    @Override
    public int updateBanalceForPay2(InspectionUserAccount record) {
        return getBaseMapper().updateBanalceForPay2(record);
    }

    /**
     * 数据列表分页方法
     *
     * @param page 分页参数
     * @return 列表
     */
    @Override
    public Page loadDatagrid(Page page, BaseModel t) throws Exception {
        // 初始化分页参数
        if (null == page) {
            page = new Page();
        }
        // 设置查询条件
        page.setObj(t);

        // 每次查询记录总数量,防止新增或删除记录后总数量错误
        page.setRowTotal(getBaseMapper().getRowTotal(page));

        // 每次重新计算总页数,防止修改了每页展示记录数量导致数据列表显示异常
        page.setPageCount((int) Math.ceil(page.getRowTotal() / (page.getPageSize() * 1.0)));

        //查看页不存在,修改查看页序号
        if (page.getPageNo() <= 0) {
            page.setPageNo(1);
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        } else if (page.getPageNo() > page.getPageCount()) {
            page.setPageNo(page.getPageCount());
            //			page.setRowOffset(page.getRowOffset());
            //			page.setRowTail(page.getRowTail());
        }

        List dataList = getBaseMapper().loadDatagrid(page);
        page.setResults(dataList);
        return page;
    }

    @Override
    public int updateBanalceForRecharge(InspectionUserAccount record) {
        return getBaseMapper().updateBanalceForRecharge(record);
    }

    /**
     *  微信端 充值、支付 状态更新
     * @throws Exception
     */
    @Override
    @Transactional
    public Boolean updateUserAccount2(Income income,AccountFlow flow,Integer samplingId,String openId,String payNumber) throws Exception{
        Boolean deal=true;
        InspectionUserAccount user=	getBaseMapper().queryAccountByUserId( Integer.parseInt(flow.getCreateBy()));//获取用户账号信息
        if(user==null){//首次使用账号
            //1.开通用户账号
            if(flow.getFlowState()==1){//充值
                user= new InspectionUserAccount();
                user.setUserId(Integer.parseInt(flow.getCreateBy()));
                user.setRechargeCount(1);
                user.setActualMoney(flow.getMoney());
                user.setGiftMoney(flow.getGiftMoney());
                user.setTotalMoney(flow.getMoney()+flow.getGiftMoney());
                Date now =new Date();
                user.setLastRechargeDate(now);
                user.setCreateDate(now);
                user.setUpdateDate(now);
                user.setCreateBy(flow.getCreateBy());
                user.setUpdateBy(flow.getCreateBy());
                saveOrUpdate(user);
                //更新余额交易流水表
                flow.setUpdateDate(now);
                flow.setBalance(user.getTotalMoney());
                flow.setPayDate(now);
                accountFlowService.saveOrUpdate(flow);
            }else{//支出 无账号
                throw new MyException("您的账户余额为0，请先充值!");
            }
        }else{
            if(flow.getFlowState()==1){//充值
                user.setUserId(Integer.parseInt(flow.getCreateBy()));
                if(user.getRechargeCount()==null){
                    user.setRechargeCount(1);
                }else{
                    user.setRechargeCount(	user.getRechargeCount()+1);
                }
                user.setActualMoney(flow.getMoney());//实际金额
                user.setGiftMoney(flow.getGiftMoney());//赠送金额
                Date now =new Date();
                user.setLastRechargeDate(now);
                user.setUpdateDate(now);
                user.setUpdateBy(flow.getCreateBy());
                updateBanalceForRecharge(user);
                user =getBaseMapper().queryAccountByUserId(user.getUserId());
                flow.setUpdateDate(now);
                flow.setBalance(user.getTotalMoney());
                flow.setPayDate(now);
                accountFlowService.saveOrUpdate(flow);
               /* if(openId!=null){//微信公众号推送消息
                    wxPayService.sendDealMsg(0, openId,flow.getMoney() , flow.getGiftMoney(),user.getTotalMoney(), payNumber, now, null,null,flow.getIncomeId());
                }*/
            }else{//支付
                //1.写入income交易记录
                Date now =new Date();
                income.setPayDate(now);
                incomeService.saveOrUpdate(income);
                user.setUserId(Integer.parseInt(flow.getCreateBy()));
//                user.setActualMoney(flow.getMoney());//实际金额
//                user.setGiftMoney(flow.getGiftMoney());//赠送金额
                user.setLastRechargeDate(now);
                user.setUpdateDate(now);
                user.setUpdateBy(flow.getCreateBy());
                if (flow.getStatus() == 0) {//待支付状态
                    int overage;// 扣除金额
                    if (user.getActualMoney()>income.getMoney()) {// 直接余额支付
                        overage =income.getMoney();
                        user.setActualMoney(overage);
                        user.setGiftMoney(0);
                    } else if (user.getActualMoney()== 0) {// 账号充值余额为0；直接扣赠送金额
                        overage = income.getMoney();
                        user.setGiftMoney(overage);
                    } else {// 账号充值余额<待支付金额，采取充值金额+赠送金额支付的方式
                        overage =income.getMoney()-user.getActualMoney();
                        user.setActualMoney(user.getActualMoney());
                        user.setGiftMoney(overage);
                    }
                }
                //2.更新账户余额
                userAccountService.updateBanalceForPay(user);
//                user =getBaseMapper().queryAccountByUserId(user.getUserId());
                //3.写入账号交易流水
                flow.setIncomeId(income.getId());
                flow.setStatus((short) 1);//交易成功
                flow.setUpdateDate(now);
                flow.setBalance(user.getTotalMoney()-user.getActualMoney()-user.getGiftMoney());
                flow.setPayDate(now);
                accountFlowService.saveOrUpdate(flow);
               /* if(openId!=null){//微信公众号推送消息
                    wxPayService.sendDealMsg(1, openId,flow.getMoney() , flow.getGiftMoney(),user.getTotalMoney(), payNumber, now, null,null,flow.getIncomeId());
                }*/
            }

        }
        return deal;
    }
}

