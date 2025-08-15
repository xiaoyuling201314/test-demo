package com.dayuan.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.dayuan.bean.Cache;
import com.dayuan.controller.wx.inspection.VerifyCodeVO;
import com.dayuan3.admin.bean.InspectionUnitUser;

/**
 * 接口登录用户缓存管理
 * Description:
 *
 * @author xyl
 * @Company: 食安科技
 * @date 2017年8月25日
 */
public class CacheManager {

    private static final Map<String, Cache> cacheMap = new HashMap<String, Cache>();
    /**
     * 初始化最大容量
     */
    private static int maxSize = 1000;

    //得到缓存。同步静态方法
    private synchronized static Cache getCache(String key) {
        return cacheMap.get(key);
    }

    //判断是否存在一个缓存
    private synchronized static boolean hasCache(String key) {
        return cacheMap.containsKey(key);
    }

    //清除所有缓存
    public synchronized static void clearAll() {
        cacheMap.clear();
    }

    //清除某一类特定缓存,通过遍历HASHMAP下的所有对象，来判断它的KEY与传入的TYPE是否匹配
    public synchronized static void clearAll(String type) {
        Iterator i = cacheMap.entrySet().iterator();
        String key;
        List<String> arr = new ArrayList<>();
        try {
            while (i.hasNext()) {
                java.util.Map.Entry entry = (java.util.Map.Entry) i.next();
                key = (String) entry.getKey();
                if (key.startsWith(type)) { //如果匹配则删除掉
                    arr.add(key);
                }
            }
            for (int k = 0; k < arr.size(); k++) {
                clearOnly(arr.get(k));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //清除指定的缓存
    public synchronized static void clearOnly(String key) {
        cacheMap.remove(key);
    }

    //载入缓存
    public synchronized static void putCache(String key, Cache obj, String userKey) {
        cacheMap.put(key, obj);
        //	        cacheUserMap.put(userKey, key);
    }

    //获取缓存信息
    public static Cache getCacheInfo(String key) {

        if (hasCache(key)) {
            Cache cache = getCache(key);
            //调用判断是否终止方法
            if (cacheExpired(cache)) {
                cache.setExpired(true);
            }
            return cache;
        } else {
            return null;
        }
    }

    //载入缓存信息
    public static void putCacheInfo(String key, Cache obj, long dt, boolean expired) {
        Cache cache = new Cache();
        cache.setKey(key);
        cache.setTimeOut(dt + System.currentTimeMillis()); //设置多久后更新缓存
        cache.setValue(obj);
        cache.setExpired(expired); //缓存默认载入时，终止状态为FALSE
        cacheMap.put(key, cache);
    }

    //重写载入缓存信息方法
    public static void putCacheInfo(String key, Cache obj, long dt) {
        Cache cache = new Cache();
        cache.setKey(key);
        cache.setTimeOut(dt + System.currentTimeMillis());
        cache.setValue(obj);
        cache.setExpired(false);
        cacheMap.put(key, cache);
    }

    //重写载入缓存信息方法
    public static void resetCacheInfo(String key, Cache obj, long dt) {
        Cache cache = new Cache();
        cache.setKey(key);
        cache.setTimeOut(dt);
        cache.setValue(obj.getValue());
        cache.setExpired(false);
        cacheMap.put(key, cache);
    }

    //判断缓存是否终止
    public static boolean cacheExpired(Cache cache) {
        if (null == cache) { //传入的缓存不存在
            return false;
        }
        long nowDt = System.currentTimeMillis(); //系统当前的毫秒数
        long cacheDt = cache.getTimeOut(); //缓存内的过期毫秒数
        //过期时间小于等于零时,或者过期时间大于当前时间时，则为FALSE
        //大于过期时间 即过期
        return cacheDt > 0 && cacheDt <= nowDt;
    }

    //获取缓存中的大小
    public static int getCacheSize() {
        return cacheMap.size();
    }

    //获取指定的类型的大小
    public static int getCacheSize(String type) {
        int k = 0;
        Iterator i = cacheMap.entrySet().iterator();
        String key;
        try {
            while (i.hasNext()) {
                java.util.Map.Entry entry = (java.util.Map.Entry) i.next();
                key = (String) entry.getKey();
                if (key.indexOf(type) != -1) { //如果匹配则删除掉
                    k++;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return k;
    }

    //获取缓存对象中的所有键值名称
    public static ArrayList getCacheAllkey() {
        ArrayList a = new ArrayList();
        try {
            Iterator i = cacheMap.entrySet().iterator();
            while (i.hasNext()) {
                java.util.Map.Entry entry = (java.util.Map.Entry) i.next();
                a.add(entry.getKey());
            }
        } catch (Exception ex) {
        } finally {
            return a;
        }
    }

    //获取缓存对象中指定类型 的键值名称
    public static ArrayList getCacheListkey(String type) {
        ArrayList a = new ArrayList();
        String key;
        try {
            Iterator i = cacheMap.entrySet().iterator();
            while (i.hasNext()) {
                java.util.Map.Entry entry = (java.util.Map.Entry) i.next();
                key = (String) entry.getKey();
                if (key.indexOf(type) != -1) {
                    a.add(key);
                }
            }
        } catch (Exception ex) {
        } finally {
            return a;
        }
    }

    /**
     * 得到验证码缓存
     *
     * @param key
     * @return
     */
    public static VerifyCodeVO getSMS(String key) {
        Cache cache = cacheMap.get(cacheType.USER.key + "_SMS_" + key);
        VerifyCodeVO vo = null;
        if (cache != null) {
            //有效时间内
            if (System.currentTimeMillis() <= cache.getTimeOut()) {
                vo = (VerifyCodeVO) cache.getValue();
            } else {
                cacheMap.remove(cacheType.USER.key + key);
            }
        }

        return vo;
    }

    /**
     * 添加用户缓存
     *
     * @param key
     * @return
     */
    public static void putUser(String key, InspectionUnitUser user) {
        Cache cache = new Cache();
        cache.setTimeOut(System.currentTimeMillis() + (cacheType.USER.time * 60 * 1000));
        cache.setValue(user);
        putCache(cacheType.USER.key + key, cache);
        putToken(user.getId(), key);
    }

    /**
     * 载入缓存
     *
     * @param key
     * @param obj
     */
    private synchronized static void putCache(String key, Cache obj) {
        //缓存已满，清除过期缓存
        if (cacheMap.size() >= maxSize) {
            long time0 = System.currentTimeMillis();
            Iterator<Map.Entry<String, Cache>> it = cacheMap.entrySet().iterator();
            while (it.hasNext()) {
                Cache cache = it.next().getValue();
                if (time0 >= cache.getTimeOut()) {
                    it.remove();
                }
            }

            //扩大缓存容量
            if (cacheMap.size() > (maxSize * 0.75)) {
                maxSize = maxSize + 1000;
            }
        }

        cacheMap.put(key, obj);
    }

    /**
     * 添加token缓存
     *
     * @param key
     * @param token 用户token
     */
    private static void putToken(Integer key, String token) {
        Cache cache = new Cache();
        cache.setTimeOut(System.currentTimeMillis() + (cacheType.USER.time * 60 * 1000));
        cache.setValue(token);
        CacheManager.putCache(CacheManager.cacheType.USER.key + "_TOKEN_" + key, cache);
    }

    /**
     * 缓存类型
     */
    private enum cacheType {
        //用户缓存
        USER("USER", 60);

        /**
         * 缓存KEY前缀
         */
        private final String key;

        /**
         * 缓存有效时间(min)
         */
        private final int time;

        cacheType(String key, int time) {
            this.key = key;
            this.time = time;
        }
    }
}
