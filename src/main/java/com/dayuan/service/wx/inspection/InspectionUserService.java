package com.dayuan.service.wx.inspection;

import com.alibaba.fastjson.JSON;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.dayuan.bean.wx.inspection.InspectionUser;
import com.dayuan.controller.wx.inspection.VerifyCodeVO;
import com.dayuan.exception.MyException;
import com.dayuan.mapper.BaseMapper;
import com.dayuan.mapper.wx.inspection.InspectionUserMapper;
import com.dayuan.model.wx.inspection.InspectionUserModel;
import com.dayuan.service.BaseService;
import com.dayuan.util.CipherUtil;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.UserContext;
import com.dayuan.util.wx.WxConst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InspectionUserService extends BaseService<InspectionUser, Integer> {

    //以下为阿里大于短信验证码字段
    @Value("${msg.SignName}")
    private String SignName;//短信签名
    @Value("${msg.TemplateCode}")
    private String TemplateCode;//模板ID
    @Value("${msg.accessKeyId}")
    private String accessKeyId;//短信签名
    @Value("${msg.accessKeySecret}")
    private String accessKeySecret;//短信签名

    @Autowired
    private InspectionUserMapper mapper;
    @Autowired
    private InspectionInformationService inspectionInformationService;

    @Override
    public BaseMapper<InspectionUser, Integer> getMapper() {
        return mapper;
    }

    /**
     * 根据账号密码查询用户信息
     *
     * @param userName
     * @param password
     * @return
     * @throws Exception
     */
    public InspectionUser selectUserByUserNameOrPassword(String userName, String password, String openid) throws Exception {
        InspectionUser inspectionUser = mapper.selectUserByUserNameOrPassword(userName, password, openid);
        if (inspectionUser == null) {
            throw new MyException("账号,密码错误或账号和微信不匹配");
        } else {
            return inspectionUser;
        }
    }

    /**
     * 根据电话号码查询用户信息
     *
     * @param mobilePhone
     * @return
     */
    public void selectInspectionUser(String mobilePhone) throws Exception {
        InspectionUser inspectionUser = mapper.selectInspectionUser(mobilePhone);
        if (inspectionUser != null) {
            throw new MyException("注册失败,该号码已被注册");
        }
    }

    /**
     * 通过手机号码和用户名查询用户
     *
     * @param mobilePhone
     * @return
     */
    public InspectionUser selectUserByPhone(String mobilePhone) throws Exception {
        InspectionUser inspectionUser = mapper.selectUserByPhone(mobilePhone);
        if (inspectionUser == null) {
            throw new MyException("账号和手机号不匹配");
        } else {
            return inspectionUser;
        }
    }

    /**
     * 通过账号名称查询用户
     *
     * @param userName
     * @return
     */
    public InspectionUser selectUserByUsername(String userName) throws Exception {
        InspectionUser inspectionUser = mapper.selectUserByUsername(userName);
        if (inspectionUser == null) {
            throw new MyException("该账号不存在");
        } else {
            return inspectionUser;
        }
    }

    /**
     * 修改密码
     *
     * @param userId
     * @param password
     */
    public void changePassword(Integer userId, String password) throws Exception {
        CipherUtil cipher = new CipherUtil();
        password = CipherUtil.generatePassword(password); // 加密算法
        mapper.changePassword(userId, password);
    }

    /**
     * 根據openid查詢是否授權
     *
     * @param openid
     * @return
     */
    public InspectionUser selectByOpenid(String openid) throws Exception {
        return mapper.selectByOpenid(openid);

    }

    /**
     * 发送短信获取验证码方法
     *
     * @param mobilePhone
     * @throws Exception
     */
    public void sendVerifyCode(String mobilePhone) throws Exception {
        //判断用户之前是否发送了验证码如果当前是第二次获取验证码需要做判断
        VerifyCodeVO VerifyCodeVO = UserContext.getVerifyCodeInSession();
        //如果是第一次发送或者发送时间大于60秒,才可以获取验证码
        if (VerifyCodeVO == null || DateUtil.getBetweenTime(VerifyCodeVO.getLastSendTime(), new Date()) > WxConst.STIPULATE_TIME) {
            //返回生成的验证码
            //String uuidCode = sendRealMessage(mobilePhone);//调用网易
            String uuidCode = StringUtil.numRandom(4);//随机数
            sendSms(mobilePhone, uuidCode);
            //保存在VerifyCodeVO对象中
            VerifyCodeVO verifyCodeVO = new VerifyCodeVO();
            verifyCodeVO.setPhoneNumber(mobilePhone);
            verifyCodeVO.setVerifyCode(uuidCode);
            verifyCodeVO.setLastSendTime(new Date());
            //把该验证信息存入session中
            UserContext.setVerifyCodeInSession(verifyCodeVO);
            System.out.println(uuidCode + "=======================================================");
        } else {
            throw new MyException("操作太频繁,请稍后再试");
        }
    }


    //阿里大于短信验证码发送
    public SendSmsResponse sendSms(String phoneNumber, String uuidCode) throws Exception {

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
        request.setPhoneNumbers(phoneNumber);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName(SignName);
        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode(TemplateCode);
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        Map<String, String> map = new HashMap<>();
        map.put("code", uuidCode);
        String JSONStr = JSON.toJSONString(map);
        request.setTemplateParam(JSONStr);
        //选填-上行短信扩展码(无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        String code = sendSmsResponse.getCode();
        if (code != null) {
            if (sendSmsResponse.getCode().equals("OK")) {
                System.out.println("请求成功--------------------");
            } else if (sendSmsResponse.getCode().equals("isv.MOBILE_NUMBER_ILLEGAL")) {
                throw new MyException("非法手机号");
            } else if (sendSmsResponse.getCode().equals("isv.MOBILE_COUNT_OVER_LIMIT")) {
                throw new MyException("手机号码数量超过限制");
            } else if (sendSmsResponse.getCode().equals("isv.OUT_OF_SERVICE")) {
                throw new MyException("业务停机");
            } else if (sendSmsResponse.getCode().equals("isv.ACCOUNT_NOT_EXISTS")) {
                throw new MyException("账户不存在");
            } else if (sendSmsResponse.getCode().equals("isv.BUSINESS_LIMIT_CONTROL")) {
                throw new MyException("当天可发短信数量超额,请明天再试");
            }
            System.out.println("请求错误码：" + code);
        } else {
            throw new MyException("发送失败，请联系管理员");
        }
        return sendSmsResponse;
    }

    /**
     * 查询用户
     *
     * @param mobilePhone
     * @return
     */
    public InspectionUser selectUserPhoneAndOpenid(String mobilePhone) throws Exception {
        return mapper.selectUserPhoneAndOpenid(mobilePhone);
    }

    /**
     * 查询用户
     *
     * @param mobilePhone
     * @return
     */
    public InspectionUser selectUserPhoneAndOpenid2(String mobilePhone, String departId) throws Exception {
        return mapper.selectUserPhoneAndOpenid2(mobilePhone, departId);
    }

    /**
     * 更换手机号码
     *
     * @param inspection_user
     */
    public void replacePhoneByUser(InspectionUser inspection_user) throws Exception {
        try {
            mapper.replacePhoneByUser(inspection_user);
        } catch (Exception e) {
            throw new MyException("更换失败");
        }
    }

    /**
     * 更改该用户之前送检过的所有送检信息的电话号码
     *
     * @param mobilePhone
     */
    public void replacePhoneInSamping(String oldPhone, String mobilePhone) throws Exception {
        try {
            mapper.replacePhoneInSamping(oldPhone, mobilePhone);
        } catch (Exception e) {
            throw new MyException("数据更改失败");
        }
    }

    /**
     * 更改该用户之前送检过的所有送检信息的电话号码
     *
     * @param mobilePhone
     */
    public void replacePhoneInSamping2(String oldPhone, String mobilePhone, String departId) throws Exception {
        try {
            List<Integer> departIds = inspectionInformationService.selectSonDepartIdById(departId);
            mapper.replacePhoneInSamping2(oldPhone, mobilePhone, departIds);
        } catch (Exception e) {
            throw new MyException("数据更改失败");
        }
    }

    /**
     * 微信界面解绑操作
     *
     * @param inspection_user session中存放当前登陆的用户 有id openid userName mobilePhone等参数
     * @throws Exception
     */
    public void untieUser(InspectionUser inspection_user) throws Exception {
        mapper.untieUser(inspection_user);
    }

    /**
     * 绑定的编辑
     *
     * @param inspectionUser
     */
    public void updateBindUser(InspectionUser inspectionUser) throws Exception {
        mapper.updateBindUser(inspectionUser);

    }

    /**
     * 解绑用户
     *
     * @param id 用户id
     * @throws Exception
     */
    public void deleteOpenidById(Integer id) throws Exception {
        mapper.deleteOpenidById(id);
    }


    /**
     * 通过appid查询关注人数
     *
     * @param model
     * @return
     */
    public List<InspectionUser> selectByAppid(InspectionUserModel model) {
        return mapper.selectByAppid(model);
    }

    /**
     * 保存地址
     */
    public void saveAddress(InspectionUser inspectionUser, InspectionUser sessionUser) throws Exception {
        if (sessionUser != null) {//如果session缓存中的用户不为空
            //缓存中的信息
            String userName = sessionUser.getUserName();
            String nickName = sessionUser.getNickName();
            String sex = sessionUser.getSex();
            String province = sessionUser.getProvince();
            String city = sessionUser.getCity();
            String address = sessionUser.getAddress();
            //用户设置的信息
            String userName2 = inspectionUser.getUserName();
            String nickName2 = inspectionUser.getNickName();
            String sex2 = inspectionUser.getSex();
            String province2 = inspectionUser.getProvince();
            String city2 = inspectionUser.getCity();
            String address2 = inspectionUser.getAddress();
            if (null != userName2 && userName2.equals(userName) && null != nickName2 && nickName2.equals(nickName) && null != sex2 && sex2.equals(sex)//什么都不改动就不做数据库操作
                    && null != province2 && province2.equals(province) && null != city2 && city2.equals(city) && null != address2 && address2.equals(address)) {
                System.out.println("用户信息未改动的保存--------------------------------------------");
            } else {
                mapper.saveAddress(inspectionUser);
                String openid = sessionUser.getOpenid();
                if (StringUtil.isNotEmpty(openid)) {
                    InspectionUser inspection_user = inspectionUser = this.selectByOpenid(openid);
                    if (inspection_user != null) {
                        ContextHolderUtils.getSession().setAttribute("inspection_user", inspectionUser);
                    }
                }
            }
        }

    }
}
