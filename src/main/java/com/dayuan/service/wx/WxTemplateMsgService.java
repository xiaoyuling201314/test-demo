package com.dayuan.service.wx;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.dataCheck.DataUnqualifiedRecording;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.WeixinUtil;
import com.dayuan3.common.util.SystemConfigUtil;
import com.dayuan3.common.util.WeChatConfig;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

/**
 * @Description
 * @Author xiaoyl
 * @Date 2021-03-25 14:05
 */
@Service
public class WxTemplateMsgService {
    /**
    * @Description 微信公众号推送不合格通知
    * @Date 2022/08/25 15:46
    * @Author xiaoyl
    * @Param
    * @return
    */
    public boolean unqualifiedNoticeMsg(String openid, String detailUrl, DataUnqualifiedRecording durd) {
        boolean send = true;
        Map<String, Object> res = WeChatConfig.getToken();
        if(res.isEmpty()){
            return false;
        }
        String Access_token = (String) res.get("access_token");
        String url = WeixinUtil.wxSendMsgUrl.replace("Access_token", Access_token);
        JSONObject json = null;
        try {
            json = SystemConfigUtil.WECHAT_PUSH_TEMPLATE_CONFIG;
            json = json.getJSONObject("unqualfiedData");
            json.replace("touser", openid);
            if (StringUtil.isNotEmpty(detailUrl)) {
                json.replace("url", detailUrl);
            } else {
                json.remove("url");
            }
            json.getJSONObject("data").getJSONObject("first").replace("value", "       您好，东营市快检监管平台【"+durd.getDepartName()+"】辖区出现不合格检测，点击详情查看检测情况");
            StringBuilder builder=new StringBuilder();
            builder.append( durd.getRegName());
            if(StringUtil.isNotEmpty(durd.getRegUserName())){
                builder.append("("+durd.getRegUserName()+")");
            }
            json.getJSONObject("data").getJSONObject("keyword1").replace("value", builder.toString());
            json.getJSONObject("data").getJSONObject("keyword2").replace("value", durd.getFoodName());
            json.getJSONObject("data").getJSONObject("keyword3").replace("value", durd.getItemName());
            json.getJSONObject("data").getJSONObject("keyword4").replace("value", DateUtil.formatDate(durd.getCheckDate(), "yyyy-MM-dd HH:mm:ss"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            net.sf.json.JSONObject parseObject = WeixinUtil.httpRequest(url, "POST", json.toString());
            String errmsg = (String) parseObject.get("errmsg");
            if (!"ok".equals(errmsg)) {//如果为errmsg为ok，则代表发送成功，公众号推送信息给用户了。
                send = true;
            }
        } catch (JSONException e) {
            e.printStackTrace();
            send = false;
        }
        return send;
    }

    /**
     * @Description 微信公众号推送不合格已处理通知
     * @Date 2022/08/25 15:46
     * @Author xiaoyl
     * @Param
     * @return
     */
    public boolean unqualifiedhandledMsg(String openid, String detailUrl, String regName, String foodName, String itemName,String dealMethod,Date handleDate) {
        boolean send = true;
        Map<String, Object> res = WeChatConfig.getToken();
        if(res.isEmpty()){
            return false;
        }
        String Access_token = (String) res.get("access_token");
        String url = WeixinUtil.wxSendMsgUrl.replace("Access_token", Access_token);
        JSONObject json = null;
        try {
            json = SystemConfigUtil.WECHAT_PUSH_TEMPLATE_CONFIG;
            json = json.getJSONObject("unqualfiedData");
            json.replace("touser", openid);
            if (StringUtil.isNotEmpty(detailUrl)) {
                json.replace("url", detailUrl);
            } else {
                json.remove("url");
            }
            json.getJSONObject("data").getJSONObject("first").replace("value", "       您好，快检监管平台出现不合格样品，点击详情查看检测情况");
            json.getJSONObject("data").getJSONObject("keyword1").replace("value", regName);
            json.getJSONObject("data").getJSONObject("keyword2").replace("value", foodName);
            json.getJSONObject("data").getJSONObject("keyword3").replace("value", itemName);
            json.getJSONObject("data").getJSONObject("keyword4").replace("value", dealMethod);
            json.getJSONObject("data").getJSONObject("keyword5").replace("value", DateUtil.formatDate(handleDate, "yyyy-MM-dd HH:mm:ss"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            net.sf.json.JSONObject parseObject = WeixinUtil.httpRequest(url, "POST", json.toString());
            String errmsg = (String) parseObject.get("errmsg");
            if (!"ok".equals(errmsg)) {//如果为errmsg为ok，则代表发送成功，公众号推送信息给用户了。
                send = true;
            }
        } catch (JSONException e) {
            e.printStackTrace();
            send = false;
        }
        return send;
    }
}
