package com.dayuan3.common.util;

import com.dayuan.bean.system.TSUser;
import com.dayuan.exception.MyException;
import com.dayuan.util.ContextHolderUtils;
import com.dayuan.util.HttpUtil;
import com.dayuan.util.StringUtil;
import com.dayuan.util.wx.MyX509TrustManager;
import com.dayuan3.admin.bean.InspectionUnitUser;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 公共方法
 *
 * @author shit
 * @Description:
 * @Company:食安科技
 * @date 2021-04-06
 */
public class WeChatUtil {

    private static Logger wxlog = Logger.getLogger("payLog");

    /**
     * 设置微信登录用户
     */
    public static void setWxUser(TSUser wxUser) {
        HttpSession session = ContextHolderUtils.getSession();
        session.setAttribute(WeChatConfig.wxUser, wxUser);
    }


    /**
     * 获取微信登录用户
     *
     * @return
     */
    public static void setOpenid(String openid) {
        HttpSession session = ContextHolderUtils.getSession();
        session.setAttribute(WeChatConfig.openId, openid);
    }

    /**
     * 获取微信登录用户
     *
     * @return
     */
    public static TSUser getWxUser() throws Exception {
        HttpSession session = ContextHolderUtils.getSession();
        TSUser wxUser = (TSUser) session.getAttribute(WeChatConfig.wxUser);
        if (null == wxUser) {
            throw new MyException("用户失效，请重新登录！");
        }
        return wxUser;
    }

    /**
     * @param mapData map对象
     * @param viewJsp 界面地址
     * @return
     */
    public static ModelAndView returnView(Map<String, Object> mapData, String viewJsp) {
        try {
            TSUser wxUser = WeChatUtil.getWxUser();
            mapData.put("wxUser", wxUser);
        } catch (MyException me) {
            me.printStackTrace();
            return new ModelAndView(new RedirectView(WeChatConfig.mainUrl));//用户失效，重新进行登录
        } catch (Exception e) {
            e.printStackTrace();
            mapData.put("msg", "操作失败，请联系管理员");
            mapData.put("error_msg", e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            return new ModelAndView("/p_wx/data_statis/404", mapData);
        }
        return new ModelAndView(viewJsp, mapData);
    }


    /**
     * 获取用户基本信息openid,nickname,headimgurl
     *
     * @return
     */
    public static JSONObject getUserInfo(String code) {
        //code为空就直接打印错误日志并返回null
        if (StringUtil.isEmpty(code)) {
            wxlog.error("getUnserInfo()方法获取用户信息失败！传递的code值为空=========================");
            return null;
        }

        //拼接完整url获取用户openid和用户access_token（注意：access_token有效期很短，此处可以得到refresh_token，并通过这个参数可以去刷新用户access_token，项目已经成型不好改动，这里每次都去拿最新的用户access_token）
        String requestUrl = WeChatConfig.code_url.replace("CODE", code).replace("APPID", WeChatConfig.appId).replace("APPSECRET", WeChatConfig.secret);
        JSONObject jsonObject = httpRequest(requestUrl, "GET", null);

        //判断jsonObject对象中是否存在openid属性
        if (!jsonObject.has("openid")) {
            wxlog.error("获取openid和用户access_token失败! ==>errcode：" + jsonObject.getString("errcode") + " ==>errmsg：" + jsonObject.getString("errmsg"));
            return null;
        }

        //把openid和refresh_token设置进入缓存，便于下次使用(但实际上当前并没有去使用refresh_token)
        WeChatUtil.setOpenidAndRefreshToken(jsonObject.getString("openid"), jsonObject.getString("refresh_token"));

        //获取用户基本信息
        String getUserInfoUrl = WeChatConfig.getUserInfoNew.replace("Access_token", jsonObject.getString("access_token")).replace("Openid", jsonObject.getString("openid"));
        jsonObject = httpRequest(getUserInfoUrl, "GET", null);//发送GET请求获取用户基本信息

        //判断jsonObject对象中是否存在openid属性
        if (!jsonObject.has("nickname")) {
            wxlog.error("获取用户基本信息nickname，headimgurl失败! ==>errcode：" + jsonObject.getString("errcode") + " ==>errmsg：" + jsonObject.getString("errmsg"));
            return null;
        }
        return jsonObject;
    }


    private static Map<String, Object> accessTokenMap = null;

    /**
     * 获取accessToken，再根据accessToken和openid获取用户基本信息（旧方法，无法获取到用户头像和昵称，当前弃用）
     *
     * @param openid
     * @return
     */
    public static JSONObject getUserInfoOld(String openid) {
        //这里进行循环调用
        JSONObject jsonObject = null;
        String access_token = null;
        int number = 0;//循环去获取用户信息的次数 最大6次
        while (number < 5) {
            number++;
            //如果本地缓存的accessTokenMap为空或者缓存的accessTokenMap已经过期就重新去获取
            if (accessTokenMap == null || (new Date().getTime() - Long.valueOf(accessTokenMap.get("access_startTime").toString()) > 6000000)) {
                accessTokenMap = getToken2();//调用接口获取accessToken
            }
            //调用接口获取accessToken三次都出错就进行本地调用
            if (accessTokenMap.get("msg") != null) {
                accessTokenMap = WeChatConfig.getTokenToUpdate();
            }
            //Map<String, Object> r = WeChatConfig.getToken();
            String getUserInfoUrl = WeChatConfig.getUserInfo.replace("Access_token", (String) accessTokenMap.get("access_token")).replace("Openid", openid);
            jsonObject = httpRequest(getUserInfoUrl, "GET", null);//发送GET请求获取用户基本信息
            if (jsonObject != null) {
                //System.out.println(jsonObject.has("errcode"));
                //System.out.println("40001".equals(jsonObject.getString("errcode")));
                if (jsonObject.has("nickname")) {
                    return jsonObject;
                    //如果access_token失效，那就重新调用


                } else if (jsonObject.has("errcode") && "40001".equals(jsonObject.getString("errcode")) && jsonObject.getString("errmsg").contains("access_token is invalid")) {
                    //continue;
                    accessTokenMap = WeChatConfig.getTokenToUpdate();
                    String getUserInfoUrl2 = WeChatConfig.getUserInfo.replace("Access_token", (String) accessTokenMap.get("access_token")).replace("Openid", openid);
                    jsonObject = httpRequest(getUserInfoUrl2, "GET", null);//发送GET请求获取用户基本信息
                    return jsonObject;
                }
            }
        }
        return jsonObject;
    }

    private static Map<String, Object> getToken2() {
        Map<String, Object> map = new HashMap<>();
        JSONObject jsonObject = null;
        try {
            String resultStr = HttpUtil.get(WeChatConfig.getAccessTokenUrl);
            if (StringUtil.isNotEmpty(resultStr)) {
                jsonObject = JSONObject.fromString(resultStr);
            } else {
                map.put("msg", "未知异常");
            }
            if (jsonObject != null && jsonObject.has("resultCode") && "0X00000".equals(jsonObject.getString("resultCode"))) {
                JSONObject obj = jsonObject.getJSONObject("obj");
                map.put("access_token", obj.getString("access_token"));
                map.put("jsapi_ticket", obj.getString("jsapi_ticket"));
                map.put("access_startTime", obj.getString("access_startTime"));
            }
        } catch (SocketTimeoutException e1) {
            WeChatConfig.setInfolog2(2, "微信调用接口获取access_token超时", "微信调用接口获取access_token超时");
            e1.printStackTrace();
            map.put("msg", "调用接口获取access_token超时");
        } catch (Exception e) {
            map.put("msg", "未知异常");
            WeChatConfig.setInfolog2(2, "微信调用接口获取access_token未知异常" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber(), "微信调用接口获取access_token未知异常" + e.getMessage() + "====>" + e.getStackTrace()[0].getClassName() + "." + e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 设置微信用户自己的openid 和 refreshToken,refreshToken用于刷新用户access_token,access_token用于获取用户基本信息
     *
     * @return
     */
    public static void setOpenidAndRefreshToken(String openid, String refreshToken) {
        HttpSession session = ContextHolderUtils.getSession();
        session.setAttribute(WeChatConfig.openId, openid);
        session.setAttribute(WeChatConfig.REFRESH_TOKEN, refreshToken);
    }
    /** 发起https请求并获取结果
     *
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值) */
    public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
        JSONObject jsonObject = null;
        StringBuffer buffer = new StringBuffer();
        try {
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new java.security.SecureRandom());
            // 从上述SSLContext对象中得到SSLSocketFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
            httpUrlConn.setSSLSocketFactory(ssf);

            httpUrlConn.setDoOutput(true);
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);
            // 设置请求方式（GET/POST）
            httpUrlConn.setRequestMethod(requestMethod);

            if ("GET".equalsIgnoreCase(requestMethod)){
                httpUrlConn.connect();
            }

            // 当有数据需要提交时
            if (null != outputStr) {
                OutputStream outputStream = httpUrlConn.getOutputStream();
                // 注意编码格式，防止中文乱码
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            // 将返回的输入流转换成字符串
            InputStream inputStream = httpUrlConn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String str = null;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            bufferedReader.close();
            inputStreamReader.close();
            // 释放资源
            inputStream.close();
            inputStream = null;
            httpUrlConn.disconnect();
            jsonObject = JSONObject.fromObject(buffer.toString());
            // jsonObject = JSONObject.fromObject(buffer.toString());
        } catch (ConnectException ce) {
            //com.dayuan.utils.LogUtil.info("Weixin server connection timed out.");
        } catch (Exception e) {
            ///com.dayuan.utils.LogUtil.info("https request error:{}" + e.getMessage());
            wxlog.error("*************************" + e.getMessage() + e.getStackTrace());
        }
        return jsonObject;
    }
    public static void setInfolog(int type, String title, String log, InspectionUnitUser user) {
        if (title == null) {
            title = "未知信息";
        }
        if (log == null) {
            log = "";
        }
        //开始拼接
        String str = "[" + title + "]" + "-----账号=" + user.getUserName() + ";id=" + user.getId() + ";openId=" + user.getOpenId() + "----" + log;
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
    }
    public static void setInfolog2(int type,String title,String log) throws Exception {
        try {
            if(title==null){
                title="未知信息";
            }
            if(log==null){
                log="";
            }
            //开始拼接
            String str="["+title+"]" +"----"+log;
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
}
