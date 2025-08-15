package com.dayuan3.common.util;

import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.wx.WxAccesstoken;
import com.dayuan.exception.MyException;
import com.dayuan.service.wx.WxAccesstokenService;
import com.dayuan.util.DateUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.WeixinUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 微信统计模块常量配置
 *
 * @author shit
 * 2021年04月06日
 */
@Component
public class WeChatConfig {
    //-------------------------日志输出配置------------
    static Logger wxlog = Logger.getLogger("wx_data_statis");
    @Autowired
    private WxAccesstokenService weiXinAccesstokenService;

    private static WeChatConfig weChatConfig;

    //目的在于在该类中获取weiXinAccesstokenService对象
    @PostConstruct
    public void init() {
        weChatConfig = this;
        weChatConfig.weiXinAccesstokenService = this.weiXinAccesstokenService;
    }

    //-------------------------服务器变更需要配置常量-------------------------------------

    //微信公众号配置
    public static String appId = "";// 微信公众号appID
    public static String secret = "";// 微信公众号appsecret
    public static String redirectUri = "";//重定向路径

    /**
     * 授权参考网址：https://developers.weixin.qq.com/doc/offiaccount/OA_Web_Apps/Wechat_webpage_authorization.html#0
     * 1 第一步：用户同意授权，获取code
     * <p>
     * 2 第二步：通过code换取网页授权access_token
     * <p>
     * 3 第三步：刷新access_token（如果需要）
     * <p>
     * 4 第四步：拉取用户信息(需scope为 snsapi_userinfo)
     * <p>
     * 5 附：检验授权凭证（access_token）是否有效
     */
    public static String mainUrl = "";//授权主界面1(用户同意授权，获取code)

    public static String getAccessTokenUrl = "";//获取其他项目的token接口路径

    //
    public final static String code_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code ";

    //用戶授权链接
    public static String authUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=RETURNURI&response_type=code&scope=snsapi_base#wechat_redirect";//网页临时授权 &state=STATE

    //获取微信access_token
    public static String getToken = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret=" + secret;
    //获取用户基本信息
    public final static String getUserInfo = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=Access_token&openid=Openid&lang=zh_CN";
    //获取用户基本信息 2021-12-27日微信更改为新的方式获取用户基本信息
    public final static String getUserInfoNew = "https://api.weixin.qq.com/sns/userinfo?access_token=Access_token&openid=Openid&lang=zh_CN";
    //session 用户
    public static final String wxUser = "WX_TS_USER";
    //openId
    public static final String openId = "TS_OPENID";//用户openid
    public static final String REFRESH_TOKEN = "TS_REFRESH_TOKEN";//refresh_token用来刷新用户的access_token，此access_token与基础支持的access_token不同

    /**
     * 获取微信全局凭证
     *
     * @return
     */
    public static Map<String, Object> getToken() {
        Map<String, Object> res = new HashMap<>();
        String access_token = null;
        String jsapi_ticket = null;
        Long addTime = null;
        WxAccesstoken map;
        try {
            //去数据库获取缓存access_token, 如果库中access_token失效那就重新发请求获取
            map = weChatConfig.weiXinAccesstokenService.queryById("2");
            Date now = new Date();
            //7000s 内使用这个token 有效期7200s
            boolean isCreate = map == null;
            boolean isSet = false;
            if (!isCreate && DateUtil.getBetweenTime(now, map.getAddtime()) < 7000) {
                access_token = map.getAccesstoken();
                jsapi_ticket = map.getJsapiticket();
                addTime = map.getAddtime().getTime();
            } else {//重新获取token
                Map<String, Object> r = getWXToken();
                jsapi_ticket = (String) r.get("jsapi_ticket");
                access_token = (String) r.get("access_token");
                isSet = true;
            }

            //这里判断是新增还是插入
            if (isSet) {
                if (isCreate) map = new WxAccesstoken();
                map.setId("2");
                map.setAccesstoken(access_token);
                map.setAddtime(new Date());
                map.setJsapiticket(jsapi_ticket);

                if (StringUtil.isNotEmpty(access_token)) {
                    if (isCreate) {
                        weChatConfig.weiXinAccesstokenService.insertSelective(map);
                    } else {
                        weChatConfig.weiXinAccesstokenService.updateById(map);
                    }
                    addTime = map.getAddtime().getTime();
                } else {
                    setInfolog2(2, "获取access_token", "获取access_token失败");
                    throw new MyException("获取access_token失败！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        res.put("access_token", access_token);
        res.put("jsapi_ticket", jsapi_ticket);
        res.put("access_startTime", addTime);
        return res;
    }

    /**
     * 更新微信access_token
     *
     * @return
     */
    public static Map<String, Object> getTokenToUpdate() {
        Map<String, Object> res = new HashMap<>();
        String access_token = null;
        String jsapi_ticket = null;
        Date access_startTime = null;//access_token 有效期 add by xiaoyl 2021/04/25
        WxAccesstoken map;
        try {
            //去数据库获取缓存access_token, 如果库中access_token失效那就重新发请求获取
            map = weChatConfig.weiXinAccesstokenService.queryById("2");
            Date now = new Date();
            //7000s 内使用这个token 有效期7200s
            boolean isCreate = map == null;
            //前往微信端获取
            Map<String, Object> r = getWXToken();
            jsapi_ticket = (String) r.get("jsapi_ticket");
            access_token = (String) r.get("access_token");
            //这里判断是新增还是插入
            if (isCreate) map = new WxAccesstoken();
            map.setId("2");
            map.setAccesstoken(access_token);
            map.setAddtime(new Date());
            map.setJsapiticket(jsapi_ticket);
            access_startTime = map.getAddtime();
            if (StringUtil.isNotEmpty(access_token)) {
                if (isCreate) {
                    weChatConfig.weiXinAccesstokenService.insertSelective(map);
                } else {
                    weChatConfig.weiXinAccesstokenService.updateById(map);
                }
            } else {
                setInfolog2(2, "获取access_token", "获取access_token失败");
                throw new MyException("获取access_token失败！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        res.put("access_startTime", access_startTime.getTime());
        res.put("access_token", access_token);
        res.put("jsapi_ticket", jsapi_ticket);
        return res;
    }

    public static void setInfolog2(int type, String title, String log) {
        try {
            if (title == null) {
                title = "未知信息";
            }
            if (log == null) {
                log = "";
            }
            //开始拼接
            String str = "[" + title + "]" + "----" + log;
            switch (type) {
                case 1:
                    wxlog.info(str);
                    break;
                case 2:
                    wxlog.error(str);
                    break;

                default://默认info
                    wxlog.info(str);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 系统配置微信参数时，及时更新各个变量值
     */
    public static void updateWxConfig() {
        JSONObject json = SystemConfigUtil.WECHAT_PUBLIC_CONFIG;//获取系统配置参数
        if (json != null) {
            String wxCongfig = StringUtil.isEmpty(json.getString("wx2")) ? json.getString("wx") : json.getString("wx2");
            JSONObject json1 = JSONObject.parseObject(wxCongfig);
            if (json1 != null) {
                //1.修改当前配置
                appId = json1.getString("appId");
                secret = json1.getString("secret");
                redirectUri= json1.getString("redirectUri");
                getToken = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + json1.getString("appId") + "&secret=" + json1.getString("secret");
                mainUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + json1.getString("appId") + "&redirect_uri=" + json1.getString("redirectUri") + "wx%2Fdata_statis%2Fmain1&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
                if (json1.containsKey("getAccessTokenUrl")) {
                    getAccessTokenUrl = json1.getString("getAccessTokenUrl");
                }
            }
        }
    }


    /**
     * 获取openid
     *
     * @return
     */
    public static String getOpenId(String code) throws Exception {
        net.sf.json.JSONObject jsonObject = null;
        String openid = null;
        if (code != null) {
            String requestUrl = code_url.replace("CODE", code).replace("APPID", appId).replace("APPSECRET", secret);
            jsonObject = WeChatUtil.httpRequest(requestUrl, "GET", null);
        }
        if (null != jsonObject) {
            if (jsonObject.has("openid")) {
                openid = jsonObject.getString("openid");
                WeChatUtil.setOpenid(openid);
            } else {
                throw new MyException("获取openid失败! ==>errcode：" + jsonObject.getString("errcode") + " ==>errmsg：" + jsonObject.getString("errmsg"));
            }
        }
        return openid;
    }
    /**
     * 获取token jsapi_ticket
     * @return
     * @throws Exception
     */
    public static Map<String, Object> getWXToken() throws Exception {
        Map<String, Object> ret = new HashMap<String, Object>();
        String url1 = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + WeChatConfig.appId + "&secret="
                + WeChatConfig.secret;
        net.sf.json.JSONObject json = WeixinUtil.httpRequest(url1, "GET", null);

        if (json != null) {
            if(json.has("access_token")){//返回信息成功
                // 要注意，access_token需要缓存
                String	access_token = json.getString("access_token");
                ret.put("access_token", access_token);
                String url2 = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + access_token + "&type=jsapi";
                json = WeixinUtil.httpRequest(url2, "GET", null);
                if (json != null) {
                    String	jsapi_ticket = json.getString("ticket");
                    ret.put("jsapi_ticket", jsapi_ticket);
                }

            }else if(json.has("errcode")){
                //errcode=40164时,ip未进入微信公共平台白名单，将后面ip放入白名单即可,其他详情参考api;
                setInfolog2(2,"微信公众号获取token","错误返回:errcode:"
                        +json.getString("errcode")+";errmsg:"+json.getString("errmsg"));
                //throw new Exception("JsAPI-扫码接口获取jsapi_ticket失败:"+json);
            }else{
                //throw new Exception("JsAPI-扫码接口获取jsapi_ticket失败:"+json);
            }

        }
        return ret;
    }
}

