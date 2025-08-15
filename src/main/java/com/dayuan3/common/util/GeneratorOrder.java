package com.dayuan3.common.util;


import java.util.Date;

import com.dayuan.util.DateUtil;

public class GeneratorOrder {
	
	/**
	 * 交易订单号：用户号+yyyymmddhhmmssSSS
	 * @description
	 * @param userId
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月19日
	 */
	public static String generate(Integer userId) {
		return userId+DateUtil.yyyymmddhhmmssSSS.format(new Date());
	}
	/**
	 * 分账订单号：S+yyyymmddhhmmssSSS
	 * @description
	 * @param prefix
	 * @return
	 * @author xiaoyl
	 * @date   2019年7月19日
	 */
	public static String generateSplitNo(String prefix) {
		return prefix+DateUtil.yyyymmddhhmmssSSS.format(new Date());
	}
}
