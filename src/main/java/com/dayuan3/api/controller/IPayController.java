package com.dayuan3.api.controller;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.exceptions.ValidateException;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dayuan.bean.sampling.TbSampling;
import com.dayuan.common.PublicUtil;
import com.dayuan.exception.MyException;
import com.dayuan.service.sampling.TbSamplingService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.DateUtil;
import com.dayuan3.admin.bean.InspectionUnitUser;
import com.dayuan3.admin.bean.SplitAmount;
import com.dayuan3.admin.bean.SplitMember;
import com.dayuan3.admin.bean.WithdrawAmount;
import com.dayuan3.admin.service.SplitAmountService;
import com.dayuan3.admin.service.SplitMemberService;
import com.dayuan3.admin.service.WithdrawAmountService;
import com.dayuan3.api.common.*;
import com.dayuan3.api.vo.CostStatisticsRespVo;
import com.dayuan3.api.vo.IncomePageRespVo;
import com.dayuan3.api.vo.PageVo;
import com.dayuan3.api.vo.pay.PayReqVO;
import com.dayuan3.api.vo.pay.PaymentCallBakRespVO;
import com.dayuan3.api.vo.pay.SplitAmountReqVO;
import com.dayuan3.api.vo.pay.WithDrawalReqVO;
import com.dayuan3.common.bean.AccountFlow;
import com.dayuan3.common.bean.InspectionUserAccount;
import com.dayuan3.common.service.CommonLogUtilService;
import com.dayuan3.common.service.InspectionUserAccountService;
import com.dayuan3.common.util.GeneratorOrder;
import com.dayuan3.terminal.bean.Income;
import com.dayuan3.terminal.service.IncomeService;
import com.trhui.mallbook.common.rsa.RsaUtil;
import com.trhui.mallbook.common.utils.JsonUtil;
import com.trhui.mallbook.domain.common.ApiResponse;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.response.hf.*;
import com.trhui.mallbook.domain.response.trade.PaymentQueryResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Description 支付相关接口
 *
 * @Author xiaoyl
 * @Date 2025/6/22 15:41
 */
@Api(tags = "5.支付相关")
@RestController
@RequestMapping("/api/pay")
public class IPayController {
    private static final Logger log = Logger.getLogger("payLog");
    static String nonce_str;
    @Autowired
    private TbSamplingService tbSamplingService;
    @Autowired
    private IncomeService incomeService;
    @Autowired
    private CommonLogUtilService logUtil;
    @Autowired
    private InspectionUserAccountService inspectionUserAccountService;
    @Autowired
    private SplitAmountService splitAmountService;
    @Autowired
    private WithdrawAmountService withdrawAmountService;
    @Autowired
    private SplitMemberService splitMemberService;

    /**
     * Description 返回的支付码payCode，通过微信JSAPI调起支付
     *
     * @Author xiaoyl
     * @Date 2025/6/23 8:54
     */
    /*private static HashMap<String, String> getSign(String preperId) {
        HashMap<String, String> map = new HashMap<String, String>();
        try {
            map.put("appId", WeChatConfig.appId);
            map.put("timeStamp", String.valueOf(System.currentTimeMillis() / 1000));
            map.put("nonceStr", WXPayUtil.genNonceStr());
            map.put("package", "prepay_id=" + preperId);
            map.put("signType", String.valueOf(SignType.MD5));
            map.put("paySign", WXPayUtil.generateSignature(map, WeChatConfig.secret, SignType.MD5));
            //            map.put("package", preperId);//为了在前台页面解析好解析 所以去掉 “prepay_id=”
            System.out.println(map.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }*/

    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    @ApiOperation(value = "1.自助下单支付&复检，获取微信支付码payCode，JSAPI支付", position = 1)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "orderId", dataType = "Integer", value = "订单ID", paramType = "query"),
            @ApiImplicitParam(name = "payType", dataType = "short", value = "费用类型:0 检测费，1复检费"
                    , paramType = "query", defaultValue = "0")
    })
    @PostMapping(value = "/getPrepay")
    public MiniProgramJson<JSONObject> getPrepay(HttpServletRequest request,
                                                 @RequestParam(value = "orderId", required = true) Integer orderId,
                                                 @RequestParam(value = "payType", required = false, defaultValue = "0") short payType) {
        String payCode = null;
        try {
            String terminalIp = getIpAddress(request);
            PayReqVO payReqVO = new PayReqVO(orderId, PaymentType.WX_JSAPI.getCode(), terminalIp, payType);
            payCode = tbSamplingService.payManyAsyncSplit(payReqVO);
            JSONObject payResult = JSON.parseObject(payCode);
            return MiniProgramJson.data(payResult);
        } catch (Exception e) {
            log.error("接口名称：getPrepay，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "调起支付接口失败，" + e.getMessage());
        }
    }

    @ApiOperation(value = "2.电子抽样支付：根据订单ID生成付款码字符串，给用户扫码支付，前端根据返回内容生成二维码,返回-1表示已经支付成功", position = 2)
    @ApiImplicitParam(name = "orderId", dataType = "Integer", value = "订单ID", paramType = "query")
    @PostMapping("/getQrCode")
    public MiniProgramJson getQrCode(HttpServletRequest request, Integer orderId) {
        String payCode = null;
        try {
            String terminalIp = getIpAddress(request);
            PayReqVO payReqVO = new PayReqVO(orderId, PaymentType.WX_CB.getCode(), terminalIp, (short) 0);
            payCode = tbSamplingService.payManyAsyncSplit(payReqVO);
        } catch (Exception e) {
            log.error("接口名称：getQrCode，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "生成收款码失败，请退出重试!！" + e.getMessage());
        }
        return MiniProgramJson.data(payCode);
    }

    @ApiOperation(value = "3.查询订单支付状态,返回状态：0：待处理；1：成功；2：失败；3：已取消", position = 3)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "orderId", dataType = "Integer", value = "订单ID", paramType = "query"),
            @ApiImplicitParam(name = "payNumber", dataType = "String", value = "支付订单号", paramType = "query"),
            @ApiImplicitParam(name = "transactionType", dataType = "short", value = "费用类型:0 检测费，1复检费，2 充值费用"
                    , paramType = "query", defaultValue = "0")
    })
    @GetMapping("/queryOrder")
    public MiniProgramJson<Integer> queryOrder(@RequestParam(required = false) Integer orderId,
                                               @RequestParam(required = false) String payNumber,
                                               @RequestParam(required = false, defaultValue = "0") Short transactionType) {
        int payResult = 0;// 0：待处理；1：成功；2：失败3：已取消
        try {
            if (orderId == null && StrUtil.isBlank(payNumber)) {
                return MiniProgramJson.error(ErrCode.PARAM_REQUIRED, "至少输入一个必填参数！");
            }
            Income income = incomeService.selectBySamplingId(orderId, payNumber, transactionType);
            if (income == null) {
                return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND,"支付交易不存在或者超时关闭，请刷新付款码");
            } else if (income.getStatus() == 1) {
                //交易已支付成功，直接返回
                return MiniProgramJson.data(1);
            }
            BaseResponse<PaymentQueryResponse> result = MallBookUtil.queryOrder(income.getNumber(), "1");
            PaymentQueryResponse queryObj = result.getData();
            //0：待处理；1：成功；2：失败 3：已取消,关单成功后状态会更新为已取消。9 对应预下单的状态,0和 9 都可以当待处理处理
            payResult =queryObj.getStatus().equals("9") ? 0 : Integer.valueOf(queryObj.getStatus());
            if (payResult == 1 && orderId != null) {
                //支付成功，更新订单状态
                tbSamplingService.paid(orderId);
            }
            if (payResult>0) {
                income.setStatus((short) payResult);
                income.setUpdateDate(new Date());
                if (payResult == 1) {
                    //官方商户订单号
                    income.setPayNumber(queryObj.getPartyOrderId());
                    //官方订单号
                    income.setParam1(queryObj.getOutTransId());
                    //渠道订单号
                    income.setParam2(queryObj.getChannelOrderId());
                }
                incomeService.updateById(income);
            }
        } catch (Exception e) {
            log.error("接口名称：queryOrder，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR);
        }
        return MiniProgramJson.data(payResult);
    }
    @ApiOperation(value = "4.查询账号余额", position = 1)
    @PostMapping(value = "/getBalance")
    public MiniProgramJson getBalance() {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            //查询余额账户
            InspectionUserAccount userAccount = inspectionUserAccountService.queryAccountByUserId(user.getId());
            if(userAccount==null || 0==userAccount.getTotalMoney()){
                return MiniProgramJson.data(0);
            }else{
                //余额单位是分，转换为：元
                BigDecimal reCheckPrice = new BigDecimal(userAccount.getTotalMoney());
                BigDecimal result1 =reCheckPrice.divide(new BigDecimal(100),2,RoundingMode.HALF_UP);
                return MiniProgramJson.data(result1);
            }
        } catch (Exception e) {
            log.error("接口名称：getBalance，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "查询账号余额失败，" + e.getMessage());
        }
    }
    @ApiOperation(value = "5.设置支付密码", position = 1)
    @ApiImplicitParam(name = "payPassword", dataType = "string", value = "支付密码：md5加密一次转大写", paramType = "query")
    @PostMapping(value = "/setPaypwd")
    public MiniProgramJson setPaypwd(@RequestParam(required = true) String payPassword) {
        try {
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            if (StrUtil.isBlank(payPassword)) {
                return MiniProgramJson.error(ErrCode.DATA_IS_EMPTY, "支付密码不能为空！");
            }
            InspectionUserAccount bean = inspectionUserAccountService.queryAccountByUserId(user.getId());
            bean.setUpdateBy(user.getId().toString());
            bean.setUpdateDate(new Date());
            String payPwd = payPassword.length() == 32 ? CipherUtil.encodeByMD5(payPassword) : CipherUtil.generatePassword(payPassword);
            bean.setPayPassword(payPwd);
            inspectionUserAccountService.saveOrUpdate(bean);
            return MiniProgramJson.ok("设置支付密码成功");
        } catch (Exception e) {
            log.error("接口名称：setPaypwd，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "支付密码设置失败，" + e.getMessage());
        }
    }

    @ApiOperation(value = "6.余额充值，获取微信支付码payCode，JSAPI支付")
    @ApiImplicitParam(name = "rechargeMoney", dataType = "double", value = "充值金额，单位：元", paramType = "query")
    @PostMapping(value = "/getPrepareRecharge")
    public MiniProgramJson<JSONObject> getPrepareRecharge(HttpServletRequest request, double rechargeMoney) {
        String payCode = null;
        try {
            //1.获取用户信息
            InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
            Income income = null;
            String terminalIp = getIpAddress(request);
            Date now = new Date();
            //2.封装交易流水对象，并写入记录表
            BigDecimal bd = BigDecimal.valueOf(rechargeMoney)
                    .multiply(BigDecimal.valueOf(100))
                    .setScale(0, RoundingMode.HALF_UP);
            Integer money = bd.intValueExact();
            income = new Income(GeneratorOrder.generate(user.getId()), null, (short) 1, (short) 2, money,
                    user.getId().toString(), now, user.getId().toString(), now);
            income.setDeleteFlag(0);
            income.setPayType((short) 0);
            incomeService.saveOrUpdate(income);
            PayReqVO payReqVO = new PayReqVO(income.getNumber(), PaymentType.WX_JSAPI.getCode(), terminalIp, (short) 2, user.getOpenId(), income.getMoney());
            //3.调用汇付交易接口
            BaseResponse<HfPaymentOrderResponse> payResult = MallBookUtil.guaranteePayManyAsyncSplit(payReqVO);
            if (!payResult.getCode().equals("0000")) {
                throw new Exception("2.余额充值，汇付接口执行异常：" + payResult.getMsg());
            }
            //4.调用成功，返回支付信息
            payCode = payResult.getData().getPayCode();
            return MiniProgramJson.data(JSON.parseObject(payCode));
        } catch (Exception e) {
            log.error("接口名称：getPrepareRecharge，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "调起支付接口失败，" + e.getMessage());
        }
    }

    @ApiOperation(value = "7.余额支付方法", position = 1)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "orderId", dataType = "Integer", value = "订单ID", paramType = "query"),
            @ApiImplicitParam(name = "pwd", dataType = "string", value = "支付密码：nd5加密一次转大写", paramType = "query"),
            @ApiImplicitParam(name = "payType", dataType = "short", value = "费用类型:0 检测费，1复检费", paramType = "query", defaultValue = "0")
    })
    @PostMapping(value = "/payForBalance")
    public MiniProgramJson payForBalance(HttpServletRequest request,
                                         @RequestParam(value = "orderId", required = true) Integer orderId,
                                         @RequestParam(value = "pwd", required = true) String pwd,
                                         @RequestParam(value = "payType", required = false, defaultValue = "0") short payType) {
        try {
            if (orderId != null) {//检测订单
                TbSampling sampling = tbSamplingService.getById(orderId);
                if (sampling != null) {
                    InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");
                    if (user != null) {
                        //查询余额账户
                        InspectionUserAccount userAccount = inspectionUserAccountService.queryAccountByUserId(user.getId());
                        //余额账户不为空
                        if (userAccount == null) {
                            return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "余额账号不存在,请联系管理员");
                        }
                        //验证密码
                        if (StringUtils.isEmpty(userAccount.getPayPassword())) {
                            return MiniProgramJson.error(ErrCode.DATA_IS_EMPTY, "请先设置支付密码!");
                        }
                        pwd = pwd.length() == 32 ? CipherUtil.encodeByMD5(pwd) : CipherUtil.generatePassword(pwd);
                        if (!pwd.equals(userAccount.getPayPassword())) {
                            return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, "支付密码不正确，请重新输入!");
                        }
                        if (userAccount.getStatus() == 1) {
                            return MiniProgramJson.error(ErrCode.DATA_ABNORMAL, "您的余额账户已被冻结，请联系管理人员!");
                        }
                        String No = GeneratorOrder.generate(user.getId());
//                        Income income =null;
                        synchronized (this) {
                            //                            AccountFlow bean = accountFlowService.insertFlow(1, user, sampling.getOrderFees(), No, null, null, orderId, null);
                            int money = sampling.getOrderFees();
                            if (payType == 1) {
                                //计算复检费用
                                money = tbSamplingService.reCheckMoney(sampling.getId(), sampling.getOrderNumber());
                            }
                            Double totalmoeny = Double.parseDouble(userAccount.getTotalMoney().toString());
                            if (totalmoeny < money) {
                                return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "账户余额不足，请充值!，");
                            }
//                            income=incomeService.selectBySamplingId(orderId,null,payType);
                            Income income = new Income(No, orderId, (short) 1, (short) 2, No, payType, money, (short) 1);
                            PublicUtil.setCommonForTable1(income, true, user);
                            AccountFlow bean = new AccountFlow(income.getId(), income.getMoney(), (short) 0, (short) 0, income.getCreateBy(), income.getCreateDate());
                            //生成交易记录
                            inspectionUserAccountService.updateUserAccount2(income, bean, orderId, user.getOpenId(), No);
                            //支付成功，更新订单状态
                            if (payType == 0) {
                                tbSamplingService.paid(orderId);
                                log.info("余额支付检测费用成功,更新订单ID:" + orderId);
                            } else {
                                tbSamplingService.recheck(orderId, income.getMoney());
                                log.info("余额支付复检费用成功,更新订单ID:" + orderId);
                            }
                            //写入支付日志
                            logUtil.savePayLogForWX(No, (short) 1, (short) 2, (short) 4, sampling.getOrderFees(), IPayController.class.toString(), "payFor", "微信端余额支付订单", "微信端余额支付订单", true, null, user.getId(), "余额支付订单" + orderId, request);
                          /*  //微信消息推送 shit
                            try {
                                int foodNumber = tbSamplingDetailService.queryFoodCountBySamplingId(orderId);
                                wxPayService.sendOrderMsg(user.getOpenId(), null, sampling.getSamplingNo(), foodNumber, sampling.getOrderFees(), sampling.getCreateDate(), sampling.getOrderPlatform(), bean.getIncomeId());
                            } catch (Exception e) {
                                e.printStackTrace();
                                System.out.println("下单成功消息推送失败" + e.getMessage());
                            }*/
                        }

                        return MiniProgramJson.data(No);
                        //System.out.println(samplingId+"：---" +(new Date().getTime()-start.getTime())+"ms");
                    } else {
                        throw new MyException("用户登录失效，请重新登录!");
                    }
                } else {
                    throw new MyException("订单不存在!");
                }
            }
            return MiniProgramJson.ok("");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("接口名称：payForBalance，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "调起余额支付接口失败，" + e.getMessage());
        }
    }

    /**
     * Description 回调示例：{ "amount": "1", "channelOrderId": "ZF1937799013437894657", "merOrderId": "1049420250625170414229", "outTransId": "2025062522001492251459700860", "partyOrderId": "02232506256146217514489", "payFinishTime": "2025-06-25 17:07:48", "splitList": [], "status": "1" }
     *
     * @Author xiaoyl
     * @Date 2025/7/9 13:14
     */
    @ApiOperation(value = "9.支付成功回调地址,不用对接", position = 4)
    @PostMapping("/payNotify")
    public MiniProgramJson payNotify(ApiResponse response) throws Exception {
        log.info("业务系统接收mallbook异步通知 begin");
        log.info("支付成功回调*****：" + JSONObject.toJSONString(response));
        // 验签
        boolean verify = RsaUtil.doCheck(response.toString(), response.getSign(), ChannelConfig.mallBookPublicKey);
        if (!verify) {
            log.error("业务系统接收mallbook异步通知:签名验证失败");
            throw new ValidateException("签名验证失败");
        }
        // 验签通过，处理业务
        PaymentCallBakRespVO payResult = JSONObject.parseObject(response.getResult(), PaymentCallBakRespVO.class);
        if (payResult.getStatus().equals("1")) {
            Income income = incomeService.selectByNumber(payResult.getMerOrderId(), 1);
            if (income == null) {
                log.info("没有找到交易订单:" + payResult.getMerOrderId());
                throw new ValidateException("找不到订单信息");
            } else if (income.getStatus() == 0) {
                income.setStatus(Short.valueOf(payResult.getStatus()));
                income.setUpdateDate(new Date());
                //官方商户订单号
                income.setPayNumber(payResult.getPartyOrderId());
                //官方订单号
                income.setParam1(payResult.getOutTransId());
                //渠道订单号
                income.setParam2(payResult.getChannelOrderId());
                income.setPayDate(DateUtil.datetimeFormat.parse(payResult.getPayFinishTime()));
                incomeService.updateById(income);
                //检测费用，更新订单状态
                if (income.getTransactionType() == 0 && income.getSamplingId() != null) {
                    tbSamplingService.paid(income.getSamplingId());
                    log.info("支付成功,更新订单ID:" + income.getSamplingId());
                } else if (income.getTransactionType() == 1 && income.getSamplingId() != null) {
                    tbSamplingService.recheck(income.getSamplingId(), income.getMoney());
                    log.info("复检费用支付成功,更新订单ID:" + income.getSamplingId());
                } else if (income.getTransactionType() == 2) {
                    //TODO 待验证
                    AccountFlow flow = new AccountFlow(income.getId(), income.getMoney(), (short) 1, (short) 1, income.getCreateBy(), income.getCreateDate());
                    inspectionUserAccountService.updateUserAccount2(null, flow, null, income.getPayNumber(), null);
                    log.info("余额充值支付成功" + income.getCreateBy() + ",充值金额：" + income.getMoney() / 100 + " 元");
                }
            }

        }
        log.info("业务系统接收mallbook异步通知 end");
        return MiniProgramJson.ok("回调成功");
    }


    @ApiOperation(value = "9.查询交易记录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "查询类型（0：所有记录，1：交易记录，2：充值记录）", required = true, dataType = "Long", example = "1"),
            @ApiImplicitParam(name = "ym", value = "年月", required = true, dataType = "String", example = "2025-07"),
            @ApiImplicitParam(name = "current", value = "页码", required = true, dataType = "Long", example = "1"),
            @ApiImplicitParam(name = "size", value = "每页显示记录数（默认10）", required = false, dataType = "Long", example = "10")
    })
    @PostMapping(value = "/getHistory")
    public MiniProgramJson<PageVo<IncomePageRespVo>> getHistory(
            @RequestParam(value = "type", required = true) Long type,
            @RequestParam(value = "ym", required = true) String ym,
            @RequestParam(value = "current", required = true) Long current,
            @RequestParam(value = "size", required = false, defaultValue = "10") Long size) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 查询年月
        if (StrUtil.isBlank(ym)) {
            return MiniProgramJson.error(ErrCode.PARAM_REQUIRED, "请选择查询年月！");
        } else if (!ym.matches("^20\\d{2}-\\d{2}$")) {
            return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, "请选择正确的查询年月，格式：2025-07");
        }
        Date ymDate = cn.hutool.core.date.DateUtil.parse(ym, "yyyy-MM");

        // 查询开始结束日期
        DateTime beginDate = cn.hutool.core.date.DateUtil.beginOfMonth(ymDate);
        DateTime endDate = cn.hutool.core.date.DateUtil.endOfMonth(ymDate);
        if (endDate.isAfter(cn.hutool.core.date.DateUtil.date())) {
            endDate = cn.hutool.core.date.DateUtil.date();
        }
        String begin = cn.hutool.core.date.DateUtil.format(beginDate, "yyyy-MM-dd 00:00:00");
        String end = cn.hutool.core.date.DateUtil.format(endDate, "yyyy-MM-dd HH:mm:ss");

        // 查询条件
        LambdaQueryWrapper<Income> queryWrapper = new LambdaQueryWrapper<Income>()
                .between(Income::getPayDate, begin, end)

                //费用类型：0_检测费用, 1_复检费用, 2_充值费用, 3_订单退款, 4_充值退款
                // 交易记录
                .in(type == 1, Income::getTransactionType, 0, 1, 3)
                // 充值记录
                .in(type == 2, Income::getTransactionType, 2, 4)
                // 非法参数
                .eq(!Arrays.asList(0, 1, 2).contains(type.intValue()), Income::getId, 0)

                // 根据创建用户ID查询记录
                .eq(Income::getCreateBy, user.getId())

                .orderByDesc(Income::getPayDate);
        Page<Income> incomePage = incomeService.page(Page.of(current, size), queryWrapper);

        // 转换数据
        PageVo<IncomePageRespVo> pageVo = new PageVo<>();
        BeanUtil.copyProperties(incomePage, pageVo);
        pageVo.setRecords(incomePage.getRecords().stream().map(income -> {
            return BeanUtil.toBean(income, IncomePageRespVo.class);
        }).collect(Collectors.toList()));

        return MiniProgramJson.data(pageVo);
    }


    @ApiOperation(value = "10.费用统计")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type", value = "查询类型（1：支出，2：充值）", required = true, dataType = "Long", example = "1"),
            @ApiImplicitParam(name = "ym", value = "年月", required = true, dataType = "String", example = "2025-07")
    })
    @PostMapping(value = "/costStatistics")
    public MiniProgramJson<CostStatisticsRespVo> costStatistics(
            @RequestParam(value = "type", required = true) Long type,
            @RequestParam(value = "ym", required = true) String ym) {

        // 获取用户信息
        InspectionUnitUser user = (InspectionUnitUser) StpUtil.getTokenSession().get("user");

        // 1.查询当月统计
        // 查询年月
        if (StrUtil.isBlank(ym)) {
            return MiniProgramJson.error(ErrCode.PARAM_REQUIRED, "请选择查询年月！");
        } else if (!ym.matches("^20\\d{2}-\\d{2}$")) {
            return MiniProgramJson.error(ErrCode.PARAM_ILLEGAL, "请选择正确的查询年月，格式：2025-07");
        }
        Date ymDate = cn.hutool.core.date.DateUtil.parse(ym, "yyyy-MM");

        // 查询开始结束日期
        DateTime beginDate = cn.hutool.core.date.DateUtil.beginOfMonth(ymDate);
        DateTime endDate = cn.hutool.core.date.DateUtil.endOfMonth(ymDate);
        if (endDate.isAfter(cn.hutool.core.date.DateUtil.date())) {
            endDate = cn.hutool.core.date.DateUtil.date();
        }
        String begin = cn.hutool.core.date.DateUtil.format(beginDate, "yyyy-MM-dd 00:00:00");
        String end = cn.hutool.core.date.DateUtil.format(endDate, "yyyy-MM-dd HH:mm:ss");

        // 月费用统计查询条件
        LambdaQueryWrapper<Income> queryWrapper = new LambdaQueryWrapper<Income>()
                .between(Income::getPayDate, begin, end)

                //费用类型：0_检测费用, 1_复检费用, 2_充值费用, 3_订单退款, 4_充值退款
                // 支出
                .in(type == 1, Income::getTransactionType, 0, 1, 3)
                // 充值
                .in(type == 2, Income::getTransactionType, 2, 4)
                // 非法参数
                .eq(!Arrays.asList(1, 2).contains(type.intValue()), Income::getId, 0)

                // 普通用户仅显示当前用户记录
                .eq(Income::getCreateBy, user.getId());
        List<Income> incomeList = incomeService.list(queryWrapper);

        // 本月 支出|充值 费用（分）
        int cost = incomeList.stream()
                .filter(income -> income.getTransactionType() == 0 || income.getTransactionType() == 1 || income.getTransactionType() == 2)
                .mapToInt(Income::getMoney).sum() -
                incomeList.stream()
                        .filter(income -> income.getTransactionType() == 3 || income.getTransactionType() == 4)
                        .mapToInt(Income::getMoney).sum();
        // 本月 支出|充值 次数（含退款）
        long times = incomeList.stream().filter(income -> income.getTransactionType() == 0 || income.getTransactionType() == 1 || income.getTransactionType() == 2).count();


        // 2.查询近半年每月统计
        // 查询时间 近半年
        DateTime endDate1 = cn.hutool.core.date.DateUtil.date();
        DateTime beginDate1 = cn.hutool.core.date.DateUtil.beginOfMonth(cn.hutool.core.date.DateUtil.offset(endDate1, DateField.MONTH, -5));
        String begin1 = cn.hutool.core.date.DateUtil.format(beginDate1, "yyyy-MM-dd 00:00:00");
        String end1 = cn.hutool.core.date.DateUtil.format(endDate1, "yyyy-MM-dd HH:mm:ss");

        // 月费用统计查询条件
        LambdaQueryWrapper<Income> queryWrapper1 = new LambdaQueryWrapper<Income>()
                .between(Income::getPayDate, begin1, end1)

                //费用类型：0_检测费用, 1_复检费用, 2_充值费用, 3_订单退款, 4_充值退款
                // 支出
                .in(type == 1, Income::getTransactionType, 0, 1, 3)
                // 充值
                .in(type == 2, Income::getTransactionType, 2, 4)
                // 非法参数
                .eq(!Arrays.asList(1, 2).contains(type.intValue()), Income::getId, 0)

                // 根据创建用户ID查询记录
                .eq(Income::getCreateBy, user.getId());
        List<Income> incomeList1 = incomeService.list(queryWrapper1);

        // 近半年月份
        List<CostStatisticsRespVo.monthly> monthly = new ArrayList<>();
        Date monthlyYm1 = beginDate1;
        while (monthlyYm1.getTime() <= endDate1.getTime()) {
            // 统计月
            String monthlyYm = cn.hutool.core.date.DateUtil.format(monthlyYm1, "yyyy-MM");
            // 统计月 支出|充值 费用（分）
            int monthlyCost = incomeList1.stream()
                    .filter(income -> monthlyYm.equals(cn.hutool.core.date.DateUtil.format(income.getPayDate(), "yyyy-MM"))
                            && (income.getTransactionType() == 0 || income.getTransactionType() == 1 || income.getTransactionType() == 2)
                    )
                    .mapToInt(Income::getMoney).sum() -
                    incomeList1.stream()
                            .filter(income -> monthlyYm.equals(cn.hutool.core.date.DateUtil.format(income.getPayDate(), "yyyy-MM"))
                                    && (income.getTransactionType() == 3 || income.getTransactionType() == 4)
                            )
                            .mapToInt(Income::getMoney).sum();

            monthly.add(new CostStatisticsRespVo.monthly(monthlyYm, monthlyCost + ""));
            monthlyYm1 = cn.hutool.core.date.DateUtil.offset(monthlyYm1, DateField.MONTH, 1);
        }

        return MiniProgramJson.data(new CostStatisticsRespVo(cost + "", times, monthly));
    }
    @ApiOperation(value = "11.申请退款", position = 1)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "originalMerOrderId", dataType = "string", value = "原支付请求订单号,income表的number订单号", paramType = "query"),
            @ApiImplicitParam(name = "reMoney", dataType = "int", value = "退款金额，单位为分", paramType = "query")
    })
    @PostMapping(value = "/reFund")
    public MiniProgramJson reFund(@RequestParam(required = true) String originalMerOrderId,
                                  @RequestParam(required = false,defaultValue = "1")int reMoney) {
        try {
            Income income=incomeService.selectByNumber(originalMerOrderId,1);
           int money=income!=null ? income.getMoney() : reMoney;
            BaseResponse<HfRefundResponse> response =MallBookUtil.requestAsyncRefund(originalMerOrderId,money);
            if (response.success()){
                System.out.println(JsonUtil.toJsonStr(response.getData()));
                return MiniProgramJson.ok("退款申请提交成功");
            }else{
                return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR,"申请退款失败:"+response.getMsg());
            }
        } catch (Exception e) {
            log.error("接口名称：reFund，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "申请退款失败，" + e.getMessage());
        }
    }

    @ApiOperation(value = "13.手动分账", position = 1)
    @ApiImplicitParam(name = "originalMerOrderId", dataType = "string", value = "原支付请求订单号,income表的number订单号", paramType = "query")
    @PostMapping(value = "/splitAmount")
    public MiniProgramJson splitAmount(@RequestParam(required = true) String originalMerOrderId) {
        try {
            int count=0;
            Income income=incomeService.selectByNumber(originalMerOrderId,1);
            int money=income.getMoney();
            List<SplitMember> allSplitMembers=splitMemberService.querySplitMember();
            int splitCount=allSplitMembers.size();
            if(splitCount==0){
                return MiniProgramJson.error(ErrCode.DATA_NOT_FOUND, "分账方数量为0，请联系管理员配置！");
            }
            for (int i = 0; i < splitCount; i += 7) {
                //分账接口最多支持7个分账方，所以每7个分账方为一组进行处理
                int endIndex = Math.min(i + 7, splitCount);
                List<SplitMember> currentSplitMembers = allSplitMembers.subList(i, endIndex);
                SplitAmountReqVO splitAmountReqVO = new SplitAmountReqVO(originalMerOrderId, GeneratorOrder.generateSplitNo("A"), money, currentSplitMembers);
                BaseResponse<HfCompleteResponse> response = MallBookUtil.splitAmount(splitAmountReqVO);
                if (response.success()) {
                    log.info(JsonUtil.toJsonStr(response.getData()));
                    HfCompleteResponse result = response.getData();
                    Date now = new Date();
                    SplitAmount splitAmount = new SplitAmount(splitAmountReqVO.getMerOrderId(), originalMerOrderId, splitAmountReqVO.getSplitMoney(), (short) 0, now, (short) 0, now);
                    splitAmount.setSplitJson(result.getParameter1());
                    splitAmountService.save(splitAmount);
                    count++;
                } else {
                    log.error("分账申请失败:" + response.getMsg());
                }
            }
            if(count>0){
                return MiniProgramJson.ok("分账申请提交成功");
            }else{
                return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "分账申请失败" );
            }
        } catch (Exception e) {
            log.error("接口名称：splitAmount，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "分账申请失败，" + e.getMessage());
        }
    }

    @ApiOperation(value = "14.确认收货", position = 1)
    @ApiImplicitParam(name = "splitNumber", dataType = "string", value = "分账订单号", paramType = "query")
    @PostMapping(value = "/receiveGood")
    public MiniProgramJson receiveGood(@RequestParam(required = true) String splitNumber) {
        try {
           SplitAmount splitAmount=splitAmountService.queryByNumber(splitNumber);
            splitAmount.setReceiveNumber(GeneratorOrder.generateSplitNo("B"));
            BaseResponse<HfReceiveResponse> response =MallBookUtil.receiveGoods(splitAmount);
            if (response.success()){
                log.info(JsonUtil.toJsonStr(response.getData()));
                splitAmount.setReceiveStatus((short)1);
                splitAmount.setReceiveDate(new Date());
                splitAmountService.saveOrUpdate(splitAmount);
                return MiniProgramJson.ok("确认收货成功");
            }else{
                return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR,"确认收货失败:"+response.getMsg());
            }
        } catch (Exception e) {
            log.error("接口名称：receiveGood，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "确认收货失败，" + e.getMessage());
        }
    }
    @ApiOperation(value = "15.提现接口", position = 1)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", dataType = "string", value = "子商户编号", paramType = "query"),
            @ApiImplicitParam(name = "amount", dataType = "string", value = "结算金额，必须大于0", paramType = "query")
    })
    @PostMapping(value = "/withDrawal")
    public MiniProgramJson withDrawal(@RequestParam(required = true) String userId,String amount) {
        try {
            WithDrawalReqVO drawalReqVO=new WithDrawalReqVO(GeneratorOrder.generateSplitNo("C"),userId,amount);
            BaseResponse<HfWithdrawResponse> response =MallBookUtil.withDrawal(drawalReqVO);
            log.info(JsonUtil.toJsonStr(response.getData()));
            if (response.success()){
                WithdrawAmount withdrawalAmount=new WithdrawAmount(userId,drawalReqVO.getMerOrderId(),Integer.valueOf(amount),(short)0,new Date());
                withdrawalAmount.setStartDate(DateUtil.datetimeFormat.parse(response.getData().getCreateTime()));
                withdrawAmountService.saveOrUpdate(withdrawalAmount);
                return MiniProgramJson.ok("提现申请提交成功");
            }else{
                return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR,"提现申请提交失败:"+response.getMsg());
            }
        } catch (Exception e) {
            log.error("接口名称：withDrawal，错误消息："+e.getMessage()+"====>"+e.getStackTrace()[0].getClassName()+"."+e.getStackTrace()[0].getMethodName()+":"+e.getStackTrace()[0].getLineNumber());
            return MiniProgramJson.error(ErrCode.UNKNOWN_ERROR, "提现申请提交失败，" + e.getMessage());
        }
    }
    @PostMapping("/callBackNotify/{callType}")
    @ApiOperation(value = "16.异步分账/退款/提现 回调接口,不用对接", position = 4)
    @ApiImplicitParam(name="callType", value="回调类型（1:分账|2:退款 |3: 提现）", required=true, dataType="int", example = "1")
    public MiniProgramJson callBackNotify(@PathVariable("callType") Integer callType,ApiResponse response) throws Exception {
        log.info(String.format("汇付回调callBackNotify:类型：%s *****返回参数：%s",callType,JSONObject.toJSONString(response)) );
        // 验签
        boolean verify = RsaUtil.doCheck(response.toString(), response.getSign(), ChannelConfig.mallBookPublicKey);
        if (!verify) {
            log.error("业务系统接收mallbook异步通知:签名验证失败");
            throw new MiniProgramException(ErrCode.HF_VALIDSIGN_FAILD,null,"签名验证失败");
        }
        switch (callType){
            case 1:
                // 分账回调
                HfCompleteResponse payResult = JSONObject.parseObject(response.getResult(), HfCompleteResponse.class);
                SplitAmount splitAmount= splitAmountService.queryByNumber(payResult.getMerOrderId());
                splitAmount.setStatus(Short.valueOf(payResult.getStatus()));
                splitAmountService.saveOrUpdate(splitAmount);
                log.info("业务系统接收mallbook【异步分账回调】 end"+JSONObject.toJSONString(payResult));
                break;
            case 2:
                //退款回调
                HfRefundResponse result = JSONObject.parseObject(response.getResult(), HfRefundResponse.class);
                //TODO 退款成功，修改交易流水状态以及送检订单状态信息
                log.info("业务系统接收mallbook【退款异步回调】 end"+JSONObject.toJSONString(result));
                break;
            case 3:
                //提现回调
                HfWithdrawResponse result3 = JSONObject.parseObject(response.getResult(), HfWithdrawResponse.class);
                WithdrawAmount withdrawAmount=withdrawAmountService.queryByNumber(result3.getMerOrderId());
                withdrawAmount.setStatus(Short.valueOf(result3.getStatus()));
                withdrawAmount.setStartDate(DateUtil.datetimeFormat.parse(result3.getCreateTime()));
                withdrawAmount.setEndDate(DateUtil.datetimeFormat.parse(result3.getEndTime()));
                withdrawAmount.setWithdrawBackFlag(Short.valueOf(result3.getWithdrawBackFlag()));
                withdrawAmountService.saveOrUpdate(withdrawAmount);
                log.info("业务系统接收mallbook【提现异步回调】 end："+JSONObject.toJSONString(result3));
                break;
            default:
                throw new MiniProgramException(ErrCode.PARAM_ILLEGAL,null,"未定义的回调类型");
        }
        return MiniProgramJson.ok("回调成功");
    }

}
