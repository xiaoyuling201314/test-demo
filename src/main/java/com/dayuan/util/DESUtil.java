package com.dayuan.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

/**
 * 3DES加密工具类
 */
public class DESUtil {
    /**
     * 加解密统一编码方式
     */
    private final static String ENCODING = "utf-8";

    /**
     * 加解密方式
     */
    private final static String ALGORITHM  = "DESede";

    /**
     *加密模式及填充方式
     */
//    private final static String PATTERN = "DESede/CBC/PKCS5Padding";
    private final static String PATTERN = "DESede/ECB/PKCS5Padding";

    /**
     * 偏移变量，固定占8位字节
     */
    private final static String IV_PARAMETER = "14325879";

    /**
     * 3DES加密
     *
     * @param plainText 普通文本
     * @param sK 秘钥（24位密码）
     * @return
     * @throws Exception
     */
    public static String encode(String plainText, String sK) throws Exception {
        SecretKey secretKey = new SecretKeySpec(sK.getBytes(ENCODING), ALGORITHM);
        // 3DES加密采用pkcs5padding填充
        Cipher cipher = Cipher.getInstance(PATTERN);
//        // 偏移量
//        IvParameterSpec iv = new IvParameterSpec(IV_PARAMETER.getBytes(ENCODING));
//        // 用密匙初始化Cipher对象
//        cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
        // 用密匙初始化Cipher对象
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        // 执行加密操作
        byte[] encryptData = cipher.doFinal(plainText.getBytes(ENCODING));
        return Base64.getEncoder().encodeToString(encryptData);
    }

    /**
     * 3DES解密
     *
     * @param encryptText 加密文本
     * @return
     * @throws Exception
     */
    public static String decode(String encryptText, String sK) throws Exception {
        SecretKey secretKey = new SecretKeySpec(sK.getBytes(ENCODING), ALGORITHM);
        // 3DES加密采用pkcs5padding填充
        Cipher cipher = Cipher.getInstance(PATTERN);
//        // 偏移量
//        IvParameterSpec iv = new IvParameterSpec(IV_PARAMETER.getBytes(ENCODING));
//        // 用密匙初始化Cipher对象
//        cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
        // 用密匙初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        // 正式执行解密操作
        byte[] decryptData = cipher.doFinal(Base64.getDecoder().decode(encryptText));
        return new String(decryptData, ENCODING);
    }

    public static void main(String[] args) throws Exception {
        //密钥
        String sk = "sakj@(430437)#chinafstcn";
        //加密
        String encrypt = encode("JK2023030701928xxxxx", sk);
        System.out.println(encrypt);
        //解密
        System.out.println(decode(encrypt, sk));
    }

}
