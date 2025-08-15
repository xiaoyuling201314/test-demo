package com.dayuan.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dayuan.bean.Cache;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 萤石云Token
 * Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2020年8月18日
 */
public class YingShiYun {

	/**
	 * 获取TOKEN地址
	 */
	private static final String GET_TOKEN_URL = "https://open.ys7.com/api/lapp/token/get";

	/**
	 * 缓存
	 */
	private static final Map<String,Cache> cacheMap = new HashMap<String,Cache>();
	/**
	 * 初始化最大容量
	 */
	private static int maxSize = 100;

	/**
	 * TokenKEY前缀
	 */
	private static final String tokenKey = "TOKEN_";

	/**
	 * 得到Token
	 * @param appKey
	 * @param appSecret
	 * @return
	 */
	public static String getToken(String appKey, String appSecret) {
		String toekn = "";
		Cache cache = cacheMap.get(tokenKey + appKey);
		if (cache != null) {
			//有效时间内
			if (System.currentTimeMillis() <= cache.getTimeOut()) {
				toekn = cache.getValue().toString();
			} else {
				//获取TOKEN
				Map params = new HashMap(3);
				params.put("appKey", appKey);
				params.put("appSecret", appSecret);
				String res = HttpClient4Util.doPost(GET_TOKEN_URL, params);
				JSONObject resJson = JSON.parseObject(res);

				toekn = resJson.getJSONObject("data").getString("accessToken");
				cache.setValue(toekn);
				//提前2小时过期
				cache.setTimeOut(resJson.getJSONObject("data").getLong("expireTime") - (2 * 3600 * 1000));
				putCache(tokenKey + appKey, cache);
			}
		} else {
			//获取TOKEN
			Map params = new HashMap(3);
			params.put("appKey", appKey);
			params.put("appSecret", appSecret);
			String res = HttpClient4Util.doPost(GET_TOKEN_URL, params);
			JSONObject resJson = JSON.parseObject(res);

			if ("200".equals(resJson.getString("code"))){
				toekn = resJson.getJSONObject("data").getString("accessToken");
				cache = new Cache();
				cache.setValue(toekn);
				//提前2小时过期
				cache.setTimeOut(resJson.getJSONObject("data").getLong("expireTime") - (2 * 3600 * 1000));
				putCache(tokenKey + appKey, cache);
			}
		}
		return toekn;
	}

	/**
	 * 写入缓存
	 * @param key
	 * @param obj
	 */
	private synchronized static void putCache(String key, Cache obj) {
		//缓存已满，清除过期缓存
		if (cacheMap.size() >= maxSize) {
			long time0 = System.currentTimeMillis();
			Iterator<Map.Entry<String,Cache>> it = cacheMap.entrySet().iterator();
			while (it.hasNext()){
				Cache cache = it.next().getValue();
				if (time0 >= cache.getTimeOut()) {
					it.remove();
				}
			}

			//扩大缓存容量
			if (cacheMap.size() > (maxSize * 0.75)) {
				maxSize = maxSize+1000;
			}
		}

		cacheMap.put(key, obj);
	}


}
