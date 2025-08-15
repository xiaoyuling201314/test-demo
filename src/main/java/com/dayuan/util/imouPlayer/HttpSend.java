package com.dayuan.util.imouPlayer;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.httpclient.protocol.Protocol;
import org.apache.commons.httpclient.protocol.ProtocolSocketFactory;
import org.apache.commons.io.IOUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dayuan3.common.util.SystemConfigUtil;

public class HttpSend {

    public static JSONObject execute(Map<String, Object> paramsMap, String method,String accountPhone) {
        Map<String, Object> map = paramsInit(paramsMap,accountPhone);
        JSONObject jsonObj =null;
        if(map!=null) {
        	// 返回json
        	jsonObj = doPost(SystemConfigUtil.MONITOR_CONFIG.getString("host") + ":" + SystemConfigUtil.MONITOR_CONFIG.getString("port") + "/openapi/" + method, map);
        	System.out.println("=============================");
        	System.out.println("调用的方法："+method+"，返回结果：" + jsonObj.toJSONString());
        }
        return jsonObj;
    }

    public static JSONObject doPost(String url, Map<String, Object> map) {
    	String json = JSON.toJSONString(map);
        ProtocolSocketFactory factory = new MySecureProtocolSocketFactory();
        Protocol.registerProtocol("https", new Protocol("https", factory, 443));
        HttpClient client = new HttpClient();
        client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
        PostMethod method = new PostMethod(url);
        System.out.println(url);
        JSONObject jsonObject = new JSONObject();
        try {
            RequestEntity entity = new StringRequestEntity(json, "application/json", "UTF-8");
            method.setRequestEntity(entity);
            client.executeMethod(method);

            InputStream inputStream = method.getResponseBodyAsStream();
            String result = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
            jsonObject = JSONObject.parseObject(result);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            method.releaseConnection();
        }
        return jsonObject;
    }

    protected static Map<String, Object> paramsInit(Map<String, Object> paramsMap,String accountPhone) {
    	JSONObject jsonObject=SystemConfigUtil.MONITOR_CONFIG.getJSONObject("account").getJSONObject(accountPhone);
    	if(jsonObject==null) {
    		 return null;
    	}
    	long time = System.currentTimeMillis() / 1000;
         String nonce = UUID.randomUUID().toString();
         String id = UUID.randomUUID().toString();

         StringBuilder paramString = new StringBuilder();
         paramString.append("time:").append(time).append(",");
         paramString.append("nonce:").append(nonce).append(",");
         paramString.append("appSecret:").append(jsonObject.getString("app_secret"));

         String sign = "";
         // 计算MD5得值
         try {
             System.out.println("传入参数：" + paramString.toString().trim());
             sign = DigestUtils.md5Hex(paramString.toString().trim().getBytes(StandardCharsets.UTF_8));
         } catch (Exception e) {
             e.printStackTrace();
         }

         Map<String, Object> systemMap = new HashMap<String, Object>();
         systemMap.put("ver", "1.0");
         systemMap.put("sign", sign);
         systemMap.put("appId", jsonObject.getString("app_id"));
         systemMap.put("nonce", nonce);
         systemMap.put("time", time);
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("system", systemMap);
         map.put("params", paramsMap);
         map.put("id", id);
         return map;
    }

}
