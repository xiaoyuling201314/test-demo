package com.dayuan.util.wx;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import net.sf.json.JSONObject;

import com.alibaba.fastjson.JSON;

/** 公众平台通用接口工具类
 * 
 * @author 胡洪涛
 * @date 2017-06-10 */
@Component
public class WeixinUtil {
	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	// 菜单创建（POST） 限100（次/天）
	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	// 客服接口地址
	public static String send_message_url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";

	//微信公众号推送消息请求地址 Access_token是需要全局的请求凭证
	public static final String wxSendMsgUrl     = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=Access_token";

	//
	// private static final ResourceBundle bundle =
	// ResourceBundle.getBundle("weixin");

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

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes(StandardCharsets.UTF_8));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, StandardCharsets.UTF_8);
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
			LogUtil.info("Weixin server connection timed out.");
		} catch (Exception e) {
			LogUtil.info("https request error:{}" + e.getMessage());
		}
		return jsonObject;
	}

	/** 编码
	 * @param bstr
	 * @return String */
	public static String encode(byte[] bstr) {
		return new sun.misc.BASE64Encoder().encode(bstr);
	}

	/** 解码
	 * @param str
	 * @return string */
	public static byte[] decode(String str) {

		byte[] bt = null;
		try {
			sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
			bt = decoder.decodeBuffer(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bt;

	}

	public static String jsapi_ticket(String access_token) {

		String str = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + access_token + "&type=jsapi";
		String jsapi_ticket = null;
		String expiresin = null;
		try {
			URL url = new URL(str);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("GET");
			// 必须是get方式请求
			http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			http.setDoOutput(true);
			http.setDoInput(true);
			System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
			// 连接超时30秒
			System.setProperty("sun.net.client.defaultReadTimeout", "30000");
			// 读取超时30秒 http.connect();
			InputStream is = http.getInputStream();
			int size = is.available();
			byte[] jsonBytes = new byte[size];
			is.read(jsonBytes);
			String message = new String(jsonBytes, StandardCharsets.UTF_8);

			// 看不懂看上一个方法注释，同理，下面类似都是
			com.alibaba.fastjson.JSONObject demoJson = JSON.parseObject(message);
			jsapi_ticket = demoJson.getString("ticket");
			expiresin = demoJson.getString("expires_in");
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsapi_ticket;
	}

	/** 方法名：getWxConfig</br> 详述：获取微信的配置信息 </br> 开发人员： 胡洪涛</br> 创建时间： </br>
	 * @param request
	 * @return 说明返回值含义
	 * @throws Exception 
	 * @throws 说明发生此异常的条件 */
	public static Map<String, Object> getWxConfig(HttpServletRequest request, String appId,String secret,String access_token,String jsapi_ticket,String jspurl) throws Exception {
		Map<String, Object> ret = new HashMap<String, Object>();
		/*
		 * String appId = "wxed86b695b42432e5"; // 必填，公众号的唯一标识 String secret =
		 * "a1866b50633049b5e6e39487b4bfd4c2";
		 */
		String	requestUrl="";
		if(jspurl!=null&&!jspurl.equals("")){//JS带来的url
				requestUrl=jspurl;
		}else{//系统获取url
			 requestUrl = request.getRequestURL().toString();
			String canshu=request.getQueryString();//?后面的参数
			if(canshu!=null){
				requestUrl = request.getRequestURL().toString()+	"?"+request.getQueryString();
			}
		}
		String timestamp = Long.toString(System.currentTimeMillis() / 1000); // 必填，生成签名的时间戳
		String nonceStr = UUID.randomUUID().toString(); // 必填，生成签名的随机串
		if (access_token.equals("huhongtao")) {//错误token， 
			String url1 = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret="
					+ secret;
			JSONObject json = WeixinUtil.httpRequest(url1, "GET", null);
			if (json != null) {
				// 要注意，access_token需要缓存
				access_token = json.getString("access_token");
				String url2 = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + access_token
						+ "&type=jsapi";
				json = WeixinUtil.httpRequest(url2, "GET", null);
				if (json != null) {
					jsapi_ticket = json.getString("ticket");
					}
				}
			} else{
						String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + access_token + "&type=jsapi";
						JSONObject json = WeixinUtil.httpRequest(url, "GET", null);
						if (json != null&&json.getString("errcode").equals("0")) {
							jsapi_ticket = json.getString("ticket");
						} else {// 如果token失效就重新获取
							String url1 = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret="
									+ secret;
							JSONObject	 json1 = WeixinUtil.httpRequest(url1, "GET", null);
							if (json1 != null) {
								System.out.println(json1+json.getString("errcode"));
								// 要注意，access_token需要缓存
								access_token = json1.getString("access_token");
								System.out.println(access_token);
								String url2 = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + access_token
										+ "&type=jsapi";
								JSONObject	json2 = WeixinUtil.httpRequest(url2, "GET", null);
								if (json2 != null) {
									jsapi_ticket = json2.getString("ticket");
					}
				}
			}
		}
		String signature = "";
		// 注意这里参数名必须全部小写，且必须有序
		String sign = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonceStr + "&timestamp=" + timestamp + "&url=" + requestUrl;
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(sign.getBytes(StandardCharsets.UTF_8));
			signature = byteToHex(crypt.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
        ret.put("appId", appId);
		ret.put("timestamp", timestamp);
		ret.put("nonceStr", nonceStr);
		ret.put("signature", signature);
		ret.put("requestUrl", requestUrl);
		ret.put("jsapi_ticket", jsapi_ticket);
		ret.put("sign", sign);
		ret.put("access_token", access_token);
		return ret;
	}
	/** 方法名：byteToHex</br> 详述：字符串加密辅助方法 </br> 开发人员：胡洪涛 </br> 创建时间：2017-5-30
	 * </br>
	 * @param hash
	 * @return 说明返回值含义
	 * @throws 说明发生此异常的条件 */
	public static String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;

	}


}
