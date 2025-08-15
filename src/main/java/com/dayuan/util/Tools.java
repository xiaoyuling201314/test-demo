package com.dayuan.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

//import org.apache.mina.core.buffer.IoBuffer;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.RandomStringUtils;

/**
 * 工具类
 * Description:
 * @Company: 食安科技
 * @author xyl
 * @date 2017年10月18日
 */
public final class Tools {
	/**
	 * 将Object对象装换为byte[]，用于UDP，TCP数据解析
	 * @param message
	 * @return byte[]
	 * @author xyl
	 */
/*	public static byte[] ioBufferToByte(Object message) {
		if (!(message instanceof IoBuffer)) {
			return null;
		}
		IoBuffer ioBuffer = (IoBuffer) message;
		// ioBuffer.flip();
		byte[] readByte = new byte[ioBuffer.limit()];
		try {
			ioBuffer.get(readByte);
		} catch (Exception e) {
			System.out.println(e);
		}
		return readByte;
	}*/

	/**
	 * 完善TCP，UDP通信时间 将yy-MM-dd HH:mm:mm格式转换为yyyy-MM-dd HH:mm:mm
	 * @return byte[]
	 * @param type 数据来源： 0 UDP,1 TCP
	 * @author xyl
	 */
	public static Date getLocationDate(byte[] bytes,Integer type) throws ParseException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String year = cal.get(Calendar.YEAR) + "";
		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String mark = year.substring(0, 2) + bytes[0] + "-" + String.format("%0" + 2 + "d", bytes[1]) + "-"
				+ String.format("%0" + 2 + "d", bytes[2]) + " " + String.format("%0" + 2 + "d", bytes[3]) + ":"
				+ String.format("%0" + 2 + "d", bytes[4]) + ":" + String.format("%0" + 2 + "d", bytes[5]).trim();
		Date sourceDate = simple.parse(mark);
		cal.setTime(sourceDate);
		if(type==1){
			cal.set(Calendar.HOUR_OF_DAY, cal.get(Calendar.HOUR_OF_DAY) + 8);// 將UTC转换为UTC+8，加8小时
		}
		return cal.getTime();
	}


	/**
	 * 将经纬度分转换为度
	 * @param
	 */
	public static double getResult(String str) {
		Integer value = Integer.valueOf(str.trim(), 16);
		double dbVal = value / 30000.0;
		int intVal = (int) dbVal / 60;// 度数
		float flaVal = (float) (dbVal - intVal * 60) / 60;// 将分数转换为度数
		dbVal = Double.parseDouble((intVal + flaVal) + "");// 计算最后的度数并转换为double
		return dbVal;
	}
	/**
	 * 产生随机数组
	 */
	public static int[] randomArray(int length,int min,int max){
		Random random=new Random();
		
		int []number=new int[length];
		for(int i=0;i<number.length;i++){
			int spacing=Math.abs(max-min);
			int storage=random.nextInt(spacing);
			number[i]=storage+min;	
		}
		return number;
	}
	
	/**
	 * 产生中英合并的随机字符串
	 */
	public static String randomString(int length) {
		StringBuffer stringbuffer = new StringBuffer();
		List<Character> list = new ArrayList<>();
		for (int i = 48; i < 58; i++) {
			list.add((char) i);
		}
		for (int i = 0; i < 26; i++) {
			int a = 65;
			int A = 97;
			list.add((char) (a + i));
			list.add((char) (A + i));
		}
		Random random = new Random();
		for (int i = 0; i <= length; i++) {

			stringbuffer.append(list.get(random.nextInt(list.size())));
		}
		
		return stringbuffer.toString();

	}
	
	public static String randomNum(int length){
		StringBuffer stringBuffer=new StringBuffer();
		Random random = new Random();
		for(int i=length;i>=0;i--){
		stringBuffer.append(random.nextInt(10));
		}
		return stringBuffer.toString();
	}
	/**
	 * JSON转换工具类
	 * @description
	 * @param json
	 * @return
	 * @author xiaoyl
	 * @date   2020年7月21日
	 */
	public static List<Map<String,Object>> jsonObj2List(JSONObject jsonobj){
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		JSONArray array=jsonobj.getJSONObject("result").getJSONObject("data").getJSONArray("deviceList");
		Map<String,Object> map=null;
		JSONArray channels=null;
		if(array.size()>0) {
			for (int i = 0; i < array.size(); i++) {
				JSONObject j2= array.getJSONObject(i);
				channels=j2.getJSONArray("channels");
				for (int j = 0; j < channels.size(); j++) {
					JSONObject channel=channels.getJSONObject(j);
					map=new HashMap<String, Object>();
					map.put("deviceId", j2.getString("deviceId"));
					map.put("channelName", channel.getString("channelName"));
					map.put("channelId", channel.getString("channelId"));
					list.add(map);
				}
			}
		}
		return list;
	}
	public static String generateToken() {
		return RandomStringUtils.random(30, true, true);
	}
}
