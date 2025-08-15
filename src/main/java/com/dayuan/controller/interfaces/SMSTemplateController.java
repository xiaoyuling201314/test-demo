package com.dayuan.controller.interfaces;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.dayuan.bean.AjaxJson;
import com.dayuan.bean.sms.SMSBean;
import com.dayuan.common.WebConstant;
import com.dayuan.controller.wx.inspection.VerifyCodeVO;
import com.dayuan.exception.MyException;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.UserContext;
import com.dayuan.util.wx.WxConst;
import com.dayuan3.common.util.SystemConfigUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Author: shit
 * Date: 2019-03-21 16:18
 *
 * @Company: 食安科技
 * Content:短信接口 短信模板信息,请到svn寻找短信模板文档
 */
@Controller
@RequestMapping("/interfaces/sms")
public class SMSTemplateController extends BaseInterfaceController {

    /**
     * 发送短信获取验证码方法
     *
     * @return
     * @remark phone      电话号码 必须传递
     * @remark templateId 模板ID 可传递,不传就使用配置文件的默认模板ID
     * @remark serviceId  服务ID(请平台短信发送接口配置中的服务名称相对应，不填写则使用默认配置)
     * @remark paramMap   模板需要的参数，以Map<String, String> 对象的方式传入
     * @remark jsonStr    参数的json字符串，前台自行拼接或者JSON.stringify(planJsonArr) 格式如：{"service":"ali服务器","name":"端州测试系统","msg":"服务异常"}
     * @remark paramMap 和 jsonStr 二选一，可以通过直接传递map也可以传递json字符串，优先选择paramMap对象方式,通知短信参数为空的可不传（可不填）
     */
    @RequestMapping(value = "/send_sms", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson sendSms(SMSBean smsBean) {
        AjaxJson ajaxJson = new AjaxJson();
        //==========================1.定义需要的参数============================
        String signName = "";               //短信签名
        String accessKeyId = "";            //访问秘钥ID
        String accessKeySecret = "";        //访问秘钥
        String phone = "";                  //电话号码
        String templateId = "";             //短信模板ID
        Map<String, String> paramMap = null;//模板参数 map方式（用于通知短信）
        String jsonStr = "";                //模板参数 json字符串格式（用于通知短信）
        String serviceIdDefault = "";         //默认使用的服务名称
        try {
            //==========================2.参数的赋值和校验============================
            phone = smsBean.getPhone();
            paramMap = smsBean.getParamMap();
            jsonStr = smsBean.getParamJsonStr();
            //在执行前先进行参数的基本校验
            required(phone, WebConstant.INTERFACE_CODE2, "参数phone必填");//电话号码必填校验
            //1.数据库配置为空或者传递的配置为空就用默认配置
            JSONObject smsConfigJsonObj = SystemConfigUtil.MESSAGE_INTERFACE_CONFIG;
            if (smsConfigJsonObj != null && smsConfigJsonObj.size() > 0) {//配置读取不为空
                serviceIdDefault = setCheckParam(smsBean.getServiceId(), smsConfigJsonObj.getString("service_id_default"), "短信服务ID不能为空");//赋值与校验
                JSONObject serviceIdObj = smsConfigJsonObj.getJSONObject("service_id");
                if (serviceIdObj != null && serviceIdObj.size() > 0) {
                    //判断是否存在该服务名称
                    if (serviceIdObj.containsKey(serviceIdDefault)) {
                        JSONObject jsonobj = serviceIdObj.getJSONObject(serviceIdDefault);
                        signName = jsonobj.getString("sign_name");
                        accessKeyId = jsonobj.getString("accessKeyId");
                        accessKeySecret = jsonobj.getString("accessKeySecret");
                        required2(signName, WebConstant.INTERFACE_CODE2, "短信签名必填");   //秘钥ID必填校验
                        required2(accessKeyId, WebConstant.INTERFACE_CODE2, "短信秘钥ID必填");   //秘钥ID必填校验
                        required2(accessKeySecret, WebConstant.INTERFACE_CODE2, "短信秘钥必填"); //秘钥ID必填校验
                        templateId = setCheckParam(smsBean.getTemplateId(), jsonobj.getString("template_id"), "短信模板ID不能为空");//赋值与校验
                        //根据类型进行短信发送
                        sendSmsByType(signName, accessKeyId, accessKeySecret, templateId, phone, paramMap, jsonStr, smsBean.getType());
                    } else {
                        required2(accessKeyId, WebConstant.INTERFACE_CODE2, "后台配置的短信服务ID[ " + serviceIdDefault + " ]不存在");   //秘钥ID必填校验
                    }
                } else {
                    throw new MyException("参数错误", "后台读取serviceId内容失败！", WebConstant.INTERFACE_CODE2);
                }
            } else {
                throw new MyException("配置读取失败", "后台配置参数读取失败！", WebConstant.INTERFACE_CODE2);
            }
            ajaxJson.setMsg("发送成功");
        } catch (MyException e) {
            setAjaxJson(ajaxJson, e.getCode(), e.getText());
        } catch (Exception e) {
            setAjaxJson(ajaxJson, WebConstant.INTERFACE_CODE11, "操作失败！", e);
        }
        return ajaxJson;
    }


    /**
     * 根据类型进行短信发送
     *
     * @param signName        短信签名
     * @param accessKeyId     秘钥ID
     * @param accessKeySecret 秘钥
     * @param templateId      模板ID
     * @param phone           电话号码
     * @param paramMap        模板参数 map方式（用于通知短信,paramMap和jsonStr两种方式传值选择一种即可）
     * @param jsonStr         模板参数 json字符串格式（用于通知短信）
     * @param type            短信类型 0：验证码短信 1：通知短信（不传则默认验证码方式）
     */
    private void sendSmsByType(String signName, String accessKeyId, String accessKeySecret, String templateId, String phone, Map<String, String> paramMap, String jsonStr, Short type) throws Exception {
        //==============================1.确定短信类型为验证码还是通知短信==========================
        if (type == 0) {//验证码短信
            paramMap = new HashMap<>();
            //判断用户之前是否发送了验证码如果当前是第二次获取验证码需要做判断
            VerifyCodeVO VerifyCodeVO = UserContext.getVerifyCodeInSession();
            //如果是第一次发送或者发送时间大于60秒,才可以获取验证码
            if (VerifyCodeVO == null || DateUtil.getBetweenTime(VerifyCodeVO.getLastSendTime(), new Date()) > WxConst.STIPULATE_TIME) {
                //返回生成的验证码
                String uuidCode = StringUtil.numRandom(4);//随机数
                paramMap.put("code", uuidCode);
                sendSms(signName, accessKeyId, accessKeySecret, templateId, phone, JSON.toJSONString(paramMap));
                //保存在VerifyCodeVO对象中
                VerifyCodeVO verifyCodeVO = new VerifyCodeVO();
                verifyCodeVO.setPhoneNumber(phone);
                verifyCodeVO.setVerifyCode(uuidCode);
                verifyCodeVO.setLastSendTime(new Date());
                //把该验证信息存入session中
                UserContext.setVerifyCodeInSession(verifyCodeVO);
            } else {
                throw new MyException("操作异常", "操作太频繁,请稍后再试", WebConstant.INTERFACE_CODE2);
            }
        } else {//通知短信
            if (StringUtil.isNotEmpty(jsonStr)) {
                sendSms(signName, accessKeyId, accessKeySecret, templateId, phone, jsonStr);
            } else if (paramMap != null) {
                sendSms(signName, accessKeyId, accessKeySecret, templateId, phone, JSON.toJSONString(paramMap));
            } else {//表示传递空参数
                sendSms(signName, accessKeyId, accessKeySecret, templateId, phone, JSON.toJSONString(new HashMap<>()));
            }
        }
    }


    //阿里大于短信验证码发送
    private SendSmsResponse sendSms(String signName, String accessKeyId, String accessKeySecret, String templateId, String phone, String JSONStr /*Map<String, String> paramMap*/) throws Exception {
        //可自助调整超时时间
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");

        //初始化acsClient,暂不支持region化
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", WxConst.product, WxConst.domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);

        //组装请求对象-具体描述见控制台-文档部分内容
        SendSmsRequest request = new SendSmsRequest();
        //必填:待发送手机号
        request.setPhoneNumbers(phone);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName(signName);
        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode(templateId);
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //String JSONStr = JSON.toJSONString(paramMap);
        request.setTemplateParam(JSONStr);
        //选填-上行短信扩展码(无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        String code = sendSmsResponse.getCode();
        if (code != null) {
            checkCode(code);
        } else {
            throw new MyException("操作异常", "发送失败，请联系管理员！", WebConstant.INTERFACE_CODE11);
        }
        return sendSmsResponse;
    }


    /**
     * 默认返回参数1，参数1为空则返回参数2，参数1和参数2都为空则抛出异常
     *
     * @param param1 参数1
     * @param param2 参数2
     * @return
     */
    private String setCheckParam(String param1, String param2, String msg) throws MyException {
        if (StringUtil.isNotEmpty(param1)) {
            return param1;
        } else if (StringUtil.isNotEmpty(param2)) {
            return param2;
        } else {
            throw new MyException("接口参数错误", msg, WebConstant.INTERFACE_CODE2);
        }
    }


    /**
     * 接口参数必填验证
     *
     * @param obj      验证参数
     * @param tipsCode 错误码
     * @param tipsMsg  提示信息
     * @throws MyException
     */
    private void required2(Object obj, String tipsCode, String tipsMsg) throws MyException {
        if (!StringUtil.isNotEmpty(obj)) {
            throw new MyException("后台配置参数错误", tipsMsg, tipsCode);
        }
    }


    /**
     * 错误码的校验
     *
     * @param code
     * @throws Exception
     */
    private void checkCode(String code) throws Exception {
        if (code.equals("OK")) {
            System.out.println("请求成功--------------------");
        } else {
            System.out.println("请求错误码：" + code);
            if ("isv.MOBILE_NUMBER_ILLEGAL".equals(code)) {
                throw new MyException("接口参数错误", "非法手机号", code);
            } else if ("isv.MOBILE_COUNT_OVER_LIMIT".equals(code)) {
                throw new MyException("接口参数错误", "手机号码数量超过限制", code);
            } else if ("isv.OUT_OF_SERVICE".equals(code)) {
                throw new MyException("短信服务异常", "业务停机", code);
            } else if ("isv.ACCOUNT_NOT_EXISTS".equals(code)) {
                throw new MyException("短信服务异常", "账户不存在", code);
            } else if ("isv.BUSINESS_LIMIT_CONTROL".equals(code)) {
                throw new MyException("当日发送超额异常", "当天可发短信数量超额,请明天再试", code);
            } else if ("isv.TEMPLATE_MISSING_PARAMETERS".equals(code)) {
                throw new MyException("模版参数匹配异常", "模版缺少变量", code);
            } else if ("isv.PARAM_LENGTH_LIMIT".equals(code)) {
                throw new MyException("接口参数错误", "参数超出长度限制", code);
            } else if ("isv.AMOUNT_NOT_ENOUGH".equals(code)) {
                throw new MyException("短信服务异常", "账户余额不足", code);
            } else if ("isv.SMS_TEMPLATE_ILLEGAL".equals(code)) {
                throw new MyException("接口参数错误", "短信模版不合法", code);
            } else if ("isv.SMS_SIGNATURE_ILLEGAL".equals(code)) {
                throw new MyException("接口参数错误", "短信签名不合法", code);
            } else if ("isv.INVALID_PARAMETERS".equals(code)) {
                throw new MyException("接口参数错误", "短信模板内容参数格式错误", code);
            } else if ("isv.SMS_SIGNATURE_SCENE_ILLEGAL".equals(code)) {
                throw new MyException("短信签名场景非法", "签名的适用场景与短信类型不匹配", code);
            } else if ("isv.SMS_CONTENT_ILLEGAL".equals(code)) {
                throw new MyException("短信内容非法", "短信内容包含禁止发送内容", code);
            } else if ("isv.PARAM_NOT_SUPPORT_URL".equals(code)) {
                throw new MyException("不支持URL", "变量中不允许透传URL", code);
            } else {
                throw new MyException("短信其他异常", "短信其他异常，请联系管理员", code);
            }
        }
    }
    //serviceId 取默认值

    /**
     * @param templateId //短信模板ID
     * @param phone      //电话号码
     * @param paramMap   //模板参数 map方式（用于通知短信）
     * @throws Exception
     */
    public void sendSmsLocal(String templateId, String phone, Map<String, String> paramMap) throws Exception {
        //==========================1.定义需要的参数============================
        String signName = "";               //短信签名
        String accessKeyId = "";            //访问秘钥ID
        String accessKeySecret = "";        //访问秘钥
        String serviceId = "";              //短信服务ID 为空的话就取默认值
        //String phone = "";                  //电话号码
        //String templateId = "";             //短信模板ID
        //Map<String, String> paramMap = null;//模板参数 map方式（用于通知短信）
        String jsonStr = "";                //模板参数 json字符串格式（用于通知短信）
        String serviceIdDefault = "";         //默认使用的服务名称
        //1.数据库配置为空或者传递的配置为空就用默认配置
        JSONObject smsConfigJsonObj = SystemConfigUtil.MESSAGE_INTERFACE_CONFIG;
        if (smsConfigJsonObj != null && smsConfigJsonObj.size() > 0) {//配置读取不为空
            serviceIdDefault = setCheckParam(serviceId, smsConfigJsonObj.getString("service_id_default"), "短信服务ID不能为空");//赋值与校验
            JSONObject serviceIdObj = smsConfigJsonObj.getJSONObject("service_id");
            if (serviceIdObj != null && serviceIdObj.size() > 0) {
                //判断是否存在该服务名称
                if (serviceIdObj.containsKey(serviceIdDefault)) {
                    JSONObject jsonobj = serviceIdObj.getJSONObject(serviceIdDefault);
                    signName = jsonobj.getString("sign_name");
                    accessKeyId = jsonobj.getString("accessKeyId");
                    accessKeySecret = jsonobj.getString("accessKeySecret");
                    required2(signName, WebConstant.INTERFACE_CODE2, "短信签名必填");   //秘钥ID必填校验
                    required2(accessKeyId, WebConstant.INTERFACE_CODE2, "短信秘钥ID必填");   //秘钥ID必填校验
                    required2(accessKeySecret, WebConstant.INTERFACE_CODE2, "短信秘钥必填"); //秘钥ID必填校验
                    templateId = setCheckParam(templateId, jsonobj.getString("template_id"), "短信模板ID不能为空");//赋值与校验
                    //根据类型进行短信发送
                    sendSmsByType(signName, accessKeyId, accessKeySecret, templateId, phone, paramMap, jsonStr, new Short("1"));
                } else {
                    required2(accessKeyId, WebConstant.INTERFACE_CODE2, "后台配置的短信服务ID[ " + serviceIdDefault + " ]不存在");   //秘钥ID必填校验
                }
            } else {
                throw new MyException("参数错误", "后台读取serviceId内容失败！", WebConstant.INTERFACE_CODE2);
            }
        } else {
            throw new MyException("配置读取失败", "后台配置参数读取失败！", WebConstant.INTERFACE_CODE2);
        }
    }


    /*

   //前台调用接口测试代码参考
    //发送验证码（发送验证码只需要传递 phone，signName，templateId 这三个字段即可）
    function dj() {
        $.ajax({
            url: "${webRoot}/interfaces/sms/send_sms",
            dataType: "json",
            type: "POST",
            data: {
                phone: '17722665293',           //手机号码（必填）
                //type: 1,                      //短信类型 0：验证码短信 1：通知短信,不传则默认验证码方式（可不填）
                //serviceId: 'zjdy',            //短信服务ID,不写就取默认值（可不填）
                //templateId: 'SMS_176928520'   //短信模板ID,不写就取默认值（可不填）
            },
            success: function (data) {
                alert(data.msg);
            }
        });
    }


    //发送通知短信
    function dj() {
        $.ajax({
            url: "${webRoot}/interfaces/sms/send_sms",
            dataType: "json",
            type: "POST",
            method: "POST",
            data: {
                phone: '17722665293',           //手机号码（必填）
                templateId: 'SMS_187935869',    //短信模板ID,不写就取默认值（可不填）
                type: 1,                        //短信类型 0：验证码短信 1：通知短信（不传则默认验证码方式）
                serviceId: 'zjdy2',              //短信服务ID,不写就取默认值（可不填）
                paramJsonStr: JSON.stringify({date: '4-15 13:29', market: "江南市场 A档", food: "白菜",item:"有机磷和氨基甲酸酯类农药残留"}),
                //paramJsonStr: JSON.stringify({server: 'ali(测试数据2)', name: "dztest", number: 3}),//paramMap 和 jsonStr 二选一，可以通过直接传递map也可以传递json字符串，优先选择paramJsonStr对象方式,通知短信参数为空的可不传（可不填）
                //paramMap: {server: 'ali(测试数据1)', name: "dztest", number: 3}//paramMap 和 jsonStr 二选一，可以通过直接传递map也可以传递json字符串，优先选择paramJsonStr对象方式,通知短信参数为空的可不传（可不填）
            },
            success: function (data) {
                alert(data.msg);
            }
        });
    }

     */


    /*@RequestMapping("/sms_test")
    public String testSendSMS() {
        System.out.println("");
        return "/wxPay/sms_test";
    }*/


}
