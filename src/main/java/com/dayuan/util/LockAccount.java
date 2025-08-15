package com.dayuan.util;

import java.util.HashMap;
import java.util.Map;

/**
 * 锁定账号
 * Description:
 * @Company: 食安科技
 * @author Dz
 * @date 2020年7月22日
 */
public class LockAccount {

	/**
	 * 锁定时间(min)
	 */
	private static final int LOCK_TIME = 30;
	/**
	 * 连续输入密码错误次数N，锁定账号
	 */
	private static final int MAX_ERR_NUM = 10;

	/**
	 * 平台账号
	 */
	private static final String TYPE1 = "WEB_";

	/**
	 * 输入错误密码或锁定的账号
	 */
	private static final Map<String, Map> accounts = new HashMap<String, Map>(100);

//	/**
//	 * 输入错误次数+1
//	 * @param name 账号名
//	 * @return true 锁定
//	 */
//	private synchronized static boolean inputError(String name) {
//		Map map0 = accounts.get(name);
//		if (map0 == null) {
//			map0 = new HashMap(4);
//			map0.put("errNum", 1);
//			map0.put("lastTime", System.currentTimeMillis());
//			map0.put("locking", false);
//			accounts.put(name, map0);
//
//		//账号未锁定
//		} else if (!((boolean) map0.get("locking"))) {
//			int errNum = (int) map0.get("errNum");
//			long lastTime = (long) map0.get("lastTime");
//
//			//超时，重新记录错误次数
//			if(System.currentTimeMillis() > (lastTime + lockTime * 60 * 1000)) {
//				map0.put("errNum", 1);
//				map0.put("lastTime", System.currentTimeMillis());
//				map0.put("locking", false);
//
//			//不锁定
//			} else if (maxErrNum < (errNum + 1)) {
//				map0.put("errNum", (errNum + 1));
//				map0.put("lastTime", System.currentTimeMillis());
//				map0.put("locking", false);
//
//			} else {
//				map0.put("errNum", (errNum + 1));
//				map0.put("lastTime", System.currentTimeMillis());
//				map0.put("locking", true);
//			}
//			accounts.put(name, map0);
//		}
//
//		return (boolean) map0.get("locking");
//	}

	/**
	 * 平台账号输入错误次数+1
	 * @param name 账号名
	 * @return true 锁定
	 */
	public synchronized static void waInputError(String name) {
		name = TYPE1 + name;
		Map map0 = accounts.get(name);
		if (map0 == null) {
			map0 = new HashMap(4);
			map0.put("errNum", 1);
			map0.put("lastTime", System.currentTimeMillis());
			map0.put("locking", false);

		} else {
			int errNum = (int) map0.get("errNum");
			long lastTime = (long) map0.get("lastTime");

			//超时，重新记录错误次数
			if(System.currentTimeMillis() > (lastTime + LOCK_TIME * 60 * 1000)) {
				map0.put("errNum", 1);
				map0.put("lastTime", System.currentTimeMillis());
				map0.put("locking", false);

			//不锁定
			} else if (MAX_ERR_NUM > (errNum + 1)) {
				map0.put("errNum", (errNum + 1));
				map0.put("lastTime", System.currentTimeMillis());
				map0.put("locking", false);

			} else {
				map0.put("errNum", (errNum + 1));
				map0.put("lastTime", System.currentTimeMillis());
				map0.put("locking", true);
			}
		}
		accounts.put(name, map0);
	}

	/**
	 * 平台账号是否锁定
	 * @param name 账号名
	 * @return true 锁定
	 */
	public synchronized static boolean waIsLocked(String name) {
		name = TYPE1 + name;
		Map map0 = accounts.get(name);
		if (map0 == null || !((boolean) map0.get("locking"))) {
			return false;

		//超时，解除锁定
		} else if (System.currentTimeMillis() > ((long) map0.get("lastTime") + LOCK_TIME * 60 * 1000)){
			accounts.remove(name);
			return false;

		} else {
			return true;
		}
	}

	/**
	 * 平台账号解除锁定
	 * @param name 账号名
	 */
	public synchronized static void waUnlock(String name) {
		accounts.remove(TYPE1 + name);
	}

}
