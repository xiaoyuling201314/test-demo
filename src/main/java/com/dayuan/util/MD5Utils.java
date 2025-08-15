package com.dayuan.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class MD5Utils {
    private final static String[] hexDigits = {"0", "1", "2", "3", "4",
            "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};
    /**
     * 方法名: generatePassword
     * 方法作用: TODO 对字符串进行加密
     *
     * @param @param  inputString
     * @param @return 返回值类型： String
     * @throws
     */
    public static String generatePassword(String inputString) {
        return md5UpperCase(md5UpperCase(inputString));
    }


    /**
     * Md5加密
     * @param @param  originString
     * @param @return 返回值类型： String
     * @throws
     */
    public static String md5(String originString) {
        if (originString != null) {
            try {
                //创建具有指定算法名称的信息摘要
                MessageDigest md = MessageDigest.getInstance("MD5");
                //使用指定的字节数组对摘要进行最后更新，然后完成摘要计算
                byte[] results = md.digest(originString.getBytes(StandardCharsets.UTF_8));
                //将得到的字节数组变成字符串返回
                String resultString = byteArrayToHexString(results);
                return resultString;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }

    /**
     * Md5加密 大写
     * @param @param  originString
     * @param @return 返回值类型： String
     * @throws
     */
    public static String md5UpperCase(String originString) {
        return md5(originString).toUpperCase();
    }

    /**
     * 方法名: byteArrayToHexString
     * 方法作用: TODO 转换字节数组为十六进制字符串
     *
     * @param @param  b
     * @param @return 返回值类型： String
     */
    private static String byteArrayToHexString(byte[] b) {
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++) {
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }
    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }
}
