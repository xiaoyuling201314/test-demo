package com.dayuan.util;


import java.net.InetAddress;

public class UUIDGenerator {
	
	/**
	 * 产生一个32位的UUID
	 * 
	 * @return
	 */
	public static String generate() {
		return new StringBuilder(32).append(format(getIP())).append(
				format(getJVM())).append(format(getHiTime())).append(
				format(getLoTime())).append(format(getCount())).toString();
	}
	
	/**
	 * 根据位数和最后的编码生成下一位编码.
	 * @param numSize 生成编码结尾数字位数
	 * @param lastcode 最新编码
	 * @param pcode 编码固定开头字符
	 * @return
	 */
	public synchronized static String getNextCode(int numSize, String lastcode, String pcode) {
		String retvalue = "";
		if(pcode == null || pcode.trim().length() == 0) {
			pcode = "";
		}
		
		if (lastcode != null && lastcode.trim().length() > 0) {
			String numstr = String.valueOf(Integer.valueOf(lastcode.replaceFirst(pcode, "")).intValue() + 1);
			int l = numstr.length();
			for (int i = 0; i < numSize - l; i++) {
				numstr = "0" + numstr;
			}

			retvalue = pcode + numstr;
		} else {
			for (int i = 0; i < numSize - 1; i++) {
				retvalue = "0" + retvalue;
			}

			retvalue = pcode + retvalue + "1";
		}

		return retvalue;
	}
	
	private static final int IP;
	static {
		int ipadd;
		try {
			ipadd = toInt(InetAddress.getLocalHost().getAddress());
		} catch (Exception e) {
			ipadd = 0;
		}
		IP = ipadd;
	}

	private static short counter = (short) 0;

	private static final int JVM = (int) (System.currentTimeMillis() >>> 8);

	private final static String format(int intval) {
		String formatted = Integer.toHexString(intval);
		StringBuilder buf = new StringBuilder("00000000");
		buf.replace(8 - formatted.length(), 8, formatted);
		return buf.toString();
	}

	private final static String format(short shortval) {
		String formatted = Integer.toHexString(shortval);
		StringBuilder buf = new StringBuilder("0000");
		buf.replace(4 - formatted.length(), 4, formatted);
		return buf.toString();
	}

	private final static int getJVM() {
		return JVM;
	}

	private final static short getCount() {
		synchronized (UUIDGenerator.class) {
			if (counter < 0)
				counter = 0;
			return counter++;
		}
	}

	/**
	 * Unique in a local network
	 */
	private final static int getIP() {
		return IP;
	}

	/**
	 * Unique down to millisecond
	 */
	private final static short getHiTime() {
		return (short) (System.currentTimeMillis() >>> 32);
	}

	private final static int getLoTime() {
		return (int) System.currentTimeMillis();
	}

	private final static int toInt(byte[] bytes) {
		int result = 0;
		for (int i = 0; i < 4; i++) {
			result = (result << 8) - Byte.MIN_VALUE + (int) bytes[i];
		}
		return result;
	}

}
