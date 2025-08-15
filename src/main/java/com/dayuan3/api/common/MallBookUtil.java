package com.dayuan3.api.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dayuan3.admin.bean.SplitAmount;
import com.dayuan3.admin.bean.SplitMember;
import com.dayuan3.api.vo.pay.PayReqVO;
import com.dayuan3.api.vo.pay.SplitAmountReqVO;
import com.dayuan3.api.vo.pay.WithDrawalReqVO;
import com.trhui.mallbook.client.*;
import com.trhui.mallbook.common.utils.JsonUtil;
import com.trhui.mallbook.domain.common.BaseResponse;
import com.trhui.mallbook.domain.request.Goods;
import com.trhui.mallbook.domain.request.PaymentOrderUser;
import com.trhui.mallbook.domain.request.QueryOrderRequest;
import com.trhui.mallbook.domain.request.hf.*;
import com.trhui.mallbook.domain.response.hf.*;
import com.trhui.mallbook.domain.response.trade.PaymentQueryResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * MallBookUtil，汇付支付工具类
 *
 * @author xiaoyl
 * @version 1.0
 * @date 2025/6/23 14:27
 * @description 类的功能描述
 */
public class MallBookUtil {
    private static final Logger log = Logger.getLogger("payLog");

    /**
     * 担保交易，异步分账：接口参数对照说明：https://o2yyifwsjv.feishu.cn/docx/WaV7diAKMoNwt2xsfRVcXwxZn3d
     * //mallbook请求参数:{"date":"1665219989844("sign":"MzPkzUYWfET5047lpmNVe9WWxBEmyrOZ9MDKYPiIYhvcUsjbiJeap4xGuZ5YOQHYOYgPVHM7ckptlWrqkQSyXqfFIROlCjmwm0wYTJAvyVmHelQOWnI7kWakSpsCoXKEbCMnJmfxWKVOkXd6TPQMPMg74osZJSy1zdTJ+M1yWMA=("channelType":"HF("params":"{\"asynSplitFlag\":\"1\(\"amount\":\"2\(\"frontUrl\":\"https://dev.6tfish.com/notice\(\"payType\":\"ALI_CB\(\"bizOrderId\":1665219989806,\"transferType\":\"0\(\"notifyUrl\":\"https://dev.6tfish.com/notice\(\"goodsDetail\":[{\"goodsName\":\"商品2\"}],\"orderName\":\"订单信息1\(\"terminalIp\":\"127.0.0.1\"}("version":"1.0.0("serverCode":"paymentOrder("merchantNo":"506("merOrderId":"01185587a1864647ae4d75e92fd169b7"}
     * //mallbook响应参数:{"result":"{\"amount\":\"2\(\"merOrderId\":\"01185587a1864647ae4d75e92fd169b7\(\"payCode\":\"https://qr.alipay.com/bax06780yyskqtkt1gfo005a\(\"status\":\"0\"}("sign":"cDXDCYmhSjEz2YadUDoY2E7Zy+2L2HQ2t/c+LEwSKmbvgdc46RF1tvpK0xnrjSklbBEGszaezu4lqzvDHmMM6y9hwNbytpYadaS4Mfxbn00Pdp52fPzwVQYcQaEPb6ZFSTqhgg9QnA89cO6cUo46BkrVWwGUo718mvCr4qiKikw=("code":"0000("msg":"操作成功("date":"1665219990896("version":"1.0.0"}
     *
     * @param payReqVO 支付请求相关参数
     * @Author xiaoyl
     * @Date 2025/6/23 14:30
     */
    public static BaseResponse<HfPaymentOrderResponse> guaranteePayManyAsyncSplit(PayReqVO payReqVO) {
        HfPaymentOrderRequest request = new HfPaymentOrderRequest();
        request.setMerchantNo(ChannelConfig.merchantNo);
        request.setMerOrderId(payReqVO.getMerOrderId());
        //交易类型： 0：担保交易，需要调用确认收货接口，资金才会划转到对方账户；1：直接支付，支付成功后，资金直接划转到对方账户中。
        request.setTransferType("0");
        //是否异步分账：0：否 1：是;当交易类型为直接支付时，不支持异步分账。
        request.setAsynSplitFlag("1");
        if (payReqVO.getPayType().equals(PaymentType.WX_JSAPI.getCode())) {
            request.setOpenid(payReqVO.getOpenId());//(StringUtils.isNotEmpty(payReqVO.getOpenId()) ? payReqVO.getOpenId() : "owEI1vt1fMnuaKFU6J5sQs0ZM5UY")
        }
        //业务订单号
        String orderNumber = StringUtils.isNotBlank(payReqVO.getOrderNumber()) ? payReqVO.getOrderNumber() : String.valueOf(System.currentTimeMillis());
        request.setBizOrderId(orderNumber);
        //交易金额
        request.setAmount(payReqVO.getOrderFees() + "");
        String orderName = "检测费"; //订单信息
        String goodsName = "样品检测";
        switch (payReqVO.getTransactionType()) {
            case 0:
                orderName = "样品检测费，订单号：" + orderNumber;
                break;
            case 1:
                orderName = "样品复检费用，订单号：" + orderNumber;
                goodsName = "样品复检";
                break;
            case 2:
                orderName = "余额充值";
                goodsName = "余额充值";
                break;
            default:
                break;
        }

        request.setOrderName(orderName);
        //支付类型
        request.setPayType(payReqVO.getPayType());
        //终端IP
        request.setTerminalIp(payReqVO.getTerminalIp());
        //商品列表
        List<Goods> goodsDetail = new ArrayList<>();
        Goods good = new Goods();
        good.setGoodsName(goodsName);
        goodsDetail.add(good);
        request.setGoodsDetail(goodsDetail);
        //后台回调地址
        request.setNotifyUrl(ChannelConfig.notifyUrl);
        //前台回调地址
        request.setFrontUrl(ChannelConfig.frontUrl);
        BaseResponse<HfPaymentOrderResponse> baseResponse = PaymentClient.hfPayment(request);
        log.info("1.交易接口返回数据：" + JsonUtil.toJsonStr(baseResponse));
        return baseResponse;
    }

    /**
     * Description 交易查询：
     * //响应参数：{"code":"0000","data":{"amount":"800000","channelOrderId":"ZF1679465432191070208","merOrderId":"2022052100543992274hf","outTransId":"1679465432350453760","partyOrderId":"1679465432191070209","splitList":[{"splitAmount":"100000","splitType":"2","splitUserId":"22646118415"},{"splitAmount":"200000","splitType":"1","splitUserId":"23693056068"},{"splitAmount":"500000","splitType":"0","splitUserId":"702195200955"}],"status":"1"},"msg":"操作成功"}
     *
     * @param merOrderId : 原请求订单号(必填)  字段长度最长：32位
     * @param queryType: 交易类型：1：支付查询 2：退款查询 3：确认收货查询 4：结算查询 5：充值查询 6：转账查询 7：异步分账查询(必填)  字段长度最长：1位
     * @Author xiaoyl
     * @Date 2025/6/24 9:45
     */
    public static BaseResponse<PaymentQueryResponse> queryOrder(String merOrderId, String queryType) {
        QueryOrderRequest queryOrder = new QueryOrderRequest();
        queryOrder.setMerOrderId(System.currentTimeMillis() + "");
        queryOrder.setMerchantNo(ChannelConfig.merchantNo);
        queryOrder.setOriginalMerOrderId(merOrderId);
        //1：支付查询 2：退款查询 3：确认收货查询 4：结算查询 5：充值查询 6：转账查询 7：异步分账查询(必填)  字段长度最长：1位
        queryOrder.setQueryType(queryType);
        BaseResponse response = TradeQueryClient.hfTradeQuery(queryOrder);
        System.out.println(JsonUtil.toJsonStr(response));
        log.info("交易查询接口返回：" + JsonUtil.toJsonStr(response));
        return response;
    }

    /**
     * Description:分账方法
     * {"code":"0000","data":{"merOrderId":"1693310297985","parameter1":"","parameter2":"","status":"2"},"msg":"操作成功"}
     * {"merOrderId":"1693310297985","parameter1":"","parameter2":"","status":"2"}
     * mallbook请求参数: {"date":"1693310298091","serverCode":"complete","sign":"a19E572kt7VTcRg1kZj2DLg4DBdgPiuryYLKPX+Eh/iyWmMRjPADJ/NkSWLNZJXlFRlKE2DplC7lNIBoJpQwFsvwT+Qc6UUIWt9Me68kONQ/3GpZDq3Z6Ulro075y/rN0lhMpITkcOwiW+C75wDbdshrLn+h29MbOnwIG8+LkWg=","channelType":"HF","params":"{\"notifyUrl\":\"https://dev.6tfish.com/notice\",\"originalMerOrderId\":\"2022042100657087363hf\",\"parameter1\":\"\",\"parameter2\":\"\",\"splitList\":[{\"splitAmount\":\"1\",\"splitType\":\"0\",\"splitUserId\":\"702195200955\"}]}","version":"1.0.0","merOrderId":"1693310297985","merchantNo":"hf0919"}
     * mallbook响应参数: {"result":"{\"merOrderId\":\"1693310297985\",\"parameter1\":\"\",\"parameter2\":\"\",\"status\":\"2\"}","sign":"n3g6nfdYypppLShuZc4Xy4kU/F7c6vIm0O7N1XUD7q2MaTtNY2FHMUXIepiI+hYSYBdd5EXJAixTR6oPkphCVRanwc21mQYnHc1LxkhQ9cwr5cmz5W/nq5pkWapq5A+VDz0749j3d7AkHM5i6x6SdhvErpPmzg96XTZCoftu5eY=","code":"0000","msg":"操作成功","date":"1693310298200","version":"1.0.0"}
     */
    public static BaseResponse<HfCompleteResponse> splitAmount(SplitAmountReqVO splitAmountReqVO) {
        HfCompleteRequest complete = new HfCompleteRequest();
        complete.setMerchantNo(ChannelConfig.merchantNo);
        complete.setMerOrderId(splitAmountReqVO.getMerOrderId());
        //原支付请求订单号(必填) 字段长度最长：32位
        complete.setOriginalMerOrderId(splitAmountReqVO.getOriginalMerOrderId());
        //后台回调地址(必填) 字段长度最长：256位
        complete.setNotifyUrl(ChannelConfig.splitNotifyUrl);
        //{"splitList":[{"userId":"95786578844384 ","userName":"肖裕玲","splitRate":100}]}
        JSONArray splitArray = JSON.parseArray(ChannelConfig.splitList);
        //分账方列表
        List<PaymentOrderUser> splitList = new ArrayList<>();
        if(splitAmountReqVO.getSplitMembers().size()>0){
            //封装分账方对象
            for (SplitMember bean:splitAmountReqVO.getSplitMembers()) {
                PaymentOrderUser pamentOrderUser = new PaymentOrderUser();
                //分账方会员ID（必填） 字段长度最长：20位
                pamentOrderUser.setSplitUserId(bean.getMbUserId());
                //分账金额（必填） 字段长度最长：12位
                String money = calculateSplitAmount(String.valueOf(splitAmountReqVO.getSplitMoney()),bean.getSplitRate());
                pamentOrderUser.setSplitAmount(money);
                //分账类型（必填）字段长度最长：1位: 0：收单金额（收款人）,1：分账金额, 2：佣金
                pamentOrderUser.setSplitType("1");
                splitList.add(pamentOrderUser);
            }
        }
        complete.setSplitList(splitList);
        BaseResponse<HfCompleteResponse> response = CompleteClient.hfComplete(complete);
        log.info(JsonUtil.toJsonStr(response));
        //返回分账方列表对象数据，用于写入数据库，后续确认收货接口直接调用即可
        if(null!= response.getData()){
            response.getData().setParameter1(JSON.toJSONString(splitList));
        }
        return response;
    }

    /**
     * Description 计算分账金额:订单金额*分账比例
     *
     * @Author xiaoyl
     * @Date 2025/7/18 16:38
     */
    public static String calculateSplitAmount(String totalAmount, int splitRate) {
        try {
            // 检查输入有效性
            if (totalAmount == null || totalAmount.isEmpty()) {
                return "0";
            }
            // 创建 BigDecimal 并计算
            BigDecimal amount = new BigDecimal(totalAmount);
            BigDecimal rate = new BigDecimal(splitRate);
            BigDecimal divisor = new BigDecimal("100");

            // 执行计算并保留两位小数（四舍五入）
            return amount.multiply(rate)
                    .divide(divisor, 2, BigDecimal.ROUND_HALF_UP)
                    .setScale(0, RoundingMode.HALF_UP)
                    .toPlainString();
        } catch (NumberFormatException e) {
            // 处理金额格式错误
            return "0";
        } catch (ArithmeticException e) {
            // 处理除零等异常
            return "0";
        }
    }

    /**
     * Description 确认收货,返回参数以JSON方式同步返回。code结果代码返回0000为确认收货成功。
     * //mallbook请求参数:{merOrderId='3db4622d5f6a4c02b614f43b95250c2e', merchantNo='mallbook', sign='cGTXI0gegoflLU2wY8Z2H29tEt1ZueQQ38oJCXyMA6gIMKKRqmkuWZTg8dhng4dsQO1dy7/4eZ1o/vHLmNG3xGd3/8Uly6V7nWOez33K3O+BkgRGb7bfYxVCMzwdcOOHvOOyCQOu50hxLoiGphd/qr18LPYxlcqv5lu5gIQzXaA=', serverCode='receive', params='{"splitList":[{"rcvSplitAmount":"1","splitUserId":"300213760751"}],"rcvAmount":"1","originalMerOrderId":"20221008001","asynMerOrderId":"202210080001","goodsDetail":[{"quantity":"1","goodsId":"","price":"1","goodsName":"商品1"}],"parameter2":"参数2","parameter1":"参数1"}', date='1665279689932', version='1.0.0', channelType='HF'}
     * //mallbook响应参数:{"result":"{\"merOrderId\":\"3db4622d5f6a4c02b614f43b95250c2e\",\"parameter1\":\"参数1\",\"parameter2\":\"参数2\",\"rcvAmount\":\"1\"}","sign":"Xb0EameRXxUQGlM9RSWI2AbgGw3L7TmQftNrzTQCTmwfojKon+QBXcXgMZb4PUMt2/OZuyVvrddeDpzCwA4vaOAQ8KHy3kZE4luKCOLrJmFgE5Xo/wIPfK3LILRikLVvOu1MxKHcdlrdfvyMqIwE8ff80p+VzFrdFeLH4FAg+fc=","code":"0000","msg":"操作成功","date":"1665279727976","version":"1.0.0"}
     *
     * @Author xiaoyl
     * @Date 2025/7/18 15:23
     */
    public static BaseResponse<HfReceiveResponse> receiveGoods(SplitAmount splitAmount) {
        HfReceiveRequest receive = new HfReceiveRequest();
        receive.setMerchantNo(ChannelConfig.merchantNo);
        receive.setMerOrderId(splitAmount.getReceiveNumber());
        //原支付请求订单号(必填) 字段长度最长：32位
        receive.setOriginalMerOrderId(splitAmount.getIncomeNumber());
        //异步分账订单号 字段长度最长：32位
        receive.setAsynMerOrderId(splitAmount.getNumber());
        //确认收货总额(必填) 必须大于0 且要等于总确认分账金额 字段长度最长：12位
        receive.setRcvAmount(splitAmount.getSplitMoney() + "");
        /**
         * 分账方列表(必填)
         */
        List<PaymentOrderUser> splitList = JSONArray.parseArray(splitAmount.getSplitJson(), PaymentOrderUser.class);
        List<ReceiveUser> splitList2 = new ArrayList<>();
        for (PaymentOrderUser orderUser : splitList) {
            ReceiveUser receiveUser = new ReceiveUser();
            //分账方子商户编号(必填) 字段长度最长：20位
            receiveUser.setSplitUserId(orderUser.getSplitUserId());
            //确认分账金额(必填) 字段长度最长：12位
            receiveUser.setRcvSplitAmount(orderUser.getSplitAmount());
            splitList2.add(receiveUser);
        }
        receive.setSplitList(splitList2);
        BaseResponse<HfReceiveResponse> response = ReceiveClient.hfReceive(receive);
        log.info(JsonUtil.toJsonStr(response));
        return response;
    }


    /**
     * Description 退款接口
     * // {"code":"0000","data":{"merOrderId":"1693307883224","refundAmount":"1","status":"2","statusMsg":"原支付交易未成功"},"msg":"操作成功"}
     * //{"merOrderId":"1693307883224","refundAmount":"1","status":"2","statusMsg":"原支付交易未成功"}
     * 担保交易多次异步分账部分退款 退款成功请求、响应报文
     * mallbook请求参数:{"date":"1665478628685","sign":"A1PYj8anAbmdzy6mfeegNyTp4FmCco16xVHqAPLxR+9HDR//r9hEZDnrAco24wFQYakc7BIfyLzK8GjxK2jZuzErGmVHVLB8jzG/5DnnZ2nX4YfQJygZQhHjFMtEgW20yICSSLJxTNcGfzgk9+kmS9ahA0TYZe5TpHZQv+amgkI=","channelType":"HF","params":"{\"splitList\":[{\"splitUserId\":\"24309248755\",\"refundSplitAmount\":\"1\"}],\"originalMerOrderId\":\"20221011010980016\",\"asynMerOrderId\":\"2022101009230068\",\"notifyUrl\":\"http://www.baidu.com/\",\"refundAmount\":\"1\"}","version":"1.0.0","serverCode":"refund","merchantNo":"mallbook","merOrderId":"421ad73ac674472da6fca64b7a065624"}
     * mallbook响应参数:{"result":"{\"merOrderId\":\"421ad73ac674472da6fca64b7a065624\",\"refundAmount\":\"1\",\"status\":\"0\",\"statusMsg\":\"\"}","sign":"PpRWDaWFtE7qar18e8oYVmetnEfAYQ+AIGQ31fendvD0O6th2Bf/qvV66AYaNrXl9fNB31p8Bl8TWcZ4/CeW+bNf16HNbqF7utxjt7b+t1bCx+7T/kpVdjFrfbRfccNKhbuavHi6tPeBH8oGZATC7T9hpTUYDx2Rldro8VmZDG4=","code":"0000","msg":"操作成功","date":"1665478642510","version":"1.0.0"}
     *
     * @Author xiaoyl
     * @Date 2025/7/14 15:13
     */
    public static BaseResponse<HfRefundResponse> requestAsyncRefund(String originalMerOrderId, int money) {
        //确认收货退款
        HfRefundRequest refund = new HfRefundRequest();
        refund.setMerchantNo(ChannelConfig.merchantNo);
        refund.setMerOrderId(System.currentTimeMillis() + "");
        // 原支付请求订单号(必填)
        refund.setOriginalMerOrderId(originalMerOrderId);
        // 退分账金额，必填
        refund.setRefundAmount(money + "");
        refund.setNotifyUrl(ChannelConfig.reFundnotifyUrl);
        BaseResponse<HfRefundResponse> response = RefundClient.hfRefund(refund);
        return response;
    }
    /**
     * Description 提现接口
     *MallBook请求参数:{"channelType":"HF","date":"1752906013223","merOrderId":"J20250719142004462","merchantNo":"HF20250623","params":"{\"amount\":\"4\",\"notifyUrl\":\"http://b6a8a7f6.natappfree.cc/dykjfw/api/pay/callBackNotify/3\",\"settlementToAccount\":\"T1\",\"userId\":\"95786578844384\"}","serverCode":"withdraw","sign":"FoxXglOpYbMmoHvorzknURqOiiwUTwJK7IeJxb/lZEvDIHJ5oqUBvavYUFRcJS5wjuyPSsMYr5GiL51C/XpUR/bwXlQOEIZBDWpym/9aLq3q8NK+qjTWgJpHNMlMQCXa8szEViYtFSDEhyp5uA+AJsQiVwAoYNMSRzEJ1J0GXHs=","version":"1.3.0"}
     *MallBook响应参数:{"result":"{\"amount\":\"4\",\"bankAcctNo\":\"6214832013223487\",\"createTime\":\"2025-07-19 14:20:17\",\"merOrderId\":\"J20250719142004462\",\"status\":\"0\",\"statusMsg\":\"\",\"userId\":\"95786578844384\",\"withdrawBackFlag\":\"0\"}","sign":"sMVzPxeBeWEg4UuUzh3XK861R7Jz+tRDfge8scsEZEmU5N3CkHuoBdUrtLnFbO7Uf9cyIbgbUeL2sqrfMmVgvfLafW1RDr5slwCxhiYZHv8uOmEhTHORqafCvsgpLQ54NkX2QaO3kSmhhRIKcZXPKWgvNiR7PdLGetqo0OQNhEg=","code":"0000","msg":"操作成功","date":"1752906016975","version":"1.3.0"}
     * @Author xiaoyl
     * @Date 2025/7/19 11:17
     */
    public static BaseResponse<HfWithdrawResponse> withDrawal(WithDrawalReqVO drawalReqVO) {
        HfWithdrawRequest withdraw = new HfWithdrawRequest();
        withdraw.setMerchantNo(ChannelConfig.merchantNo);
        withdraw.setMerOrderId(drawalReqVO.getMerOrderId());
        /**
         * 子商户编号(必填) 字段长度最长：20位
         */
        withdraw.setUserId(drawalReqVO.getUserId());
        /**
         * 结算金额 (必填)(结算金额必须大于0) 字段长度最长：12位
         */
        withdraw.setAmount(drawalReqVO.getAmount());

        /**
         * 后台回调地址(必填) 字段长度最长：256位
         */
        withdraw.setNotifyUrl(ChannelConfig.withDrawalNotifyUrl);
        /**
         * 到账时效
         * T1：下一个工作日到账
         * D1：下一个自然日到账
         * D0：实时到账，有额外费用
         * DM：实时到账，没有费用，但有额度限制
         */
        withdraw.setSettlementToAccount("T1");
        BaseResponse<HfWithdrawResponse> response = WithdrawClient.hfWithdraw(withdraw);
        return response;
    }
}
