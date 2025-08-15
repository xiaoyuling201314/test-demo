package com.dayuan.util;


import java.util.Date;
import java.util.Random;

public class TimeIDGenerator {
	
	//随机字符
	private static final char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
			'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
			'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
	
	private static final char[] codeSequence1 = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
			'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
	
	/**
	 * 生成一个时间戳+多位随机字符ID
	 * @param num 随机字符长度
	 * @return
	 */
	public static String generate(int num) {
		StringBuilder b = new StringBuilder();
		b.append(new Date().getTime());
		
		Random random = new Random();
		for(int i=0;i<num;i++){
			b.append(codeSequence[random.nextInt(codeSequence.length)]);
		}
		return b.toString();
	}
	
	/**
	 * 生成字母和数字组成的随机字符串
	 * @param num 长度
	 * @return
	 */
	public static String generate1(int num) {
		StringBuilder b = new StringBuilder();

		Random random = new Random();
		for(int i=0;i<num;i++){
			b.append(codeSequence1[random.nextInt(codeSequence1.length)]);
		}
		return b.toString();
	}

}
