package com.dayuan.util;

/**
 * @author ocean 全局配置管理工具类
 *
 */
public class GlobalConfig {

	private static GlobalConfig config = null;

	public static GlobalConfig getInstance() {
		if (null == config) {
			config = new GlobalConfig();
		}

		return config;
	}

	public GlobalConfig() {
	}

	/**
	 * 根据位数和最后的编码生成下一位编码.
	 * @param numSize
	 * @param lastcode 最后一个数据编码
	 * @param pcode 父类编码
	 * @return
	 */
	public synchronized String getNextCode(int numSize, String lastcode, String pcode) {
		String retvalue = "";
		if (lastcode != null && lastcode.trim().length() > 0) {
			int m = lastcode.length() / numSize;
			m = (m - 1) * numSize;
			String bstr = lastcode.substring(0, m);
			String estr = lastcode.substring(m);
			String nstr = String.valueOf(Integer.valueOf(estr).intValue() + 1);
			int l = nstr.length();
			if(l<=numSize){
				for (int i = 0; i < numSize - l; i++) {
					nstr = "0" + nstr;
				}
				retvalue = bstr + nstr;
			}else {
				retvalue="0";
			}
		} else {
			for (int i = 0; i < numSize - 1; i++) {
				retvalue = "0" + retvalue;
			}

			retvalue = pcode + retvalue + "1";
		}

		return retvalue;
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(GlobalConfig.getInstance().getNextCode(3, "001999", "001"));
	}
}
