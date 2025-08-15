package com.dayuan.util.imouPlayer;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.AjaxJson;
import com.dayuan.common.WebConstant;
import com.dayuan.exception.MyException;
import com.dayuan3.common.util.SystemConfigUtil;
import net.jodah.expiringmap.ExpirationPolicy;
import net.jodah.expiringmap.ExpiringMap;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

/**
 * @Description 乐橙摄像头方法封装
 * @Author xiaoyl
 * @Date 2022-07-18 10:39
 */
public class LeChengMonitorUtil {

    //保存视频监控相关账号的轻应用accessToken:
    // 获取到的accessToken有效期是3天，请在即将过期或者接口报错TK1002时重新获取，每个accessToken具备独立的3天生命周期，请勿频繁调用避免占用过多接口调用次数
    private static final ExpiringMap<String, Object> accessTokenMap = ExpiringMap.builder().variableExpiration().expirationPolicy(ExpirationPolicy.CREATED).build();

    /**
     * @return
     * @Description 根据手机号码获取token信息
     * @Date 2022/07/18 11:12
     * @Author xiaoyl
     * @Param
     */
    public static String getToken(String accountPhone,String dev) throws MyException {
        String token = "";
        if (SystemConfigUtil.MONITOR_CONFIG.getJSONObject("account").getJSONObject(accountPhone) == null) {
            throw new MyException("乐橙账号未配置", "系统参数中未配置:" + accountPhone + "相关的乐橙账号信息", WebConstant.INTERFACE_CODE11);
        }
        //首先判断本地map中有没有accessToken，没有则前往乐橙云后台获取
        HashMap<String, Object> paramsMap = new HashMap<String, Object>();
        if (accessTokenMap.get("account_" + accountPhone) == null) {//accessToken，2天有校
            com.alibaba.fastjson.JSONObject returnJson = HttpSend.execute(paramsMap, "accessToken", accountPhone);
            if (returnJson == null || !returnJson.getJSONObject("result").getString("code").equals("0")) {
                throw new MyException("获取accessToken失败", "请配置:" + accountPhone + "正确的APPID和秘钥，如果不知道appsecret，请登录open.lechange.com，开发者服务模块中创建应用", WebConstant.INTERFACE_CODE11);
            } else {
                token = returnJson.getJSONObject("result").getJSONObject("data").getString("accessToken");
                accessTokenMap.put("account_" + accountPhone, token, 172800,TimeUnit.SECONDS);//2天有效期172800，实际使用的时候提前刷新
            }
        } else {
            //从缓存中获取token需先测试一下token是否有效，如果无效则先从accessTokenMap中移除然后重新获取
            token = accessTokenMap.get("account_" + accountPhone).toString();
            JSONObject jsonObject = getDeviceBindOrNot(token,accountPhone, dev);
            if(jsonObject.getJSONObject("result").getString("code").equals("TK1002")){//token已过期或不存在，请重新获取token
                accessTokenMap.remove("account_" + accountPhone);
                getToken(accountPhone,dev);
            }
        }
        return token;
    }
    /**
     * @return
     * @Description 查询设备绑定情况
     * 返回数据格式：{"id":"0820618f-52ee-4d1d-b35f-a13282ba0c18","result":{"code":"0","data":{"isBind":true,"isMine":true},"msg":"操作成功。"}}
     * @Date 2022/07/18 10:44
     * @Author xiaoyl
     * @Param
     */
    public static JSONObject getDeviceBindOrNot(String token,String accountPhone, String dev){
        HashMap<String, Object> paramsMap = new HashMap<String, Object>();
        paramsMap.put("token", token);//管理员或者子账户accessToken
        paramsMap.put("deviceId", dev);//设备序列号
        JSONObject returnJson = HttpSend.execute(paramsMap, "checkDeviceBindOrNot", accountPhone);
        return returnJson;
    }
    /**
     * @return
     * @Description 获取设备在线状态
     * 返回数据：{"id":"50ca1c5c-a85e-4e3d-8c51-18295d84bf70","result":{"code":"0","data":{"channels":[{"channelId":"0","onLine":"1"},{"channelId":"1","onLine":"0"},{"channelId":"2","onLine":"0"},{"channelId":"3","onLine":"0"},{"channelId":"4","onLine":"0"},{"channelId":"5","onLine":"0"},{"channelId":"6","onLine":"0"},{"channelId":"7","onLine":"0"}],"deviceId":"6C07DFBPAZCE9D3","onLine":"1"},"msg":"操作成功。"}}
     * @Date 2022/07/18 10:44
     * @Author xiaoyl
     * @Param
     */
    public static JSONObject getDeviceOnLine(String token,String accountPhone, String dev){
        HashMap<String, Object> paramsMap = new HashMap<String, Object>();
        paramsMap.put("token", token);//管理员或者子账户accessToken
        paramsMap.put("deviceId", dev);//设备序列号
        JSONObject returnJson = HttpSend.execute(paramsMap, "deviceOnline", accountPhone);
        return returnJson;
    }

    /**
     * @return
     * @Description 获取设备在线状态
     * 当前设备的SD存储卡状态返回数据：{"result":{"msg":"操作成功。","code":"0","data":{"status":"normal"}},"id":"d5c287b4-5b2f-4f03-baf5-8032c5c354af"}
     * 当前设备的云存储服务信息返回数据：{"id":"d5c287b4-5b2f-4f03-baf5-8032c5c354af","result":{"data":{"hasDefault":true,"strategyId":1,"name":"套餐名称","strategyStatus":2,"beginTime":"2017-05-01 00:12:23","endTime":"2018-05-01 00:12:23"},"code":"0","msg":"操作成功"}}
     * @Date 2022/07/18 10:44
     * @Author xiaoyl
     * @Param
     */
    public static Short getDeviceStorageType(String token,String accountPhone, String dev){
        Short storageType=0;//0 无，1 TF内存卡，2 云存储
        //1.首先获取当前设备SD存储卡状态
        HashMap<String, Object> paramsMap = new HashMap<String, Object>();
        paramsMap.put("token", token);//管理员或者子账户accessToken
        paramsMap.put("deviceId", dev);//设备序列号
        JSONObject returnJson = HttpSend.execute(paramsMap, "deviceSdcardStatus", accountPhone);
        //存储卡状态，empty：无SD卡，normal：正常，abnormal：异常，recovering：格式化中
        returnJson =returnJson.getJSONObject("result");
        if(returnJson.getString("code").equals("0")) {
            if ("normal".equals(returnJson.getJSONObject("data").getString("status"))) {
                storageType = 1;
                return storageType;
            }
        }
        //2.没有SD内存卡，进一步获取当前设备的云存储服务信息
        paramsMap.put("channelId", "0");//通道号
        returnJson = HttpSend.execute(paramsMap, "getDeviceCloud", accountPhone);
        //套餐状态，-1：未开通，0：过期，1：使用中，2：暂停
        JSONObject resultJson =returnJson.getJSONObject("result");
        if(resultJson.getString("code").equals("0")){
            if(resultJson.getJSONObject("data").getInteger("strategyStatus")==1){
                storageType=2;
            }
        }
        return storageType;
    }
}
